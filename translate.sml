signature TRANSLATE = 
sig
	structure Frame : FRAME = MipsFrame
	
	(*type level *)
	datatype level = 
		Top 
		| Inner of {unique:unit ref,parent:level,frame:Frame.frame}
	type access (*not the same as Frame.access*)



	(*CH6*)
	val errorLevel : level
	val outermost : level
	val newLevel : {parent: level, name: Temp.label, formals:bool list} -> level
	val formals : level -> access list
	val allocLocal : level -> bool -> access

	(*CH7*)
	

	datatype exp = 
		Ex of Tree.exp 
		| Nx of Tree.stm
		| Cx of Tree.label * Tree.label -> Tree.stm

	val unEx : exp -> Tree.exp
	val unNx : exp -> Tree.stm
	val unCx : exp -> Tree.label * Tree.label -> Tree.stm 
	(*little modification here, add the last arrow and change Temp into Tree*)

	val clearFraglist : unit -> unit
	(*val procEntryDec : {level:level, body:exp} -> unit*)
	val procEntryExit : {level:level, body:exp} -> unit (*p169*)
	val getResult : unit -> Frame.frag list

	(*Process semant - return Tree exp*)
	(*transVar*)
	val simpleVar : access * level -> exp
	val fieldVar : exp * int -> exp
	val subscriptVar : exp * exp -> exp
	(*transExp*)
	val errorExp : unit -> exp
	val nilExp : unit -> exp
	val intExp : int -> exp
	val stringExp : string -> exp
	val callExp : level * level * Temp.label * exp list -> exp
	val opExp : exp * Absyn.oper * exp -> exp
	val cmpExp : exp * Absyn.oper * exp -> exp
	val recordExp : int * exp list -> exp 
	val seqExp : exp list -> exp 
	val assignExp : exp * exp -> exp 
	val ifThenElseExp : exp * exp * exp -> exp
	val ifThenExp : exp * exp -> exp
	val whileExp : exp * exp * Temp.label -> exp 
	val forExp : exp * exp * exp * exp * Temp.label -> exp 
	val breakExp : Temp.label -> exp 
	val letExp : exp list * exp -> exp
	val arrayExp : exp * exp -> exp 

end

structure Translate : TRANSLATE = 
struct
	structure Frame : FRAME = MipsFrame
	structure T = Tree
	structure A = Absyn

	val wordSize = Frame.wordSize
	val allowPrint = true
	fun log info = if allowPrint then print("***translate*** "^info^"\n") else ()

	datatype level = 
		Top 
		| Inner of {unique:unit ref,parent:level,frame:Frame.frame}
	type access = level * Frame.access


	(*helper function*)
	fun combineStmListToSEQ stmlist : Tree.stm = 
		case List.length(stmlist) of
			0 => List.hd(stmlist)
			| 1 => List.hd(stmlist)
			| 2 => Tree.SEQ(List.hd(stmlist),List.nth(stmlist,1))
			| _ =>  Tree.SEQ(List.hd(stmlist),combineStmListToSEQ(List.tl(stmlist)))

	(*Getter function*)
	fun levelUnique level = 
		case level of
			Top => ref ()
			| Inner{unique,parent,frame} => unique
	fun levelParent level = 
		case level of
			Top => Top
			| Inner{unique,parent,frame} => parent
	(*TO-DO*)
	(*Getter for static link inside one level/frame*)

	(*although the address of Static link is right, but there is no value in that address, right?*)
	(*fetch the parent's level and parse out the frame.access?? Then store? When to store? At the first fetch?*)
	fun staticLink level : Frame.access = 
		let
			fun getAccessList () = 
				case level of
					Inner{unique,parent,frame} => (#formals(frame))
					| Top => []
			val accessFrameListWithStaticLink = getAccessList()
		in
			List.nth(accessFrameListWithStaticLink,0)
		end

	(*CH6*)
	val errorLevel = Top
	val outermost = Top

	(*Call Frame.newFrame *)
	fun newLevel {parent,name,formals} = 
		let
			(*p142 Frame should not know anything about static links.*)
			(*Translate knows that each frame contains a static link.*)
			val newFrame = Frame.newFrame{name=name,formals=true::formals}
		in
			Inner{unique=ref(),parent=parent,frame=newFrame}
		end

	(*Access frame in level, return (level,Frame.access) list*)
	fun formals level : access list = 
		let
			fun tupleForLevelAndFrameAccess frameAccess =
				(level,frameAccess)

			fun getAccessList () = 
				case level of
					Inner{unique,parent,frame} => map tupleForLevelAndFrameAccess (#formals(frame))
					| Top => []
			val accessListWithStaticLink = getAccessList()

			fun getAccessListWithoutStaticLink(l::r) = r
				| getAccessListWithoutStaticLink [] = []
		in
			getAccessListWithoutStaticLink(accessListWithStaticLink)
		end


		
	(*True-escape,inFrame; False-not escape,inRegister*)
	fun allocLocal level = 
		let
			fun callFrameAllocLocal boolean =
				case level of
					Inner{unique,parent,frame} => (level,Frame.allocLocal frame boolean)
					| Top => (print("Should not allocLocal in outmost level."); (level,Frame.InFrame(0)))
		in
			callFrameAllocLocal
		end



	(*CH7*)

	(*type exp = unit*)
	datatype exp = 
		Ex of Tree.exp 
		| Nx of Tree.stm
		| Cx of Tree.label * Tree.label -> Tree.stm

	fun unEx (Ex e) = (log("unEx Ex"); e)
		| unEx (Nx s) = ((*ErrorMsg.impossible "should not come here";*) log("fucking wrong here on unEx from Nx!"); T.ESEQ(s,T.CONST 0)) (*should this be error message printing?*)
		| unEx (Cx genstm) = 
			let
				val r = Temp.newtemp()
				val t = Temp.newlabel() and f = Temp.newlabel()
			in
				T.ESEQ(
						T.SEQ(
							T.MOVE(T.TEMP r,T.CONST 1),
							T.SEQ(
								genstm(t,f),
								T.SEQ(
									T.LABEL f,
									T.SEQ(
										T.MOVE(T.TEMP r, T.CONST 0),
										T.LABEL t
									)
								)
							)
						),
						T.TEMP r
					)
			end

	fun unNx (Ex e) = T.EXP(e)
		| unNx (Nx s) = s
		| unNx (Cx genstm) = T.EXP(unEx(Cx genstm))

	fun unCx (Ex e) = 
			let
				fun conditionalJump(t:Tree.label, f:Tree.label) = 
						T.CJUMP(T.EQ, e, T.CONST(1), t, f)
			in
				conditionalJump
			end
		| unCx (Nx s) = 
			let
				fun conditionalJump(t:Tree.label, f:Tree.label) = 
					(
						print("stm:Nx cannot be translated into Cx.");
						s
					)
			in
				conditionalJump
			end
		| unCx (Cx genstm) = genstm
	
	(*
	 * p170 All the remembered fragments go into a frag list ref local to Translate
	 * Then getResult can be used to extract the fragment list.
	 *)
	val fraglist : Frame.frag list ref = ref []
	fun clearFraglist () = (fraglist := [])



	(*fun procEntryDec{level,body} = 
		case level of
			Top => (log("procEntryDec Top"))
			| Inner{unique,parent,frame} => 
				let 
					val decStm = unNx(body)
					val frameProc = Frame.PROC{body=decStm,frame=frame}
				in
					log("procEntryDec Inner");
					log("fraglist length:"^Int.toString(List.length(!fraglist)));
					fraglist := (!fraglist) @ [frameProc]
				end*)

	(*this is used to deal with function declaration. should strictly follow 11 steps in p167-168*)
	(*level is the newly allocated function level, body is the bodyExp of function*)
	fun procEntryExit{level,body} = 
		case level of
			Top => (log("procEntryExit Top"))
			| Inner{unique,parent,frame} => 
				let 
					(*Deal with main whose parent is TOP*)


					val bodyStm = Frame.procEntryExit1(frame, T.MOVE(T.TEMP Frame.RV, unEx body))
					(*val bodyStm = Frame.procEntryExit1(frame, unNx body)*)

					val frameProc = Frame.PROC{body=bodyStm,frame=frame}
				in
					log("procEntryExit Inner");
					log("fraglist length:"^Int.toString(List.length(!fraglist)));
					fraglist := (!fraglist) @ [frameProc]
				end

	fun getResult () = !fraglist

	


	(*TO-DO*)
	fun transStmListToSeqStm ([] : T.stm list) : T.stm = T.EXP(T.CONST(0))
		| transStmListToSeqStm (a) = 
			let
				val listlength = List.length(a)
			in
				if listlength = 1
				then List.hd(a)
				else if listlength = 2 
					then T.SEQ(List.nth(a,0), List.nth(a,1) )
					else T.SEQ(List.nth(a,0), transStmListToSeqStm(List.tl(a)) )
			end

	(*Go to parent level of current level until level match*)
	(*T.MEM is a must in this expression, don't DELETE it*)
	(*this function holds only if static link is at offset 0 of frame pointer*)
	(*so this can also be used to access the static link!!!!!*)
	(*current level, defined level*)

	fun getDefinedLevelFP(Top,Top) : Tree.exp = 
			(
				log("Following SL reach Top level");
				T.TEMP(Frame.FP)
			)
		| getDefinedLevelFP(Top,Inner(defined)) = 
			(
				log("Following SL pass Top's FP");
				T.TEMP(Frame.FP)
			)
		| getDefinedLevelFP(Inner(current),Top) = 
			(
				log("Following SL different level, and defined in Top");
				T.MEM(getDefinedLevelFP(#parent current,Top))
			)
		| getDefinedLevelFP(Inner(current),Inner(defined)) = 
			let
				(*Caculate offset from FP to SP (0($SP) where SL stays)*)
				(*Should be the same with Frame.procEntryExit1.framesize*)
				val localVariableNum = !(Frame.localsNumber(#frame current))
				val frameSize = (localVariableNum+Frame.numOfRA+Frame.numOfCalleesavesRegisters+Frame.numOfCallersavesRegisters+Frame.numOfArguments+Frame.numOfSL)*wordSize
			in
				if #parent current = Top
				then (
						log("Following SL with parent Top");
						T.TEMP(Frame.FP)
					)
				else
					if #unique current = #unique defined 
					then (
							log("Following SL same level with curr:"^Symbol.name(#name (#frame current))^" and defined:"^Symbol.name(#name (#frame defined)));
							T.TEMP(Frame.FP)  (*如果是同一层 传自己的FP*)
							(*T.MEM(T.BINOP(T.MINUS, T.TEMP(Frame.FP), T.CONST frameSize) ) *)
						)
					else (
							log("Following SL different level with curr:"^Symbol.name(#name (#frame current))^" and defined:"^Symbol.name(#name (#frame defined)));
							(*如果不是同一层 先用FP减去FrameSize到自己存SL的地方
								再用MEM找上一层函数的FP*)
							T.MEM(T.BINOP(T.MINUS, getDefinedLevelFP(#parent current,Inner(defined)), T.CONST frameSize) ) 
						)
			end
			

	(*
	 * p156, Must produce a chain of MEM and + nodes to fetch static links for
	 * all frames between the level of use (the level passed to simpleVar)
	 * and the level of definition (the level within the variable's access)
	 *)
	(*what if frameAccess is in register? we should check this first*)
	(*
	 * Whenever a function f is called, it can be passed a pointer to the frame of the function statically enclosing f;
	 * this pointer is the static link.
	 *)

	fun errorExp() =  Ex(T.CALL(T.NAME(Temp.namedlabel("print")), T.CONST(9999)::unEx(stringExp("errorExp"))::nil)) (*Ex(T.CONST(9999))*)


	and simpleVar ((levelDefined,frameAccess),levelUsed) = 
		(*If frameAccess inReg, not need to check level match*)
		(*清楚怎么找了 当前frame的SP的位置存上一个的frame的FP*)
		(
			log("simpleVar accessed...");
			Ex(Frame.exp(frameAccess)(getDefinedLevelFP(levelUsed,levelDefined)))
		)

	(*should be wrong because varExp is now a value not a location*)
	and fieldVar(varExp, index) = 
		Ex(Tree.MEM(Tree.BINOP(Tree.PLUS, unEx varExp, Tree.BINOP(Tree.MUL, Tree.CONST(index), Tree.CONST(wordSize)))))

	and subscriptVar(varExp, indexExp) = 
		let
			val t1 = Temp.newlabel() and t2 = Temp.newlabel() and f = Temp.newlabel() and finish = Temp.newlabel()
			val r = Temp.newtemp() (*result*)
			val indexp = unEx indexExp
			val varexp = unEx varExp
		in
			
			(*simple variable is different from array variable*)
			(*simple variable is returned with its value*)
			(*array variable is returned by its base address*)
			Ex(
				T.ESEQ(
						combineStmListToSEQ([
							(*the base address stores the size of the array, so boundary check first*)
							T.CJUMP(T.LT, indexp, T.MEM(varexp), t1, f),    
							T.LABEL t1,
							T.CJUMP(T.GE, indexp, T.CONST(0), finish, f),
							T.LABEL t2,
							

							(*T.MOVE(T.TEMP r, T.MEM(T.BINOP(T.PLUS, varexp, Tree.BINOP(Tree.MUL, Tree.CONST(wordSize), T.BINOP(T.PLUS, indexp, T.CONST 1))))),*)
							(*T.EXP(T.MEM(T.BINOP(T.PLUS, varexp, Tree.BINOP(Tree.MUL, Tree.CONST(wordSize), T.BINOP(T.PLUS, indexp, T.CONST 1))))),*)

							(*T.JUMP(T.NAME(finish), [finish]),*)
							T.LABEL f,
							T.MOVE(T.TEMP r, unEx (errorExp())),
							T.LABEL finish
						]),
						(*T.TEMP r*)
						T.MEM(T.BINOP(T.PLUS, varexp, Tree.BINOP(Tree.MUL, Tree.CONST(wordSize), T.BINOP(T.PLUS, indexp, T.CONST 1))))
					)

			)
		end

	and nilExp() = Ex(T.CONST(0))

	and intExp(n) = (
			log("T.intExp "^Int.toString(n));
			Ex(T.CONST(n))
		)

	and stringExp(s) =  
		let 
			val label = Temp.newlabel()
			val () = (fraglist := Frame.STRING(label, s)::(!fraglist))
		in 
			log("stringExp!!!!");
			Ex(T.NAME(label))
		end


	and callExp(definedLevel, calledLevel, label, args) = 
		let
			val () = log("callExp "^Symbol.name(label))
			val args' = map unEx args
			(*val sl = getDefinedLevelFP(calledLevel, definedLevel)*)

			(*p134*)
			(*目标是传合适的SL给called函数*)
			fun slfun (Inner(current),Inner(defined)) =
					let
						val localVariableNum = !(Frame.localsNumber(#frame current))
						val frameSize = (localVariableNum+Frame.numOfRA+Frame.numOfCalleesavesRegisters+Frame.numOfCallersavesRegisters+Frame.numOfArguments+Frame.numOfSL)*wordSize
						val () = log("local num:"^Int.toString(localVariableNum)^" framesize:"^Int.toString(frameSize))
					in
						(*如果called函数是本身/兄弟(有一样的父亲) 传自己的SL*)
						if (#unique current = #unique defined) 
						then (
								log("Call itself");
								T.MEM(T.TEMP(Frame.SP))
							)							
						else
							if (#parent current = #parent defined)
							then 
								 (
									log("Call sibiling");
									T.MEM(T.TEMP(Frame.SP))
								)
							else 

								(*如果called函数是自己的儿子 传自己的FP 也就是儿子的SL*)
								if Inner(current) = #parent defined
								then (
										log("Call its son");
										T.TEMP(Frame.FP)
									)
								(*如果调用函数是父亲... 要传父亲..的SL*)
								(*getDefinedLevelFP 找出来的应该只是父亲的FP 要找到SP再MEM一下把父亲的SL拿出来*)
								(*或者说直接找父亲的父亲也可以*)
								(*TO-DO*)
								else (
										log("Call father or grandfater...");
										getDefinedLevelFP(Inner(current), #parent defined)
									)
					end
				| slfun (_,_) = (
						ErrorMsg.impossible "bad Assem format"; getDefinedLevelFP(calledLevel, definedLevel)  
					)
			val sl = slfun(calledLevel,definedLevel) 
		in
			Ex(T.CALL(T.NAME(label), sl::args'))
		end

	(*Process semant - return Tree exp*)
	and opExp(leftExp,oper,rightExp) = 
		case oper of
			A.PlusOp => (log("opExp A.PlusOp");Ex(Tree.BINOP(Tree.PLUS,unEx(leftExp),unEx(rightExp))))
			| A.MinusOp => Ex(Tree.BINOP(Tree.MINUS,unEx(leftExp),unEx(rightExp)))
			| A.TimesOp => Ex(Tree.BINOP(Tree.MUL,unEx(leftExp),unEx(rightExp)))
			| A.DivideOp => Ex(Tree.BINOP(Tree.DIV,unEx(leftExp),unEx(rightExp)))
			| _ => errorExp()

	and cmpExp(leftExp, oper, rightExp) =
		case oper of
			A.EqOp => Cx(fn(t,f) => T.CJUMP(T.EQ, unEx leftExp, unEx rightExp, t, f))
		  | A.NeqOp => Cx(fn(t,f) => T.CJUMP(T.NE, unEx leftExp, unEx rightExp, t, f))
		  | A.LtOp => Cx(fn(t,f) => T.CJUMP(T.LT, unEx leftExp, unEx rightExp, t, f))
		  | A.LeOp => Cx(fn(t,f) => T.CJUMP(T.LE, unEx leftExp, unEx rightExp, t, f))
		  | A.GtOp => Cx(fn(t,f) => T.CJUMP(T.GT, unEx leftExp, unEx rightExp, t, f))
		  | A.GeOp => Cx(fn(t,f) => T.CJUMP(T.GE, unEx leftExp, unEx rightExp, t, f))
		  | _ => errorExp()

	fun arrayExp(initExp, sizeExp) = 
		let
			val r = Temp.newtemp()
			val sizeTemp = Temp.newtemp() (*assign temp just to store size*)
			val size = unEx sizeExp
			val init = unEx initExp

		in
			Ex(
				T.ESEQ(
					combineStmListToSEQ([
						T.MOVE(T.TEMP(sizeTemp), size),
						T.MOVE(T.TEMP r, Frame.externalCall("initArray", [T.BINOP(T.PLUS, T.TEMP(sizeTemp), T.CONST(1)), init])),
						(*save size information at the first position 0($array) = size*)
						T.MOVE(T.MEM(T.TEMP r), T.TEMP(sizeTemp))
					]),

					T.TEMP r
				)
			)
				
		end


	(*no need for boundary check*)
	fun recordExp(num, valExpList) = 
		let
			(*这个不对 因为这是在SML计算 实际要用一个TEMP index在MIPS里面计算*)
			(*或者把所有valExpList的项都输出来*)
			val count = ref 0

			val alloc = Temp.newlabel()
			val done = Temp.newlabel()
			val r = Temp.newtemp()

			val currTempToSave = Temp.newtemp()
			val currTemp = Temp.newtemp()

			fun initField(resultList, index) = 
					let
						(*Reference sw *)
						(*T.MOVE(T.MEM(T.BINOP(T.PLUS,T.TEMP SP,T.CONST((numOfArguments+n+2)*wordSize))), T.TEMP(List.nth(calleesaves,n)))*)

						val offset = wordSize*index
						val caculateTempToSave = T.MOVE(T.TEMP currTempToSave, T.BINOP(T.PLUS, T.TEMP r, T.CONST(offset)))
						val getCurrField = T.MOVE(T.TEMP(currTemp) ,unEx(List.nth(valExpList, index)))
						val save = T.MOVE(T.MEM(T.TEMP currTempToSave), T.TEMP currTemp)
						val result = [caculateTempToSave,getCurrField,save]
					in
						if index = num-1 
						then resultList@result
						else initField(resultList@result,index+1)
					end
		in
			Ex(
				T.ESEQ(
					combineStmListToSEQ(
						[T.MOVE(T.TEMP r, Frame.externalCall("allocRecord", [T.CONST(num*wordSize)]))]
						@
						initField([],0)





						(*T.LABEL alloc,*)
						
						(*T.MOVE(T.MEM(T.BINOP(T.MINUS, T.TEMP r, T.BINOP(T.MUL, T.CONST(wordSize), T.CONST(!count)))), unEx (List.nth(valExpList, !count))),*)

						(*caculate temp to save*)						
						(*T.MOVE(T.TEMP currTempToSave, T.BINOP(T.MINUS, T.TEMP r, T.BINOP(T.MUL, T.CONST(wordSize), T.CONST(!count)))),*)
						(*update the field*)
						(*T.MOVE(T.TEMP(currTemp) ,unEx(List.nth(valExpList, !count))),*)
						(*T.MOVE(T.MEM(T.TEMP currTempToSave), T.TEMP currTemp),*)
						
						(*T.CJUMP(T.LT, T.CONST(count:=(!count)+1; !count), T.CONST(num), alloc, done),*)
						(*T.LABEL done*)
							
					),
					T.TEMP r
				)
			)
		end



	(*fun seqExp(expList) = Nx(T.SEQ(map unNx expList))*)
	fun seqExp [] = (log("seqExp [] in Translate"); Ex (T.CONST 0))
		| seqExp (exps) = 
			let
				val expslength = List.length(exps)

				(*
					=1 T.ESEQ(unNx(List.hd(exps))
					>1 T.ESEQ(T.SEQ(outputForEseq)
				*)
				(*TO-DO empty SEQ() in the end*)
				val inputForEseq = map unNx (List.take(exps,List.length(exps)-1))
				fun getEseqStm(stms : T.stm list) : T.stm = 
					let
						val stmsLength = List.length(stms)
					in
						if stmsLength = 1 
						then unNx(List.hd(exps))
						else transStmListToSeqStm(stms)   (*T.SEQ(stms)*) 
					end
				val outputForEseq : T.stm = getEseqStm(inputForEseq)


			in
				if  expslength = 1 
				then (log("seqExp list length 1 in Translate"); List.hd(exps))
				(*else if expslength = 2*)
						(*then (log("seqExp exp in Translate with "^Int.toString(expslength)^" elements"); Ex(T.ESEQ(unNx(List.hd(exps)), unEx(List.last(exps))) )   ) *)
				else (log("seqExp exp in Translate with "^Int.toString(expslength)^" elements"); Ex(T.ESEQ( outputForEseq, unEx(List.last(exps))))   ) 
			end
		

	fun assignExp(varExp, assignedExp) = 
		(
			log("assignExp");
			Nx(T.MOVE(unEx varExp, unEx assignedExp))
		)

	fun ifThenElseExp(ifExp, thenExp, elseExp) = 
		let
			
			val t = Temp.newlabel() and f = Temp.newlabel() and join = Temp.newlabel()
			val r = Temp.newtemp()
		in
			Ex(T.ESEQ(
					T.SEQ(	
							unCx(ifExp)(t, f),
							T.SEQ(
								T.LABEL(t),
								T.SEQ(
									T.MOVE(T.TEMP(r), unEx thenExp),
									T.SEQ(
										T.JUMP(T.NAME(join), [join]),
										T.SEQ(
											T.LABEL(f),
											T.SEQ(
												T.MOVE(T.TEMP(r), unEx elseExp),
												T.LABEL(join)
											)
										)
									)
								)
							)
					),
					T.TEMP(r)
					)
				)
		end

	fun ifThenExp(ifExp, thenExp) = 
		let
			
			val t = Temp.newlabel() and f = Temp.newlabel()
		in
			Nx(
				T.SEQ(	
						unCx(ifExp)(t, f), 
						T.SEQ(
							T.LABEL(t),
							T.SEQ(
								unNx thenExp,
								T.LABEL(f)
							)
						)
					)
				)
		end

	fun whileExp(testExp, bodyExp, break) = 
		let
			val start = Temp.newlabel() and body = Temp.newlabel()
		in
			Nx(
				combineStmListToSEQ([
					T.JUMP(T.NAME(start), [start]),
					T.LABEL body,
					unNx bodyExp,
					T.LABEL start,
					unCx(testExp)(body, break),
					T.LABEL break
				])
			)
		end

	fun forExp(varExp,loExp,highExp,bodyExp, break) = 
		let
			val () = log("forExp")
			val start = Temp.newlabel() and body = Temp.newlabel()
			val varexp = unEx varExp
			val lo = unEx loExp 
			val () = log("forExp.hi")
			val hi = unEx highExp
		in
			Nx(
				combineStmListToSEQ([
					T.MOVE(varexp, lo), (*var i := lo*)
					T.JUMP(T.NAME(start), [start]),
					T.LABEL body,
					T.MOVE(varexp, T.BINOP(T.PLUS, varexp, T.CONST(1))),
					unNx bodyExp,
					T.LABEL start,
					T.CJUMP(T.LE, varexp, hi, body, break),
					T.LABEL break					
				])
			)
		end
		
	fun breakExp(break) = (
			log("breakExp");
			Nx(T.JUMP(T.NAME(break), [break]))
		)

	fun letExp(expList, bodyExp) = 
		let
			fun unNxList() = map unNx expList
		in
			Ex(
				T.ESEQ(
					(log("let part accessed..."); transStmListToSeqStm(unNxList())  (*T.SEQ(unNxList())*)),
					unEx bodyExp
					)
			)
		end
	
	
end