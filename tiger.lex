
type svalue = Tokens.svalue
type pos = int
type ('a,'b) token = ('a,'b) Tokens.token
type lexresult = (svalue,pos) token

val lineNum = ErrorMsg.lineNum
val linePos = ErrorMsg.linePos
fun err(p1,p2) = ErrorMsg.error p1

fun eof() = let val pos = hd(!linePos) in Tokens.EOF(pos,pos) end

val commentNum = ref 0
val stringVal = ref ""

%% 
%header (functor TigerLexFun(structure Tokens: Tiger_TOKENS));

%s COMMENT STRING_STATE BACKSlASH_STATE

alpha = [A-Za-z];
digit = [0-9];
digit3 = [0-9]{3};
id = [A-Za-z][A-Za-z0-9_]*;
escape = [ \t];
string_escape = [A-Za-z\"\\]|{digit3};
string_escape_ff = [ \t\n]*\\;

%%

<INITIAL>"while" 			=> (Tokens.WHILE(yypos,yypos+5));
<INITIAL>"for" 				=> (Tokens.FOR(yypos, yypos+3));
<INITIAL>"to" 				=> (Tokens.TO(yypos, yypos+2));
<INITIAL>"break"			=> (Tokens.BREAK(yypos, yypos+5));
<INITIAL>"let" 				=> (Tokens.LET(yypos, yypos+3));
<INITIAL>"in" 				=> (Tokens.IN(yypos, yypos+2));
<INITIAL>"end" 				=> (Tokens.END(yypos, yypos+3));
<INITIAL>"function" 		=> (Tokens.FUNCTION(yypos, yypos+8));
<INITIAL>"var"  			=> (Tokens.VAR(yypos,yypos+3));
<INITIAL>"type" 			=> (Tokens.TYPE(yypos, yypos+4));
<INITIAL>"array" 			=> (Tokens.ARRAY(yypos, yypos+5));
<INITIAL>"if" 				=> (Tokens.IF(yypos,yypos+2));
<INITIAL>"then" 			=> (Tokens.THEN(yypos,yypos+4));
<INITIAL>"else" 			=> (Tokens.ELSE(yypos,yypos+4));
<INITIAL>"do" 				=> (Tokens.DO(yypos, yypos+2));
<INITIAL>"of" 				=> (Tokens.OF(yypos, yypos+2));
<INITIAL>"nil" 				=> (Tokens.NIL(yypos, yypos+3));

<INITIAL>","				=> (Tokens.COMMA(yypos,yypos+1));
<INITIAL>":" 				=> (Tokens.COLON(yypos, yypos+1));
<INITIAL>";"				=> (Tokens.SEMI(yypos,yypos+1));
<INITIAL>"("				=> (Tokens.LPAREN(yypos,yypos+1));
<INITIAL>")"				=> (Tokens.RPAREN(yypos,yypos+1));
<INITIAL>"["				=> (Tokens.LBRACK(yypos,yypos+1));
<INITIAL>"]"				=> (Tokens.RBRACK(yypos,yypos+1));
<INITIAL>"{"				=> (Tokens.LBRACE(yypos,yypos+1));
<INITIAL>"}"				=> (Tokens.RBRACE(yypos,yypos+1));
<INITIAL>"."				=> (Tokens.DOT(yypos,yypos+1));
<INITIAL>"+"				=> (Tokens.PLUS(yypos,yypos+1));
<INITIAL>"-"				=> (Tokens.MINUS(yypos,yypos+1));
<INITIAL>"*"				=> (Tokens.TIMES(yypos,yypos+1));
<INITIAL>"/"				=> (Tokens.DIVIDE(yypos,yypos+1));
<INITIAL>"="				=> (Tokens.EQ(yypos,yypos+1));
<INITIAL>"<>" 				=> (Tokens.NEQ(yypos,yypos+2));
<INITIAL>"<" 				=> (Tokens.LT(yypos, yypos+1));
<INITIAL>"<=" 				=> (Tokens.LE(yypos, yypos+2));
<INITIAL>">" 				=> (Tokens.GT(yypos, yypos+1));
<INITIAL>">=" 				=> (Tokens.GE(yypos, yypos+2));
<INITIAL>"&" 				=> (Tokens.AND(yypos, yypos+1));
<INITIAL>"|" 				=> (Tokens.OR(yypos, yypos+1));
<INITIAL>":=" 				=> (Tokens.ASSIGN(yypos, yypos+2));

<INITIAL>{id}				=> (Tokens.ID(yytext, yypos, yypos+size(yytext)));
<INITIAL>{digit}+ 			=> (Tokens.INT(Option.valOf(Int.fromString(yytext)), yypos, yypos+size(yytext)));
<INITIAL>{escape} 			=> (continue());

<INITIAL>"/*" 				=> (YYBEGIN COMMENT; commentNum := !commentNum+1; continue());
<COMMENT>"/*" 				=> (YYBEGIN COMMENT; commentNum := !commentNum+1; continue());
<COMMENT>"*/" 				=> (	commentNum := !commentNum-1;
									case !commentNum of
										0 => (YYBEGIN INITIAL; continue())
										| _ => (YYBEGIN COMMENT; continue())
								);
<COMMENT>. 					=> (continue());

<INITIAL>\"					=> (stringVal := ""; YYBEGIN STRING_STATE; continue());
<STRING_STATE>\\			=> (YYBEGIN BACKSlASH_STATE; continue());
<STRING_STATE>\"			=> (YYBEGIN INITIAL; 
								Tokens.STRING(!stringVal, yypos,  yypos+String.size(!stringVal))
								);
<STRING_STATE> [^\\^\"]		=> (stringVal := !stringVal^yytext; continue());
<BACKSlASH_STATE>{string_escape}			
							=> (	
									if yytext = "b" then stringVal := !stringVal^"\b"
									else if yytext = "n" then stringVal := !stringVal^"\n"
									else if yytext = "t" then stringVal := !stringVal^"\t"
									else if String.size(yytext) = 3 
										then if (Option.valOf(Int.fromString(yytext))<256 andalso Option.valOf(Int.fromString(yytext))>=0) 
											then (stringVal := !stringVal^Char.toString(Option.valOf(Char.fromString("\\"^yytext))))
											else (ErrorMsg.error yypos ("\\" ^ yytext ^ " is not a valid ASCII. "))
									else if yytext = "\"" then stringVal := !stringVal^"\""
									else if yytext = "\\" then stringVal := !stringVal^"\\"
									else (ErrorMsg.error yypos ("\\" ^ yytext ^ " is illegal. "));									
									YYBEGIN STRING_STATE; continue()
								);

<BACKSlASH_STATE>{string_escape_ff}		
							=> (YYBEGIN STRING_STATE; continue());

<INITIAL>\n					=> (lineNum := !lineNum+1; linePos := yypos :: !linePos; continue());
<INITIAL>.       			=> (ErrorMsg.error yypos ("illegal character " ^ yytext); continue());
