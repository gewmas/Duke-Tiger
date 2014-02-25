
signature ENV = 
sig
	type access
	type ty = Types.ty
	datatype enventry = 
		VarEntry of {ty: ty} 
		| FunEntry of {formals: ty list, result: ty}
	(*val base_tenv : ty Symbol.table*)
	(*val base_venv : enventry Symbol.table*)

	(*new verions of VarEntry and FunEntry*)
	(*datatype enventry = 
		VarEntry of {access:Translate.access, ty: ty} 
		| FunEntry of {level:Translate.level, label:Temp.label, formals: ty list, result: ty}	*)
end

structure Env :> ENV = 
struct
	type access = bool
	type ty = Types.ty
	datatype enventry = 
		VarEntry of {ty: ty} 
		| FunEntry of {formals: ty list, result: ty}
	(*val base_tenv = ty Symbol.table*)
	(*val base_venv = enventry Symbol.table*)
end