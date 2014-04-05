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
    val compare =fn(r1,r2)=>Int.compare(getindex(r1,MipsFrame.colorregs),getindex(r2,MipsFrame.colorregs))
    end

    structure ColorSet = SplaySetFn(ColorKey)



    (*TO-DO Simplify, Spill, Select*)
    fun color {interference = Liveness.IGRAPH {graph, tnode, gtemp, moves},initial,spillCost,registers} =
    	let
            (*set up color set for all available machine registers*)
    		val colorSet = ColorSet.addList(ColorSet.empty, registers)
            val K = List.length(registers)

            (*find all the temps of nodes that is not machine registers*)
            val nodes = G.nodes(graph)
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

            fun highDegree(nodesTempSet) = S.filter (fn t => List.length(G.adj(tnode(t))) >= K ) nodesTempSet
            fun lowDegree(nodesTempSet) = S.filter (fn t => List.length(G.adj(tnode(t))) < K ) nodesTempSet

            fun spill(spillList,table) = (ErrorMsg.error 0 "cannot color; rewrite your program" ;([],table,spillList))

            fun buildStack(tempSet, stack, table) = 
                let
                    val significantNodesTemp = S.listItems(highDegree(tempSet))
                    val insignificantNodesTemp = S.listItems(lowDegree(tempSet))

                in
                    if List.null(significantNodesTemp) andalso List.null(insignificantNodesTemp)
                    then (stack, table, [])
                    else if List.null(insignificantNodesTemp)
                            then spill(significantNodesTemp, table)
                            else 
                                let
                                    
                                    val node = tnode(List.hd(insignificantNodesTemp))
                                    val stack' = stack@[node]
                                    val adjNodes = G.adj(node)

                                    val table' = Temp.Table.enter(table, gtemp(node), adjNodes)
                                    
                                    (* can i write like this, or should i follow like preds and succs*)
                                    fun removeAdj([]) = ()
                                        | removeAdj(adjNode::adjNodes) = 
                                        (
                                            G.rm_edge{from=node, to=adjNode};
                                            removeAdj(adjNodes)
                                        )
                                    val () = removeAdj(adjNodes)
                                    val tempSet' = S.delete(tempSet, gtemp(node))

                                in
                                    buildStack(tempSet', stack', table')
                                end
                end

            val (stack, adjTable, spillList) = buildStack(nodesTempSet, [], Temp.Table.empty)

    	in
            (*
             * Result of Color
             * AllocationResult - allocation describing the register allocation
             * Temps - list of spills
             *)
    		(initial,[])
    	end
end