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
	val callExp : exp * exp * Temp.label * exp list -> exp
	val opExp : exp * Absyn.oper * exp -> exp
	val cmpExp : exp * Absyn.oper * exp -> exp
	val recordExp : int * exp list -> exp 
	val seqExp : exp list -> exp 
	val assignExp : exp * exp -> exp 
	val ifExp : exp * exp * exp -> exp 
	val whileExp : exp * exp -> exp 
	val forExp : exp * exp * exp * exp * exp -> exp 
	val breakExp : exp -> exp 
	val letExp : exp * int -> exp (*TO-DO*)
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

	fun unEx (Ex e) = e
		| unEx (Nx s) = T.ESEQ(s,T.CONST 0) (*should this be error message printing?*)
		| unEx (Cx genstm) = 
			let
				val r = Temp.newtemp()
				val t = Temp.newlabel() and f = Temp.newlabel()
			in
				T.ESEQ(T.SEQ(
							[T.MOVE(T.TEMP r,T.CONST 1),
							genstm(t,f),
							T.LABEL f,
							T.MOVE(T.TEMP r, T.CONST 0),
							T.LABEL t
							]),
						T.READ(T.TEMP r))
			end

	(*TO-DO*)
	(*------------------------------------------------------------------*)
	(*modification goes here*)
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

	(*modification ends here*)
	(*------------------------------------------------------------------*)

	
	(*
	 * p170 All the remembered fragments go into a frag list ref local to Translate
	 * Then getResult can be used to extract the fragment list.
	 *)
	val fraglist : Frame.frag list ref = ref []

	(*TO-DO*)
	fun procEntryExit{level,body} = 
		case level of
			Top => ()
			| Inner{unique,parent,frame} => 
				let
					val stm = case body of
						Ex(e) => T.EXP(e)
						| Nx(s) => s

						(*| Cx(l1,l2) => (fn (l1,l2) => T.EXP(T.CONST(0)))*) (*TO-DO*)

					val frameProc = Frame.PROC{body=stm,frame=frame}
				in
					fraglist := frameProc :: (!fraglist)
				end
	fun getResult () = !fraglist

	fun errorExp() = Ex(T.CONST(0))
	(*
	 * ===================================================
	 * transVar - A.SimpleVar, A.FieldVar, A.SubscriptVar
	 * ===================================================
	 *)

	
	(*
	 * p156, Must produce a chain of MEM and + nodes to fetch static links for
	 * all frames between the level of use (the level passed to simpleVar)
	 * and the level of definition (the level within the variable's access)
	 *)

	(*TO-DO-----Still not clear how to follow the static link to outer level, calculateOffset-----------------------------------*)
	(*what if frameAccess is in register? we should check this first*)
	(*--------------------------------------------------------------------*)
	(*If frameAccess inReg, not need to check level match*)
	fun simpleVar ((levelDefined,frameAccess),levelUsed) = 
		let
			fun calculateOffset (currentLevel,Top) = 0
				| calculateOffset (currentLevel,parentLevel) = 
				let
					val () = log("Translate.simpleVar.calculateOffset")
					val currentLevelStaticLink = staticLink currentLevel
					val parentLevelStaticLink = staticLink parentLevel

					val currentLevelStaticLinkConst = Frame.accessInFrameConst currentLevelStaticLink
					val () = log("currentLevelStaticLinkConst:"^Int.toString(currentLevelStaticLinkConst))
					val parentLevelStaticLinkConst = Frame.accessInFrameConst parentLevelStaticLink
					val () = log("parentLevelStaticLinkConst:"^Int.toString(parentLevelStaticLinkConst))
				in
					currentLevelStaticLinkConst - parentLevelStaticLinkConst
				end

			fun produceMem (constExp,prevFPExp) = 
				Tree.READ(Tree.MEM(Tree.BINOP(Tree.PLUS,constExp,prevFPExp)))

			(*Go to parent level of current level until level match*)
			fun checkLevelMatch(currentLevel) : Tree.exp=
				if currentLevel = Top
					then (
						  log("Top level ---- Should not include any frame or formal parameter list");
						  Tree.CONST(0)
						  )
				else if levelUnique(currentLevel) = levelUnique(levelDefined)
					then (
						log("Same level found ----");
						T.READ(T.TEMP(Frame.FP))
						)
				else (
					log("Static link request ----");
					(*CONST k_n is the offset of x in its own frame*)
					produceMem(Tree.CONST(calculateOffset(currentLevel,levelParent currentLevel)),checkLevelMatch(levelParent currentLevel))
					) 
							
		in
			Ex(Frame.exp(frameAccess)(checkLevelMatch(levelUsed)))
		end


	(*TO-DO*)
	(*should be wrong because varExp is now a value not a location*)
	fun fieldVar(varExp, index) = 
		Ex(Tree.READ(Tree.MEM(Tree.BINOP(Tree.MINUS, unEx varExp, Tree.BINOP(Tree.MUL, Tree.CONST(index), Tree.CONST(wordSize) )))))

	(*TO-DO*)
	fun subscriptVar(varExp, indexExp) = 
		let
			val t = Temp.newlabel() and f = Temp.newlabel() and join = Temp.newlabel()
			val r = Temp.newtemp()
			val indexp = unEx indexExp
			val varexp = unEx varExp
		in
			Ex(
				T.ESEQ(
						T.SEQ([	
							(*still the problem of loc and fetch the value, this varexp should be the location but not the value store in that location*)
							T.CJUMP(T.LT, indexp, varexp, t, f),    
							T.LABEL t,
							T.MOVE(T.TEMP r, T.BINOP(T.PLUS, varexp, Tree.BINOP(Tree.MUL, Tree.CONST(wordSize), indexp))),
							T.JUMP(T.READ(T.NAME(join)), [join]),
							T.LABEL f,
							T.MOVE(T.TEMP r, unEx (errorExp())),
							T.LABEL join
							]),
						T.READ(T.TEMP r)
					)

			)
			(*Ex(Tree.READ(Tree.MEM(Tree.BINOP(Tree.MINUS, unEx varExp, unEx indexExp))))*)
		end
		

	(*
	 * ======================================================
	 * transExp - A.VarExp, A.NilExp, A.IntExp, A.StringExp
	 * 			  A.CallExp, A.OpExp, A.RecordExp, A.SeqExp
	 *			  A.AssignExp, A.IfExp, A.WhileExp, A.ForExp
	 *			  A.BreakExp, A.LetExp, A.ArrayExp
	 * ======================================================
	 *)
	

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
			Ex(T.READ(T.NAME(label)))
		end

	(*TO-DO*)
	fun callExp(definedLevel, calledLevel, label, args) = Ex(Tree.CONST(0))

	(*TO-DO*)
	(*Process semant - return Tree exp*)
	fun opExp(leftExp,oper,rightExp) = 
		case oper of
			A.PlusOp => (log("opExp A.PlusOp");Ex(Tree.BINOP(Tree.PLUS,unEx(leftExp),unEx(rightExp))))
			| A.MinusOp => Ex(Tree.BINOP(Tree.MINUS,unEx(leftExp),unEx(rightExp)))
			| A.TimesOp => Ex(Tree.BINOP(Tree.MUL,unEx(leftExp),unEx(rightExp)))
			| A.DivideOp => Ex(Tree.BINOP(Tree.DIV,unEx(leftExp),unEx(rightExp)))
			| _ => Ex(Tree.CONST(0))

	fun cmpExp(leftExp, oper, rightExp) = Ex(T.CONST(0))

	(*
	 * type initArray = array of int
	 * var a := initArray[12] of 0
	 * var b := initArray[12] of 7
	 * 
	 * The array variable a ends up pointing to the same 12 sevens as the variable b
	 *)

	fun arrayExp(initExp, sizeExp) = 
		let
			(*fun unExList() = map unEx valExpList*)
		in
			Ex(T.CALL(T.READ(T.NAME(Temp.namedlabel("initArray"))), [unEx sizeExp, unEx initExp]))
		end


	(*should be wrong because every initial value may not be the same*)
	fun recordExp(num, valExpList) = 
		let
			fun unExList() = map unEx valExpList
		in
			Ex(T.CALL(T.READ(T.NAME(Temp.namedlabel("initArray"))), T.CONST(num)::unExList()))
		end
		

	fun seqExp([]) = (
				log("T.seqExp empty");
				Ex(Tree.CONST(0))
			)
		| seqExp(exp::explist) = (
				log("T.seqExp");
				Ex(Tree.ESEQ(unNx exp, unEx(seqExp explist)))
			)

	
	fun assignExp(varExp, assignedExp) = Nx(T.MOVE(T.MEM(unEx varExp), unEx assignedExp))

	fun ifExp(ifExp, thenExp, elseExp) = (*Ex(Tree.CONST(0))*)
		let
			
			val t = Temp.newlabel() and f = Temp.newlabel() and join = Temp.newlabel()
			val r = Temp.newtemp()
		in
			Ex(T.ESEQ(
					T.SEQ([	unCx(ifExp)(t, f), 
							T.LABEL(t),
							T.MOVE(T.TEMP(r), unEx thenExp),
							T.JUMP(T.READ(T.NAME(join)), [join]),
							T.LABEL(f),
							T.MOVE(T.TEMP(r), unEx elseExp),
							T.LABEL(join)
							]),
					T.READ(T.TEMP(r))
					)
				)
		end

	(*TO-DO*)
	(*need to take into account BREAK*)
	fun whileExp(testExp, bodyExp) = 
		let
			val start = Temp.newlabel() and body = Temp.newlabel() and done = Temp.newlabel()
		in
			Nx(
				T.SEQ([
					T.JUMP(T.READ(T.NAME(start)), [start]),
					T.LABEL body,
					unNx bodyExp,
					T.LABEL start,
					unCx(testExp)(body, done),
					T.LABEL done
					])
			)
		end
		
	(*TO-DO*)
	(*need to take into account BREAK*)
	fun forExp(varExp,loExp,highExp,bodyExp,break) = 
		let
			val start = Temp.newlabel() and body = Temp.newlabel() and done = Temp.newlabel()
			val r = Temp.newtemp()
			val lo = unEx loExp and hi = unEx highExp
		in
			Nx(
				T.SEQ([
						T.MOVE(T.TEMP(r), lo),
						T.JUMP(T.READ(T.NAME(start)), [start]),
						T.LABEL body,
						unNx bodyExp,
						T.MOVE(T.TEMP(r), T.BINOP(T.PLUS, T.READ(T.TEMP(r)), T.CONST(1))),
						T.LABEL start,
						T.CJUMP(T.LE, T.READ(T.TEMP(r)), hi, body, done),
						T.LABEL done
					])
			)
		end
		

	(*TO-DO*)
	fun breakExp(exp) = Ex(Tree.CONST(0))

	(*TO-DO*)
	fun letExp(varExp, index) = 
		let
			
		in
			Ex(Tree.CONST(0))
		end
		

	(*TO-DO*)
	
	
end