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
	fun log info = print(info^"\n")

	val loopCounter = ref 0
	fun increaseCount () = loopCounter := !loopCounter +1
	fun decreaseCount () = loopCounter := !loopCounter-1
	fun checkCounterNotZero () = if !loopCounter = 0 
								 then error 0 ("there are at least one more BREAK nested.") 
								 else ()

	val consecutiveDecCounter = ref 0
	fun increaseConsecutiveDecCounter () = consecutiveDecCounter := !consecutiveDecCounter +1
	fun decreaseConsecutiveDecCounter () = consecutiveDecCounter := !consecutiveDecCounter-1
	fun checkConsecutiveDecCounterZero () = (!consecutiveDecCounter = 0)


	fun actual_ty ty = case ty of
		Types.NAME(symbol, ref(SOME(typeName))) => actual_ty typeName
		| Types.NAME(symbol, ref(NONE)) => (error 0 ("not found in Types.NAME."); Types.NIL)
		| _ => (log("actual_ty _\n"); ty)
	
	fun compareType (Types.NIL,Types.NIL) = (log("NIL&NIL"); true)
		| compareType (Types.NIL,_) = (log("NIL&_"); false)
		| compareType (_, Types.NIL) = (log("_&NIL"); true)
		| compareType (type1,type2) = 
			let
				fun detailCompareType(Types.RECORD(typeList1, unique1), Types.RECORD(typeList2, unique2)) = 
						let
							fun checkTwoTypeList([], []) = (log("checkTwoTypeList [],[]: compare finishied TRUE"); true)
								| checkTwoTypeList(_, []) = (log("checkTwoTypeList _,[]: compare finishied FALSE"); false)
								| checkTwoTypeList([], _) = (log("checkTwoTypeList [],_: compare finishied FALSE"); false)
								| checkTwoTypeList((symbol1, firstTy1)::restType1, (symbol2, firstTy2)::restType2) = 
									if String.compare(S.name symbol1, S.name symbol2) = EQUAL
												andalso compareType(actual_ty firstTy1, actual_ty firstTy2)
									then checkTwoTypeList(restType1, restType2)
									else (log("record fields types compared to be different"); false)
						in
							checkTwoTypeList(typeList1, typeList2)
						end
					| detailCompareType(Types.ARRAY(arrayType1, unique1), Types.ARRAY(arrayType2, unique2)) = 
						if compareType(arrayType1, arrayType2)
						then (log("array type checked to be equal"); true)
						else (log("array types are not equal"); false)
					| detailCompareType(_, _) = (type1 = type2)
					(*| detailCompareType(Types.STRING, Types.STRING) = 
						(log("strings are compared to be equal"); true)
						
					| detailCompareType(Types.INT, Types.INT) = 
						 (log("integers are compared to be equal"); true)

					| detailCompareType(_, _) = (log("_,_: two different types"); false)*)
			in
				detailCompareType(type1, type2)
			end

	fun compareFunctionField(field1,field2) = 
		let
			val {name=name1,escape=escape1,typ=typ1,pos=pos1} = field1
			val {name=name2,escape=escape2,typ=typ2,pos=pos2} = field2
		in
			if (String.compare(S.name name1,S.name name2) = EQUAL andalso String.compare(S.name typ1,S.name typ2) = EQUAL)
				then (log("compareFunctionField TRUE"); true)
			else (log("compareFunctionField TRUE"); false)
		end

	(*Method to save Type/Function name to check duplicate entries in one consective group*)
	val mutualTypeList = ref []: S.symbol list ref
	val mutualFunctionList = ref [] : (A.symbol * A.field list * A.symbol) list ref
	fun addToTypeList (name) =  mutualTypeList := name::(!mutualTypeList)
	fun addToFunctionList(name, formals, retType) = mutualFunctionList := (name, formals, retType)::(!mutualFunctionList)
	fun findTypeExist name = 
		let
		 	fun findType [] = (
		 						(*error 0 (S.name name^"has not been found mutually.");*)
		 						false
		 					  )
		 		| findType (firstType::mutualTypeList) = 
		 			if firstType = name
		 			then true
		 			else findType mutualTypeList
		 in
		 	findType (!mutualTypeList)
		 end 
	fun findFunctionExist(name:A.symbol,formals:A.field list,retType:A.symbol) = 
		let
			fun findFunction [] = ((*error 0 ("No function in scope "^S.name name);*) false)
				| findFunction((nameDefined:A.symbol,formalsDefined:A.field list,retTypeDefined:A.symbol)::mutualFunctionListLeft) = 
					let
					 	fun matchFormals([], []) = (log("Succeed find existed function:"^S.name name^" Return type:"^S.name retType); true)
					 		| matchFormals(_, []) = ((*error 0 ("unmatched defined function formals");*) false)
					 		| matchFormals([], _) = ((*error 0 ("unmatched defined function formals");*) false)
					 		| matchFormals(formal::formalsLeft,formalDefinedSingle::formalsDefinedLeft) =
						 		if compareFunctionField(formal,formalDefinedSingle) then matchFormals(formalsLeft,formalsDefinedLeft) 
						 		else findFunction mutualFunctionListLeft
					 in
					 	if (name <> nameDefined orelse retType <> retTypeDefined) 
					 		then findFunction mutualFunctionListLeft
					 	else matchFormals(formals,formalsDefined)
						
					 end 
		in
			findFunction (!mutualFunctionList)
		end



	
			 

	

	fun checkInt ({exp,ty},pos) = 
		(
			case ty of Types.INT 	=> (log("      checkInt Types.INT\n"))
						| _ => error pos "interger required"
		)

	fun transVar(venv,tenv,var) = 
		let
			fun trvar(A.SimpleVar(id,pos)) =
				(
					case S.look(venv,id) of
						SOME(E.VarEntry{ty}) => (
								log("   A.SimpleVar E.VarEntry looking for "^S.name(id)^" \n");
								{exp=(), ty=actual_ty ty}
							)
						| SOME(E.FunEntry{formals,result}) => (
								log("   A.SimpleVar E.FunEntry looking for "^S.name(id)^" \n");
								{exp=(), ty=Types.FUNCTION(formals,result)}
							)
						| NONE => (
								error pos ("undefined variable or function "^S.name id);
								{exp=(), ty=Types.NIL}
							)
				)

				(*BIG TO-DO*)
				(*I think this might be the problem of reference replace, 
					it replaces the typelist to be empty as well*)
				| trvar(A.FieldVar(var,symbol,pos)) = 
					let
						val {exp, ty} = trvar(var)
						val typeList = case ty of
										Types.RECORD(typeList, unique) => (log("A.FieldVar Types.RECORD");typeList)
										| _ => (
												error pos ("this variable should be a record type.");
												[]
												)
						fun findSymbolType((firstSymbol, firstTy)::typeList, symbol) = 
								(
									log("firstSymbol: "^S.name firstSymbol^" symbol to find: "^S.name symbol^"\n");
									if String.compare(S.name firstSymbol, S.name symbol) = EQUAL
										then (log("found corresponding symbol type!\n"); firstTy)
										else findSymbolType(typeList, symbol)
								)
							| findSymbolType([], symbol) = (
															error pos ("symbol is not in the field.");
															Types.NIL
															)
						val typeName = findSymbolType(typeList, symbol)
					in
						{exp=(), ty=typeName}
					end
				| trvar(A.SubscriptVar(var,exp,pos)) = 
					let
						val {exp, ty} = transExp(venv, tenv, exp)
						val {exp, ty=varTy} = trvar(var)
						val arrayType = case varTy of
											Types.ARRAY(arrayType, unique) => actual_ty arrayType
											| _ => (
													error pos ("this variable should be a array type.");
													Types.NIL
													)
						
					in
						if arrayType = ty 
						then (log("Match type in A.SubscriptVar"); {exp=(), ty=ty})
						else (log("Not Match type in A.SubscriptVar"); {exp=(), ty=Types.NIL})
					end

				
		in
			trvar(var)
		end

	and transExp(venv,tenv,exp) = 
		let 
			fun trexp(A.VarExp(var)) = (
						log("  A.VarExp\n");
						transVar(venv,tenv,var)
					)

				| trexp(A.NilExp) = (log("A.NilExp"); {exp=(), ty=Types.NIL})
				| trexp(A.IntExp(int)) = (
						log("   A.IntExp:"^Int.toString(int)^"\n");
						{exp=(), ty=Types.INT}
					)
				| trexp(A.StringExp(string,pos)) = (
							log("   A.StringExp: "^string^"\n");
							{exp=(), ty=Types.STRING}
						)

				| trexp(A.CallExp{func,args,pos}) = (
						let
							val {exp,ty} = transVar(venv,tenv,A.SimpleVar(func,pos))

							fun checkType(Types.FUNCTION(formals, result)) = (
										log("     A.CallExp Types.FUNCTION\n");
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
											else (log "      Args and Formals type match\n")
									in
										checkPairType();
										checkArgsType(args,formals)
									end									
								)
								| checkArgsType([],[]) = ()
								| checkArgsType([],_) = (error pos "Args and Formals number don't match")
								| checkArgsType(_,[]) = (error pos "Args and Formals number don't match")

						in
							log("  A.CallExp\n");
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
							log("  A.OpExp A.MinusOp\n");
							checkInt(trexp left, pos);
							checkInt(trexp right, pos);
							{exp=(), ty=Types.INT}
						)
				| trexp(A.OpExp{left,oper=A.TimesOp,right,pos}) =
						(
							log("  A.OpExp A.TimesOp\n");
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
					let
						val {exp, ty=typeLeft} = trexp(left)
						val {exp, ty=typeRight} = trexp(right)
						(*val () = if compareType(typeLeft, typeRight) 
								 then *)
					in
						(

							{exp=(), ty=Types.INT}
						)
					end
						
				| trexp(A.OpExp{left,oper=A.NeqOp,right,pos}) =
						(
							(*checkInt(trexp left, pos);
							checkInt(trexp right, pos);*)
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
							let
								fun getRecordTypeList () =
									 case S.look(tenv, typ) of
										SOME(ty) => actual_ty ty
										| NONE => (error pos ("the typeName does not exist."); Types.NIL)
								val typeList = case getRecordTypeList () of
									Types.RECORD(typeList, unique) => typeList
									| _ => []
								fun checkType ([], _) = ()
									(*| checkType ([], _)  = error pos ("left empty fields unmatched.")*)
									| checkType (_, [])  = error pos ("fields unmatched.")
									| checkType((symbol1, firstTy)::restType, fields) =
										let
											(*val index = ref 1*)
											fun findSameSymbol(symbol1, (symbol2, exp, pos)::fields) = 
													if String.compare(S.name(symbol1), S.name(symbol2))=EQUAL 
														then (
																(*fields := list.drop(fields, !count); *)
																(symbol2, exp, pos)
															 ) 
														else (
																(*count := !count + 1; *)
																findSameSymbol(symbol1, fields)
															)
												| findSameSymbol(symbol1, []) = (error pos ("not found."); (S.symbol(""),A.NilExp,0))
											val (symbol2, expWithSameSymbol, pos) = findSameSymbol(symbol1, fields)
											val {exp, ty} = trexp(expWithSameSymbol)
										in
											log("Type Symbol: "^S.name(symbol1)^" Param Symbol: "^S.name(symbol2)^"\n");
											if  String.compare(S.name(symbol1), S.name(symbol2))=EQUAL 
												then if compareType(actual_ty firstTy,ty) 
														then checkType(restType, fields)
														else error pos ("field types unmatched.") 
												else error pos ("field symbols unmatched.")

										end


								fun checkField ([], _) = ()
									(*| checkType ([], _)  = error pos ("left empty fields unmatched.")*)
									| checkField (_, [])  = error pos ("fields unmatched.")
									| checkField((symbol1, exp, pos)::restField, typeList) =
										let
											(*val index = ref 1*)
											fun findSameSymbol(symbol1, (symbol2, firstTy)::restTypeList) = 
													if String.compare(S.name(symbol1), S.name(symbol2))=EQUAL 
														then (
																(*fields := list.drop(fields, !count); *)
																(symbol2, firstTy)
															 ) 
														else (
																(*count := !count + 1; *)
																findSameSymbol(symbol1, restTypeList)
															)
												| findSameSymbol(symbol1, []) = (error pos ("not found."); (S.symbol(""), Types.NIL))
											val (symbol2, firstTy) = findSameSymbol(symbol1, typeList)
											val {exp, ty} = trexp(exp)
										in
											log("Type Symbol: "^S.name(symbol2)^" Param Symbol: "^S.name(symbol1)^"\n");
											if  String.compare(S.name(symbol1), S.name(symbol2))=EQUAL 
												then if compareType(actual_ty firstTy,ty) 
														then checkField(restField, typeList) 
														else error pos ("field types unmatched.") 
												else error pos ("field symbols unmatched.")

										end


							in
								(
									checkType(typeList, fields);
									checkField(fields, typeList); 
									{exp=(), ty=getRecordTypeList()}
								)
							end
							
						)

				| trexp(A.SeqExp([])) = (
						log("A.SeqExp []");
						{exp=(),ty=Types.UNIT}
					)

				| trexp(A.SeqExp((exp,pos)::rightlist)) = (
							log("  A.SeqExp "^Int.toString(pos)^"\n");
							trexp(exp);
							trexp(A.SeqExp(rightlist))
						)

				
				| trexp(A.AssignExp{var,exp,pos}) = (
							let
								val {exp=() , ty=variableType} = transVar(venv,tenv,var)
								val {exp=() , ty=valueType} = trexp(exp)
							in (
								log("  A.AssignExp "^Int.toString(pos)^"\n");
								if (actual_ty variableType)=valueType 	then (
													log("variable type matched\n");
													{exp=(), ty=Types.UNIT}
												)
											else (
													error pos ("unmatched variable or function");
													{exp=(), ty=Types.NIL}
												)
								)
							end
						)

				| trexp(A.IfExp{test,then',else'=SOME(elseExp),pos}) =
					let
						val {exp=(),ty=tyThen} = trexp(then')
						val {exp=(),ty=tyElse} = trexp(elseExp)
						val checkThenElseType = 
							case compareType(tyThen,tyElse) of
								true => ()
								| false => (error pos "Then & Else should return same type")
					in
						log(" A.IfExp If\n");
						trexp(test);
						{exp=(),ty=tyThen}
					end
				| trexp(A.IfExp{test,then',else'=NONE,pos}) =
					let
						val {exp,ty} = trexp(then')
						val checkThenType =
							case ty of
								Types.UNIT => ()
								| _ => (error pos "IfExp with no else should return unit type")
					in
						trexp(test);
						{exp=(), ty=Types.UNIT}
					end
				| trexp(A.WhileExp{test,body,pos}) =
					let
						val () = increaseCount()
						val {exp,ty} = trexp(body)
						val () = decreaseCount()
						val checkBodyType = 
							case ty of
								Types.UNIT => ()
								| _ => (error pos "body of whileExp should return unit type")

					in
						trexp(test);
						{exp=(), ty=Types.UNIT}
					end
				| trexp(A.ForExp{var,escape,lo,hi,body,pos}) = (
							let
								val venv' = S.enter(venv,var, E.VarEntry{ty=Types.INT})
								val () = increaseCount()
								val {exp,ty} =transExp(venv',tenv,body)
								val checkBodyType = 
									case ty of
										Types.UNIT => ()
										| _ => (error pos "body of forExp should return unit type")
								val () = decreaseCount()
							in
								(*in the next phase please check hi is GE lo*)
								checkInt(trexp lo, pos);
								checkInt(trexp hi, pos);
								{exp=exp,ty=Types.UNIT}
							end
							
						)
				
				| trexp(A.BreakExp(pos)) = 
						(
							(*Allow mulptiple Breaks inside one for/while*)
							checkCounterNotZero (); 
							{exp=(), ty=Types.UNIT}
						)

				| trexp(A.LetExp{decs,body,pos}) = (
							let
								

								val {venv=venv',tenv=tenv'} = transDecs(venv,tenv,decs)
							in
								log("A.LetExp After TransDecs");
								transExp(venv',tenv',body)
							end
						)

				| trexp(A.ArrayExp{typ,size,init,pos}) = 
					let
						fun checkTypeExisted symbol = 
								case S.look(tenv,symbol) of
									NONE => (error pos ("undefined type "^S.name symbol); Types.NIL)
									| SOME(res) => (actual_ty res)
							
						val definedArrayType = checkTypeExisted typ
						val arrayTypeForInit = 
							case definedArrayType of
								Types.ARRAY(ty,unique) => (actual_ty ty)
								| _ => (error pos ("Should be Types.ARRAY for array:"^S.name typ); Types.NIL)

						val {exp=_,ty=typeOfInit} = trexp init

						val checkInitType =
							case arrayTypeForInit = typeOfInit of
								true => (log("Init type match the type in arraytype.\n"))
								| false => (error pos ("Init type doesn't match the type in arraytype."))
					in
						(
							log("---Calling A.ArrayExp\n");
							checkInt(trexp size, pos);
							{exp=(), ty=definedArrayType}
						)
					end
					
		in
			trexp(exp)
		end

	and transDecs(venv,tenv, []) = (
			log("---LET Part Finish. Following is IN part \n");
			{venv=venv, tenv=tenv}
			)
		| transDecs(venv,tenv,dec::decs)= (
				let
					fun traverseTypeDecs (venv,tenv,[]) = {venv=venv,tenv=tenv}
						| traverseTypeDecs (venv,tenv,(firstDec::declarations)) = 
							let
								val canContinue = ref false
								val {venv=venv',tenv=tenv'} = 
									case firstDec of
										A.TypeDec({name, ty, pos}::typedeclist) => 
											(
												log("traverseTypeDecs A.TypeDec");
												
												(*Only continue if the same TypeDec*)
												canContinue := true;

												(*Check duplicated name in the same consecutive*)
												if findTypeExist(name) 
													then (error pos ("Duplicated type define in the same consecutive group:"^S.name name))
												else
													addToTypeList(name);

												{venv=venv,tenv=S.enter(tenv,name,Types.NAME(name,ref NONE))}
											)
										| _ => {venv=venv,tenv=tenv}
							in
								log("traverseTypeDecs");
								if !canContinue 
									then 
										(
											increaseConsecutiveDecCounter();
											traverseTypeDecs(venv',tenv',declarations)
										)
								else {venv=venv',tenv=tenv'}
							end
											
					fun transparam{name,escape,typ,pos} = 
				 		case S.look(tenv,typ) of
				 			SOME t => (
				 					log("A.FunctionDec transparam SOME param: "^S.name(name)^" \n"); 
				 					t
				 				)
				 			| NONE => (
				 					log("A.FunctionDec transparam NONE param: "^S.name(name)^" \n"); 
				 					Types.NIL
				 				)
							 			
					fun traverseFunctionDecs (venv,tenv,[]) = {venv=venv,tenv=tenv}
						| traverseFunctionDecs (venv,tenv,(firstDec::declarations)) = 
							let
								val canContinue = ref false
								val {venv=venv', tenv=tenv'} = 
									case firstDec of
										A.FunctionDec[{name, params, result=SOME(rt,pos'), body, pos}] =>
												let
													val formalTypeList = map transparam params
													val typeForResult =
														case S.look(tenv,rt) of
															SOME(ty) => ty
															| NONE => (error pos' "Type will not be defined in the scope."; Types.NIL)
												in
													log("A.FunctionDec in Let:  "^S.name name);
													canContinue := true;
													(*Check duplicated name in the same consecutive*)
													if findFunctionExist(name,params,rt)
														then (error pos ("Duplicated function define in the same consecutive group with same name, params type & return type:"^S.name name))
													else (log("Function Not Duplicated"); addToFunctionList(name,params,rt));

													{venv=S.enter(venv,name,E.FunEntry{formals=formalTypeList, result=typeForResult}), tenv=tenv}
												end														
										| A.FunctionDec[{name, params, result=NONE, body, pos}]
											=> 
											let
												val formalTypeList = map transparam params
											in
												log("A.FunctionDec in Let  "^S.name name);
												canContinue := true;
												(*Check duplicated name in the same consecutive*)
												if findFunctionExist(name,params,S.symbol(""))
													then error pos "Duplicated function define in the same consecutive group with same name, params type & return type"
												else (log("Function Not Duplicated"); addToFunctionList(name,params,S.symbol("")));

												{venv=S.enter(venv,name,E.FunEntry{formals=formalTypeList, result=Types.UNIT}),tenv=tenv}
											end
											
										| _ => {venv=venv, tenv=tenv}
							in
								log("traverseFunctionDecs");
								if !canContinue
									then 
										(
											increaseConsecutiveDecCounter();
											traverseFunctionDecs(venv',tenv',declarations)
										)
								else {venv=venv', tenv=tenv'}

							end

					(*val {venv=venvWithType,tenv=tenvWithType} = traverseTypeDecs(venv,tenv,decs)*)
					(*val {venv=venvWithFunction,tenv=tenvWithFunction} = traverseFunctionDecs(venvWithType,tenvWithType,decs)*)
					fun checkConsecutiveDec () = 
						case dec of
							A.VarDec{name,escape,typ,init,pos} => 
								(
									increaseConsecutiveDecCounter();
									{venv=venv,tenv=tenv}
								)
							| A.TypeDec l =>
								(
									mutualTypeList := []; (*Clear before a new consecutive*)
									traverseTypeDecs(venv,tenv,dec::decs)
								)
							| A.FunctionDec f => 
								(
									mutualFunctionList := []; (*Clear before a new consecutive*)
									traverseFunctionDecs(venv,tenv,dec::decs)
								)

					(*val () = log("1consecutiveDecCounter:"^Int.toString(!consecutiveDecCounter))*)
					val {venv=venvAfterCheck,tenv=tenvAfterCheck} =
						if checkConsecutiveDecCounterZero() 
							then checkConsecutiveDec()
						else {venv=venv,tenv=tenv}

					(*val () = log("2consecutiveDecCounter:"^Int.toString(!consecutiveDecCounter))*)
					val {venv=venv',tenv=tenv'} = transDec(venvAfterCheck,tenvAfterCheck,dec)
					val () = decreaseConsecutiveDecCounter()
					(*val () = log("3consecutiveDecCounter:"^Int.toString(!consecutiveDecCounter))*)
				in
					log("\n---Called one transDec, calling next one in decs.\n\n");
					transDecs(venv',tenv',decs)
				end
				
			)
		

	and transDec(venv,tenv,dec) =
		let
			fun trdec(A.VarDec{name,escape,typ=NONE,init,pos}) = 
					let
						val {exp,ty} = transExp(venv,tenv,init)
						val () = case ty of
									Types.NIL => error pos ("variable declaration without type to nil is illegal")
									| _ =>  ()
					in
						log("A.VarDec NONE\n");
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
													if compareType(actual_ty(res),ty) then (log("Type defined "^S.name symbol^"\n"))
															  else (error pos' ("unmatched type "^S.name symbol)) 
													)
							)
					in
						log("A.VarDec SOME\n");
						checkTypeExisted symbol;
						{venv=S.enter(venv,name,E.VarEntry{ty=ty}),tenv=tenv}
					end

				| trdec (A.TypeDec({name,ty,pos}::typedeclist)) = (
						let
							val venv = venv
							val tenvForTransTy = (log("transDec A.TypeDec tenvForTransTy\n"); S.enter(tenv,name,Types.NAME(name,ref NONE)))
							val typeAfterTransTy = (log("transDec A.TypeDec typeAfterTransTy\n"); transTy(tenvForTransTy,ty))
							val SOME(nameType) = (log("transDec A.TypeDec SOME(nameType)\n"); S.look(tenvForTransTy,name))

							val () = case nameType of
								Types.NAME(symbol,ty) => (ty := SOME(typeAfterTransTy))
								| _ => (error pos "Should have found the NameType." )

							(*val {venv=venv',tenv=tenv'} = transDec(venv,tenvForTransTy,A.TypeDec(typedeclist))*)
						in
							log("A.TypeDec\n");
							 (*replaceNameType nameType typeAfterTransTy;*)
							transDec(venv,tenvForTransTy,A.TypeDec(typedeclist))
						end
					)
				| trdec (A.TypeDec([])) = (log("A.TypeDec reach end.\n"); {venv=venv,tenv=tenv})

				| trdec (A.FunctionDec[{name,params,result=SOME(rt,pos'),body,pos}]) =
						let								
						 	(*val SOME(result_ty) = S.look(tenv,rt)*)
						 	val result_ty = 
						 		case S.look(tenv,rt) of
							 		SOME(result_ty') => (
							 				log("A.FunctionDec result_ty SOME: "^S.name(rt)^" \n"); 
							 				result_ty'
							 			)
							 		| NONE => (
								 			log("A.FunctionDec result_ty NONE: "^S.name(rt)^" \n"); 
							 				Types.NIL
							 			)

						 	fun transparam{name,escape,typ,pos} = 
						 		case S.look(tenv,typ) of
						 			SOME t => (
						 					log("A.FunctionDec transparam SOME param: "^S.name(name)^" \n"); 
						 					{name=name,ty=t}
						 				)
						 			| NONE => (
						 					log("A.FunctionDec transparam NONE param: "^S.name(name)^" \n"); 
						 					{name=name, ty=Types.NIL}
						 				)

						 	val params' = map transparam params

						 	val venv' = S.enter(venv,name,E.FunEntry{formals=map #ty params', result=result_ty})

						 	fun enterparam ({name,ty},venv) = (
						 			log("A.FunctionDec S.enter E.VarEntry "^S.name(name)^" \n");
						 			S.enter(venv,name,E.VarEntry{ty=ty})
						 		)
						 	
						 	val venv'' = foldr enterparam venv' params'
						 	(*Deal with exp inside the function body, thus pass venv''*)
						 	val {exp=exp, ty=bodyType} = transExp(venv'',tenv,body);
						 	(*Return venv' without the parameters*)
						 	val () = if result_ty = bodyType
						 			 then (print "body type is the same as return type")
						 			 else error pos ("body type is diffent from return type")
						 in
						 	log("A.FunctionDec SOME "^S.name name^"\n");
						 	
						 	{venv=venv',tenv=tenv}
						 end 

				| trdec (A.FunctionDec[{name,params,result=NONE,body,pos}]) =
						let								
						 	fun transparam{name,escape,typ,pos} = 
						 		case S.look(tenv,typ) of
						 			SOME t => (
						 					log("A.FunctionDec transparam SOME param: "^S.name(name)^" \n"); 
						 					{name=name,ty=t}
						 				)
						 			| NONE => (
						 					log("A.FunctionDec transparam NONE param: "^S.name(name)^" \n"); 
						 					{name=name, ty=Types.NIL}
						 				)

						 	val params' = map transparam params

						 	val venv' = S.enter(venv,name,E.FunEntry{formals=map #ty params', result=Types.UNIT})

						 	fun enterparam ({name,ty},venv) = (
						 			log("A.FunctionDec S.enter E.VarEntry "^S.name(name)^" \n");
						 			S.enter(venv,name,E.VarEntry{ty=ty})
						 		)
						 	
						 	val venv'' = foldr enterparam venv' params'

						 	val {exp=exp, ty=bodyType} = transExp(venv'',tenv,body);
						 	(*Return venv' without the parameters*)
						 	val () = if compareType(bodyType, Types.UNIT)
						 			 then (print "body type is not UNIT")
						 			 else error pos ("Wrong! should be no return type")
						 in
						 	log("A.FunctionDec NONE "^S.name name^"\n");
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
								"int" => (log("transTy processNameTySymbol int\n"); Types.INT)
								| "string" => (log("transTy processNameTySymbol string\n"); Types.STRING)
								| _ => (
											case S.look(tenv, symbol) of 
												(*SOME(Types.NAME(symbol,ty)) => (
														log("transTy processNameTySymbol _ Types.NAME\n"); 
														Types.NAME(symbol,ty)
													)
												|*) SOME(ty) => (log("trans processNameTySymbol ty\n"); ty)
												| NONE => (
															error 0 ("the type does not exist"^S.name symbol);
															Types.NIL
														)
										)
			
			fun processRecordTySymbol({name,escape,typ,pos}::fieldlist) =
					let
						val typResult = processNameTySymbol(typ)
						val resultlist = processRecordTySymbol(fieldlist)
					in
						(
							log("processRecordTySymbol "^S.name name^"\n");
							(name, typResult) :: resultlist
						)
					end
				| processRecordTySymbol([]) = (
												log("processRecordTySymbol []\n"); 
												[]
											  )

			fun processTy ty =
				case ty of
					A.NameTy(symbol,pos) 	=> processNameTySymbol symbol
					| A.RecordTy(fieldlist) => 
							let
								val resultlist = processRecordTySymbol(fieldlist)
							in
								(
									log("transTy A.RecordTy\n");
									Types.RECORD(resultlist,ref())
								)
							end
					| A.ArrayTy(symbol,pos) => (
							log("transTy processTy A.ArrayTy\n");
							Types.ARRAY(processNameTySymbol(symbol),ref())
						)
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
		
			val {venv=venv', tenv=tenv'} = transDecs(base_venv, base_tenv, declaration)

			val () = consecutiveDecCounter := 0
		in
			log("\n++++++++++++++++++++++++++++++++++++");
			log("++++++++++++++++++++++++++++++++++++");
			log("++++++++++++++++++++++++++++++++++++");
			log ">>>>>>>>transProg begins\n";
			log("++++++++++++++++++++++++++++++++++++");
			log("++++++++++++++++++++++++++++++++++++");
			log("++++++++++++++++++++++++++++++++++++\n");

      		transExp (venv',tenv',exp);
      		(*transExp(base_venv,base_tenv,exp);*)
			log ">>>>>>>>transProg ends\n"
		end
end




