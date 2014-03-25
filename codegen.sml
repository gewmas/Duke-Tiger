signature CODEGEN =
sig
	structure Frame : FRAME = MipsFrame
    val codegen : Frame.frame -> Tree.stm -> Assem.instr list
end

structure Mips : CODEGEN = 
struct
	structure A = Assem
	structure T = Tree
	structure Frame : FRAME = MipsFrame

	fun codegen (frame) (stm : T.stm) : A.instr list =
		A.LABEL{assem="test",lab=Symbol.symbol("")}::nil
end
