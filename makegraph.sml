signature MAKEGRAPH = 
sig
    val instrs2graph : Assem.instr list ->
                       Flow.flowgraph * (*Flow.*)Graph.node list
end

structure Makegraph :> MAKEGRAPH =
struct
	(*TO-DO*)
	fun instrs2graph instrs = 
		let
			val dumbtable = Graph.Table.empty
			val flowgraph = Flow.FGRAPH{control=Graph.newGraph(),def=dumbtable,use=dumbtable,ismove=dumbtable}
			val nodes = Graph.newNode(Graph.newGraph())::nil
		in
			(flowgraph,nodes)
		end
end


