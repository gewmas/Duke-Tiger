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
				moves: (IGraph.node * IGraph.node) list
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

	(*Helper functions*)
	fun printNodeList nodelist = (
			List.app (fn item => log'(IGraph.nodename(item)^" ")) nodelist;
			log'("\n")
		)


	fun interferenceGraph(Flow.FGRAPH{control,def,use,ismove}) =
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
			(*diff templist1 with templist2, return [] if no diff*)
			fun diffTempList(temps1,temps2) : Temp.temp list = 
				let
					val () = log("DiffTempList temp1:"^Int.toString(List.length(temps1))^" temp2:"^Int.toString(List.length(temps2)))
					val set1 = ref IntBinarySet.empty
					val set2 = ref IntBinarySet.empty
					val () = List.app (fn temp => (set1 := IntBinarySet.add(!set1,temp))) temps1
					val () = List.app (fn temp => (set2 := IntBinarySet.add(!set2,temp))) temps2
					
					val () = log("set1:"^Int.toString(IntBinarySet.numItems(!set1))^" set2:"^Int.toString(IntBinarySet.numItems(!set2)))
					val diffSet = IntBinarySet.difference(!set1,!set2)
					val tempsResult = IntBinarySet.listItems(diffSet)
				in
					tempsResult
				end



			(*Initialization*)
			val controlNodes = Graph.nodes(control)
			val liveInMapInstance : liveMap ref = ref Graph.Table.empty
			val liveOutMapInstance : liveMap ref = ref Graph.Table.empty
			(*Warning! using IntBinaryMap*)
			val tempToNodeMap : IGraph.node IntBinaryMap.map ref = ref IntBinaryMap.empty 
			val nodeToTempMap : Temp.temp Graph.Table.table ref = ref Graph.Table.empty
			(*iGraph*)
			val interferenceGraphResult = IGraph.newGraph()

			(*Method for result*)
			fun tempToNode(temp:Temp.temp) : IGraph.node = (*IGraph.newNode(IGraph.newGraph())*)
				case IntBinaryMap.find(!tempToNodeMap,temp) of
					SOME(node) => node
					| NONE => 
							let
							 	val newNode = IGraph.newNode(interferenceGraphResult)
							 	(*update tempToNodeMap & nodeToTempMap*)
							 	val () = (tempToNodeMap := IntBinaryMap.insert(!tempToNodeMap,temp,newNode))
							 	val () = (nodeToTempMap := Graph.Table.enter(!nodeToTempMap,newNode,temp))
							in
							 	log("Warning,couldn't find the temp. Creating newNode."^IGraph.nodename(newNode));
							 	newNode
							end 

			fun nodeToTemp node : Temp.temp = 
				case Graph.Table.look(!nodeToTempMap,node) of
					SOME(temp) => temp
					| NONE => 
							let
							 	val newTemp = Temp.newtemp()
							 	(*update tempToNodeMap & nodeToTempMap*)
							 	val () = (tempToNodeMap := IntBinaryMap.insert(!tempToNodeMap,newTemp,node))
							 	val () = (nodeToTempMap := Graph.Table.enter(!nodeToTempMap,node,newTemp))
							in
							 	log("Warning,couldn't find the node. Creating newTemp.");
							 	newTemp
							end 

			(*TO-DO*)
			val movesList = []

			(*A table mapping each flow-graph node to the set of temps that are live-out at that node*)
			fun getLiveOutTemps(node:IGraph.node) : Temp.temp list = 
				case Graph.Table.look(!liveOutMapInstance,node) of
							SOME(table,templist) => templist
							| NONE => (log("Error!Should have found."); [])






			(*
			 * Traverse the flowGraph(nodes) reversely
			 * Update live-in & live-out for each node until no more chagnes
			 *)
			val liveInfoModified = ref false
			fun updateLiveInfo node = 
				let
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
					val () = log("CurrLiveOut:")
					val () = printTempList currOut
					val () = log("CurrLiveIn:")
					val () = printTempList currIn
					val () = log("PrevLiveOut:")
					val () = printTempList prevOut
					val () = log("PrevLiveIn:")
					val () = printTempList prevIn
					

					(*Least fix point check, diffTempList = [] means no change*)
					fun checkNoChange(l1,l2) =
						if diffTempList(l2,l1) = [] 
							then (log("No change.")(*shouldn't set false, should only set true when modified*)) 
						else (log("There's change."); liveInfoModified := true)

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
					log("in in in in in in in in in ");
					log("val unit in bool traverseNodeReversely start!");
					List.app updateLiveInfo (List.rev(controlNodes));
					(*Continue until no more chagnes in live-in & live-out*)
					if !liveInfoModified 
						then (
							liveInfoModified := false; 
							log("traverseNodeReversely next!");
							traverseNodeReversely()
							)
					else (
							log("in traverseNodeReversely finish!")
						)
				)

			val () = traverseNodeReversely()

			(*
			 * Build the interference graph according to the liveness info
			 * Add an edge to the graph for each pair of temporaies in the set
			 *
			 * The node passed in is the control-flow graph node	
			 *)			
			fun createNodeAndConnectEdge controlNode = 
				let
					

					(*TO-DO*)
					(*
					 * Check current node ismove?
					 * If yes, store the info and find a match 
					 * and store to 
					 *       moves: (IGraph.node * IGraph.node) list
					 *)

					val () = log("=====createNodeAndConnectEdge:====="^Graph.nodename(controlNode))
					val () = log("Temp:"^Temp.makestring(nodeToTemp(controlNode)))
					(*Assum definitely can be found*)
					val currDefTempList = getTempListFromMap(def,controlNode)
					val liveOutTemplist = getLiveOutTemps(controlNode)
					(*TO-DO may not be right*)
					(*val tempList = combineTempList(currDefTempList,liveOutTemplist)*)


					(*Traverse live-out temp list, and find/creat new igraph.node in the meanwhile*)
					(*See tempToNode & nodeToTemp*)
					(*fun traverseLiveOutTempList(temp::temps,igraphNodes) = *)
							(*let*)
								(*val igraphNode = tempToNode(temp)*)
								(*val () = log("igraphNode:"^IGraph.nodename(igraphNode))*)
								(*val igraphNodesResult = igraphNode::traverseLiveOutTempList(temps,igraphNodes)*)
								(*val () = log("igraphNode number:"^Int.toString(List.length(igraphNodesResult)))*)
							(*in*)
								(*igraphNodesResult*)
								(*igraphNode::igraphNodes*)
							(*end*)
						(*| traverseLiveOutTempList([],igraphNodes) = igraphNodes*)


					(*val igraphNodes = traverseLiveOutTempList(liveOutTemplist,[])*)


					val currDefIgraphNodes = map tempToNode currDefTempList
					val liveOutIgraphNodes = map tempToNode liveOutTemplist
					(*val igraphNodes = map tempToNode tempList*)




					val () = log("!!!!!!igraphNodes!!!!!")
					(*val () = printNodeList(igraphNodes)*)
					val () = log'("Def:")
					val () = printNodeList(currDefIgraphNodes)
					val () = log'("Live out:")
					val () = printNodeList(liveOutIgraphNodes)

					(*------------------------------------------------------------------*)

					(*						take a look at following					*)
					(*								||									*)
					(*								\/									*)
					(*------------------------------------------------------------------*)


					(*			这里难道不应该是把 node 和 igraphNodes 连起来么？		*)
					(* node是我们在处理的那个node，igraphNodes 是所有跟他interfere的节点 *)
					(* 		按照老师上课讲的，应该是把node和所有liveoutnode连接起来，
										也就是你这里的igraphnodes,						*)
					(*				而不是igraphnodes 和igraphNodes 连 					*)
					(* 							am i right?								*)

					(*------------------------------------------------------------------*)

					(*Connect the igraph node with each other*)
					(*TO-DO bug with duplicated igraph node*)
					(*fun connectIGraphNode(node1::nodes1,node2::nodes2) = 
							if IGraph.eq(node1,node2) 
							then (
									connectIGraphNode(node1::nil,nodes2);
									connectIGraphNode(nodes1,nodes2) 
								)
							else (
									log("Connecting edge:"^IGraph.nodename(node1)^"and"^IGraph.nodename(node2));
									IGraph.mk_edge{from=node1,to=node2};
									Connect node1 with all nodes2
									connectIGraphNode(node1::nil,nodes2);
									Connect nodes1 with all node2 and nodes2
									connectIGraphNode(nodes1,node2::nodes2)
								)
						| connectIGraphNode([],_) = ()
						| connectIGraphNode(_,[]) = ()*)
					(*val () = connectIGraphNode(currDefIgraphNodes,liveOutIgraphNodes)*)

					fun connectIGraphNode(node1,node2) = 
						if IGraph.eq(node1,node2) then () else IGraph.mk_edge{from=node1,to=node2}

					val () = app (fn defNode =>
									app (fn liveOutNode =>
											connectIGraphNode(defNode,liveOutNode)
										) liveOutIgraphNodes
								) currDefIgraphNodes
				in
					()
				end

			fun travserLiveOutMap() =
				(
					List.app createNodeAndConnectEdge controlNodes
				)
			val () = travserLiveOutMap()



			(*Result*)
			val igraph = IGRAPH{
							graph=interferenceGraphResult,
							tnode=tempToNode,
							gtemp=nodeToTemp,
							moves=movesList
							}
			val () = show(TextIO.openOut("liveness_show"),igraph)

		in
			(igraph, getLiveOutTemps)
		end

	(*
	 * Show prints out for, debugging purposes, a list of nodes in the interference graph,
	 * and for each node, a list of nodes adjacent to it.
	 *)
	(*TO-DO for outstream*)
	and show (outstream,IGRAPH{graph,tnode,gtemp,moves}) = 
		let
			val () = log("show")
			val igraphNodes = IGraph.nodes(graph)
			val () = List.app (
								fn inode => 
									let
										val adjNodes = IGraph.adj(inode)
									in
										log'("Current node:");
										printNodeList([inode]);
										log'("Adjacent nodes:");
										printNodeList(adjNodes)
									end
								) igraphNodes
		in
			()
		end
end