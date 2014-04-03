structure Liveness:
sig
	datatype igraph =
		IGRAPH of {
			graph: IGraph.graph,
			tnode: Temp.temp -> IGraph.node,
			gtemp: IGraph.node -> Temp.temp,
			moves: (Graph.node * Graph.node) list
		}

	type liveSet
	type liveMap

	val interferenceGraph: Flow.flowgraph -> igraph * ((*Flow.*)Graph.node -> Temp.temp list)

	val show: TextIO.outstream * igraph -> unit


end
=
struct
	datatype igraph =
			IGRAPH of {
				graph: IGraph.graph,
				tnode: Temp.temp -> IGraph.node,
				gtemp: IGraph.node -> Temp.temp,
				moves: (Graph.node * Graph.node) list
			}

	(*The table is useful for efficient membership tests, the list is useful for enumerating all the live variables in the set*)
	type liveSet = unit Temp.Table.table * Temp.temp list
	type liveMap = liveSet (*Flow.*)Graph.Table.table


	val allowPrint = true
	fun log info = if allowPrint then print("***Liveness*** "^info^"\n") else ()

	(*Reference Only*)
	(*
	 * in[n] = use[n] U (out[n] - def[n])
	 * out[n] = U_(s of succ[n]) in[s]
	 *)
	(*datatype flowgraph = FGRAPH of {
            control: Graph.graph,
				    def: Temp.temp list Graph.Table.table,
				    use: Temp.temp list Graph.Table.table,
				    ismove: bool Graph.Table.table
          }*)
	(*def,use : node -> temp list*)

	fun interferenceGraph(Flow.FGRAPH{control,def,use,ismove}) =
		let
			(*Initialization*)
			val nodes = Graph.nodes(control)
			val liveInMapInstance : liveMap ref = ref Graph.Table.empty
			val liveOutMapInstance : liveMap ref = ref Graph.Table.empty

			(*TO-DO*)
			fun tempToNode temp = IGraph.newNode(IGraph.newGraph())
			fun nodeToTemp node = Temp.newtemp()
			val movesList = []

			(*A table mapping each flow-graph node to the set of temps that are live-out at that node*)
			(*TO-DO*)
			fun getLiveOutTemps(node:IGraph.node) : Temp.temp list = []



			(*
			 * Traverse the flowGraph(nodes) reversely
			 * Update live-in & live-out for each node until no more chagnes
			 *)
			val liveInfoModified = ref false
			fun updateLiveInfo node = 
				let
					(*Init*)
					val () = log("traversing:"^Graph.nodename(node))
					val succs = Graph.succ(node)
					val () = List.app (fn succ => log(Graph.nodename(node)^"'s succ:"^Graph.nodename(succ))) succs
				
					

					(*Update live-out*)
					(*TO-DO*)
					val liveInTempList = []


					(*Update live-in*)
					(*TO-DO*)
					val liveOutTempList = []


					(*Result*)
					val liveInSetOfCurrentNode : liveSet = (Temp.Table.empty,liveInTempList)
					val liveOutSetOfCurrentNode : liveSet = (Temp.Table.empty,liveOutTempList)


				in
					(*Update map*)
					liveInMapInstance := Graph.Table.enter(!liveInMapInstance,node,liveInSetOfCurrentNode);
					liveOutMapInstance := Graph.Table.enter(!liveOutMapInstance,node,liveOutSetOfCurrentNode)
				end
					
				
			fun traverseNodeReversely () =  (
					List.app updateLiveInfo (List.rev(nodes));
					(*Continue until no more chagnes in live-in & live-out*)
					if !liveInfoModified 
						then (liveInfoModified := false; traverseNodeReversely())
					else ()
				)

			val () = traverseNodeReversely()

			(*
			 * Build the interference graph according to the liveness info
			 *)
			(*TO-DO*)
			val interferenceGraphResult = IGraph.newGraph()



			(*Result*)
			val igraph = IGRAPH{
							graph=interferenceGraphResult,
							tnode=tempToNode,
							gtemp=nodeToTemp,
							moves=movesList
							}
		in
			(igraph, getLiveOutTemps)
		end

	(*
	 * Show prints out for, debugging purposes, a list of nodes in the interference graph,
	 * and for each node, a list of nodes adjacent to it.
	 *)
	(*TO-DO*)
	fun show (outstream,igraph) = ()
end