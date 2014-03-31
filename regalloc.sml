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

    (*TO-DO*)
    fun alloc (instrs,frame) = 
    	let
    		(* p222 
    		 * First, the control flow of the Assem prgram is analyzed, producing a control-flow grap;
			 * Then, the liveness of variables in the control-flow graph is analyzed, producing an interference graph.
    		 *)
    		val (controlFlowGraph,nodes) = Makegraph.instrs2graph(instrs)
    		val (interferenceGraph,liveOut) = Liveness.interferenceGraph(controlFlowGraph)

            (*
             * p253
             * Color, which does just the graph coloring itself
             * RegAlloc, which manages spilling and calls upon Color as a subroutine
             *)
            val a = Temp.Table.empty (*TO-DO*)
            val (allocation,temps) = Color.color{
                                            interference=interferenceGraph,
                                            initial=a,
                                            spillCost=(fn node => 1),
                                            registers=[]
                                            }

    		
    	in
    		(instrs,a)
    	end
end