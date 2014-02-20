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

	fun error pos info = print("**********************************\nError pos:"^Int.toString(pos)^" "^info^"\n**********************************\n")

	fun actural_ty ty = case ty of
		Types.NAME(symbol, ref(SOME(typeName))) => actural_ty typeName
		| Types.NAME(symbol, ref(NONE)) => (error 0 ("not found in Types.NAME."); Types.NIL)
		| _ => ty

	fun checkInt ({exp,ty},pos) = 
		(
			case ty of Types.INT 	=> (print("      checkInt Types.INT\n"))
						| _ => error pos "interger required"
		)

	fun transVar(venv,tenv,var) = 
		let
			fun trvar(A.SimpleVar(id,pos)) =
				(
					case S.look(venv,id) of
						SOME(E.VarEntry{ty}) => (
								print("   A.SimpleVar E.VarEntry looking for "^S.name(id)^" \n");
								{exp=(), ty=actural_ty ty}
							)
						| SOME(E.FunEntry{formals,result}) => (
								print("   A.SimpleVar E.FunEntry looking for "^S.name(id)^" \n");
								{exp=(), ty=Types.FUNCTION(formals,result)}
							)
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
						print("   A.IntExp\n");
						{exp=(), ty=Types.INT}
					)
				| trexp(A.StringExp(string,pos)) = (
							print("   A.StringExp\n");
							{exp=(), ty=Types.STRING}
						)

				| trexp(A.CallExp{func,args,pos}) = (
						let
							val {exp,ty} = transVar(venv,tenv,A.SimpleVar(func,pos))

							fun checkType(Types.FUNCTION(formals, result)) = (
										print("     A.CallExp Types.FUNCTION\n");
										{formals=formals, tyresult=result}
									)
								| checkType _ = {formals=[], tyresult=Types.NIL}

							(*Get formals and return type*)
							val {formals, tyresult} = checkType(ty)

							fun checkArgsType(arg::args, formal::formals) = (
									let
										val {exp,ty} = trexp(arg);
										fun checkPairType () =
											if (ty<>formal) then (error pos "Args and Formals type don't match")
											else (print "      Args and Formals type match\n")
									in
										checkPairType();
										checkArgsType(args,formals)
									end									
								)
								| checkArgsType([],[]) = ()
								| checkArgsType([],_) = (error pos "Args and Formals number don't match")
								| checkArgsType(_,[]) = (error pos "Args and Formals number don't match")

						in
							print("  A.CallExp\n");
							checkArgsType(args,formals);
							{exp=(), ty=tyresult}
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
							print("  A.OpExp A.MinusOp\n");
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
							(*TO-DO*)

							{exp=(), ty=Types.RECORD([],ref())}
						)

				| trexp(A.SeqExp((exp,pos)::rightlist)) = (
							print("  A.SeqExp "^Int.toString(pos)^"\n");
							trexp(exp);
							trexp(A.SeqExp(rightlist))
						)
				
				| trexp(A.AssignExp{var,exp,pos}) = (
							let
								val {exp=() , ty=variableType} = transVar(venv,tenv,var)
								val {exp=() , ty=valueType} = trexp(exp)
							in (
								print("  A.AssignExp "^Int.toString(pos)^"\n");
								if variableType=valueType 	then (
													print("variable type matched\n");
													{exp=(), ty=Types.UNIT}
												)
											else (
													error pos ("unmatched variable or function");
													{exp=(), ty=Types.NIL}
												)
								)
							end
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
							let
								val venv' = S.enter(venv,var, E.VarEntry{ty=Types.INT})
							in
								checkInt(trexp lo, pos);
								checkInt(trexp hi, pos);
								transExp(venv',tenv,body)
							end
							
						)
				
				| trexp(A.BreakExp(pos)) = (
							(*TO-DO*)

							{exp=(), ty=Types.UNIT}
						)

				| trexp(A.LetExp{decs,body,pos}) = (
							let
								val {venv=venv',tenv=tenv'} = transDecs(venv,tenv,decs)
							in
								print("A.LetExp After TransDecs");
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
			print("---LET Part Finish. Following is IN part \n");
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
						val {exp,ty} = transExp(venv,tenv,init)
						(*Check type as type exists*)
						fun checkTypeExisted symbol = (
								case S.look(tenv,symbol) of
									NONE => (error pos' ("undefined type "^S.name symbol))
									| SOME(res) => (
													if actural_ty(res)=ty then (print("Type defined "^S.name symbol^"\n"))
															  else (error pos' ("unmatched type "^S.name symbol)) 
													)
							)
					in
						print("A.VarDec SOME\n");
						checkTypeExisted symbol;
						{venv=S.enter(venv,name,E.VarEntry{ty=ty}),tenv=tenv}
					end

				| trdec (A.TypeDec({name,ty,pos}::typedeclist)) = (
						let
							val venv = venv
							val tenvForTransTy = (print("transDec A.TypeDec tenvForTransTy\n"); S.enter(tenv,name,Types.NAME(name,ref NONE)))
							val typeAfterTransTy = (print("transDec A.TypeDec typeAfterTransTy\n"); transTy(tenvForTransTy,ty))
							val SOME(nameType) = (print("transDec A.TypeDec SOME(nameType)"); S.look(tenvForTransTy,name))

							val () = case nameType of
								Types.NAME(symbol,ty) => (ty := SOME(typeAfterTransTy))
								| _ => (error pos "Should have found the NameType." )

							val {venv=venv',tenv=tenv'} = transDec(venv,tenvForTransTy,A.TypeDec(typedeclist))
						in
							print("A.TypeDec\n");
							 (*replaceNameType nameType typeAfterTransTy;*)
							{venv=venv',tenv=tenv'}
						end
					)
				| trdec (A.TypeDec([])) = {venv=venv,tenv=tenv}

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
						 			print("A.FunctionDec S.enter E.VarEntry "^S.name(name)^" \n");
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
								error ~1 "Wrong transDec";
								{venv=venv,tenv=tenv}
							)

				
		in
			trdec(dec)
		end

	and transTy(tenv,ty) = 
		let
			fun processNameTySymbol symbol =
				case S.name(symbol) of
								"int" => (print("transTy processNameTySymbol int\n"); Types.INT)
								| "string" => Types.STRING
								| _ => (
											case S.look(tenv, symbol) of 
												(*SOME(Types.NAME(symbol,ty)) => (
														print("transTy processNameTySymbol _ Types.NAME\n"); 
														Types.NAME(symbol,ty)
													)
												|*) SOME(ty) => (print("trans processNameTySymbol ty\n"); ty)
												| NONE => (
															error 0 ("the type does not exist"^S.name symbol);
															Types.NIL
														)
										)

			fun processRecordTySymbol({name,escape,typ,pos}::fieldlist, resultlist) =
					let
						val typResult = processNameTySymbol(typ)
						val resultlist' = processRecordTySymbol(fieldlist, (name,typResult)::resultlist)
					in
						print("processRecordTySymbol");
						resultlist'
					end
				| processRecordTySymbol([], resultlist) = (print("processRecordTySymbol []"); resultlist)

			fun processTy ty =
				case ty of
					A.NameTy(symbol,pos) 	=> processNameTySymbol symbol
					| A.RecordTy(fieldlist) => 
							let
								val resultlist = processRecordTySymbol(fieldlist,nil)
							in
								print("transTy A.RecordTy");
								Types.RECORD(resultlist,ref())
							end
					| A.ArrayTy(symbol,pos) => Types.ARRAY(processNameTySymbol(symbol),ref())
		in
			processTy(ty)
		end

		
	fun transProg exp =
		let
			val ty = Types.NIL
			(*TO-DO Standard Library p519*)
			val output = Parse.parse "standard_library";
			fun getDeclaration exp = 
				case exp of
					A.LetExp{decs,body,pos} => decs
					| _ => []
			val declaration = getDeclaration output

			val base_venv = S.empty;(*transDecs(tenv, venv, output);*)
			val base_tenv = S.enter(S.enter(S.empty,S.symbol("int"),Types.INT),S.symbol("string"),Types.STRING)
		
			(*val {venv=venv', tenv=tenv'} = transDecs(base_venv, base_tenv, declaration)*)
		in
			print ">>>>>>>>transProg begins\n";
      		(*transExp (venv',tenv',exp);*)
      		transExp(base_venv,base_tenv,exp);
			print ">>>>>>>>transProg ends\n"
		end
end




