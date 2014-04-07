signature TRANSLATE = 
sig
	type level 
	type access (*not the same as Frame.access*)

	(*CH6*)
	val errorLevel : level
	val outermost : level
	val newLevel : {parent: level, name: Temp.label, formals:bool list} -> level
	val formals : level -> access list
	val allocLocal : level -> bool -> access

	(*CH7*)
	structure Frame : FRAME = MipsFrame

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
	val allowPrint = false
	fun log info = if allowPrint then print("***translate*** "^info^"\n") else ()

	datatype level = 
		Top 
		| Inner of {unique:unit ref,parent:level,frame:Frame.frame}
	type access = level * Frame.access

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
		| unEx (Nx s) = (log("fucking wrong here on unEx from Nx!"); T.ESEQ(s,T.CONST 0)) (*should this be error message printing?*)
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
					val bodyStm = Frame.procEntryExit1(frame, T.MOVE(T.TEMP Frame.RV, unEx body))

					val frameProc = Frame.PROC{body=bodyStm,frame=frame}
				in
					log("procEntryExit Inner");
					log("fraglist length:"^Int.toString(List.length(!fraglist)));
					fraglist := (!fraglist) @ [frameProc]
				end

	fun getResult () = !fraglist

	fun errorExp() = Ex(T.CONST(0))


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

	fun getDefinedLevelFP(Top,Top) : Tree.exp = T.TEMP(Frame.FP)
		| getDefinedLevelFP(Top,Inner(defined)) = T.TEMP(Frame.FP)
		| getDefinedLevelFP(Inner(current),Top) = T.MEM(getDefinedLevelFP(#parent current,Top))
		| getDefinedLevelFP(Inner(current),Inner(defined)) = 
			if #unique current = #unique defined 
				then T.TEMP(Frame.FP) 
			else T.MEM(getDefinedLevelFP(#parent current,Inner(defined)))


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
	fun simpleVar ((levelDefined,frameAccess),levelUsed) = 
		(*If frameAccess inReg, not need to check level match*)
		(
			log("simpleVar accessed...");
			Ex(Frame.exp(frameAccess)(getDefinedLevelFP(levelUsed,levelDefined)))
		)

	(*should be wrong because varExp is now a value not a location*)
	fun fieldVar(varExp, index) = 
		Ex(Tree.MEM(Tree.BINOP(Tree.MINUS, unEx varExp, Tree.BINOP(Tree.MUL, Tree.CONST(index), Tree.CONST(wordSize)))))

	fun subscriptVar(varExp, indexExp) = 
		let
			val t = Temp.newlabel() and f = Temp.newlabel() and join = Temp.newlabel()
			val r = Temp.newtemp() (*result*)
			val indexp = unEx indexExp
			val varexp = unEx varExp
		in
			Ex(
				T.ESEQ(
						T.SEQ(	
							(*the base address stores the size of the array, so boundary check first*)
							(*simple variable is different from array variable*)
							(*simple variable is returned with its value*)
							(*array variable is returned by its base address*)
							T.CJUMP(T.LE, indexp, T.MEM(varexp), t, f),    
							T.SEQ(
								T.LABEL t,
								T.SEQ(
									T.MOVE(T.TEMP r, T.MEM(T.BINOP(T.MINUS, varexp, Tree.BINOP(Tree.MUL, Tree.CONST(wordSize), T.BINOP(T.PLUS, indexp, T.CONST 1))))),
									T.SEQ(
										T.JUMP(T.NAME(join), [join]),
										T.SEQ(
											T.LABEL f,
											T.SEQ(
												T.MOVE(T.TEMP r, unEx (errorExp())),
												T.LABEL join
											)
										)
									)
								)
							)
						),
						T.TEMP r
					)

			)
		end

	fun nilExp() = Ex(T.CONST(0))

	fun intExp(n) = (
			log("T.intExp "^Int.toString(n));
			Ex(T.CONST(n))
		)

	fun stringExp(s) =  
		let 
			val label = Temp.newlabel()
			val () = (fraglist := Frame.STRING(label, s)::(!fraglist))
		in 
			log("stringExp!!!!");
			Ex(T.NAME(label))
		end


	fun callExp(definedLevel, calledLevel, label, args) = 
		let
			val args' = map unEx args
			val sl = getDefinedLevelFP(calledLevel, definedLevel)
		in
			Ex(T.CALL(T.NAME label, sl::args'))
		end

	(*Process semant - return Tree exp*)
	fun opExp(leftExp,oper,rightExp) = 
		case oper of
			A.PlusOp => (log("opExp A.PlusOp");Ex(Tree.BINOP(Tree.PLUS,unEx(leftExp),unEx(rightExp))))
			| A.MinusOp => Ex(Tree.BINOP(Tree.MINUS,unEx(leftExp),unEx(rightExp)))
			| A.TimesOp => Ex(Tree.BINOP(Tree.MUL,unEx(leftExp),unEx(rightExp)))
			| A.DivideOp => Ex(Tree.BINOP(Tree.DIV,unEx(leftExp),unEx(rightExp)))
			| _ => errorExp()

	fun cmpExp(leftExp, oper, rightExp) =
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
			val size = unEx sizeExp
			val init = unEx initExp

		in
			Ex(
				T.ESEQ(
					T.SEQ(
						T.MOVE(T.TEMP r, Frame.externalCall("initArray", [T.BINOP(T.PLUS, size, T.CONST(1)), init])),
						T.MOVE(T.MEM(T.TEMP r), size)
					),
					T.TEMP r
				)
			)
				
		end


	(*no need for boundary check*)
	fun recordExp(num, valExpList) = 
		let
			val count = ref 0
			val alloc = Temp.newlabel() and done = Temp.newlabel()
			val r = Temp.newtemp()
		in
			Ex(
				T.ESEQ(
					T.SEQ(
						T.MOVE(T.TEMP r, Frame.externalCall("allocRecord", [T.CONST(num)])),
						T.SEQ(
							T.LABEL alloc,
							T.SEQ(
								T.MOVE(T.MEM(T.BINOP(T.MINUS, T.TEMP r, T.BINOP(T.MUL, T.CONST(wordSize), T.CONST(!count)))), unEx (List.nth(valExpList, !count))),
								T.SEQ(
									T.CJUMP(T.LT, T.CONST(count:=(!count)+1; !count), T.CONST(num), alloc, done),
									T.LABEL done
								)
							)
						)
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
				T.SEQ(
						(log("jump to start"); T.JUMP(T.NAME(start), [start])),
						T.SEQ(
							(log("this is body"); T.LABEL body),
							T.SEQ(
								(log("accessing body..."); unNx bodyExp),
								T.SEQ(
									(log("this is start"); T.LABEL start),
									T.SEQ(
										(log("test in while..."); unCx(testExp)(body, break)),
										T.LABEL break
									)
								)
							)
						)
					)
			)
		end

	fun forExp(varExp,loExp,highExp,bodyExp, break) = 
		let
			val start = Temp.newlabel() and body = Temp.newlabel()
			val varexp = unEx varExp
			val lo = unEx loExp and hi = unEx highExp
		in
			Nx(
				T.SEQ(
						T.MOVE(varexp, lo),
						T.SEQ(
							T.JUMP(T.NAME(start), [start]),
							T.SEQ(
								T.LABEL body,
								T.SEQ(
									unNx bodyExp,
									T.SEQ(
										T.MOVE(varexp, T.BINOP(T.PLUS, varexp, T.CONST(1))),
										T.SEQ(
											T.LABEL start,
											T.SEQ(
												T.CJUMP(T.LE, varexp, hi, body, break),
												T.LABEL break
											)
										)
									)
								)
							)
						)
					)
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