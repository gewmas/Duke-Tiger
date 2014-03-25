signature CODEGEN =
sig
	structure Frame : FRAME = MipsFrame
    val codegen : Frame.frame -> Tree.stm -> Assem.instr list

    val munchExp : Tree.exp -> Temp.temp
    val munchStm : Tree.stm -> unit
end

structure Mips : CODEGEN = 
struct
	structure A = Assem
	structure T = Tree
	structure Frame : FRAME = MipsFrame

	fun result(gen) = let val t = Temp.newtemp() in gen t; t end 

	fun munchStm(T.SEQ(a,b)) = (munchStm a; munchStm b)

	and munchExp(T.TEMP t) = t





	fun codegen (frame) (stm : T.stm) : A.instr list =
		let
			val ilist = ref (nil : A.instr list)
			fun emit x = ilist := x :: !ilist
		in
			A.LABEL{assem="test321\n",lab=Symbol.symbol("testabc\n")}::nil

			(*munchStm stm;
			rev(!ilist)*)
		end
		
end
