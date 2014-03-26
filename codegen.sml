signature CODEGEN =
sig
	structure Frame : FRAME = MipsFrame
    val codegen : Frame.frame -> Tree.stm -> Assem.instr list

    (*val munchExp : Tree.exp -> Temp.temp
    val munchStm : Tree.stm -> unit*)
end

structure Mips : CODEGEN = 
struct
	structure A = Assem
	structure T = Tree
	structure Frame : FRAME = MipsFrame

	fun int i = if i<0 then (String.concat ["-",Int.toString(0-i)]) else Int.toString(i)

	fun codegen (frame) (stm : T.stm) : A.instr list =
		let
			val ilist = ref (nil : A.instr list)
			fun emit x = ilist := x :: !ilist

			fun result(gen) = let val t = Temp.newtemp() in gen t; t end 

			(*TO-DO Match all munchStm and mucnchExp*)
			(*
				stm = SEQ of stm * stm
				| LABEL of label
				| JUMP of exp * label list
				| CJUMP of relop * exp * exp * label * label
				| MOVE of exp * exp
				| EXP of exp
			*)
			fun munchStm(T.SEQ(a,b)) = 
					(munchStm a; munchStm b)

				| munchStm(T.LABEL lab) = 
	    			emit(A.LABEL{
	    				assem=Symbol.name(lab)^":\n", 
	    				lab=lab})

	    		(*TO-DO*)
	    		| munchStm(T.JUMP(exp,labellist)) = 
	    			()

	    		(*TO-DO*)
	    		| munchStm(T.CJUMP(relop,e1,e2,l1,l2)) = 
	    			()

				| munchStm(T.MOVE(T.MEM(T.BINOP(T.PLUS,e1,T.CONST i)),e2)) =
					emit(A.OPER{
						assem="STORE M['s0+"^int i^"] <- 's1\n",
						src=[munchExp e1, munchExp e2],
						dst=[],
						jump=NONE})
				| munchStm(T.MOVE(T.MEM(T.BINOP(T.PLUS,T.CONST i,e1)),e2)) =
				    emit(A.OPER{
				    	assem="STORE M['s0+"^int i^"] <- 's1\n",
					    src=[munchExp e1, munchExp e2],
					    dst=[],
					    jump=NONE})
				| munchStm(T.MOVE(T.MEM(e1),T.MEM(e2))) =
					emit(A.OPER{
				    	assem="MOVE M['s0] <- M['s1]\n",
					    src=[munchExp e1, munchExp e2],
					    dst=[],
					    jump=NONE})
				| munchStm(T.MOVE(T.MEM(T.CONST i),e2)) =
					emit(A.OPER{
				    	assem="STORE M[r0+"^int i^"] <- 's0\n",
					    src=[munchExp e2],
					    dst=[],
					    jump=NONE})
				| munchStm(T.MOVE(T.MEM(e1),e2)) =
					emit(A.OPER{
				    	assem="STORE M['s0] <- 's1\n",
					    src=[munchExp e1, munchExp e2],
					    dst=[],
					    jump=NONE})
				| munchStm(T.MOVE(T.TEMP i,e2)) =
					emit(A.OPER{
				    	assem="ADD 'd0 <- 's0 + r0\n",
					    src=[munchExp e2],
					    dst=[i],
					    jump=NONE})

				(*TO-DO*)
	    		| munchStm(T.MOVE(e1,e2)) = 
	    			()
	    		(*TO-DO*)
				| munchStm(T.EXP exp) =
					(munchExp exp; ())
				
			(*
				exp = BINOP of binop * exp * exp
				| ESEQ of stm * exp
				| CONST of int
				| CALL of exp * exp list
				| MEM of exp
				| TEMP of Temp.temp
				| NAME of label
			*)
			and munchExp(T.BINOP(T.PLUS,e1,T.CONST i)) =
		           	result(fn r => emit(A.OPER{
		           		assem="ADDI 'd0 <- 's0+"^int i^"\n",
						src=[munchExp e1], 
						dst=[r], 
						jump=NONE}))
		        | munchExp(T.BINOP(T.PLUS,T.CONST i,e1)) =
		           	result(fn r => emit(A.OPER{
		           		assem="ADDI 'd0 <- 's0+"^int i^"\n",
						src=[munchExp e1], 
						dst=[r], 
						jump=NONE}))
		        | munchExp(T.BINOP(T.PLUS,e1,e2)) =
		           	result(fn r => emit(A.OPER{
		           		assem="ADDI 'd0 <- 's0+'s1'\n",
						src=[munchExp e1,munchExp e2], 
						dst=[r], 
						jump=NONE}))
		        (*TO-DO*)
		        | munchExp(T.BINOP(binop,e1,e2)) = 
		        	0

		        (*TO-DO*)
		        | munchExp(T.ESEQ(stm,exp)) = 
		        	0

		        | munchExp(T.CONST i) =
		           	result(fn r => emit(A.OPER{
		           		assem="ADDI 'd0 <- 'r0+"^int i^"\n",
						src=[], 
						dst=[r], 
						jump=NONE}))

		        (*TO-DO*)
		        | munchExp(T.CALL(exp,explist)) = 
		        	0

				| munchExp(T.MEM(T.BINOP(T.PLUS,e1,T.CONST i))) =
		           	result(fn r => emit(A.OPER{
		           		assem="LOAD 'd0 <- M['s0+"^int i^"]\n",
						src=[munchExp e1], 
						dst=[r], 
						jump=NONE}))
		        | munchExp(T.MEM(T.BINOP(T.PLUS,T.CONST i,e1))) =
		           	result(fn r => emit(A.OPER{
		           		assem="LOAD 'd0 <- M['s0+"^int i^"]\n",
						src=[munchExp e1], 
						dst=[r], 
						jump=NONE}))
		        | munchExp(T.MEM(T.CONST i)) =
		           	result(fn r => emit(A.OPER{
		           		assem="LOAD 'd0 <- M['r0+"^int i^"]\n",
						src=[], 
						dst=[r], 
						jump=NONE}))
		        | munchExp(T.MEM(e1)) =
		           	result(fn r => emit(A.OPER{
		           		assem="LOAD 'd0 <- M['s0+0]\n",
						src=[munchExp e1], 
						dst=[r], 
						jump=NONE}))

				| munchExp(T.TEMP t) = t

				(*TO-DO*)
		        | munchExp(T.NAME(label)) = 
		        	0
		in
			A.LABEL{assem="test321\n",lab=Symbol.symbol("testabc\n")}::nil

			(*munchStm stm;
			rev(!ilist)*)
		end
		
end
