
signature ENV = 
sig
	type access
	type ty
	datatype enventry = 
		VarEntry of {ty: ty} 
		| FunEntry of {formals: ty list, result: ty}
end