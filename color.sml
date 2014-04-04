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


    (*TO-DO Simplify, Spill, Select*)
    fun color {interference,initial,spillCost,registers} =
    	let
    		
    	in
            (*
             * Result of Color
             * AllocationResult - allocation describing the register allocation
             * Temps - list of spills
             *)
    		(initial,[])
    	end
end