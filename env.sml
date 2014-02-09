
signature ENV = 
sig
	type access
	type ty
	datatype enventry = 
		VarEntry of {ty: ty} 
		| FunEntry of {formals: ty list, result: ty}
end

structure Env :> ENV = 
struct
	type access = bool
	type ty = Types.ty Symbol.table
	datatype enventry = 
		VarEntry of {ty: ty} 
		| FunEntry of {formals: ty list, result: ty}
end