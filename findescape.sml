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

	and traverseExp(env:escEnv, d:depth, s:A.exp) : unit =
		case s of
			A.VarExp(var) => traverseVar(env, d, var)
			| A.NilExp => ()
			| A.IntExp(int) => ()
			| A.StringExp(string,pos) => ()
			| A.CallExp{func,args,pos} => (map (fn arg => traverseExp(env, d, arg)) args; ())
			| A.OpExp{left,oper=A.PlusOp,right,pos} => (traverseExp(env, d, left); traverseExp(env, d, right))
			| A.OpExp{left,oper=A.MinusOp,right,pos} => (traverseExp(env, d, left); traverseExp(env, d, right))
			| A.OpExp{left,oper=A.TimesOp,right,pos} => (traverseExp(env, d, left); traverseExp(env, d, right))
			| A.OpExp{left,oper=A.DivideOp,right,pos} => (traverseExp(env, d, left); traverseExp(env, d, right))
			| A.OpExp{left,oper=A.EqOp,right,pos} => (traverseExp(env, d, left); traverseExp(env, d, right))
			| A.OpExp{left,oper=A.NeqOp,right,pos} => (traverseExp(env, d, left); traverseExp(env, d, right))
			| A.OpExp{left,oper=A.LtOp,right,pos} => (traverseExp(env, d, left); traverseExp(env, d, right))
			| A.OpExp{left,oper=A.LeOp,right,pos} => (traverseExp(env, d, left); traverseExp(env, d, right))
			| A.OpExp{left,oper=A.GtOp,right,pos} => (traverseExp(env, d, left); traverseExp(env, d, right))
			| A.OpExp{left,oper=A.GeOp,right,pos} => (traverseExp(env, d, left); traverseExp(env, d, right))
			| A.RecordExp{fields,typ,pos} => (map (fn(symbol,exp,pos)=>(traverseExp(env,d,exp))) fields; ())
			| A.ArrayExp{typ,size,init,pos} => (traverseExp(env, d, size); traverseExp(env, d, init))
			| A.SeqExp(l) => (map (fn exp => traverseExp(env, d, exp)); ())
			| A.AssignExp{var,exp,pos} => (traverseVar(env, d, var); traverseExp(env, d, exp))
			| A.IfExp{test,then',else'=SOME(elseExp),pos} => (traverseExp(env, d, test); traverseExp(env, d, then'); traverseExp(env, d, elseExp))
			| A.IfExp{test,then',else'=NONE,pos} => (traverseExp(env, d, test); traverseExp(env, d, then'))
			| A.WhileExp{test,body,pos} => (traverseExp(env, d, test); traverseExp(env, d, body))
			| A.ForExp{var,escape,lo,hi,body,pos} =>
						let
							val newenv = (escape:=false; S.enter(env,var,(d,escape)))
						in
							traverseExp(env, d, lo);
							traverseExp(env, d, hi);
							traverseExp(newenv, d+1, body)

						end
			| A.BreakExp(pos) => ()
			| A.LetExp{decs,body,pos} => traverseExp((traverseDecs(env, d, decs), d+1, body))

	and traverseDecs(env, d, s:A.dec list) : escEnv = 
		let
			fun traverseDec(dec, env) = 
				case dec of
					A.VarDec{name,escape,typ,init,pos} => (escape:=false; S.enter(env,name,(d,escape)))
					| A.TypeDec({name,ty,pos}::typedeclist) => env
					| A.FunctionDec[{name,params,result,body,pos}] =>
						let 
							val newenv = foldl(fn({name,escape,typ,pos},myenv)=> (escape:=false; Symbol.enter(myenv,name,(d,escape)))) (env) (params)
						in 
							(traverseExp(newenv,d+1,body) ;newenv) 
						end
					| _ => env
		in
			foldl traverseDec (env) (s)
		end

	fun findEscape(prog:A.exp) : unit = traverseExp(S.empty, 0, prog)
end