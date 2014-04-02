signature MAKEGRAPH = 
sig
    val instrs2graph : Assem.instr list ->
                       Flow.flowgraph * (*Flow.*)Graph.node list
end

structure Makegraph :> MAKEGRAPH =
struct
	
	(*Reference Only*)
	(*datatype flowgraph = FGRAPH of {
            control: Graph.graph,
				    def: Temp.temp list Graph.Table.table,
				    use: Temp.temp list Graph.Table.table,
				    ismove: bool Graph.Table.table
          }*)
	(*datatype instr = 
  		OPER of {assem: string,
			    dst: temp list,
			    src: temp list,
			    jump: label list option}
       	| LABEL of {assem: string, lab: Temp.label}
        | MOVE of {assem: string, 
			    dst: temp,
			    src: temp}*)


	(*TO-DO*)
	fun instrs2graph instrs = 
		let
			(*Initialization*)
			val graph = Graph.newGraph()
			val nodes = map (fn _=> Graph.newNode(graph)) instrs (*p223 create node for each instr*)
			val def : Temp.temp list Graph.Table.table = Graph.Table.empty
			val use : Temp.temp list Graph.Table.table  = Graph.Table.empty
			val ismove : bool Graph.Table.table = Graph.Table.empty

			(*
			 * traverse instrs and update def,use,ismove table
			 * node -> temp list
			 *
  			 * A table of the temporaries defined/used/ismove at each node
			 *)
			fun constructTable(Assem.OPER{assem,dst,src,jump},node,(defTable,useTable,ismoveTable)) =
					(
						Graph.Table.enter(defTable,node,dst),
						Graph.Table.enter(useTable,node,src),
						Graph.Table.enter(ismoveTable,node,false)
					)
				| constructTable(Assem.LABEL{assem,lab},node,(defTable,useTable,ismoveTable)) =
					(
						Graph.Table.enter(defTable,node,[]),
						Graph.Table.enter(useTable,node,[]),
						Graph.Table.enter(ismoveTable,node,false)
					)
				| constructTable(Assem.MOVE{assem,dst,src},node,(defTable,useTable,ismoveTable)) =
					(
						Graph.Table.enter(defTable,node,dst::nil),
						Graph.Table.enter(useTable,node,src::nil),
						Graph.Table.enter(ismoveTable,node,true)
					)
				

			(*ListPair val foldr   : ('a * 'b * 'c -> 'c)  -> 'c -> 'a list * 'b list -> 'c *)
			val (defResult,useResult,ismoveResult) = ListPair.foldl constructTable (def,use,ismove) (instrs,nodes)

			(*connect nodes with edge if sequential or jump*)
			(*TO-DO*)
			fun connectEdge() = ()

			(*Result*)
			val flowgraph = Flow.FGRAPH{control=graph,def=def,use=use,ismove=ismove}
		in
			(flowgraph,nodes)
		end
end


