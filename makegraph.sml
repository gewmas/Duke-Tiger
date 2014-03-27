signature MAKEGRAPH = 
sig
    val instrs2graph : Assem.instr list ->
                       Flow.flowgraph * (*Flow.*)Graph.node list
end

(*structure Makegraph :> MAKEGRAPH =
struct
	fun instrs2graph instrs = 
end*)


