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
		| Cx of Temp.label * Temp.label

	val unEx : exp -> Tree.exp
	val unNx : exp -> Tree.stm
	val unCx : exp -> Temp.label * Temp.label

	val procEntryExit : {level:level, body:exp} -> unit (*p169*)
	val getResult : unit -> Frame.frag list

	(*Process semant - return Tree exp*)
	(*transVar*)
	val simpleVar : access * level -> exp
	val fieldVar : exp * int -> exp
	val subscriptVar : exp * int -> exp
	(*transExp*)
	val errorExp : unit -> exp
	val nilExp : unit -> exp
	val intExp : int -> exp
	val stringExp : string -> exp
	val callExp : exp * int -> exp
	val opExp : exp * Absyn.oper * exp -> exp
	val recordExp : exp * int -> exp
	val seqExp : exp * int -> exp
	val assignExp : exp * int -> exp
	val ifExp : exp * int -> exp
	val whileExp : exp * int -> exp
	val forExp : exp * int -> exp
	val breakExp : exp * int -> exp
	val letExp : exp * int -> exp
	val arrayExp : exp * int -> exp

end

structure Translate : TRANSLATE = 
struct
	structure Frame : FRAME = MipsFrame
	structure T = Tree
	structure A = Absyn

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
	fun staticLink level : Frame.access = 
		let
			(*fun getAccessList () = 
				case level of
					Inner{unique,parent,frame} => (#formals(frame))
					| Top => []
			val accessFrameListWithStaticLink = getAccessList()

			fun getOnlyStaticLink[] = []
				| getOnlyStaticLink(l::r) = l*)
		in
			(*getOnlyStaticLink(accessFrameListWithStaticLink)*)
			Frame.InFrame(0)
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
		| Cx of Temp.label * Temp.label

	fun unEx (Ex e) = e
		| unEx (Nx s) = T.ESEQ(s,T.CONST 0)
		| unEx (Cx genstm) = 
			let
				val r = Temp.newtemp()
				val t = Temp.newlabel() and f = Temp.newlabel()
			in
				T.ESEQ(T.SEQ(
							[T.MOVE(T.TEMP r,T.CONST 1),
							(*genstm(t,f),*)
							T.LABEL f,
							T.MOVE(T.TEMP r, T.CONST 0),
							T.LABEL t
							]),T.READ(T.TEMP r))
			end

	(*TO-DO*)
	fun unNx (Ex e) = Tree.EXP(Tree.CONST(0))
		| unNx (Nx s) = Tree.EXP(Tree.CONST(0))
		| unNx (Cx genstm) = Tree.EXP(Tree.CONST(0))

	(*TO-DO*)
	fun unCx (Ex e) = (Symbol.symbol(""),Symbol.symbol(""))
		| unCx (Nx s) = (Symbol.symbol(""),Symbol.symbol(""))
		| unCx (Cx genstm) = (Symbol.symbol(""),Symbol.symbol(""))

	(*TO-DO*)
	fun procEntryExit{level,body} = 
		case level of
			Top => ()
			| Inner{unique,parent,frame} => ()
	(*
	 * p170 All the remembered fragments go into a frag list ref local to Translate
	 * Then getResult can be used to extract the fragment list.
	 *)
	val fraglist : Frame.frag list ref = ref []
	fun getResult () = !fraglist


	(*
	 * ===================================================
	 * transVar - A.SimpleVar, A.FieldVar, A.SubscriptVar
	 * ===================================================
	 *)

	(*TO-DO*)
	(*
	 * p156, Must produce a chain of MEM and + nodes to fetch static links for
	 * all frames between the level of use (the level passed to simpleVar)
	 * and the level of definition (the level within the variable's access)
	 *)
	fun simpleVar ((levelDefined,frameAccess),levelUsed) = 
		let
			fun produceMem (constExp,prevFPExp) = 
				Tree.READ(Tree.MEM(Tree.BINOP(Tree.PLUS,constExp,prevFPExp)))

			(*Go to parent level of current level until level match*)
			fun checkLevelMatch currentLevel =
				if currentLevel = Top
					then (produceMem(Tree.CONST(0),Tree.CONST(Frame.accessInFrameConst(staticLink(currentLevel)))))
				else if levelUnique(currentLevel) = levelUnique(levelDefined)
					then (produceMem(Tree.CONST(Frame.accessInFrameConst(frameAccess)),Tree.CONST(Frame.accessInFrameConst(staticLink(currentLevel)))))
				else (produceMem(Tree.CONST(0),Tree.CONST(Frame.accessInFrameConst(staticLink(currentLevel))))) 
							
		in
			checkLevelMatch levelUsed;
			Ex(Tree.CONST(0))
		end
	(*TO-DO*)
	fun fieldVar(varExp, index) = Ex(Tree.CONST(0))
	(*TO-DO*)
	fun subscriptVar(varExp, index) = Ex(Tree.CONST(0))

	(*
	 * ======================================================
	 * transExp - A.VarExp, A.NilExp, A.IntExp, A.StringExp
	 * 			  A.CallExp, A.OpExp, A.RecordExp, A.SeqExp
	 *			  A.AssignExp, A.IfExp, A.WhileExp, A.ForExp
	 *			  A.BreakExp, A.LetExp, A.ArrayExp
	 * ======================================================
	 *)
	fun errorExp() = Ex(T.CONST(0))

	fun nilExp() = Ex(Tree.CONST(0))

	fun intExp(n) = Ex(Tree.CONST(n))

	fun stringExp(s) =  
		let 
			val label = Temp.newlabel()
			val () = (fraglist := Frame.STRING(label, s)::(!fraglist))
		in 
			Ex(Tree.READ(Tree.NAME(label)))
		end

	(*TO-DO*)
	fun callExp(varExp, index) = Ex(Tree.CONST(0))

	(*Process semant - return Tree exp*)
	fun opExp(leftExp,oper,rightExp) = 
		case oper of
			A.PlusOp => Ex(Tree.BINOP(Tree.PLUS,unEx(leftExp),unEx(rightExp)))
			| A.MinusOp => Ex(Tree.BINOP(Tree.MINUS,unEx(leftExp),unEx(rightExp)))
			| A.TimesOp => Ex(Tree.BINOP(Tree.MUL,unEx(leftExp),unEx(rightExp)))
			| A.DivideOp => Ex(Tree.BINOP(Tree.DIV,unEx(leftExp),unEx(rightExp)))
			| _ => Ex(Tree.CONST(0))

	(*TO-DO*)
	fun recordExp(varExp, index) = Ex(Tree.CONST(0))

	(*TO-DO*)
	fun seqExp(varExp, index) = Ex(Tree.CONST(0))

	(*TO-DO*)
	fun assignExp(varExp, index) = Ex(Tree.CONST(0))

	(*TO-DO*)
	fun ifExp(varExp, index) = Ex(Tree.CONST(0))

	(*TO-DO*)
	fun whileExp(varExp, index) = Ex(Tree.CONST(0))

	(*TO-DO*)
	fun forExp(varExp, index) = Ex(Tree.CONST(0))

	(*TO-DO*)
	fun breakExp(varExp, index) = Ex(Tree.CONST(0))

	(*TO-DO*)
	fun letExp(varExp, index) = Ex(Tree.CONST(0))

	(*TO-DO*)
	fun arrayExp(varExp, index) = Ex(Tree.CONST(0))
end