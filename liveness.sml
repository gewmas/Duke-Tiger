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
			(*TO-DO*)
			fun findLivenessInfo () = 
				List.app (fn node => log(Graph.nodename(node))) (List.rev(nodes))

			val () = findLivenessInfo()

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