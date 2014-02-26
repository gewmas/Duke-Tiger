signature TRANSLATE = 
sig
	type level
	type access (*not the same as Frame.access*)
	type exp

	val outermost : level
	val newLevel : {parent: level, name: Temp.label, formals:bool list} -> level
	val formals : level -> access list
	val allocLocal : level -> bool -> access


	val procEntryExit : {level:level, body:exp} -> unit
	structure Frame : FRAME
	val getResult : unit -> Frame.frag list

	(*val simpleVar : access * level -> exp*)
end

structure Translate (*: TRANSLATE *)= 
struct
	(*type exp = unit*)

	datatype exp = 
		Ex of Tree.exp 
		| Nx of Tree.stm
		| Cx of Temp.label * Temp.label

	(*type access = level * Frame.access*)
end