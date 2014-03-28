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

			(*Match all munchStm and munchExp*)
			(*
				stm = SEQ of stm * stm
				| LABEL of label
				| JUMP of exp * label list
				| CJUMP of relop * exp * exp * label * label
				| MOVE of exp * exp
				| EXP of exp
			*)

			fun munchRelop T.EQ = "beq"
				| munchRelop T.NE = "bne"
				| munchRelop T.LT = "blt"
				| munchRelop T.GT = "bgt"
				| munchRelop T.LE = "ble"
				| munchRelop T.GE = "bge"
				| munchRelop T.ULT = "bltu"
				| munchRelop T.ULE = "bleu"
				| munchRelop T.UGT = "bgtu"
				| munchRelop T.UGE = "bgeu"

			and munchArgs(i,args) = [0]

			and munchStm(T.SEQ(a,b)) = 
					(munchStm a; munchStm b)

				| munchStm(T.LABEL lab) = 
	    			emit(A.LABEL{
	    				assem=Symbol.name(lab)^":\n", 
	    				lab=lab})

	    		(*--------------------- JUMP and CJUMP ---------------------------------------------*)

	    		| munchStm(T.JUMP(exp,labellist)) = 
	    			emit(A.OPER{
						assem="j $`s0 \n",
						src=[munchExp exp],
						dst=[],
						jump=SOME(labellist)})



	    		(*this should not be right according to logic analysis*)
	    		(*| munchStm(T.CJUMP(relop,T.CONST i,e1,l1,l2)) = 
	    			emit(A.OPER{
	    				assem=((munchRelop(relop))^" $`s0,"^int i^", "^ Symbol.name(l1)^"\n"),
		      			src=[munchExp e1], 
		      			dst=[], 
		      			jump=SOME([l1,l2])})*)
	    		| munchStm(T.CJUMP(relop,e1,T.CONST i,l1,l2)) = 
	    			emit(A.OPER{
	    				assem=((munchRelop(relop))^" "^int i^", $`s0, "^ Symbol.name(l1)^"\n"),
		      			src=[munchExp e1], 
		      			dst=[], 
		      			jump=SOME([l1,l2])})
	    		| munchStm(T.CJUMP(relop,e1,e2,l1,l2)) = 
	    			emit(A.OPER{
	    				assem=((munchRelop(relop))^" $`s0, $`s1, "^ Symbol.name(l1)^"\n"),
		      			src=[munchExp e1,munchExp e2], 
		      			dst=[], 
		      			jump=SOME([l1,l2])})


	    		(*--------------------- SAVE and MOVE ---------------------------------------------*)

				| munchStm(T.MOVE(T.MEM(T.BINOP(T.PLUS,e1,T.CONST i)),e2)) =
					emit(A.OPER{
						assem="sw $`s1, "^int i^"($`s0)\n",
						src=[munchExp e1, munchExp e2],
						dst=[],
						jump=NONE})

				| munchStm(T.MOVE(T.MEM(T.BINOP(T.PLUS,T.CONST i,e1)),e2)) =
				    emit(A.OPER{
				    	assem="sw $`s1, "^int i^"($`s0)\n",
					    src=[munchExp e1, munchExp e2],
					    dst=[],
					    jump=NONE})

				| munchStm(T.MOVE(T.MEM(e1),T.MEM(e2))) =
					emit(A.OPER{
				    	assem="move $`s0, $`s1\n",
					    src=[munchExp e1, munchExp e2],
					    dst=[],
					    jump=NONE})

				| munchStm(T.MOVE(T.MEM(T.CONST i),e2)) =
					emit(A.OPER{
				    	assem="sw $`s0, "^int i^"($zero)\n",
					    src=[munchExp e2],
					    dst=[],
					    jump=NONE})

				| munchStm(T.MOVE(T.MEM(e1),e2)) =
					emit(A.OPER{
				    	assem="sw $`s1, $`s0\n",
					    src=[munchExp e1, munchExp e2],
					    dst=[],
					    jump=NONE})
				| munchStm(T.MOVE(T.TEMP i,e2)) =
					emit(A.OPER{
				    	assem="sw $`s0, $`d0\n",
					    src=[munchExp e2],
					    dst=[i],
					    jump=NONE})

				(*TO-DO*)
	    		| munchStm(T.MOVE(e1,e2)) = 
	    			()

	    		(*TO-DO*)
	    		(*Procedure Calls p203*)
				| munchStm(T.EXP(T.CALL(e,args))) =
					emit(A.OPER{
				    	assem="CALL `s0\n",
					    src=munchExp(e)::munchArgs(0,args),
					    dst=Frame.calldefs,
					    jump=NONE})
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
		           		assem="addi $`d0, $`s0, "^int i^"\n",
						src=[munchExp e1], 
						dst=[r], 
						jump=NONE}))
		        | munchExp(T.BINOP(T.PLUS,T.CONST i,e1)) =
		           	result(fn r => emit(A.OPER{
		           		assem="addi $`d0, $`s0, "^int i^"\n",
						src=[munchExp e1], 
						dst=[r], 
						jump=NONE}))
		        | munchExp(T.BINOP(T.PLUS,e1,e2)) =
		           	result(fn r => emit(A.OPER{
		           		assem="add $`d0, $`s0, $`s1\n",
						src=[munchExp e1,munchExp e2], 
						dst=[r], 
						jump=NONE}))
		        | munchExp(T.BINOP(T.MINUS,e1,e2)) =
		           	result(fn r => emit(A.OPER{
		           		assem="sub $`d0, $`s0, $`s1\n",
						src=[munchExp e1,munchExp e2], 
						dst=[r], 
						jump=NONE}))
		        | munchExp(T.BINOP(T.MUL,e1,e2)) =
		           	result(fn r => emit(A.OPER{
		           		assem="mul $`d0, $`s0, $`s1\n",
						src=[munchExp e1,munchExp e2], 
						dst=[r], 
						jump=NONE}))
		        | munchExp(T.BINOP(T.DIV,e1,e2)) =
		           	result(fn r => emit(A.OPER{
		           		assem="div $`d0, $`s0, $`s1\n",
						src=[munchExp e1,munchExp e2], 
						dst=[r], 
						jump=NONE}))
		        | munchExp(T.BINOP(T.AND,e1,T.CONST i)) =
		            result(fn r => emit(A.OPER{
		            	assem="andi $`d0, $`s0, "^int i^ "\n",
						src=[munchExp e1], 
						dst=[r], 
						jump=NONE}))
				| munchExp(T.BINOP(T.AND,T.CONST i,e1)) =
		            result(fn r => emit(A.OPER{
		            	assem="andi $`d0, $`s0, "^int i^ "\n",
						src=[munchExp e1], 
						dst=[r], 
						jump=NONE}))
				| munchExp(T.BINOP(T.AND, e1, e2)) =
		            result(fn r => emit(A.OPER{
		            	assem="and $`d0, $`s0, $`s1\n",
						src=[munchExp e1, munchExp e2], 
						dst=[r], 
						jump=NONE}))
				| munchExp(T.BINOP(T.OR, e1, T.CONST i)) =
		            result(fn r => emit(A.OPER{
		            	assem="ori $`d0, $`s0, "^int i^ "\n",
						src=[munchExp e1], 
						dst=[r], 
						jump=NONE}))
				| munchExp(T.BINOP(T.OR,T.CONST i, e1)) =
		            result(fn r => emit(A.OPER{
		            	assem="ori $`d0, $`s0,"^int i^ "\n",
						src=[munchExp e1], 
						dst=[r], 
						jump=NONE}))
			    | munchExp(T.BINOP(T.OR, e1, e2)) =
		            result(fn r => emit(A.OPER{
		            	assem="or $`d0, $`s0, $`s1\n",
						src=[munchExp e1, munchExp e2], 
						dst=[r], 
						jump=NONE}))
			    | munchExp(T.BINOP(T.LSHIFT, e1, e2)) = 
		            result(fn r => emit(A.OPER{
		            	assem="sll $`d0, $`s0, $`s1",
						src=[munchExp e1, munchExp e2], 
						dst=[r], 
						jump=NONE}))
		        | munchExp(T.BINOP(T.RSHIFT, e1, e2)) = 
		            result(fn r => emit(A.OPER{
		            	assem="srl $`d0, $`s0, $`s1",
						src=[munchExp e1, munchExp e2], 
						dst=[r], 
						jump=NONE}))
		        | munchExp(T.BINOP(T.ARSHIFT, e1, e2)) = 
		            result(fn r => emit(A.OPER{
		            	assem="sra $`d0, $`s0, $`s1",
						src=[munchExp e1, munchExp e2], 
						dst=[r], 
						jump=NONE}))
		        | munchExp(Tree.BINOP(T.XOR, e1, e2)) = 
		            result(fn r => emit(A.OPER{
		            	assem="xor $`d0, $`s0, $`s1",
						src=[munchExp e1, munchExp e2], 
						dst=[r], 
						jump=NONE}))

		        | munchExp(T.ESEQ(stm,exp)) = 
		        	(munchStm(stm);munchExp(exp))

		        | munchExp(T.CONST i) =
		           	result(fn r => emit(A.OPER{
		           		assem="addi $`d0, $zero, "^int i^"\n",
						src=[], 
						dst=[r], 
						jump=NONE}))

		        (*TO-DO*)
		        | munchExp(T.CALL(exp,explist)) = 
		        	0

				| munchExp(T.MEM(T.BINOP(T.PLUS,e1,T.CONST i))) =
		           	result(fn r => emit(A.OPER{
		           		assem="lw $`d0, "^int i^"($`s0)\n",
						src=[munchExp e1], 
						dst=[r], 
						jump=NONE}))

		        | munchExp(T.MEM(T.BINOP(T.PLUS,T.CONST i,e1))) =
		           	result(fn r => emit(A.OPER{
		           		assem="lw $`d0, "^int i^"($`s0)\n",
						src=[munchExp e1], 
						dst=[r], 
						jump=NONE}))

		        | munchExp(T.MEM(T.CONST i)) =
		           	result(fn r => emit(A.OPER{
		           		assem="lw $`d0, "^int i^"($zero)\n",
						src=[], 
						dst=[r], 
						jump=NONE}))

		        | munchExp(T.MEM(e1)) =
		           	result(fn r => emit(A.OPER{
		           		assem="lw $`d0, $`s0\n",
						src=[munchExp e1], 
						dst=[r], 
						jump=NONE}))

				| munchExp(T.TEMP t) = t

		        | munchExp(T.NAME(label)) = 
		        	Temp.newtemp()
		in
			munchStm stm;
			rev(!ilist)
		end
		
end
