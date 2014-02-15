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
			case ty of Types.INT 	=> (print("      checkInt Types.INT\n"))
						 (*TO-DO Recursive find the variable and check*)
								| _ => error pos "interger required"
		)

	fun transVar(venv,tenv,var) = 
		let
			fun trvar(A.SimpleVar(id,pos)) =
				(
					case S.look(venv,id) of
						SOME(E.VarEntry{ty}) => (
								print("   A.SimpleVar E.VarEntry looking for "^S.name(id)^" \n");
								{exp=(), ty=ty}
							)
						| SOME(E.FunEntry{formals,result}) => {exp=(), ty=Types.FUNCTION(formals,result)}
						| NONE => (
								error pos ("undefined variable or function"^S.name id);
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
			fun trexp(A.VarExp(var)) = (
						print("  A.VarExp\n");
						transVar(venv,tenv,var)
					)

				| trexp(A.NilExp) = {exp=(), ty=Types.NIL}
				| trexp(A.IntExp(int)) = (
						print("  A.IntExp\n");
						{exp=(), ty=Types.INT}
					)
				| trexp(A.StringExp(string,pos)) = {exp=(), ty=Types.STRING}

				| trexp(A.CallExp{func,args,pos}) = (
						let
							val {exp,ty} = transVar(venv,tenv,A.SimpleVar(func,pos))
							
							(*To-DO check args match formals and return result*)
						in
							print("  A.CallExp\n");
							{exp=(), ty=ty}
						end
					)

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
							print("  A.OpExp A.TimesOp\n");
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
				| trexp(A.OpExp{left,oper=A.EqOp,right,pos}) =
						(
							print("  A.OpExp A.EqOp\n");
							checkInt(trexp left, pos);
							checkInt(trexp right, pos);
							{exp=(), ty=Types.INT}
						)
				| trexp(A.OpExp{left,oper=A.NeqOp,right,pos}) =
						(
							checkInt(trexp left, pos);
							checkInt(trexp right, pos);
							{exp=(), ty=Types.INT}
						)
				| trexp(A.OpExp{left,oper=A.LtOp,right,pos}) =
						(
							checkInt(trexp left, pos);
							checkInt(trexp right, pos);
							{exp=(), ty=Types.INT}
						)
				| trexp(A.OpExp{left,oper=A.LeOp,right,pos}) =
						(
							checkInt(trexp left, pos);
							checkInt(trexp right, pos);
							{exp=(), ty=Types.INT}
						)
				| trexp(A.OpExp{left,oper=A.GtOp,right,pos}) =
						(
							checkInt(trexp left, pos);
							checkInt(trexp right, pos);
							{exp=(), ty=Types.INT}
						)
				| trexp(A.OpExp{left,oper=A.GeOp,right,pos}) =
						(
							checkInt(trexp left, pos);
							checkInt(trexp right, pos);
							{exp=(), ty=Types.INT}
						)
						
				| trexp(A.RecordExp{fields,typ,pos}) = (
							{exp=(), ty=Types.RECORD([],ref())}
						)

				| trexp(A.SeqExp((exp,pos)::rightlist)) = (
							print("  A.SeqExp "^Int.toString(pos)^"\n");
							trexp(exp);
							trexp(A.SeqExp(rightlist))
						)
				
				| trexp(A.AssignExp{var,exp,pos}) = (
							{exp=(), ty=Types.INT}
						)

				| trexp(A.IfExp{test,then',else',pos}) = (
							print(" A.IfExp If\n");
							trexp(test);
							print(" A.IfExp Then\n");
							trexp(then');
							print(" A.IfExp Else\n");
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

	and transDecs(venv,tenv, []) = (
			print("---Calling transDec nil \n");
			{venv=venv, tenv=tenv}
			)
		| transDecs(venv,tenv,dec::decs)= (
				let
					val {venv=venv',tenv=tenv'} = transDec(venv,tenv,dec)
				in
					print("---Called one transDec, calling next one in decs.\n");
					transDecs(venv',tenv',decs)
				end
				
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

				| trdec (A.FunctionDec[{name,params,result=SOME(rt,pos'),body,pos}]) =
						let								
						 	(*val SOME(result_ty) = S.look(tenv,rt)*)
						 	val result_ty = 
						 		case S.look(tenv,rt) of
							 		SOME(result_ty') => (
							 				print("A.FunctionDec result_ty SOME: "^S.name(rt)^" \n"); 
							 				result_ty'
							 			)
							 		| NONE => (
								 			print("A.FunctionDec result_ty NONE: "^S.name(rt)^" \n"); 
							 				Types.NIL
							 			)

						 	fun transparam{name,escape,typ,pos} = 
						 		case S.look(tenv,typ) of
						 			SOME t => (
						 					print("A.FunctionDec transparam SOME param: "^S.name(name)^" \n"); 
						 					{name=name,ty=t}
						 				)
						 			| NONE => (
						 					print("A.FunctionDec transparam NONE param: "^S.name(name)^" \n"); 
						 					{name=name, ty=Types.NIL}
						 				)

						 	val params' = map transparam params

						 	val venv' = S.enter(venv,name,E.FunEntry{formals=map #ty params', result=result_ty})

						 	fun enterparam ({name,ty},venv) = (
						 			print("FunctionDec S.enter E.VarEntry "^S.name(name)^" \n");
						 			S.enter(venv,name,E.VarEntry{ty=ty})
						 		)
						 	
						 	val venv'' = foldr enterparam venv' params'
						 in
						 	print("A.FunctionDec\n");
						 	(*Deal with exp inside the function body, thus pass venv''*)
						 	transExp(venv'',tenv,body);
						 	(*Return venv' without the parameters*)
						 	{venv=venv',tenv=tenv}
						 end 
				
				| trdec _ = (
								print("Calling transDec other");
								{venv=venv,tenv=tenv}
							)

				
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
			val tenv = S.enter(S.enter(S.empty,S.symbol("int"),Types.INT),S.symbol("string"),Types.STRING)
		in
			print ">>>transProg begins\n";
      		transExp (venv,tenv,exp);
			print ">>>transProg ends\n"
		end
end




