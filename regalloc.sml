signature REG_ALLOC = 
sig
	structure Frame : FRAME = MipsFrame
    type allocation = Frame.register Temp.Table.table
    val alloc : Assem.instr list * Frame.frame -> Assem.instr list * allocation             
end

structure RegAlloc : REG_ALLOC = 
struct
	structure Frame : FRAME = MipsFrame
    type allocation = Frame.register Temp.Table.table

    val allowPrint = false
    fun log info = if allowPrint then print("***RegAlloc*** "^info^"\n") else ()


    fun alloc (instrs,frame) = 
    	let
    		(* p222 
    		 * First, the control flow of the Assem prgram is analyzed, producing a control-flow grap;
			 * Then, the liveness of variables in the control-flow graph is analyzed, producing an interference graph.
    		 *)
            val () = log("\n\n\n&&&&&&&&Makegraph&&&&&&&&&\n\n\n")
    		val (controlFlowGraph,nodes) = Makegraph.instrs2graph(instrs)
            val () = log("\n\n\n&&&&&&&&Liveness&&&&&&&&\n\n\n")
    		val (interferenceGraph,liveOut) = Liveness.interferenceGraph(controlFlowGraph)

            (*Reference Only*)
            (*type allocation = MipsFrame.register Temp.Table.table*)
            (*val color : {interference: Liveness.igraph,
                 initial: allocation,
                 spillCost: Graph.node -> int,
                 registers: MipsFrame.register list}
                -> allocation * Temp.temp list*)

            (*
             * p253
             * Color, which does just the graph coloring itself
             * RegAlloc, which manages spilling and calls upon Color as a subroutine
             *)
            val allocationInit : allocation = Frame.tempMap
            val registers : MipsFrame.register list = Frame.colorregs (*all machine registers*)
            (*p254 A naive spillCost that just returns 1 for every temporary will also work*)
            fun caculateSpillCost node = 1 

            (*
             * Result of Color
             * AllocationResult - allocation describing the register allocation
             * Temps - list of spills
             *)
            val (allocationResult,temps) = Color.color{
                                            interference=interferenceGraph,
                                            initial=allocationInit,
                                            spillCost=caculateSpillCost,
                                            registers=registers
                                            }
            val () = log("I am reaching end of regalloc.sml")

    	in
    		(instrs,allocationResult)
            (*(instrs,allocationInit)*)
    	end
end