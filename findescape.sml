structure FindEscape : 
sig val prog : Absyn.exp -> unit end 
= 
struct
	type depth = int
	type escEnv = (depth * bool ref) Symbol.table

	fun traverseVar(env:escEnv, d:depth, s:Absyn.var) : unit =
		()
	and traverseExp(env:escEnv, d:depth, s:Absyn.exp) : unit =
		()
	and traverseDecs(env, d, s:Absyn.dec list) : escEnv = 
		(Symbol.empty)

	fun prog(prog:Absyn.exp) : unit = ()
end