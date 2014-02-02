functor TigerLrValsFun(structure Token : TOKEN)
 : sig structure ParserData : PARSER_DATA
       structure Tokens : Tiger_TOKENS
   end
 = 
struct
structure ParserData=
struct
structure Header = 
struct
structure A = Absyn


end
structure LrTable = Token.LrTable
structure Token = Token
local open LrTable in 
val table=let val actionRows =
"\
\\001\000\001\000\000\000\000\000\
\\001\000\001\000\134\000\002\000\025\000\003\000\024\000\004\000\023\000\
\\008\000\022\000\015\000\181\000\016\000\021\000\017\000\181\000\
\\018\000\181\000\019\000\181\000\020\000\181\000\021\000\181\000\
\\022\000\181\000\023\000\181\000\024\000\181\000\026\000\181\000\
\\027\000\181\000\030\000\020\000\033\000\019\000\034\000\018\000\
\\037\000\017\000\038\000\134\000\041\000\016\000\042\000\015\000\
\\043\000\014\000\044\000\013\000\045\000\012\000\000\000\
\\001\000\001\000\136\000\002\000\025\000\003\000\024\000\004\000\023\000\
\\008\000\022\000\015\000\181\000\016\000\021\000\017\000\181\000\
\\018\000\181\000\019\000\181\000\020\000\181\000\021\000\181\000\
\\022\000\181\000\023\000\181\000\024\000\181\000\026\000\181\000\
\\027\000\181\000\030\000\020\000\033\000\019\000\034\000\018\000\
\\037\000\017\000\041\000\016\000\042\000\015\000\043\000\014\000\
\\044\000\013\000\045\000\012\000\000\000\
\\001\000\001\000\153\000\002\000\153\000\003\000\153\000\004\000\153\000\
\\008\000\153\000\015\000\044\000\016\000\043\000\017\000\042\000\
\\018\000\041\000\026\000\034\000\027\000\033\000\030\000\153\000\
\\033\000\153\000\034\000\153\000\037\000\153\000\038\000\153\000\
\\041\000\153\000\042\000\153\000\043\000\153\000\044\000\153\000\
\\045\000\153\000\000\000\
\\001\000\001\000\154\000\002\000\154\000\003\000\154\000\004\000\154\000\
\\008\000\154\000\015\000\044\000\016\000\043\000\017\000\042\000\
\\018\000\041\000\026\000\034\000\027\000\033\000\030\000\154\000\
\\033\000\154\000\034\000\154\000\037\000\154\000\038\000\154\000\
\\041\000\154\000\042\000\154\000\043\000\154\000\044\000\154\000\
\\045\000\154\000\000\000\
\\001\000\001\000\174\000\002\000\174\000\003\000\174\000\004\000\174\000\
\\005\000\174\000\007\000\174\000\008\000\061\000\009\000\174\000\
\\010\000\150\000\011\000\174\000\012\000\150\000\013\000\174\000\
\\014\000\174\000\015\000\174\000\016\000\174\000\017\000\174\000\
\\018\000\174\000\019\000\174\000\020\000\174\000\021\000\174\000\
\\022\000\174\000\023\000\174\000\024\000\174\000\026\000\174\000\
\\027\000\174\000\028\000\174\000\030\000\174\000\031\000\174\000\
\\032\000\174\000\033\000\174\000\034\000\174\000\035\000\174\000\
\\036\000\174\000\037\000\174\000\038\000\174\000\039\000\174\000\
\\041\000\174\000\042\000\174\000\043\000\174\000\044\000\174\000\
\\045\000\174\000\000\000\
\\001\000\001\000\182\000\002\000\182\000\003\000\182\000\004\000\182\000\
\\005\000\182\000\007\000\182\000\008\000\182\000\009\000\182\000\
\\010\000\148\000\011\000\182\000\012\000\148\000\013\000\182\000\
\\015\000\182\000\016\000\182\000\017\000\182\000\018\000\182\000\
\\019\000\182\000\020\000\182\000\021\000\182\000\022\000\182\000\
\\023\000\182\000\024\000\182\000\026\000\182\000\027\000\182\000\
\\030\000\182\000\031\000\182\000\032\000\182\000\033\000\182\000\
\\034\000\182\000\035\000\182\000\036\000\182\000\037\000\182\000\
\\038\000\182\000\039\000\182\000\041\000\182\000\042\000\182\000\
\\043\000\182\000\044\000\182\000\045\000\182\000\000\000\
\\001\000\001\000\183\000\002\000\183\000\003\000\183\000\004\000\183\000\
\\005\000\183\000\007\000\183\000\008\000\183\000\009\000\183\000\
\\010\000\149\000\011\000\183\000\012\000\149\000\013\000\183\000\
\\015\000\183\000\016\000\183\000\017\000\183\000\018\000\183\000\
\\019\000\040\000\020\000\039\000\021\000\038\000\022\000\037\000\
\\023\000\036\000\024\000\035\000\026\000\183\000\027\000\183\000\
\\030\000\183\000\031\000\183\000\032\000\183\000\033\000\183\000\
\\034\000\183\000\035\000\183\000\036\000\183\000\037\000\183\000\
\\038\000\183\000\039\000\183\000\041\000\183\000\042\000\183\000\
\\043\000\183\000\044\000\183\000\045\000\183\000\000\000\
\\001\000\002\000\025\000\003\000\024\000\004\000\023\000\005\000\181\000\
\\007\000\181\000\008\000\022\000\009\000\158\000\015\000\181\000\
\\016\000\021\000\017\000\181\000\018\000\181\000\019\000\181\000\
\\020\000\181\000\021\000\181\000\022\000\181\000\023\000\181\000\
\\024\000\181\000\026\000\181\000\027\000\181\000\030\000\020\000\
\\033\000\019\000\034\000\018\000\037\000\017\000\039\000\158\000\
\\041\000\016\000\042\000\015\000\000\000\
\\001\000\002\000\025\000\003\000\024\000\004\000\023\000\005\000\181\000\
\\007\000\181\000\008\000\022\000\009\000\158\000\015\000\181\000\
\\016\000\021\000\017\000\181\000\018\000\181\000\019\000\181\000\
\\020\000\181\000\021\000\181\000\022\000\181\000\023\000\181\000\
\\024\000\181\000\026\000\181\000\027\000\181\000\030\000\020\000\
\\033\000\019\000\034\000\018\000\037\000\017\000\041\000\016\000\
\\042\000\015\000\000\000\
\\001\000\002\000\025\000\003\000\024\000\004\000\023\000\005\000\181\000\
\\007\000\181\000\008\000\022\000\009\000\082\000\015\000\181\000\
\\016\000\021\000\017\000\181\000\018\000\181\000\019\000\181\000\
\\020\000\181\000\021\000\181\000\022\000\181\000\023\000\181\000\
\\024\000\181\000\026\000\181\000\027\000\181\000\030\000\020\000\
\\033\000\019\000\034\000\018\000\037\000\017\000\041\000\016\000\
\\042\000\015\000\000\000\
\\001\000\002\000\025\000\003\000\024\000\004\000\023\000\005\000\181\000\
\\007\000\181\000\008\000\022\000\015\000\181\000\016\000\021\000\
\\017\000\181\000\018\000\181\000\019\000\181\000\020\000\181\000\
\\021\000\181\000\022\000\181\000\023\000\181\000\024\000\181\000\
\\026\000\181\000\027\000\181\000\030\000\020\000\033\000\019\000\
\\034\000\018\000\037\000\017\000\039\000\158\000\041\000\016\000\
\\042\000\015\000\000\000\
\\001\000\002\000\025\000\003\000\024\000\004\000\023\000\008\000\022\000\
\\015\000\181\000\016\000\021\000\017\000\181\000\018\000\181\000\
\\019\000\181\000\020\000\181\000\021\000\181\000\022\000\181\000\
\\023\000\181\000\024\000\181\000\026\000\181\000\027\000\181\000\
\\030\000\020\000\033\000\019\000\034\000\018\000\037\000\017\000\
\\038\000\136\000\041\000\016\000\042\000\015\000\043\000\014\000\
\\044\000\013\000\045\000\012\000\000\000\
\\001\000\002\000\051\000\003\000\050\000\004\000\049\000\000\000\
\\001\000\002\000\051\000\003\000\050\000\004\000\049\000\012\000\091\000\
\\029\000\090\000\000\000\
\\001\000\002\000\052\000\000\000\
\\001\000\002\000\053\000\000\000\
\\001\000\002\000\063\000\000\000\
\\001\000\004\000\079\000\000\000\
\\001\000\005\000\085\000\013\000\084\000\000\000\
\\001\000\005\000\111\000\009\000\110\000\000\000\
\\001\000\005\000\111\000\013\000\121\000\000\000\
\\001\000\006\000\071\000\028\000\070\000\000\000\
\\001\000\006\000\112\000\000\000\
\\001\000\006\000\124\000\019\000\123\000\000\000\
\\001\000\007\000\078\000\009\000\077\000\015\000\044\000\016\000\043\000\
\\017\000\042\000\018\000\041\000\019\000\040\000\020\000\039\000\
\\021\000\038\000\022\000\037\000\023\000\036\000\024\000\035\000\
\\026\000\034\000\027\000\033\000\000\000\
\\001\000\008\000\072\000\000\000\
\\001\000\009\000\103\000\000\000\
\\001\000\009\000\116\000\000\000\
\\001\000\010\000\046\000\012\000\045\000\000\000\
\\001\000\011\000\083\000\015\000\044\000\016\000\043\000\017\000\042\000\
\\018\000\041\000\019\000\040\000\020\000\039\000\021\000\038\000\
\\022\000\037\000\023\000\036\000\024\000\035\000\026\000\034\000\
\\027\000\033\000\000\000\
\\001\000\011\000\087\000\015\000\044\000\016\000\043\000\017\000\042\000\
\\018\000\041\000\019\000\040\000\020\000\039\000\021\000\038\000\
\\022\000\037\000\023\000\036\000\024\000\035\000\026\000\034\000\
\\027\000\033\000\000\000\
\\001\000\015\000\044\000\016\000\043\000\017\000\042\000\018\000\041\000\
\\019\000\040\000\020\000\039\000\021\000\038\000\022\000\037\000\
\\023\000\036\000\024\000\035\000\026\000\034\000\027\000\033\000\
\\031\000\076\000\000\000\
\\001\000\015\000\044\000\016\000\043\000\017\000\042\000\018\000\041\000\
\\019\000\040\000\020\000\039\000\021\000\038\000\022\000\037\000\
\\023\000\036\000\024\000\035\000\026\000\034\000\027\000\033\000\
\\035\000\074\000\000\000\
\\001\000\015\000\044\000\016\000\043\000\017\000\042\000\018\000\041\000\
\\019\000\040\000\020\000\039\000\021\000\038\000\022\000\037\000\
\\023\000\036\000\024\000\035\000\026\000\034\000\027\000\033\000\
\\036\000\075\000\000\000\
\\001\000\015\000\044\000\016\000\043\000\017\000\042\000\018\000\041\000\
\\019\000\040\000\020\000\039\000\021\000\038\000\022\000\037\000\
\\023\000\036\000\024\000\035\000\026\000\034\000\027\000\033\000\
\\036\000\114\000\000\000\
\\001\000\019\000\069\000\000\000\
\\001\000\019\000\086\000\000\000\
\\001\000\019\000\131\000\000\000\
\\001\000\028\000\109\000\000\000\
\\001\000\038\000\073\000\000\000\
\\001\000\039\000\113\000\000\000\
\\001\000\040\000\106\000\000\000\
\\001\000\040\000\107\000\000\000\
\\135\000\000\000\
\\137\000\000\000\
\\138\000\000\000\
\\139\000\000\000\
\\140\000\015\000\044\000\016\000\043\000\017\000\042\000\018\000\041\000\
\\019\000\040\000\020\000\039\000\021\000\038\000\022\000\037\000\
\\023\000\036\000\024\000\035\000\026\000\034\000\027\000\033\000\000\000\
\\141\000\000\000\
\\142\000\000\000\
\\143\000\000\000\
\\144\000\000\000\
\\145\000\002\000\095\000\000\000\
\\146\000\000\000\
\\147\000\005\000\111\000\000\000\
\\148\000\000\000\
\\149\000\000\000\
\\150\000\000\000\
\\151\000\015\000\044\000\016\000\043\000\017\000\042\000\018\000\041\000\
\\019\000\040\000\020\000\039\000\021\000\038\000\022\000\037\000\
\\023\000\036\000\024\000\035\000\026\000\034\000\027\000\033\000\000\000\
\\152\000\015\000\044\000\016\000\043\000\017\000\042\000\018\000\041\000\
\\019\000\040\000\020\000\039\000\021\000\038\000\022\000\037\000\
\\023\000\036\000\024\000\035\000\026\000\034\000\027\000\033\000\000\000\
\\155\000\005\000\102\000\007\000\101\000\015\000\044\000\016\000\043\000\
\\017\000\042\000\018\000\041\000\019\000\040\000\020\000\039\000\
\\021\000\038\000\022\000\037\000\023\000\036\000\024\000\035\000\
\\026\000\034\000\027\000\033\000\000\000\
\\156\000\000\000\
\\157\000\000\000\
\\159\000\000\000\
\\160\000\000\000\
\\161\000\000\000\
\\162\000\000\000\
\\163\000\000\000\
\\164\000\000\000\
\\165\000\000\000\
\\166\000\000\000\
\\167\000\000\000\
\\168\000\000\000\
\\169\000\000\000\
\\170\000\000\000\
\\171\000\000\000\
\\172\000\000\000\
\\173\000\000\000\
\\175\000\000\000\
\\176\000\000\000\
\\177\000\000\000\
\\178\000\010\000\028\000\014\000\027\000\028\000\026\000\000\000\
\\179\000\000\000\
\\180\000\000\000\
\\181\000\002\000\025\000\003\000\024\000\004\000\023\000\008\000\022\000\
\\016\000\021\000\030\000\020\000\033\000\019\000\034\000\018\000\
\\037\000\017\000\041\000\016\000\042\000\015\000\000\000\
\\184\000\000\000\
\\185\000\000\000\
\\186\000\015\000\044\000\016\000\043\000\017\000\042\000\018\000\041\000\
\\019\000\040\000\020\000\039\000\021\000\038\000\022\000\037\000\
\\023\000\036\000\024\000\035\000\026\000\034\000\027\000\033\000\000\000\
\\187\000\026\000\034\000\027\000\033\000\000\000\
\\188\000\000\000\
\\189\000\000\000\
\\190\000\000\000\
\\191\000\015\000\044\000\016\000\043\000\017\000\042\000\018\000\041\000\
\\019\000\040\000\020\000\039\000\021\000\038\000\022\000\037\000\
\\023\000\036\000\024\000\035\000\026\000\034\000\027\000\033\000\000\000\
\\192\000\015\000\044\000\016\000\043\000\017\000\042\000\018\000\041\000\
\\019\000\040\000\020\000\039\000\021\000\038\000\022\000\037\000\
\\023\000\036\000\024\000\035\000\026\000\034\000\027\000\033\000\000\000\
\\193\000\015\000\044\000\016\000\043\000\017\000\042\000\018\000\041\000\
\\019\000\040\000\020\000\039\000\021\000\038\000\022\000\037\000\
\\023\000\036\000\024\000\035\000\026\000\034\000\027\000\033\000\
\\032\000\115\000\000\000\
\\194\000\015\000\044\000\016\000\043\000\017\000\042\000\018\000\041\000\
\\019\000\040\000\020\000\039\000\021\000\038\000\022\000\037\000\
\\023\000\036\000\024\000\035\000\026\000\034\000\027\000\033\000\000\000\
\\195\000\015\000\044\000\016\000\043\000\017\000\042\000\018\000\041\000\
\\019\000\040\000\020\000\039\000\021\000\038\000\022\000\037\000\
\\023\000\036\000\024\000\035\000\026\000\034\000\027\000\033\000\000\000\
\\196\000\000\000\
\\197\000\000\000\
\\198\000\015\000\044\000\016\000\043\000\017\000\042\000\018\000\041\000\
\\019\000\040\000\020\000\039\000\021\000\038\000\022\000\037\000\
\\023\000\036\000\024\000\035\000\026\000\034\000\027\000\033\000\000\000\
\\199\000\005\000\085\000\000\000\
\\200\000\002\000\067\000\000\000\
\\201\000\000\000\
\\202\000\015\000\044\000\016\000\043\000\017\000\042\000\018\000\041\000\
\\019\000\040\000\020\000\039\000\021\000\038\000\022\000\037\000\
\\023\000\036\000\024\000\035\000\026\000\034\000\027\000\033\000\000\000\
\"
val actionRowNumbers =
"\002\000\082\000\092\000\091\000\
\\048\000\047\000\046\000\029\000\
\\045\000\001\000\013\000\015\000\
\\016\000\083\000\098\000\012\000\
\\085\000\085\000\085\000\085\000\
\\085\000\007\000\006\000\005\000\
\\085\000\017\000\085\000\066\000\
\\065\000\064\000\085\000\078\000\
\\077\000\075\000\073\000\076\000\
\\074\000\072\000\071\000\068\000\
\\067\000\070\000\069\000\102\000\
\\085\000\044\000\036\000\057\000\
\\056\000\058\000\022\000\026\000\
\\040\000\033\000\034\000\032\000\
\\089\000\025\000\018\000\010\000\
\\093\000\079\000\030\000\088\000\
\\019\000\037\000\031\000\014\000\
\\085\000\013\000\053\000\011\000\
\\085\000\085\000\085\000\099\000\
\\009\000\090\000\061\000\027\000\
\\086\000\080\000\103\000\102\000\
\\085\000\042\000\050\000\049\000\
\\043\000\053\000\059\000\039\000\
\\020\000\023\000\041\000\035\000\
\\096\000\095\000\028\000\008\000\
\\008\000\087\000\101\000\100\000\
\\085\000\013\000\021\000\085\000\
\\024\000\053\000\013\000\081\000\
\\085\000\085\000\084\000\062\000\
\\063\000\104\000\052\000\051\000\
\\060\000\085\000\013\000\055\000\
\\054\000\097\000\094\000\003\000\
\\038\000\085\000\004\000\000\000"
val gotoT =
"\
\\001\000\131\000\002\000\009\000\003\000\008\000\006\000\007\000\
\\007\000\006\000\008\000\005\000\010\000\004\000\011\000\003\000\
\\012\000\002\000\013\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\014\000\030\000\015\000\029\000\016\000\028\000\017\000\027\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\001\000\045\000\002\000\009\000\003\000\008\000\006\000\007\000\
\\007\000\006\000\008\000\005\000\010\000\004\000\011\000\003\000\
\\012\000\002\000\013\000\001\000\000\000\
\\006\000\046\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\001\000\052\000\002\000\009\000\003\000\008\000\006\000\007\000\
\\007\000\006\000\008\000\005\000\010\000\004\000\011\000\003\000\
\\012\000\002\000\013\000\001\000\000\000\
\\006\000\007\000\010\000\053\000\011\000\003\000\012\000\002\000\
\\013\000\001\000\000\000\
\\006\000\007\000\010\000\054\000\011\000\003\000\012\000\002\000\
\\013\000\001\000\000\000\
\\006\000\007\000\010\000\055\000\011\000\003\000\012\000\002\000\
\\013\000\001\000\000\000\
\\006\000\007\000\010\000\056\000\011\000\003\000\012\000\002\000\
\\013\000\001\000\000\000\
\\006\000\007\000\010\000\057\000\011\000\003\000\012\000\002\000\
\\013\000\001\000\000\000\
\\016\000\058\000\000\000\
\\000\000\
\\000\000\
\\006\000\007\000\010\000\060\000\011\000\003\000\012\000\002\000\
\\013\000\001\000\000\000\
\\000\000\
\\006\000\007\000\010\000\062\000\011\000\003\000\012\000\002\000\
\\013\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\006\000\007\000\010\000\063\000\011\000\003\000\012\000\002\000\
\\013\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\018\000\064\000\000\000\
\\006\000\007\000\010\000\066\000\011\000\003\000\012\000\002\000\
\\013\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\014\000\030\000\015\000\029\000\016\000\028\000\017\000\027\000\000\000\
\\014\000\030\000\015\000\029\000\016\000\028\000\017\000\027\000\000\000\
\\014\000\030\000\015\000\029\000\016\000\028\000\017\000\027\000\000\000\
\\014\000\030\000\015\000\029\000\016\000\028\000\017\000\027\000\000\000\
\\014\000\030\000\015\000\029\000\016\000\028\000\017\000\027\000\000\000\
\\000\000\
\\006\000\007\000\009\000\079\000\010\000\078\000\011\000\003\000\
\\012\000\002\000\013\000\001\000\000\000\
\\014\000\030\000\015\000\029\000\016\000\028\000\017\000\027\000\000\000\
\\000\000\
\\014\000\030\000\015\000\029\000\016\000\028\000\017\000\027\000\000\000\
\\014\000\030\000\015\000\029\000\016\000\028\000\017\000\027\000\000\000\
\\000\000\
\\000\000\
\\014\000\030\000\015\000\029\000\016\000\028\000\017\000\027\000\000\000\
\\004\000\087\000\006\000\086\000\000\000\
\\006\000\007\000\010\000\090\000\011\000\003\000\012\000\002\000\
\\013\000\001\000\000\000\
\\006\000\091\000\000\000\
\\005\000\092\000\000\000\
\\006\000\007\000\009\000\094\000\010\000\078\000\011\000\003\000\
\\012\000\002\000\013\000\001\000\000\000\
\\006\000\007\000\010\000\095\000\011\000\003\000\012\000\002\000\
\\013\000\001\000\000\000\
\\006\000\007\000\010\000\096\000\011\000\003\000\012\000\002\000\
\\013\000\001\000\000\000\
\\006\000\007\000\010\000\097\000\011\000\003\000\012\000\002\000\
\\013\000\001\000\000\000\
\\000\000\
\\006\000\007\000\009\000\098\000\010\000\078\000\011\000\003\000\
\\012\000\002\000\013\000\001\000\000\000\
\\000\000\
\\014\000\030\000\015\000\029\000\016\000\028\000\017\000\027\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\018\000\102\000\000\000\
\\006\000\007\000\010\000\103\000\011\000\003\000\012\000\002\000\
\\013\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\005\000\106\000\000\000\
\\014\000\030\000\015\000\029\000\016\000\028\000\017\000\027\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\014\000\030\000\015\000\029\000\016\000\028\000\017\000\027\000\000\000\
\\014\000\030\000\015\000\029\000\016\000\028\000\017\000\027\000\000\000\
\\014\000\030\000\015\000\029\000\016\000\028\000\017\000\027\000\000\000\
\\000\000\
\\006\000\007\000\009\000\115\000\010\000\078\000\011\000\003\000\
\\012\000\002\000\013\000\001\000\000\000\
\\006\000\007\000\009\000\116\000\010\000\078\000\011\000\003\000\
\\012\000\002\000\013\000\001\000\000\000\
\\000\000\
\\000\000\
\\014\000\030\000\015\000\029\000\016\000\028\000\017\000\027\000\000\000\
\\006\000\007\000\010\000\117\000\011\000\003\000\012\000\002\000\
\\013\000\001\000\000\000\
\\006\000\118\000\000\000\
\\000\000\
\\006\000\007\000\010\000\120\000\011\000\003\000\012\000\002\000\
\\013\000\001\000\000\000\
\\000\000\
\\005\000\123\000\000\000\
\\006\000\124\000\000\000\
\\000\000\
\\006\000\007\000\010\000\125\000\011\000\003\000\012\000\002\000\
\\013\000\001\000\000\000\
\\006\000\007\000\010\000\126\000\011\000\003\000\012\000\002\000\
\\013\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\014\000\030\000\015\000\029\000\016\000\028\000\017\000\027\000\000\000\
\\000\000\
\\000\000\
\\014\000\030\000\015\000\029\000\016\000\028\000\017\000\027\000\000\000\
\\006\000\007\000\010\000\127\000\011\000\003\000\012\000\002\000\
\\013\000\001\000\000\000\
\\006\000\128\000\000\000\
\\000\000\
\\000\000\
\\014\000\030\000\015\000\029\000\016\000\028\000\017\000\027\000\000\000\
\\014\000\030\000\015\000\029\000\016\000\028\000\017\000\027\000\000\000\
\\014\000\030\000\015\000\029\000\016\000\028\000\017\000\027\000\000\000\
\\000\000\
\\006\000\007\000\010\000\130\000\011\000\003\000\012\000\002\000\
\\013\000\001\000\000\000\
\\014\000\030\000\015\000\029\000\016\000\028\000\017\000\027\000\000\000\
\\000\000\
\"
val numstates = 132
val numrules = 69
val s = ref "" and index = ref 0
val string_to_int = fn () => 
let val i = !index
in index := i+2; Char.ord(String.sub(!s,i)) + Char.ord(String.sub(!s,i+1)) * 256
end
val string_to_list = fn s' =>
    let val len = String.size s'
        fun f () =
           if !index < len then string_to_int() :: f()
           else nil
   in index := 0; s := s'; f ()
   end
val string_to_pairlist = fn (conv_key,conv_entry) =>
     let fun f () =
         case string_to_int()
         of 0 => EMPTY
          | n => PAIR(conv_key (n-1),conv_entry (string_to_int()),f())
     in f
     end
val string_to_pairlist_default = fn (conv_key,conv_entry) =>
    let val conv_row = string_to_pairlist(conv_key,conv_entry)
    in fn () =>
       let val default = conv_entry(string_to_int())
           val row = conv_row()
       in (row,default)
       end
   end
val string_to_table = fn (convert_row,s') =>
    let val len = String.size s'
        fun f ()=
           if !index < len then convert_row() :: f()
           else nil
     in (s := s'; index := 0; f ())
     end
local
  val memo = Array.array(numstates+numrules,ERROR)
  val _ =let fun g i=(Array.update(memo,i,REDUCE(i-numstates)); g(i+1))
       fun f i =
            if i=numstates then g i
            else (Array.update(memo,i,SHIFT (STATE i)); f (i+1))
          in f 0 handle General.Subscript => ()
          end
in
val entry_to_action = fn 0 => ACCEPT | 1 => ERROR | j => Array.sub(memo,(j-2))
end
val gotoT=Array.fromList(string_to_table(string_to_pairlist(NT,STATE),gotoT))
val actionRows=string_to_table(string_to_pairlist_default(T,entry_to_action),actionRows)
val actionRowNumbers = string_to_list actionRowNumbers
val actionT = let val actionRowLookUp=
let val a=Array.fromList(actionRows) in fn i=>Array.sub(a,i) end
in Array.fromList(List.map actionRowLookUp actionRowNumbers)
end
in LrTable.mkLrTable {actions=actionT,gotos=gotoT,numRules=numrules,
numStates=numstates,initialState=STATE 0}
end
end
local open Header in
type pos = int
type arg = unit
structure MlyValue = 
struct
datatype svalue = VOID | ntVOID of unit ->  unit
 | STRING of unit ->  (string) | INT of unit ->  (int)
 | ID of unit ->  (string) | recordList of unit ->  (A.exp)
 | booleanOper of unit ->  (A.oper)
 | comparisonOper of unit ->  (A.oper)
 | arithmeticOper of unit ->  (A.oper) | oper of unit ->  (A.oper)
 | lvalue of unit ->  (A.exp) | arrayExp of unit ->  (A.exp)
 | recordExp of unit ->  (A.exp) | exp of unit ->  (A.exp)
 | exps of unit ->  (A.exp) | fundec of unit ->  (A.exp)
 | vardec of unit ->  (A.exp) | type_id of unit ->  (A.exp)
 | tyfields of unit ->  (A.exp) | ty of unit ->  (A.exp)
 | tydec of unit ->  (A.exp) | dec of unit ->  (A.exp)
 | decs of unit ->  (A.exp)
end
type svalue = MlyValue.svalue
type result = A.exp
end
structure EC=
struct
open LrTable
infix 5 $$
fun x $$ y = y::x
val is_keyword =
fn (T 32) => true | (T 33) => true | (T 34) => true | (T 40) => true
 | (T 36) => true | (T 37) => true | (T 38) => true | (T 42) => true
 | (T 43) => true | (T 44) => true | (T 28) => true | (T 29) => true
 | (T 30) => true | (T 31) => true | (T 35) => true | (T 39) => true
 | (T 41) => true | _ => false
val preferred_change : (term list * term list) list = 
(nil
,nil
 $$ (T 30))::
(nil
,nil
 $$ (T 31))::
(nil
,nil
 $$ (T 7))::
nil
val noShift = 
fn (T 0) => true | _ => false
val showTerminal =
fn (T 0) => "EOF"
  | (T 1) => "ID"
  | (T 2) => "INT"
  | (T 3) => "STRING"
  | (T 4) => "COMMA"
  | (T 5) => "COLON"
  | (T 6) => "SEMICOLON"
  | (T 7) => "LPAREN"
  | (T 8) => "RPAREN"
  | (T 9) => "LBRACK"
  | (T 10) => "RBRACK"
  | (T 11) => "LBRACE"
  | (T 12) => "RBRACE"
  | (T 13) => "DOT"
  | (T 14) => "PLUS"
  | (T 15) => "MINUS"
  | (T 16) => "TIMES"
  | (T 17) => "DIVIDE"
  | (T 18) => "EQ"
  | (T 19) => "NEQ"
  | (T 20) => "LT"
  | (T 21) => "LE"
  | (T 22) => "GT"
  | (T 23) => "GE"
  | (T 24) => "UMINUS"
  | (T 25) => "AND"
  | (T 26) => "OR"
  | (T 27) => "ASSIGN"
  | (T 28) => "ARRAY"
  | (T 29) => "IF"
  | (T 30) => "THEN"
  | (T 31) => "ELSE"
  | (T 32) => "WHILE"
  | (T 33) => "FOR"
  | (T 34) => "TO"
  | (T 35) => "DO"
  | (T 36) => "LET"
  | (T 37) => "IN"
  | (T 38) => "END"
  | (T 39) => "OF"
  | (T 40) => "BREAK"
  | (T 41) => "NIL"
  | (T 42) => "FUNCTION"
  | (T 43) => "VAR"
  | (T 44) => "TYPE"
  | _ => "bogus-term"
local open Header in
val errtermvalue=
fn (T 1) => MlyValue.ID(fn () => ("bogus")) | 
(T 2) => MlyValue.INT(fn () => (1)) | 
(T 3) => MlyValue.STRING(fn () => ("")) | 
_ => MlyValue.VOID
end
val terms : term list = nil
 $$ (T 44) $$ (T 43) $$ (T 42) $$ (T 41) $$ (T 40) $$ (T 39) $$ (T 38)
 $$ (T 37) $$ (T 36) $$ (T 35) $$ (T 34) $$ (T 33) $$ (T 32) $$ (T 31)
 $$ (T 30) $$ (T 29) $$ (T 28) $$ (T 27) $$ (T 26) $$ (T 25) $$ (T 24)
 $$ (T 23) $$ (T 22) $$ (T 21) $$ (T 20) $$ (T 19) $$ (T 18) $$ (T 17)
 $$ (T 16) $$ (T 15) $$ (T 14) $$ (T 13) $$ (T 12) $$ (T 11) $$ (T 10)
 $$ (T 9) $$ (T 8) $$ (T 7) $$ (T 6) $$ (T 5) $$ (T 4) $$ (T 0)end
structure Actions =
struct 
exception mlyAction of int
local open Header in
val actions = 
fn (i392,defaultPos,stack,
    (()):arg) =>
case (i392,stack)
of  ( 0, ( ( _, ( MlyValue.dec dec1, dec1left, dec1right)) :: rest671)
) => let val  result = MlyValue.decs (fn _ => let val  dec1 = dec1 ()
 in (A.NilExp)
end)
 in ( LrTable.NT 0, ( result, dec1left, dec1right), rest671)
end
|  ( 1, ( ( _, ( MlyValue.decs decs1, _, decs1right)) :: ( _, ( 
MlyValue.dec dec1, dec1left, _)) :: rest671)) => let val  result = 
MlyValue.decs (fn _ => let val  dec1 = dec1 ()
 val  decs1 = decs1 ()
 in (A.NilExp)
end)
 in ( LrTable.NT 0, ( result, dec1left, decs1right), rest671)
end
|  ( 2, ( rest671)) => let val  result = MlyValue.decs (fn _ => (
A.NilExp))
 in ( LrTable.NT 0, ( result, defaultPos, defaultPos), rest671)
end
|  ( 3, ( ( _, ( MlyValue.tydec tydec1, tydec1left, tydec1right)) :: 
rest671)) => let val  result = MlyValue.dec (fn _ => let val  tydec1 =
 tydec1 ()
 in (A.NilExp)
end)
 in ( LrTable.NT 1, ( result, tydec1left, tydec1right), rest671)
end
|  ( 4, ( ( _, ( MlyValue.vardec vardec1, vardec1left, vardec1right))
 :: rest671)) => let val  result = MlyValue.dec (fn _ => let val  
vardec1 = vardec1 ()
 in (A.NilExp)
end)
 in ( LrTable.NT 1, ( result, vardec1left, vardec1right), rest671)
end
|  ( 5, ( ( _, ( MlyValue.fundec fundec1, fundec1left, fundec1right))
 :: rest671)) => let val  result = MlyValue.dec (fn _ => let val  
fundec1 = fundec1 ()
 in (A.NilExp)
end)
 in ( LrTable.NT 1, ( result, fundec1left, fundec1right), rest671)
end
|  ( 6, ( ( _, ( MlyValue.exp exp1, exp1left, exp1right)) :: rest671))
 => let val  result = MlyValue.dec (fn _ => let val  (exp as exp1) = 
exp1 ()
 in (exp)
end)
 in ( LrTable.NT 1, ( result, exp1left, exp1right), rest671)
end
|  ( 7, ( ( _, ( MlyValue.ty ty1, _, ty1right)) :: _ :: ( _, ( 
MlyValue.type_id type_id1, _, _)) :: ( _, ( _, TYPE1left, _)) :: 
rest671)) => let val  result = MlyValue.tydec (fn _ => let val  
type_id1 = type_id1 ()
 val  ty1 = ty1 ()
 in (A.NilExp)
end)
 in ( LrTable.NT 2, ( result, TYPE1left, ty1right), rest671)
end
|  ( 8, ( ( _, ( MlyValue.type_id type_id1, type_id1left, 
type_id1right)) :: rest671)) => let val  result = MlyValue.ty (fn _ =>
 let val  type_id1 = type_id1 ()
 in (A.NilExp)
end)
 in ( LrTable.NT 3, ( result, type_id1left, type_id1right), rest671)

end
|  ( 9, ( ( _, ( _, _, RBRACE1right)) :: ( _, ( MlyValue.tyfields 
tyfields1, _, _)) :: ( _, ( _, LBRACE1left, _)) :: rest671)) => let
 val  result = MlyValue.ty (fn _ => let val  tyfields1 = tyfields1 ()
 in (A.NilExp)
end)
 in ( LrTable.NT 3, ( result, LBRACE1left, RBRACE1right), rest671)
end
|  ( 10, ( ( _, ( MlyValue.type_id type_id1, _, type_id1right)) :: _
 :: ( _, ( _, ARRAY1left, _)) :: rest671)) => let val  result = 
MlyValue.ty (fn _ => let val  type_id1 = type_id1 ()
 in (A.NilExp)
end)
 in ( LrTable.NT 3, ( result, ARRAY1left, type_id1right), rest671)
end
|  ( 11, ( rest671)) => let val  result = MlyValue.tyfields (fn _ => (
A.NilExp))
 in ( LrTable.NT 4, ( result, defaultPos, defaultPos), rest671)
end
|  ( 12, ( ( _, ( MlyValue.type_id type_id1, _, type_id1right)) :: _
 :: ( _, ( MlyValue.ID ID1, ID1left, _)) :: rest671)) => let val  
result = MlyValue.tyfields (fn _ => let val  ID1 = ID1 ()
 val  type_id1 = type_id1 ()
 in (A.NilExp)
end)
 in ( LrTable.NT 4, ( result, ID1left, type_id1right), rest671)
end
|  ( 13, ( ( _, ( MlyValue.tyfields tyfields2, _, tyfields2right)) ::
 _ :: ( _, ( MlyValue.tyfields tyfields1, tyfields1left, _)) :: 
rest671)) => let val  result = MlyValue.tyfields (fn _ => let val  
tyfields1 = tyfields1 ()
 val  tyfields2 = tyfields2 ()
 in (A.NilExp)
end)
 in ( LrTable.NT 4, ( result, tyfields1left, tyfields2right), rest671)

end
|  ( 14, ( ( _, ( MlyValue.INT INT1, INT1left, INT1right)) :: rest671)
) => let val  result = MlyValue.type_id (fn _ => let val  INT1 = INT1
 ()
 in (A.NilExp)
end)
 in ( LrTable.NT 5, ( result, INT1left, INT1right), rest671)
end
|  ( 15, ( ( _, ( MlyValue.STRING STRING1, STRING1left, STRING1right))
 :: rest671)) => let val  result = MlyValue.type_id (fn _ => let val  
STRING1 = STRING1 ()
 in (A.NilExp)
end)
 in ( LrTable.NT 5, ( result, STRING1left, STRING1right), rest671)
end
|  ( 16, ( ( _, ( MlyValue.ID ID1, ID1left, ID1right)) :: rest671)) =>
 let val  result = MlyValue.type_id (fn _ => let val  ID1 = ID1 ()
 in (A.NilExp)
end)
 in ( LrTable.NT 5, ( result, ID1left, ID1right), rest671)
end
|  ( 17, ( ( _, ( MlyValue.exp exp1, _, exp1right)) :: _ :: ( _, ( 
MlyValue.ID ID1, _, _)) :: ( _, ( _, VAR1left, _)) :: rest671)) => let
 val  result = MlyValue.vardec (fn _ => let val  ID1 = ID1 ()
 val  exp1 = exp1 ()
 in (A.NilExp)
end)
 in ( LrTable.NT 6, ( result, VAR1left, exp1right), rest671)
end
|  ( 18, ( ( _, ( MlyValue.exp exp1, _, exp1right)) :: _ :: ( _, ( 
MlyValue.type_id type_id1, _, _)) :: _ :: ( _, ( MlyValue.ID ID1, _, _
)) :: ( _, ( _, VAR1left, _)) :: rest671)) => let val  result = 
MlyValue.vardec (fn _ => let val  ID1 = ID1 ()
 val  type_id1 = type_id1 ()
 val  exp1 = exp1 ()
 in (A.NilExp)
end)
 in ( LrTable.NT 6, ( result, VAR1left, exp1right), rest671)
end
|  ( 19, ( ( _, ( MlyValue.exp exp1, _, exp1right)) :: _ :: _ :: ( _, 
( MlyValue.tyfields tyfields1, _, _)) :: _ :: ( _, ( MlyValue.ID ID1,
 _, _)) :: ( _, ( _, FUNCTION1left, _)) :: rest671)) => let val  
result = MlyValue.fundec (fn _ => let val  ID1 = ID1 ()
 val  tyfields1 = tyfields1 ()
 val  exp1 = exp1 ()
 in (A.NilExp)
end)
 in ( LrTable.NT 7, ( result, FUNCTION1left, exp1right), rest671)
end
|  ( 20, ( ( _, ( MlyValue.exp exp1, _, exp1right)) :: _ :: ( _, ( 
MlyValue.type_id type_id1, _, _)) :: _ :: _ :: ( _, ( 
MlyValue.tyfields tyfields1, _, _)) :: _ :: ( _, ( MlyValue.ID ID1, _,
 _)) :: ( _, ( _, FUNCTION1left, _)) :: rest671)) => let val  result =
 MlyValue.fundec (fn _ => let val  ID1 = ID1 ()
 val  tyfields1 = tyfields1 ()
 val  type_id1 = type_id1 ()
 val  exp1 = exp1 ()
 in (A.NilExp)
end)
 in ( LrTable.NT 7, ( result, FUNCTION1left, exp1right), rest671)
end
|  ( 21, ( ( _, ( MlyValue.exp exp1, exp1left, exp1right)) :: rest671)
) => let val  result = MlyValue.exps (fn _ => let val  exp1 = exp1 ()
 in (A.NilExp)
end)
 in ( LrTable.NT 8, ( result, exp1left, exp1right), rest671)
end
|  ( 22, ( ( _, ( MlyValue.exps exps1, _, exps1right)) :: _ :: ( _, ( 
MlyValue.exp exp1, exp1left, _)) :: rest671)) => let val  result = 
MlyValue.exps (fn _ => let val  exp1 = exp1 ()
 val  exps1 = exps1 ()
 in (A.NilExp)
end)
 in ( LrTable.NT 8, ( result, exp1left, exps1right), rest671)
end
|  ( 23, ( ( _, ( MlyValue.exps exps1, _, exps1right)) :: _ :: ( _, ( 
MlyValue.exp exp1, exp1left, _)) :: rest671)) => let val  result = 
MlyValue.exps (fn _ => let val  exp1 = exp1 ()
 val  exps1 = exps1 ()
 in (A.NilExp)
end)
 in ( LrTable.NT 8, ( result, exp1left, exps1right), rest671)
end
|  ( 24, ( rest671)) => let val  result = MlyValue.exps (fn _ => (
A.NilExp))
 in ( LrTable.NT 8, ( result, defaultPos, defaultPos), rest671)
end
|  ( 25, ( ( _, ( MlyValue.arithmeticOper arithmeticOper1, 
arithmeticOper1left, arithmeticOper1right)) :: rest671)) => let val  
result = MlyValue.oper (fn _ => let val  (arithmeticOper as 
arithmeticOper1) = arithmeticOper1 ()
 in (arithmeticOper)
end)
 in ( LrTable.NT 13, ( result, arithmeticOper1left, 
arithmeticOper1right), rest671)
end
|  ( 26, ( ( _, ( MlyValue.comparisonOper comparisonOper1, 
comparisonOper1left, comparisonOper1right)) :: rest671)) => let val  
result = MlyValue.oper (fn _ => let val  (comparisonOper as 
comparisonOper1) = comparisonOper1 ()
 in (comparisonOper)
end)
 in ( LrTable.NT 13, ( result, comparisonOper1left, 
comparisonOper1right), rest671)
end
|  ( 27, ( ( _, ( MlyValue.booleanOper booleanOper1, booleanOper1left,
 booleanOper1right)) :: rest671)) => let val  result = MlyValue.oper
 (fn _ => let val  (booleanOper as booleanOper1) = booleanOper1 ()
 in (booleanOper)
end)
 in ( LrTable.NT 13, ( result, booleanOper1left, booleanOper1right), 
rest671)
end
|  ( 28, ( ( _, ( _, TIMES1left, TIMES1right)) :: rest671)) => let
 val  result = MlyValue.arithmeticOper (fn _ => (A.TimesOp))
 in ( LrTable.NT 14, ( result, TIMES1left, TIMES1right), rest671)
end
|  ( 29, ( ( _, ( _, DIVIDE1left, DIVIDE1right)) :: rest671)) => let
 val  result = MlyValue.arithmeticOper (fn _ => (A.DivideOp))
 in ( LrTable.NT 14, ( result, DIVIDE1left, DIVIDE1right), rest671)

end
|  ( 30, ( ( _, ( _, PLUS1left, PLUS1right)) :: rest671)) => let val  
result = MlyValue.arithmeticOper (fn _ => (A.PlusOp))
 in ( LrTable.NT 14, ( result, PLUS1left, PLUS1right), rest671)
end
|  ( 31, ( ( _, ( _, MINUS1left, MINUS1right)) :: rest671)) => let
 val  result = MlyValue.arithmeticOper (fn _ => (A.MinusOp))
 in ( LrTable.NT 14, ( result, MINUS1left, MINUS1right), rest671)
end
|  ( 32, ( ( _, ( _, EQ1left, EQ1right)) :: rest671)) => let val  
result = MlyValue.comparisonOper (fn _ => (A.EqOp))
 in ( LrTable.NT 15, ( result, EQ1left, EQ1right), rest671)
end
|  ( 33, ( ( _, ( _, NEQ1left, NEQ1right)) :: rest671)) => let val  
result = MlyValue.comparisonOper (fn _ => (A.NeqOp))
 in ( LrTable.NT 15, ( result, NEQ1left, NEQ1right), rest671)
end
|  ( 34, ( ( _, ( _, GT1left, GT1right)) :: rest671)) => let val  
result = MlyValue.comparisonOper (fn _ => (A.GtOp))
 in ( LrTable.NT 15, ( result, GT1left, GT1right), rest671)
end
|  ( 35, ( ( _, ( _, LT1left, LT1right)) :: rest671)) => let val  
result = MlyValue.comparisonOper (fn _ => (A.LtOp))
 in ( LrTable.NT 15, ( result, LT1left, LT1right), rest671)
end
|  ( 36, ( ( _, ( _, GE1left, GE1right)) :: rest671)) => let val  
result = MlyValue.comparisonOper (fn _ => (A.GeOp))
 in ( LrTable.NT 15, ( result, GE1left, GE1right), rest671)
end
|  ( 37, ( ( _, ( _, LE1left, LE1right)) :: rest671)) => let val  
result = MlyValue.comparisonOper (fn _ => (A.LeOp))
 in ( LrTable.NT 15, ( result, LE1left, LE1right), rest671)
end
|  ( 38, ( ( _, ( _, AND1left, AND1right)) :: rest671)) => let val  
result = MlyValue.booleanOper (fn _ => (A.GtOp))
 in ( LrTable.NT 16, ( result, AND1left, AND1right), rest671)
end
|  ( 39, ( ( _, ( _, OR1left, OR1right)) :: rest671)) => let val  
result = MlyValue.booleanOper (fn _ => (A.GtOp))
 in ( LrTable.NT 16, ( result, OR1left, OR1right), rest671)
end
|  ( 40, ( ( _, ( MlyValue.ID ID1, ID1left, ID1right)) :: rest671)) =>
 let val  result = MlyValue.lvalue (fn _ => let val  ID1 = ID1 ()
 in (A.NilExp)
end)
 in ( LrTable.NT 12, ( result, ID1left, ID1right), rest671)
end
|  ( 41, ( ( _, ( MlyValue.ID ID1, _, ID1right)) :: _ :: ( _, ( 
MlyValue.lvalue lvalue1, lvalue1left, _)) :: rest671)) => let val  
result = MlyValue.lvalue (fn _ => let val  lvalue1 = lvalue1 ()
 val  ID1 = ID1 ()
 in (A.NilExp)
end)
 in ( LrTable.NT 12, ( result, lvalue1left, ID1right), rest671)
end
|  ( 42, ( ( _, ( _, _, RBRACK1right)) :: ( _, ( MlyValue.exp exp1, _,
 _)) :: _ :: ( _, ( MlyValue.lvalue lvalue1, lvalue1left, _)) :: 
rest671)) => let val  result = MlyValue.lvalue (fn _ => let val  
lvalue1 = lvalue1 ()
 val  exp1 = exp1 ()
 in (A.NilExp)
end)
 in ( LrTable.NT 12, ( result, lvalue1left, RBRACK1right), rest671)

end
|  ( 43, ( ( _, ( _, _, END1right)) :: ( _, ( MlyValue.exps exps1, _,
 _)) :: _ :: ( _, ( MlyValue.decs decs1, _, _)) :: ( _, ( _, LET1left,
 _)) :: rest671)) => let val  result = MlyValue.exp (fn _ => let val  
decs1 = decs1 ()
 val  exps1 = exps1 ()
 in (A.NilExp)
end)
 in ( LrTable.NT 9, ( result, LET1left, END1right), rest671)
end
|  ( 44, ( ( _, ( MlyValue.lvalue lvalue1, lvalue1left, lvalue1right))
 :: rest671)) => let val  result = MlyValue.exp (fn _ => let val  
lvalue1 = lvalue1 ()
 in (A.NilExp)
end)
 in ( LrTable.NT 9, ( result, lvalue1left, lvalue1right), rest671)
end
|  ( 45, ( ( _, ( _, NIL1left, NIL1right)) :: rest671)) => let val  
result = MlyValue.exp (fn _ => (A.NilExp))
 in ( LrTable.NT 9, ( result, NIL1left, NIL1right), rest671)
end
|  ( 46, ( ( _, ( _, _, RPAREN1right)) :: ( _, ( MlyValue.exps exps1,
 _, _)) :: _ :: ( _, ( MlyValue.exp exp1, _, _)) :: ( _, ( _, 
LPAREN1left, _)) :: rest671)) => let val  result = MlyValue.exp (fn _
 => let val  exp1 = exp1 ()
 val  exps1 = exps1 ()
 in (A.NilExp)
end)
 in ( LrTable.NT 9, ( result, LPAREN1left, RPAREN1right), rest671)
end
|  ( 47, ( rest671)) => let val  result = MlyValue.exp (fn _ => (
A.NilExp))
 in ( LrTable.NT 9, ( result, defaultPos, defaultPos), rest671)
end
|  ( 48, ( ( _, ( MlyValue.INT INT1, INT1left, INT1right)) :: rest671)
) => let val  result = MlyValue.exp (fn _ => let val  INT1 = INT1 ()
 in (A.NilExp)
end)
 in ( LrTable.NT 9, ( result, INT1left, INT1right), rest671)
end
|  ( 49, ( ( _, ( MlyValue.STRING STRING1, STRING1left, STRING1right))
 :: rest671)) => let val  result = MlyValue.exp (fn _ => let val  
STRING1 = STRING1 ()
 in (A.NilExp)
end)
 in ( LrTable.NT 9, ( result, STRING1left, STRING1right), rest671)
end
|  ( 50, ( ( _, ( _, _, RPAREN1right)) :: _ :: ( _, ( MlyValue.ID ID1,
 ID1left, _)) :: rest671)) => let val  result = MlyValue.exp (fn _ =>
 let val  ID1 = ID1 ()
 in (A.NilExp)
end)
 in ( LrTable.NT 9, ( result, ID1left, RPAREN1right), rest671)
end
|  ( 51, ( ( _, ( _, _, RPAREN1right)) :: ( _, ( MlyValue.exps exps1,
 _, _)) :: _ :: ( _, ( MlyValue.ID ID1, ID1left, _)) :: rest671)) =>
 let val  result = MlyValue.exp (fn _ => let val  ID1 = ID1 ()
 val  exps1 = exps1 ()
 in (A.NilExp)
end)
 in ( LrTable.NT 9, ( result, ID1left, RPAREN1right), rest671)
end
|  ( 52, ( ( _, ( MlyValue.exp exp2, _, exp2right)) :: ( _, ( 
MlyValue.oper oper1, _, _)) :: ( _, ( MlyValue.exp exp1, exp1left, _))
 :: rest671)) => let val  result = MlyValue.exp (fn _ => let val  (exp
 as exp1) = exp1 ()
 val  oper1 = oper1 ()
 val  exp2 = exp2 ()
 in (exp)
end)
 in ( LrTable.NT 9, ( result, exp1left, exp2right), rest671)
end
|  ( 53, ( ( _, ( MlyValue.exp exp1, _, exp1right)) :: ( _, ( _, 
MINUS1left, _)) :: rest671)) => let val  result = MlyValue.exp (fn _
 => let val  exp1 = exp1 ()
 in (A.NilExp)
end)
 in ( LrTable.NT 9, ( result, MINUS1left, exp1right), rest671)
end
|  ( 54, ( ( _, ( MlyValue.STRING STRING2, _, STRING2right)) :: ( _, (
 MlyValue.comparisonOper comparisonOper1, _, _)) :: ( _, ( 
MlyValue.STRING STRING1, STRING1left, _)) :: rest671)) => let val  
result = MlyValue.exp (fn _ => let val  STRING1 = STRING1 ()
 val  comparisonOper1 = comparisonOper1 ()
 val  STRING2 = STRING2 ()
 in (A.NilExp)
end)
 in ( LrTable.NT 9, ( result, STRING1left, STRING2right), rest671)
end
|  ( 55, ( ( _, ( MlyValue.recordExp recordExp1, recordExp1left, 
recordExp1right)) :: rest671)) => let val  result = MlyValue.exp (fn _
 => let val  recordExp1 = recordExp1 ()
 in (A.NilExp)
end)
 in ( LrTable.NT 9, ( result, recordExp1left, recordExp1right), 
rest671)
end
|  ( 56, ( ( _, ( MlyValue.arrayExp arrayExp1, arrayExp1left, 
arrayExp1right)) :: rest671)) => let val  result = MlyValue.exp (fn _
 => let val  arrayExp1 = arrayExp1 ()
 in (A.NilExp)
end)
 in ( LrTable.NT 9, ( result, arrayExp1left, arrayExp1right), rest671)

end
|  ( 57, ( ( _, ( MlyValue.exp exp1, _, exp1right)) :: _ :: ( _, ( 
MlyValue.lvalue lvalue1, lvalue1left, _)) :: rest671)) => let val  
result = MlyValue.exp (fn _ => let val  lvalue1 = lvalue1 ()
 val  exp1 = exp1 ()
 in (A.NilExp)
end)
 in ( LrTable.NT 9, ( result, lvalue1left, exp1right), rest671)
end
|  ( 58, ( ( _, ( MlyValue.exp exp3, _, exp3right)) :: _ :: ( _, ( 
MlyValue.exp exp2, _, _)) :: _ :: ( _, ( MlyValue.exp exp1, _, _)) :: 
( _, ( _, IF1left, _)) :: rest671)) => let val  result = MlyValue.exp
 (fn _ => let val  exp1 = exp1 ()
 val  exp2 = exp2 ()
 val  exp3 = exp3 ()
 in (A.NilExp)
end)
 in ( LrTable.NT 9, ( result, IF1left, exp3right), rest671)
end
|  ( 59, ( ( _, ( MlyValue.exp exp2, _, exp2right)) :: _ :: ( _, ( 
MlyValue.exp exp1, _, _)) :: ( _, ( _, IF1left, _)) :: rest671)) =>
 let val  result = MlyValue.exp (fn _ => let val  exp1 = exp1 ()
 val  exp2 = exp2 ()
 in (A.NilExp)
end)
 in ( LrTable.NT 9, ( result, IF1left, exp2right), rest671)
end
|  ( 60, ( ( _, ( MlyValue.exp exp2, _, exp2right)) :: _ :: ( _, ( 
MlyValue.exp exp1, _, _)) :: ( _, ( _, WHILE1left, _)) :: rest671)) =>
 let val  result = MlyValue.exp (fn _ => let val  exp1 = exp1 ()
 val  exp2 = exp2 ()
 in (A.NilExp)
end)
 in ( LrTable.NT 9, ( result, WHILE1left, exp2right), rest671)
end
|  ( 61, ( ( _, ( MlyValue.exp exp3, _, exp3right)) :: _ :: ( _, ( 
MlyValue.exp exp2, _, _)) :: _ :: ( _, ( MlyValue.exp exp1, _, _)) :: 
( _, ( _, FOR1left, _)) :: rest671)) => let val  result = MlyValue.exp
 (fn _ => let val  exp1 = exp1 ()
 val  exp2 = exp2 ()
 val  exp3 = exp3 ()
 in (A.NilExp)
end)
 in ( LrTable.NT 9, ( result, FOR1left, exp3right), rest671)
end
|  ( 62, ( ( _, ( _, BREAK1left, BREAK1right)) :: rest671)) => let
 val  result = MlyValue.exp (fn _ => (A.NilExp))
 in ( LrTable.NT 9, ( result, BREAK1left, BREAK1right), rest671)
end
|  ( 63, ( ( _, ( _, _, RPAREN1right)) :: ( _, ( MlyValue.exp exp1, _,
 _)) :: ( _, ( _, LPAREN1left, _)) :: rest671)) => let val  result = 
MlyValue.exp (fn _ => let val  exp1 = exp1 ()
 in (A.NilExp)
end)
 in ( LrTable.NT 9, ( result, LPAREN1left, RPAREN1right), rest671)
end
|  ( 64, ( ( _, ( MlyValue.exp exp1, _, exp1right)) :: _ :: ( _, ( 
MlyValue.ID ID1, ID1left, _)) :: rest671)) => let val  result = 
MlyValue.recordList (fn _ => let val  ID1 = ID1 ()
 val  exp1 = exp1 ()
 in (A.NilExp)
end)
 in ( LrTable.NT 17, ( result, ID1left, exp1right), rest671)
end
|  ( 65, ( ( _, ( MlyValue.recordList recordList2, _, recordList2right
)) :: _ :: ( _, ( MlyValue.recordList recordList1, recordList1left, _)
) :: rest671)) => let val  result = MlyValue.recordList (fn _ => let
 val  recordList1 = recordList1 ()
 val  recordList2 = recordList2 ()
 in (A.NilExp)
end)
 in ( LrTable.NT 17, ( result, recordList1left, recordList2right), 
rest671)
end
|  ( 66, ( rest671)) => let val  result = MlyValue.recordList (fn _ =>
 (A.NilExp))
 in ( LrTable.NT 17, ( result, defaultPos, defaultPos), rest671)
end
|  ( 67, ( ( _, ( _, _, RBRACE1right)) :: ( _, ( MlyValue.recordList 
recordList1, _, _)) :: _ :: ( _, ( MlyValue.type_id type_id1, 
type_id1left, _)) :: rest671)) => let val  result = MlyValue.recordExp
 (fn _ => let val  type_id1 = type_id1 ()
 val  recordList1 = recordList1 ()
 in (A.NilExp)
end)
 in ( LrTable.NT 10, ( result, type_id1left, RBRACE1right), rest671)

end
|  ( 68, ( ( _, ( MlyValue.exp exp2, _, exp2right)) :: _ :: _ :: ( _, 
( MlyValue.exp exp1, _, _)) :: _ :: ( _, ( MlyValue.type_id type_id1, 
type_id1left, _)) :: rest671)) => let val  result = MlyValue.arrayExp
 (fn _ => let val  type_id1 = type_id1 ()
 val  exp1 = exp1 ()
 val  exp2 = exp2 ()
 in (A.NilExp)
end)
 in ( LrTable.NT 11, ( result, type_id1left, exp2right), rest671)
end
| _ => raise (mlyAction i392)
end
val void = MlyValue.VOID
val extract = fn a => (fn MlyValue.decs x => x
| _ => let exception ParseInternal
	in raise ParseInternal end) a ()
end
end
structure Tokens : Tiger_TOKENS =
struct
type svalue = ParserData.svalue
type ('a,'b) token = ('a,'b) Token.token
fun EOF (p1,p2) = Token.TOKEN (ParserData.LrTable.T 0,(
ParserData.MlyValue.VOID,p1,p2))
fun ID (i,p1,p2) = Token.TOKEN (ParserData.LrTable.T 1,(
ParserData.MlyValue.ID (fn () => i),p1,p2))
fun INT (i,p1,p2) = Token.TOKEN (ParserData.LrTable.T 2,(
ParserData.MlyValue.INT (fn () => i),p1,p2))
fun STRING (i,p1,p2) = Token.TOKEN (ParserData.LrTable.T 3,(
ParserData.MlyValue.STRING (fn () => i),p1,p2))
fun COMMA (p1,p2) = Token.TOKEN (ParserData.LrTable.T 4,(
ParserData.MlyValue.VOID,p1,p2))
fun COLON (p1,p2) = Token.TOKEN (ParserData.LrTable.T 5,(
ParserData.MlyValue.VOID,p1,p2))
fun SEMICOLON (p1,p2) = Token.TOKEN (ParserData.LrTable.T 6,(
ParserData.MlyValue.VOID,p1,p2))
fun LPAREN (p1,p2) = Token.TOKEN (ParserData.LrTable.T 7,(
ParserData.MlyValue.VOID,p1,p2))
fun RPAREN (p1,p2) = Token.TOKEN (ParserData.LrTable.T 8,(
ParserData.MlyValue.VOID,p1,p2))
fun LBRACK (p1,p2) = Token.TOKEN (ParserData.LrTable.T 9,(
ParserData.MlyValue.VOID,p1,p2))
fun RBRACK (p1,p2) = Token.TOKEN (ParserData.LrTable.T 10,(
ParserData.MlyValue.VOID,p1,p2))
fun LBRACE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 11,(
ParserData.MlyValue.VOID,p1,p2))
fun RBRACE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 12,(
ParserData.MlyValue.VOID,p1,p2))
fun DOT (p1,p2) = Token.TOKEN (ParserData.LrTable.T 13,(
ParserData.MlyValue.VOID,p1,p2))
fun PLUS (p1,p2) = Token.TOKEN (ParserData.LrTable.T 14,(
ParserData.MlyValue.VOID,p1,p2))
fun MINUS (p1,p2) = Token.TOKEN (ParserData.LrTable.T 15,(
ParserData.MlyValue.VOID,p1,p2))
fun TIMES (p1,p2) = Token.TOKEN (ParserData.LrTable.T 16,(
ParserData.MlyValue.VOID,p1,p2))
fun DIVIDE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 17,(
ParserData.MlyValue.VOID,p1,p2))
fun EQ (p1,p2) = Token.TOKEN (ParserData.LrTable.T 18,(
ParserData.MlyValue.VOID,p1,p2))
fun NEQ (p1,p2) = Token.TOKEN (ParserData.LrTable.T 19,(
ParserData.MlyValue.VOID,p1,p2))
fun LT (p1,p2) = Token.TOKEN (ParserData.LrTable.T 20,(
ParserData.MlyValue.VOID,p1,p2))
fun LE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 21,(
ParserData.MlyValue.VOID,p1,p2))
fun GT (p1,p2) = Token.TOKEN (ParserData.LrTable.T 22,(
ParserData.MlyValue.VOID,p1,p2))
fun GE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 23,(
ParserData.MlyValue.VOID,p1,p2))
fun UMINUS (p1,p2) = Token.TOKEN (ParserData.LrTable.T 24,(
ParserData.MlyValue.VOID,p1,p2))
fun AND (p1,p2) = Token.TOKEN (ParserData.LrTable.T 25,(
ParserData.MlyValue.VOID,p1,p2))
fun OR (p1,p2) = Token.TOKEN (ParserData.LrTable.T 26,(
ParserData.MlyValue.VOID,p1,p2))
fun ASSIGN (p1,p2) = Token.TOKEN (ParserData.LrTable.T 27,(
ParserData.MlyValue.VOID,p1,p2))
fun ARRAY (p1,p2) = Token.TOKEN (ParserData.LrTable.T 28,(
ParserData.MlyValue.VOID,p1,p2))
fun IF (p1,p2) = Token.TOKEN (ParserData.LrTable.T 29,(
ParserData.MlyValue.VOID,p1,p2))
fun THEN (p1,p2) = Token.TOKEN (ParserData.LrTable.T 30,(
ParserData.MlyValue.VOID,p1,p2))
fun ELSE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 31,(
ParserData.MlyValue.VOID,p1,p2))
fun WHILE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 32,(
ParserData.MlyValue.VOID,p1,p2))
fun FOR (p1,p2) = Token.TOKEN (ParserData.LrTable.T 33,(
ParserData.MlyValue.VOID,p1,p2))
fun TO (p1,p2) = Token.TOKEN (ParserData.LrTable.T 34,(
ParserData.MlyValue.VOID,p1,p2))
fun DO (p1,p2) = Token.TOKEN (ParserData.LrTable.T 35,(
ParserData.MlyValue.VOID,p1,p2))
fun LET (p1,p2) = Token.TOKEN (ParserData.LrTable.T 36,(
ParserData.MlyValue.VOID,p1,p2))
fun IN (p1,p2) = Token.TOKEN (ParserData.LrTable.T 37,(
ParserData.MlyValue.VOID,p1,p2))
fun END (p1,p2) = Token.TOKEN (ParserData.LrTable.T 38,(
ParserData.MlyValue.VOID,p1,p2))
fun OF (p1,p2) = Token.TOKEN (ParserData.LrTable.T 39,(
ParserData.MlyValue.VOID,p1,p2))
fun BREAK (p1,p2) = Token.TOKEN (ParserData.LrTable.T 40,(
ParserData.MlyValue.VOID,p1,p2))
fun NIL (p1,p2) = Token.TOKEN (ParserData.LrTable.T 41,(
ParserData.MlyValue.VOID,p1,p2))
fun FUNCTION (p1,p2) = Token.TOKEN (ParserData.LrTable.T 42,(
ParserData.MlyValue.VOID,p1,p2))
fun VAR (p1,p2) = Token.TOKEN (ParserData.LrTable.T 43,(
ParserData.MlyValue.VOID,p1,p2))
fun TYPE (p1,p2) = Token.TOKEN (ParserData.LrTable.T 44,(
ParserData.MlyValue.VOID,p1,p2))
end
end
