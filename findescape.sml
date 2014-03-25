structure FindEscape : 
sig val findEscape : Absyn.exp -> unit end 
= 
struct
	structure A = Absyn
	structure S = Symbol
	type depth = int
	type escEnv = (depth * bool ref) S.table

	val allowError = true
	val allowPrint = true
	fun error pos info = if allowError then print("**********************************\nError pos:"^Int.toString(pos)^" "^info^"\n**********************************\n") else ()
	fun log info = if allowPrint then print("***semant*** "^info^"\n") else ()

	fun traverseVar(env:escEnv, d:depth, s:A.var) : unit =
		case s of
			A.SimpleVar(symbol,pos) => 
					(
					case S.look(env, symbol) of
						SOME (depth, escBool) => if d > depth then escBool := true else ()
						| NONE => error pos ("The symbol "^S.name(symbol)^" has not been found in table!")
					)
			| A.FieldVar(var,symbol,pos) => traverseVar(env, d, var)
			| A.SubscriptVar(var,exp,pos) => traverseVar(env, d, var)
			(*| _ => error 0 ("The type of var is not matched!")*)
	and traverseExp(env:escEnv, d:depth, s:Absyn.exp) : unit =
		()
	and traverseDecs(env, d, s:A.dec list) : escEnv = 
		(S.empty)

	fun findEscape(prog:A.exp) : unit = traverseExp(S.empty, 0, prog)
end