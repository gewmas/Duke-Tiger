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
	structure A = Absyn

	type expty = {exp: Translate.exp, ty: Types.ty}
	type venv = Env.enventry Symbol.table
	type tenv = Env.ty Symbol.table

	fun error pos info = print("pos:"^Int.toString(pos)^" "^info^"\n")

	fun checkInt ({exp,ty},pos) = 
		(
			case ty of Types.INT 	=> ()
								| _ => error pos "interger required"
		)

	fun transExp (venv,tenv,exp) = 
		let 
			fun trexp(A.OpExp{left,oper=A.PlusOp,right,pos}) =
						(
							checkInt(trexp left, pos);
							checkInt(trexp right, pos);
							{exp=(), ty=Types.INT}
						)
				| trexp(A.VarExp(var)) = ({exp=(), ty=Types.INT})
				| trexp(A.LetExp{decs,body,pos}) = ({exp=(), ty=Types.STRING})
				| trexp _ = ({exp=(), ty=Types.STRING})
			and trvar(A.SimpleVar(id,pos)) =
				(
					(*case Symbol.look(venv,id) of
						SOME(Env.VarEntry{ty}) => ({exp=(), ty=Types.INT})
						| NONE => ({exp=(), ty=Types.INT})*)
				)
				| trvar(A.FieldVar(v,id,pos)) = ()
				| trvar _ = ()
		in
			trexp(exp)
		end

	(*fun transDec (venv,tenv,A.VarDec{name,escape,typ=NONE,init,pos}) = ()*)

	fun transProg exp =
		let
			
		in
			print "===transProg begins===\n";
      		transExp (nil,nil,exp);
			print "===transProg ends===\n"
		end
end




