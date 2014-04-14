signature MAKEGRAPH = 
sig
    val instrs2graph : Assem.instr list ->
                       Flow.flowgraph * (*Flow.*)Graph.node list
end

structure Makegraph :> MAKEGRAPH =
struct
	
	val allowPrint = false
	fun log info = if allowPrint then print("***makegraph*** "^info^"\n") else ()

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
			val defInit : Temp.temp list Graph.Table.table = Graph.Table.empty
			val useInit : Temp.temp list Graph.Table.table  = Graph.Table.empty
			val ismoveInit : bool Graph.Table.table = Graph.Table.empty

			

			(*
			 * traverse instrs and update def,use,ismove table
			 * node -> temp list
			 *
  			 * A table of the temporaries defined/used/ismove at each node
			 *)
			val () = log("constructing table")
			fun constructTable(Assem.OPER{assem,dst,src,jump},node,(defTable,useTable,ismoveTable)) =
					(
						(*log("Assem.OPER "^assem);*)
						(
							Graph.Table.enter(defTable,node,dst),
							Graph.Table.enter(useTable,node,src),
							Graph.Table.enter(ismoveTable,node,false)
						)
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
			val (defResult,useResult,ismoveResult) = ListPair.foldl constructTable (defInit,useInit,ismoveInit) (instrs,nodes)


			(*
			 * Build node list just for Assem.LABEL to be jumped to
			 * If there's such label node to jump to, just jump to next node
			 *)
			val () = log("constructing labelNodeList")
			fun isLabel(Assem.LABEL{assem,lab},node) = SOME(lab,node)
				| isLabel(_,node) = NONE
			val labelNodeList : (Temp.label*Graph.node) list = List.mapPartial isLabel (ListPair.zipEq(instrs,nodes))
			fun findLabelNode(label:Assem.label) : Graph.node option = 
				case (List.find (fn (lab,node) => label = lab) labelNodeList) of
					SOME(lab,node) => SOME node
					| NONE => NONE

			(*
			 * Connect nodes with edge if sequential or jump
			 * If there's such label node to jump to, just jump to next node
			 *
			 * a,b,c,....
			 * a->b->c if no jump
			 * a->x->... if there is jump
			 *)
			fun connectEdgeWithTwoNodes(from,to) = 
				let
					val () = log("in connectEdgeWithTwoNodes from:"^Graph.nodename(from)^" to:"^Graph.nodename(to)^" in ")

					val SOME(defList) = Graph.Table.look(defResult,from)
					val () = List.app (fn def => log("Def node:"^Temp.makestring(def))) defList
					val SOME(useList) = Graph.Table.look(useResult,from)
					val () = List.app (fn use => log("Use node:"^Temp.makestring(use)^"\n")) useList
				in
					(*No jump, connect node1 and node2*)
					Graph.mk_edge{from=from,to=to}
				end

			fun connectEdge(instrs,nodes) = 
				case List.length(instrs) of
					0 => (log("connectEdge 0"))
					| 1 => (
							(*Last instr and node, can only jump*)
							let
								val () = log("connectEdge 1")

								val instrHd = List.hd(instrs)
								val nodeHd = List.hd(nodes)
							in
								case instrHd of
									Assem.OPER{assem,dst,src,jump} =>
										(
											case jump of
												SOME labels => 
													(
														List.app ( 
																fn label =>
																	case findLabelNode(label) of
																		SOME node => connectEdgeWithTwoNodes(nodeHd,node)
																		| NONE => ()
																) labels
													)
												| NONE => ()
										)
									| _ => ()
							end
							)
					| _ => (
							let
								(*val () = log("connectEdge length instrs:"^Int.toString(List.length(instrs))^" nodes:"^Int.toString(List.length(nodes)))*)

								val instrHd = List.hd(instrs)
								val instrTl = List.tl(instrs)

								val nodeHd = List.hd(nodes)
								val node2 = List.nth(nodes,1)
								val nodeTl = List.tl(nodes) (*same as node2 if List.length = 2*)

								
							in
								case instrHd of
									Assem.OPER{assem,dst,src,jump} => 
										(
											(*With jump, find all label list with according nodes*)
											case jump of
												SOME labels => 
														(
															List.app ( 
																	fn label =>
																		case findLabelNode(label) of
																			SOME node => 
																				(
																					log("connectEdge OPER SOME SOME")
																					;
																					connectEdgeWithTwoNodes(nodeHd,node)
																				)
																			| NONE => (
																					log("connectEdge OPER SOME NONE")
																					;
																					connectEdgeWithTwoNodes(nodeHd,node2)
																				)
																	) labels
															;
															log("connectEdge OPER labels empty")
														)
												| NONE => (
															log("connectEdge OPER NONE")
															;
															connectEdgeWithTwoNodes(nodeHd,node2)
														)
										)
									| _ => (
											log("connectEdge Not OPER")
											;
											connectEdgeWithTwoNodes(nodeHd,node2)
											)
								;
								connectEdge(instrTl,nodeTl)
							end
							)

			val () = log("constructing connectEdge")
			val () = connectEdge(instrs,nodes)


			(*Debug*)
			val () = log("Control nodes number:"^Int.toString(List.length(nodes)))
			fun traverseNode node = 
				let
					val succs = Graph.succ(node)
					val () = List.app (fn succ => log("in Yuhua Mai:"^Graph.nodename(succ)^" in ")) succs
				in
					case Graph.Table.look(defResult, node) of
						 SOME(l) => log("length of defTable is:"^ Int.toString(List.length(l)))
						| NONE => log("no defTable in this case");
					case Graph.Table.look(useResult, node) of
						 SOME(l) => log("length of useTable is:"^ Int.toString(List.length(l)))
						| NONE => log("no useTable in this case");
					case Graph.Table.look(ismoveResult, node) of
						 SOME(l) => (if l then log("ismove true") else log("ismove false"))
						| NONE => log("no isMoveTable in this case")
				end
					


				
			val () = app traverseNode nodes

			(*Result*)
			val flowgraph = Flow.FGRAPH{control=graph,def=defResult,use=useResult,ismove=ismoveResult}
		in
			(flowgraph,nodes)
		end
end


