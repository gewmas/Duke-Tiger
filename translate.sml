signature TRANSLATE = 
sig
	type level 
	type access (*not the same as Frame.access*)

	(*CH6*)
	val outermost : level
	val newLevel : {parent: level, name: Temp.label, formals:bool list} -> level
	val formals : level -> access list
	val allocLocal : level -> bool -> access

	(*CH7*)
	structure Frame : FRAME = MipsFrame

	datatype frag = 
		PROC of {body:Tree.stm,frame:Frame.frame} 
		| STRING of Temp.label * string

	datatype exp = 
		Ex of Tree.exp 
		| Nx of Tree.stm
		| Cx of Temp.label * Temp.label

	val unEx : exp -> Tree.exp
	val unNx : exp -> Tree.stm
	val unCx : exp -> Temp.label * Temp.label
	
	val simpleVar : access * level -> exp

	
	val procEntryExit : {level:level, body:exp} -> unit (*p169*)
	val getResult : unit -> Frame.frag list

	(*Process semant - return Tree exp*)
	val opExp : exp * Absyn.oper * exp -> exp

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
	datatype frag = 
		PROC of {body:Tree.stm,frame:Frame.frame} 
		| STRING of Temp.label * string
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
	fun procEntryExit {level, body} = ()
	(*TO-DO*)
	fun getResult () = []


	(*Process semant - return Tree exp*)
	fun opExp(leftExp,oper,rightExp) = 
		case oper of
			A.PlusOp => Ex(Tree.BINOP(Tree.PLUS,unEx(leftExp),unEx(rightExp)))
			| A.MinusOp => Ex(Tree.BINOP(Tree.MINUS,unEx(leftExp),unEx(rightExp)))
			| A.TimesOp => Ex(Tree.BINOP(Tree.MUL,unEx(leftExp),unEx(rightExp)))
			| A.DivideOp => Ex(Tree.BINOP(Tree.DIV,unEx(leftExp),unEx(rightExp)))
			| _ => Ex(Tree.CONST(0))
end