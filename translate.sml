signature TRANSLATE = 
sig
	type level
	type access (*not the same as Frame.access*)
	
	(*type exp*)
	datatype exp = 
		Ex of Tree.exp 
		| Nx of Tree.stm
		| Cx of Temp.label * Temp.label

	(*CH6*)
	(*val outermost : level
	val newLevel : {parent: level, name: Temp.label, formals:bool list} -> level
	val formals : level -> access list
	val allocLocal : level -> bool -> access*)

	(*CH7*)
	(*val procEntryExit : {level:level, body:exp} -> unit*)
	(*structure Frame : FRAME = MipsFrame*)
	(*val getResult : unit -> Frame.frag list*)

	(*val simpleVar : access * level -> exp*)
end

structure Translate : TRANSLATE = 
struct
	structure Frame : FRAME = MipsFrame

	type level = int
	type access = level * Frame.access

	(*type exp = unit*)
	datatype exp = 
		Ex of Tree.exp 
		| Nx of Tree.stm
		| Cx of Temp.label * Temp.label

	
end