signature REG_ALLOC = 
sig
	structure Frame : FRAME
    type allocation = Frame.register Temp.Table.table
    val alloc : Assem.instr list * Frame.frame -> Assem.instr list * allocation             
end

structure RegAlloc : REG_ALLOC = 
struct
	structure Frame : FRAME = MipsFrame
    type allocation = Frame.register Temp.Table.table

    val allowPrint = true
    fun log info = if allowPrint then print("***RegAlloc*** "^info^"\n") else ()


    (*TO-DO*)
    fun alloc (instrs,frame) = 
    	let
    		(* p222 
    		 * First, the control flow of the Assem prgram is analyzed, producing a control-flow grap;
			 * Then, the liveness of variables in the control-flow graph is analyzed, producing an interference graph.
    		 *)
            val () = log("Makegraph")
    		val (controlFlowGraph,nodes) = Makegraph.instrs2graph(instrs)
            val () = log("Liveness")
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
            (*TO-DO*)
            val allocationResult = Temp.Table.empty 
            val registers : MipsFrame.register list = []
            fun caculateSpillCost node = 1

            (*
             * Simpilfy
             *)

            

            (*
             * Select
             *)


            (*Result*)
            val (allocation,temps) = Color.color{
                                            interference=interferenceGraph,
                                            initial=allocationResult,
                                            spillCost=caculateSpillCost,
                                            registers=registers
                                            }

    		
    	in
    		(instrs,allocationResult)
    	end
end