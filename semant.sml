structure Semant :
sig 

	type expty = {exp: Translate.exp, ty: Types.ty}
	type venv = Env.enventry Symbol.table
  	type tenv = Env.ty Symbol.table

  	(*val transVar : venv * tenv * Absyn.var -> expty*)
  	val transExp : venv * tenv * Absyn.exp -> expty
	(*val transDec : venv * tenv * Absyn.dec -> {venv:venv, tenv:tenv}*)
  	(*val transTy : tenv * Absyn.ty -> Types.ty*)
	val transProg : Absyn.exp -> unit 

end 
= 
struct
	type expty = {exp: Translate.exp, ty: Types.ty}
  	type venv = Env.enventry Symbol.table
  	type tenv = Env.ty Symbol.table

  	fun error pos info = print(Int.toString(pos)^info)

  	fun transExp (venv, tenv, Absyn.OpExp{left,oper=Absyn.PlusOp,right,pos}) =
  		let
  			val {exp=_, ty=tyleft} = transExp(venv,tenv,left)
  			val {exp=_, ty=tyright} = transExp(venv,tenv,right)
  		in
  			case tyleft of Types.INT => ()
  							| _ => error pos "interger required";
			case tyright of Types.INT => ()
							| _ => error pos "interger required";
  			{exp=(), ty=Types.INT}
  		end

  	fun transProg exp =
  		let
  			
  		in
  			print "nothing\n"
  		end
end




