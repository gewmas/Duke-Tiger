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
	fun log' info = if allowPrint then print(info) else ()

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
					(*Helper functions*)
					fun printTempList templist = (
							List.app (fn item => log'(Temp.makestring(item)^" ")) templist;
							log'("\n")
						)
					fun getTempListFromMap(map,node) : Temp.temp list =
						case Graph.Table.look(map,node) of
							SOME(templist) => templist
							| NONE => []
					fun getExistingLiveSet(map,node) : Temp.temp list=
						case Graph.Table.look(map,node) of
							SOME((table,templist)) => templist
							| NONE => []
					(*combine two temp lists and get rid of duplicate items*)
					fun combineTempList(temps1,temps2) : Temp.temp list = 
						let
							val set = ref IntBinarySet.empty
							val () = List.app (fn temp => (set := IntBinarySet.add(!set,temp))) temps1
							val () = List.app (fn temp => (set := IntBinarySet.add(!set,temp))) temps2
							val tempsResult = IntBinarySet.listItems(!set)
							(*val () = log("Combine Liveout temps1:"^Int.toString(List.length(temps1))^" temps2:"^Int.toString(List.length(temps2))^" tempsResult:"^Int.toString(List.length(tempsResult)))*)
						in
							tempsResult
						end
					(*diff templist1 with templist2*)
					fun diffTempList(temps1,temps2) : Temp.temp list = 
						let
							val set1 = ref IntBinarySet.empty
							val set2 = ref IntBinarySet.empty
							val () = List.app (fn temp => (set1 := IntBinarySet.add(!set1,temp))) temps1
							val () = List.app (fn temp => (set2 := IntBinarySet.add(!set2,temp))) temps2
							val diffSet = IntBinarySet.difference(!set1,!set2)
							val tempsResult = IntBinarySet.listItems(diffSet)
						in
							tempsResult
						end


					(*Init*)
					val () = log("=====traversing:====="^Graph.nodename(node))
					val succs = Graph.succ(node)
					val currDef = getTempListFromMap(def,node)
					val currUse = getTempListFromMap(use,node)
					val () = List.app (fn succ => log(Graph.nodename(node)^"'s succ:"^Graph.nodename(succ))) succs
				
					(*Previous live-out & live-in*)
					val prevIn = getExistingLiveSet(!liveInMapInstance,node)
					val prevOut = getExistingLiveSet(!liveOutMapInstance,node)

					(*Updated live-out & live-in*)
					(*traverse succs*)
					fun traverseSucc(succ::succs,prevList) : Temp.temp list = 
							let
								(*out[n] = U_(s of succ[n]) in[s]*)
								val succList = getExistingLiveSet(!liveInMapInstance,succ)
								val currList = combineTempList(prevList,succList)
							in
								traverseSucc(succs,currList)
							end
						|traverseSucc([],prevList) = (prevList)
					val currOut = traverseSucc(succs,prevOut)
					val currIn = combineTempList(currUse,diffTempList(currOut,currDef)) (*in[n] = use[n] U (out[n] - def[n])*)
					
					(*val () = log("CurrIn:"^Int.toString(List.length(currIn))^" CurrOut:"^Int.toString(List.length(currOut)))*)
					val () = log("Def:")
					val () = printTempList currDef
					val () = log("Use:")
					val () = printTempList currUse
					val () = log("CurrOut:")
					val () = printTempList currOut
					val () = log("CurrIn:")
					val () = printTempList currIn
					

					(*Least fix point check*)
					fun checkNoChange(l1,l2) =
						if diffTempList(l1,l2) = [] then () else (liveInfoModified := true)
					val () = checkNoChange(prevIn,currIn)
					val () = checkNoChange(prevOut,currOut)

					(*Result*)
					val liveInSetOfCurrentNode : liveSet = (Temp.Table.empty,currIn)
					val liveOutSetOfCurrentNode : liveSet = (Temp.Table.empty,currOut)

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