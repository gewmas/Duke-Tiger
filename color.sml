signature COLOR = 
sig
	structure Frame : FRAME     
    type allocation = Frame.register Temp.Table.table
		      
    val color : {
		interference: Liveness.igraph,
		initial: allocation,
		spillCost: Graph.node -> int,
		registers: Frame.register list
	} -> allocation * Temp.temp list
end

structure Color : COLOR = 
struct
	structure Frame : FRAME = MipsFrame
    type allocation = Frame.register Temp.Table.table
    structure G = IGraph

    structure TempKey = 
    struct
    type ord_key = Temp.temp
    val compare  = Int.compare
    end

    structure S = SplaySetFn(TempKey)

    fun getindex(r,rlist)= 
        let
            val iref = ref 0
            (*val whatever = List.exists (fn ther => (iref := !iref+1; r=ther)) rlist*)
            fun find(r, []) = ~1
                | find(r, a::l) = 
                if String.compare(r, a) = EQUAL
                then !iref
                else (iref := !iref + 1; find(r, l))
        in
            find(r, rlist)
        end

    (*val r = "abc"
    val rlist = ["acb", "abc"]
    val () = print(Int.toString(getindex(r, rlist)))*)


    structure ColorKey = 
    struct
    type ord_key = MipsFrame.register
    val compare =fn(r1,r2)=>Int.compare(getindex(r1,MipsFrame.registers(*colorregs*)),getindex(r2,MipsFrame.registers(*colorregs*)))
    end

    structure ColorSet = SplaySetFn(ColorKey)

    val allowPrint = false
    fun log info = if allowPrint then print("***Color*** "^info^"\n") else ()


    (*Reference Only*)
    (*
        datatype igraph =
        IGRAPH of {
            graph: IGraph.graph,
            tnode: Temp.temp -> IGraph.node,
            gtemp: IGraph.node -> Temp.temp,
            moves: (Graph.node * Graph.node) list
        }
    *)

    (*TO-DO Simplify, Spill, Select*)
    fun color {interference = Liveness.IGRAPH {graph, tnode, gtemp, moves},initial,spillCost,registers} =
    	let
            (*Helper function*)
            (*fun show() = 
                let
                    val igraph = Liveness.IGRAPH {graph, tnode, gtemp, moves}
                in
                    Liveness.show'(igraph)
                end*)





            (*set up color set for all available machine registers*)
    		val colorSet = ColorSet.addList(ColorSet.empty, registers)
            val K = List.length(registers)
            val () = log("length of available colors:"^Int.toString(K))

            (*find all the temps of nodes that is not machine registers*)
            val nodes = G.nodes(graph)
            val () = log("length of nodes in igraph are "^Int.toString(List.length(nodes)))
           
            val all = S.addList(S.empty, (map gtemp nodes))
            val nodesTempSet = 
                let
                    val all = S.addList(S.empty, (map gtemp nodes))
                    fun isExisted(t) = 
                        case Temp.Table.look(initial, t) of
                            SOME(x) => false
                            | NONE => true
                in
                    S.filter isExisted all
                end

            val () = log("length of nodesTempSet are "^Int.toString(List.length( S.listItems(nodesTempSet) )))

            fun highDegree(nodesTempSet) = S.filter (fn t => List.length(G.adj(tnode(t))) >= K ) nodesTempSet
            fun lowDegree(nodesTempSet) = S.filter (fn t => List.length(G.adj(tnode(t))) < K ) nodesTempSet

            fun spill(spillList,table) = (ErrorMsg.error 0 "cannot color; rewrite your program" ;([],table,spillList))


            (*simplify*)
            fun buildStack(tempSet, stack, table) = 
                let
                    val significantNodesTemp = S.listItems(highDegree(tempSet))
                    val insignificantNodesTemp = S.listItems(lowDegree(tempSet))
                    val () = log("Reached in buildStack label 1")

                in
                    if List.null(significantNodesTemp) andalso List.null(insignificantNodesTemp)
                    then (
                            log("significant and insignificant are all empty");
                            (stack, table, [])
                         )
                    else if List.null(insignificantNodesTemp)
                            then spill(significantNodesTemp, table)
                            else 
                                let
                                    
                                    val node = tnode(List.hd(insignificantNodesTemp))
                                    val stack' = stack@[node]
                                    (*val () = log("Reached in buildStack label 2")*)

                                    (*val adjNodes = G.adj(node)

                                    val table' = Temp.Table.enter(table, gtemp(node), adjNodes)
                                    fun removeAdj([]) = ()
                                        | removeAdj(adjNode::adjNodes) = 
                                        (
                                            G.rm_edge{from=node, to=adjNode};
                                            log("From:"^G.nodename(node)^" To:"^G.nodename(adjNode));
                                            removeAdj(adjNodes)
                                        )
                                    val () = removeAdj(adjNodes)*)

                                    val predNodes = G.pred(node)
                                    val succNodes = G.succ(node)
                                    val table' = Temp.Table.enter(table, gtemp(node), predNodes@succNodes)

                                    val () = log("Current node:"^G.nodename(node))
                                    val () = log("PredNodes: "^Int.toString(List.length(predNodes)))
                                    val () = log("SuccNodes: "^Int.toString(List.length(succNodes)))

                                    fun removePred([]) = (log("no pred to remove pred"))
                                        | removePred(predNode::predNodes) = 
                                        (
                                            log("about to remove Pred From:"^G.nodename(predNode)^" To:"^G.nodename(node));
                                            G.rm_edge{from=predNode, to=node};
                                            log("in !removePred! From:"^G.nodename(predNode)^" To:"^G.nodename(node));
                                            removePred(predNodes)
                                        )
                                    val () = removePred(predNodes)

                                    fun removeSucc([]) = (log("no pred to remove succ"))
                                        | removeSucc(succNode::succNodes) = 
                                        (
                                            log("about to remove Succ From:"^G.nodename(node)^" To:"^G.nodename(succNode));
                                            G.rm_edge{from=node, to=succNode};
                                            log("in !removeSucc! From:"^G.nodename(node)^" To:"^G.nodename(succNode));
                                            removeSucc(succNodes)
                                        )
                                    val () = removeSucc(succNodes)



                                    val () = log("Reached in buildStack label 3")

                                    val tempSet' = S.delete(tempSet, gtemp(node))


                                in
                                    buildStack(tempSet', stack', table')
                                end
                end

            val (finalStack, adjTable, spillList) = buildStack(nodesTempSet, [], Temp.Table.empty)
            val () = log("buildStack finish")

            (*assign color*)
            fun graphColor([], colorTable) = (log("colorTable is empty"); colorTable)
                | graphColor(stack, colorTable) = 
                    let
                        val topNode = List.last(stack)
                        val adjNodes = valOf(Temp.Table.look(adjTable, gtemp(topNode)))

                        val adjTempList = map gtemp adjNodes

                        val leftColors = 
                            let
                                fun findLeftColors(currColorSet,[]) = currColorSet
                                    | findLeftColors(currColorSet, temp::temps) = 
                                        case Temp.Table.look(colorTable, temp) of
                                            SOME(c) => findLeftColors(ColorSet.difference(currColorSet, ColorSet.singleton(c)), temps)
                                            | NONE => findLeftColors(currColorSet, temps)
                            in
                                findLeftColors(colorSet, adjTempList)
                            end 
                        
                        val newColor = List.hd(ColorSet.listItems(leftColors))
                        val () = log("=================newly assigned color ===========================")
                        val () = log(G.nodename(topNode)^": "^newColor^"\n")
                        val colorTable' = Temp.Table.enter(colorTable, gtemp topNode, newColor)
                        val stack' = List.take(stack, List.length(stack)-1)

                    in
                        graphColor(stack', colorTable')
                    end

    	in
            (*
             * Result of Color
             * AllocationResult - allocation describing the register allocation
             * Temps - list of spills
             *)
            log("I am reach beginning of in part");
            (*(initial, spillList)*)
    		(graphColor(finalStack, initial), spillList)
    	end
end