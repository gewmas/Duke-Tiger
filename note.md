<INITIAL>{stringLiteral} 	=> (Tokens.STRING(yytext, yypos,yypos+size(yytext)));


<INITIAL>{[\"]}				=> (print("1"^yytext); YYBEGIN STRINGSTATE; continue());
<STRINGSTATE> {[\"]}		=> (print("2"^yytext); YYBEGIN INITIAL; continue());
<STRINGSTATE> {([^\"]|(\\\"))*}				=> (print yytext ; Tokens.STRING(yytext, yypos,yypos+size(yytext)));


<INITIAL>\"					=> (YYBEGIN STRINGSTATE; quoteNum := !quoteNum+1; continue());
<STRINGSTATE>\"				=> (	print("inStringState "^yytext^" ");
									quoteNum := !quoteNum-1;
									case !quoteNum of
										~0 => (YYBEGIN INITIAL; quoteNum := 0; continue())
										| _ => (YYBEGIN STRINGSTATE; continue())
								);
<STRINGSTATE> .				=> (continue());