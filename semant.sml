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

	fun error pos info = print("***Error pos:"^Int.toString(pos)^" "^info^"\n")



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
								{exp=(), ty=Types.NIL}
							)
				)
				| trvar(A.FieldVar(var,symbol,pos)) = {exp=(), ty=Types.INT}
				| trvar(A.SubscriptVar(var,exp,pos)) = {exp=(), ty=Types.INT}
		in
			trvar(var)
		end

	and transExp(venv,tenv,exp) = 
		let 
			fun trexp(A.VarExp(var)) = transVar(venv,tenv,var)

				| trexp(A.NilExp) = {exp=(), ty=Types.NIL}
				| trexp(A.IntExp(int)) = {exp=(), ty=Types.INT}
				| trexp(A.StringExp(string,pos)) = {exp=(), ty=Types.STRING}

				| trexp(A.CallExp{func,args,pos}) = {exp=(), ty=Types.UNIT}

				| trexp(A.OpExp{left,oper=A.PlusOp,right,pos}) =
						(
							checkInt(trexp left, pos);
							checkInt(trexp right, pos);
							{exp=(), ty=Types.INT}
						)
				| trexp(A.OpExp{left,oper=A.MinusOp,right,pos}) =
						(
							checkInt(trexp left, pos);
							checkInt(trexp right, pos);
							{exp=(), ty=Types.INT}
						)
				| trexp(A.OpExp{left,oper=A.TimesOp,right,pos}) =
						(
							checkInt(trexp left, pos);
							checkInt(trexp right, pos);
							{exp=(), ty=Types.INT}
						)
				| trexp(A.OpExp{left,oper=A.DivideOp,right,pos}) =
						(
							checkInt(trexp left, pos);
							checkInt(trexp right, pos);
							{exp=(), ty=Types.INT}
						)
						
				| trexp(A.RecordExp{fields,typ,pos}) = (
							{exp=(), ty=Types.RECORD([],ref())}
						)

				| trexp(A.SeqExp((exp,pos)::rightlist)) = (
							print("A.SeqExp "^Int.toString(pos)^"\n");
							trexp(exp);
							trexp(A.SeqExp(rightlist))
						)
				
				| trexp(A.AssignExp{var,exp,pos}) = (
							{exp=(), ty=Types.INT}
						)

				| trexp(A.IfExp{test,then',else',pos}) = (
							trexp(test);
							trexp(then');
							trexp(Option.valOf(else'))
						)

				| trexp(A.WhileExp{test,body,pos}) = (
							trexp(test);
							trexp(body)
						)

				| trexp(A.ForExp{var,escape,lo,hi,body,pos}) = (
							{exp=(), ty=Types.INT}
						)
				
				| trexp(A.BreakExp(pos)) = (
							{exp=(), ty=Types.NIL}
						)

				| trexp(A.LetExp{decs,body,pos}) = (
							let
								val {venv=venv',tenv=tenv'} = transDecs(venv,tenv,decs)
							in
								transExp(venv',tenv',body)
							end
						)

				| trexp(A.ArrayExp{typ,size,init,pos}) = (
							print("---Calling A.ArrayExp\n");
							checkInt(trexp size, pos);
							checkInt(trexp init, pos);
							{exp=(), ty=Types.ARRAY(Types.INT,ref())}
						)

				| trexp _ = (
							{exp=(), ty=Types.NIL}
						)
		in
			trexp(exp)
		end

	and transDecs(venv,tenv,dec::decs)= (
				let
					val {venv=venv',tenv=tenv'} = transDec(venv,tenv,dec)
				in
					print("---Calling transDecs\n");
					transDecs(venv',tenv',decs)
				end
				
			)
		| transDecs(venv,tenv, _) = (
			print("transDec nil \n");
			{venv=venv, tenv=tenv}
			)

	and transDec(venv,tenv,dec) =
		let
			fun trdec(A.VarDec{name,escape,typ=NONE,init,pos}) = 
					let
						val {exp,ty} = transExp(venv,tenv,init)
					in
						print("A.VarDec NONE\n");
						{venv=S.enter(venv,name,E.VarEntry{ty=ty}),tenv=tenv}
					end
				| trdec(A.VarDec{name,escape,typ=SOME((symbol,pos')),init,pos}) = 
					let
						(*Check type as type exists*)
						fun checkTypeExisted symbol = (
								case S.look(tenv,symbol) of
									NONE => (error pos' ("undefined type "^S.name symbol))
									| _ => (print("Type defined"^S.name symbol^"\n"))
							)
						val {exp,ty} = transExp(venv,tenv,init)
					in
						print("A.VarDec SOME\n");
						checkTypeExisted symbol;
						{venv=S.enter(venv,name,E.VarEntry{ty=ty}),tenv=tenv}
					end

				| trdec (A.TypeDec({name,ty,pos}::typedeclist)) = (
						let
							val venv = venv
							val tenv = S.enter(tenv,name,transTy(tenv,ty))
						in
							print("A.TypeDec\n");
							trdec(A.TypeDec(typedeclist));
							{venv=venv,tenv=tenv}
						end
					)


				(*| trdec (A.FunctionDec[{name,params,body,pos,result=SOME(rt,pos')}]) = {tenv=tenv,venv=nil}*)
				| trdec _ = {venv=venv,tenv=tenv}
		in
			trdec(dec)
		end

	and transTy(tenv,ty) = 
		let
			fun processNameTySymbol symbol =
				case S.name(symbol) of
								"int" => Types.INT
								| "string" => Types.STRING
								| _ => Types.NIL (*TO-DO check exisitng type*)

			fun processRecordTySymbol({name,escape,typ,pos}::fieldlist, resultlist) =
					let
						val typResult = processNameTySymbol(typ)
						val resultlist' = processRecordTySymbol(fieldlist, resultlist)
					in
						(name,typResult)::resultlist'
					end
				| processRecordTySymbol([], resultlist) = resultlist

			fun processTy ty =
				case ty of
					A.NameTy(symbol,pos) 	=> processNameTySymbol symbol
					| A.RecordTy(fieldlist) => 
							let
								val resultlist = processRecordTySymbol(fieldlist,nil)
							in
								Types.RECORD(resultlist,ref())
							end
					| A.ArrayTy(symbol,pos) => Types.ARRAY(processNameTySymbol(symbol),ref())
		in
			processTy(ty)
		end

		
	fun transProg exp =
		let
			val ty = Types.NIL
			val venv = S.empty
			val tenv = S.empty
		in
			print ">>>transProg begins\n";
      		transExp (venv,tenv,exp);
			print ">>>transProg ends\n"
		end
end




