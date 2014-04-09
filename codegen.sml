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

			and munchArgs(i,args) = 
				let
					val ith = List.nth(args, i)
					val argRegs = Frame.argregs
					fun emitMemory(i, args) = 
						let
							val offset = if i=0 then 0 else i-4
						in
							(*TO-DO*)
							if i = 0 
							then munchStm(T.MOVE(T.TEMP Frame.FP, ith)) 
							else munchStm(T.MOVE(T.MEM(T.BINOP(T.PLUS, T.TEMP Frame.SP, T.CONST (offset*Frame.wordSize))), ith))
						end

					fun emitReg(i, args) =
						let
							val iRegs = List.nth(argRegs, i-1)
							
						in
							(munchStm(T.MOVE(T.TEMP iRegs, ith)); iRegs)
						end
				in
					if i=List.length(args)-1
					then if (i<=4 andalso i>0) 
							then [emitReg(i, args)] 
							else (emitMemory(i, args); [])
					else if (i<=4 andalso i>0) 
							then emitReg(i, args)::munchArgs(i+1, args)
							else (emitMemory(i, args); munchArgs(i+1, args)) 
				end

			and munchStm(T.SEQ(a,b)) = 
					(munchStm a; munchStm b)

				| munchStm(T.LABEL lab) = 
	    			emit(A.LABEL{
	    				assem=Symbol.name(lab)^":\n", 
	    				lab=lab})

	    		(*--------------------- JUMP and CJUMP ---------------------------------------------*)


	    		| munchStm(T.JUMP(T.NAME label,labellist)) = 
	    			emit(A.OPER{
						assem="j `j0 \n",
						src=[],
						dst=[],
						jump=SOME(labellist)})
	    		(*TO-DO*)
	    		| munchStm(T.JUMP(T.TEMP t, labelList)) =
                	emit(A.OPER{
                		assem="jr $`d0\n",
                        src=[],
                        dst=[t], 
                        jump=SOME(labelList)})
                | munchStm(T.JUMP(e, labelList)) =
                	emit(A.OPER{
                		assem="jr `j0\n",
                        src=[munchExp e],
                        dst=[], 
                        jump=SOME(labelList)})

	    		(*this should not be right according to logic analysis*)
	    		(*| munchStm(T.CJUMP(relop,T.CONST i,e1,l1,l2)) = 
	    			emit(A.OPER{
	    				assem=((munchRelop(relop))^" $`s0,"^int i^", "^ Symbol.name(l1)^"\n"),
		      			src=[munchExp e1], 
		      			dst=[], 
		      			jump=SOME([l1,l2])})*)
	    		(*| munchStm(T.CJUMP(relop,e1,T.CONST i,l1,l2)) = 
	    			emit(A.OPER{
	    				assem=((munchRelop(relop))^" $`s0, "^int i^", "^ Symbol.name(l1)^"\n"),
		      			src=[munchExp e1], 
		      			dst=[], 
		      			jump=SOME([l1,l2])})*)

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
				    	assem="sw $`s1, 0($`s0)\n",
					    src=[munchExp e1, munchExp e2],
					    dst=[],
					    jump=NONE})


				(*Move constant to register*)
				| munchStm(T.MOVE(T.TEMP t, T.MEM(T.BINOP(T.PLUS, e, T.CONST i)))) =
                	emit(A.OPER{
                		assem="lw $`d0, "^int i^"($`s0)\n",
                        src=[munchExp e],
                        dst=[t], 
                        jump=NONE})
              	| munchStm(T.MOVE(T.TEMP t, T.MEM(T.BINOP(T.PLUS, T.CONST i, e)))) =
                	emit(A.OPER{
                		assem="lw $`d0, "^int i^"($`s0)\n",
                        src=[munchExp e],
                        dst=[t], 
                        jump=NONE})

                | munchStm(T.MOVE(T.TEMP t, T.BINOP(T.PLUS, e, T.CONST i))) =
                	emit(A.OPER{
                		assem="addi $`d0, $`s0, "^int(i)^"\n",
                        src=[munchExp e],
                        dst=[t], 
                        jump=NONE})
                | munchStm(T.MOVE(T.TEMP t, T.BINOP(T.MINUS, e, T.CONST i))) =
                	emit(A.OPER{
                		assem="addi $`d0, $`s0, "^int(~i)^"\n",
                        src=[munchExp e],
                        dst=[t], 
                        jump=NONE})
                | munchStm(T.MOVE(T.TEMP t1, T.MEM(T.TEMP t2))) =
                	emit(A.OPER{
                		assem="move $`s0, $`s1\n",
                        src=[t1,t2],
                        dst=[], 
                        jump=NONE})
                | munchStm(T.MOVE(e1, T.MEM(e2))) =
                	emit(A.OPER{
                		assem="lw $`s0, 0($`s1)\n",
                        src=[munchExp e1, munchExp e2],
                        dst=[], 
                        jump=NONE})

              	| munchStm(T.MOVE(T.TEMP t, T.NAME label)) =
                	emit(A.OPER{
                		assem="la $`d0, "^Symbol.name(label)^ "\n",
                        src=[],
                        dst=[t], 
                        jump=NONE})
				| munchStm(T.MOVE(T.TEMP t,T.CONST i)) =
					emit(A.OPER{
				    	assem="li $`d0, "^int i^ "\n",
					    src=[],
					    dst=[t],
					    jump=NONE})
				| munchStm(T.MOVE(T.TEMP t,e)) =
					emit(A.OPER{
				    	assem="move $`d0, $`s0\n",
					    src=[munchExp e],
					    dst=[t],
					    jump=NONE})


				(*wrong syntax, should not happen*)
				(*TO-DO*)
	    		| munchStm(T.MOVE(e1,e2)) = 
	    			()

	    		(*TO-DO*)
	    		(*Procedure Calls p203*)
				(*| munchStm(T.EXP(T.CALL(e,args))) =
					emit(A.OPER{
				    	assem="CALL `s0\n",
					    src=munchExp(e)::munchArgs(0,args),
					    dst=Frame.calldefs,
					    jump=NONE})*)

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

		        
		        | munchExp(T.CALL(T.NAME label,args)) = 
		        	let
		        		fun newname(name) = 
		        			if (name="initArray" orelse name="print" orelse name="flush" orelse name="getchar" orelse name="ord" orelse name="chr" orelse name="size" orelse name="substring" orelse name="concat"
							orelse name="not" orelse name="exit") 
							then ("_" ^ name) 
							else name
					    val functionName= newname(Symbol.name (label))
		        		(*take care of static link*)
		        		(*val () = if (List.length(args)>5 ) 
									then munchStm(T.MOVE(T.TEMP Frame.SP ,T.BINOP(T.MINUS,T.TEMP Frame.SP, T.CONST(4*(List.length(args)-4))  )))
		      						else munchStm(T.MOVE(T.TEMP Frame.SP ,T.BINOP(T.MINUS,T.TEMP Frame.SP, T.CONST(4) )))*)   
		        	in
		        		emit(A.OPER{
				    		assem="jal "^functionName^"\n",
					    	src=munchArgs(0,args),
					    	dst=Frame.calldefs,
					    	jump=NONE});
		        		Frame.RV
		        	end
		        | munchExp(T.CALL(e,args)) = 
		        	let
		        		
		        		(*take care of static link*)
		        		(*val () = if (List.length(args)>5 ) 
									then munchStm(T.MOVE(T.TEMP Frame.SP ,T.BINOP(T.MINUS,T.TEMP Frame.SP, T.CONST(4*(List.length(args)-4))  )))
		      						else munchStm(T.MOVE(T.TEMP Frame.SP ,T.BINOP(T.MINUS,T.TEMP Frame.SP, T.CONST(4) )))   *)
		        	in
		        		emit(A.OPER{
				    		assem="jal $`s0\n",
					    	src=munchExp(e)::munchArgs(0,args),
					    	dst=Frame.calldefs,
					    	jump=NONE});
		        		Frame.RV
		        	end


		        	

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
