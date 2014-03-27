signature REG_ALLOC = 
sig
	structure Frame : FRAME
    type allocation = Frame.register Temp.Table.table
    (*val alloc : Assem.instr list * Frame.frame -> Assem.instr list * allocation             *)
end

structure Reg_Alloc : REG_ALLOC = 
struct
	structure Frame : FRAME = MipsFrame
    type allocation = Frame.register Temp.Table.table

end