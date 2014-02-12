structure Semant :
sig 

	type expty = {exp: Translate.exp, ty: Types.ty}
	type venv = Env.enventry Symbol.table
  	type tenv = Types.ty Symbol.table

  	val transVar : venv * tenv * Absyn.var -> expty
  	val transExp : venv * tenv * Absyn.exp -> expty
	val transDec : venv * tenv * Absyn.dec -> {venv:venv, tenv:tenv}
  	val transTy : tenv * Absyn.ty -> Types.ty
	val transProg : Absyn.exp -> unit 

end 
= 
struct
	structure A = Absyn
	structure E = Env
	structure S = Symbol

	type expty = {exp: Translate.exp, ty: Types.ty}
	type venv = Env.enventry Symbol.table
	type tenv = Env.ty Symbol.table

	fun error pos info = print("pos:"^Int.toString(pos)^" "^info^"\n")

	fun checkInt ({exp,ty},pos) = 
		(
			case ty of Types.INT 	=> ()
								| _ => error pos "interger required"
		)

	fun transVar(venv,tenv,var) = 
		let
			fun trvar(A.SimpleVar(id,pos)) =
				(
					case S.look(venv,id) of
						SOME(E.VarEntry{ty}) => {exp=(), ty=Types.INT}
						| SOME(E.FunEntry{formals,result}) => {exp=(), ty=Types.INT}
						| NONE => (
								error pos ("undefined variable "^S.name id);
								{exp=(), ty=Types.INT}
							)
				)
				| trvar(A.FieldVar(var,symbol,pos)) = {exp=(), ty=Types.INT}
				| trvar(A.SubscriptVar(var,exp,pos)) = {exp=(), ty=Types.INT}
		in
			trvar(var)
		end

	and transExp(venv,tenv,exp) = 
		let 
			fun trexp(A.VarExp(var)) = ({exp=(), ty=Types.INT})
				| trexp(A.NilExp) = ({exp=(), ty=Types.INT})
				| trexp(A.IntExp(int)) = ({exp=(), ty=Types.INT})
				| trexp(A.StringExp(string,pos)) = ({exp=(), ty=Types.INT})
				| trexp(A.CallExp{func,args,pos}) = ({exp=(), ty=Types.INT})
				| trexp(A.OpExp{left,oper=A.PlusOp,right,pos}) =
						(
							checkInt(trexp left, pos);
							checkInt(trexp right, pos);
							{exp=(), ty=Types.INT}
						)
				| trexp(A.RecordExp{fields,typ,pos}) = ({exp=(), ty=Types.INT})
				| trexp(A.SeqExp[(exp,pos)]) = ({exp=(), ty=Types.INT})
				| trexp(A.AssignExp{var,exp,pos}) = ({exp=(), ty=Types.INT})
				| trexp(A.IfExp{test,then',else',pos}) = ({exp=(), ty=Types.INT})
				| trexp(A.WhileExp{test,body,pos}) = ({exp=(), ty=Types.INT})
				| trexp(A.ForExp{var,escape,lo,hi,body,pos}) = ({exp=(), ty=Types.INT})
				| trexp(A.BreakExp(pos)) = ({exp=(), ty=Types.INT})
				| trexp(A.LetExp{decs,body,pos}) = (
						let
							(*val {venv=venv',tenv=tenv'} = transDecs(venv,tenv,decs)*)
						in
							{exp=(), ty=Types.STRING}
						end
					)
				| trexp(A.ArrayExp{typ,size,init,pos}) = ({exp=(), ty=Types.INT})
				| trexp _ = ({exp=(), ty=Types.STRING})
		in
			trexp(exp)
		end

	and transDecs(venv,tenv,decs)= ()

	and transDec(venv,tenv,dec) =
		let
			fun trdec(A.VarDec{name,typ=NONE,init,...}) = 
					let
						val {exp,ty} = transExp(venv,tenv,init)
					in
						{venv=S.enter(venv,name,E.VarEntry{ty=ty}),tenv=tenv}
					end
				| trdec (A.TypeDec[{name,ty,...}]) = 
						{venv=venv, tenv=S.enter(tenv,name,transTy(tenv,ty))}
				(*| trdec (A.FunctionDec[{name,params,body,pos,result=SOME(rt,pos')}]) = {tenv=tenv,venv=nil}*)
				| trdec _ = {tenv=tenv,venv=venv}
		in
			trdec(dec)
		end

	and transTy(tenv,ty) = 
		let
			fun trty(ty) = Types.INT
		in
			trty(ty)
		end
	

	fun transProg exp =
		let
			
		in
			print "===transProg begins===\n";
      		(*transExp (nil,nil,exp);*)
			print "===transProg ends===\n"
		end
end




