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
\\001\000\001\000\155\000\000\000\
\\001\000\001\000\156\000\005\000\156\000\007\000\156\000\009\000\156\000\
\\011\000\156\000\013\000\156\000\026\000\156\000\027\000\156\000\
\\031\000\156\000\032\000\156\000\035\000\156\000\036\000\156\000\
\\038\000\156\000\039\000\156\000\043\000\156\000\044\000\156\000\
\\045\000\156\000\000\000\
\\001\000\001\000\157\000\005\000\157\000\007\000\157\000\009\000\157\000\
\\011\000\157\000\013\000\157\000\026\000\157\000\027\000\157\000\
\\031\000\157\000\032\000\157\000\035\000\157\000\036\000\157\000\
\\038\000\157\000\039\000\157\000\043\000\157\000\044\000\157\000\
\\045\000\157\000\000\000\
\\001\000\001\000\158\000\005\000\158\000\007\000\158\000\009\000\158\000\
\\011\000\158\000\013\000\158\000\026\000\158\000\027\000\158\000\
\\031\000\158\000\032\000\158\000\035\000\158\000\036\000\158\000\
\\038\000\158\000\039\000\158\000\043\000\158\000\044\000\158\000\
\\045\000\158\000\000\000\
\\001\000\001\000\159\000\005\000\159\000\007\000\159\000\009\000\159\000\
\\011\000\159\000\013\000\159\000\026\000\159\000\027\000\159\000\
\\031\000\159\000\032\000\159\000\035\000\159\000\036\000\159\000\
\\038\000\159\000\039\000\159\000\043\000\159\000\044\000\159\000\
\\045\000\159\000\000\000\
\\001\000\001\000\160\000\005\000\160\000\007\000\160\000\009\000\160\000\
\\011\000\160\000\013\000\160\000\026\000\024\000\027\000\023\000\
\\031\000\160\000\032\000\160\000\035\000\160\000\036\000\160\000\
\\038\000\160\000\039\000\160\000\043\000\160\000\044\000\160\000\
\\045\000\160\000\000\000\
\\001\000\001\000\161\000\005\000\161\000\007\000\161\000\009\000\161\000\
\\011\000\161\000\013\000\161\000\026\000\161\000\027\000\161\000\
\\031\000\161\000\032\000\161\000\035\000\161\000\036\000\161\000\
\\038\000\161\000\039\000\161\000\043\000\161\000\044\000\161\000\
\\045\000\161\000\000\000\
\\001\000\001\000\162\000\005\000\162\000\007\000\162\000\009\000\162\000\
\\011\000\162\000\013\000\162\000\026\000\162\000\027\000\162\000\
\\031\000\162\000\032\000\162\000\035\000\162\000\036\000\162\000\
\\038\000\162\000\039\000\162\000\043\000\162\000\044\000\162\000\
\\045\000\162\000\000\000\
\\001\000\001\000\163\000\005\000\163\000\007\000\163\000\009\000\163\000\
\\011\000\163\000\013\000\163\000\026\000\163\000\027\000\163\000\
\\031\000\163\000\032\000\163\000\035\000\163\000\036\000\163\000\
\\038\000\163\000\039\000\163\000\043\000\163\000\044\000\163\000\
\\045\000\163\000\000\000\
\\001\000\001\000\164\000\005\000\164\000\007\000\164\000\009\000\164\000\
\\011\000\164\000\013\000\164\000\026\000\164\000\027\000\164\000\
\\031\000\164\000\032\000\090\000\035\000\164\000\036\000\164\000\
\\038\000\164\000\039\000\164\000\043\000\164\000\044\000\164\000\
\\045\000\164\000\000\000\
\\001\000\001\000\165\000\005\000\165\000\007\000\165\000\009\000\165\000\
\\011\000\165\000\013\000\165\000\026\000\165\000\027\000\165\000\
\\031\000\165\000\032\000\165\000\035\000\165\000\036\000\165\000\
\\038\000\165\000\039\000\165\000\043\000\165\000\044\000\165\000\
\\045\000\165\000\000\000\
\\001\000\001\000\166\000\005\000\166\000\007\000\166\000\009\000\166\000\
\\011\000\166\000\013\000\166\000\026\000\166\000\027\000\166\000\
\\031\000\166\000\032\000\166\000\035\000\166\000\036\000\166\000\
\\038\000\166\000\039\000\166\000\043\000\166\000\044\000\166\000\
\\045\000\166\000\000\000\
\\001\000\001\000\167\000\005\000\167\000\007\000\167\000\009\000\167\000\
\\011\000\167\000\013\000\167\000\026\000\167\000\027\000\167\000\
\\031\000\167\000\032\000\167\000\035\000\167\000\036\000\167\000\
\\038\000\167\000\039\000\167\000\043\000\167\000\044\000\167\000\
\\045\000\167\000\000\000\
\\001\000\001\000\168\000\005\000\168\000\007\000\168\000\009\000\168\000\
\\011\000\168\000\013\000\168\000\026\000\168\000\027\000\168\000\
\\031\000\168\000\032\000\168\000\035\000\168\000\036\000\168\000\
\\038\000\168\000\039\000\168\000\043\000\168\000\044\000\168\000\
\\045\000\168\000\000\000\
\\001\000\001\000\169\000\005\000\169\000\007\000\169\000\009\000\169\000\
\\010\000\021\000\011\000\169\000\013\000\169\000\014\000\020\000\
\\026\000\169\000\027\000\169\000\028\000\019\000\031\000\169\000\
\\032\000\169\000\035\000\169\000\036\000\169\000\038\000\169\000\
\\039\000\169\000\043\000\169\000\044\000\169\000\045\000\169\000\000\000\
\\001\000\001\000\170\000\005\000\170\000\007\000\170\000\009\000\170\000\
\\011\000\170\000\013\000\170\000\026\000\170\000\027\000\170\000\
\\031\000\170\000\032\000\170\000\035\000\170\000\036\000\170\000\
\\038\000\170\000\039\000\170\000\043\000\170\000\044\000\170\000\
\\045\000\170\000\000\000\
\\001\000\001\000\171\000\005\000\171\000\007\000\171\000\009\000\171\000\
\\011\000\171\000\013\000\171\000\026\000\171\000\027\000\171\000\
\\031\000\171\000\032\000\171\000\035\000\171\000\036\000\171\000\
\\038\000\171\000\039\000\171\000\043\000\171\000\044\000\171\000\
\\045\000\171\000\000\000\
\\001\000\001\000\172\000\005\000\172\000\007\000\172\000\009\000\172\000\
\\011\000\172\000\013\000\172\000\026\000\172\000\027\000\172\000\
\\031\000\172\000\032\000\172\000\035\000\172\000\036\000\172\000\
\\038\000\172\000\039\000\172\000\043\000\172\000\044\000\172\000\
\\045\000\172\000\000\000\
\\001\000\001\000\173\000\005\000\173\000\007\000\173\000\009\000\173\000\
\\011\000\173\000\013\000\173\000\026\000\173\000\027\000\173\000\
\\031\000\173\000\032\000\173\000\035\000\173\000\036\000\173\000\
\\038\000\173\000\039\000\173\000\043\000\173\000\044\000\173\000\
\\045\000\173\000\000\000\
\\001\000\001\000\174\000\005\000\174\000\007\000\174\000\009\000\174\000\
\\011\000\174\000\013\000\174\000\026\000\174\000\027\000\174\000\
\\031\000\174\000\032\000\174\000\035\000\174\000\036\000\174\000\
\\038\000\174\000\039\000\174\000\043\000\174\000\044\000\174\000\
\\045\000\174\000\000\000\
\\001\000\001\000\175\000\005\000\175\000\007\000\175\000\009\000\175\000\
\\011\000\175\000\013\000\175\000\026\000\175\000\027\000\175\000\
\\031\000\175\000\032\000\175\000\035\000\175\000\036\000\175\000\
\\038\000\175\000\039\000\175\000\043\000\175\000\044\000\175\000\
\\045\000\175\000\000\000\
\\001\000\001\000\176\000\005\000\176\000\007\000\176\000\009\000\176\000\
\\011\000\176\000\013\000\176\000\026\000\176\000\027\000\176\000\
\\031\000\176\000\032\000\176\000\035\000\176\000\036\000\176\000\
\\038\000\176\000\039\000\176\000\043\000\176\000\044\000\176\000\
\\045\000\176\000\000\000\
\\001\000\001\000\177\000\005\000\177\000\007\000\177\000\009\000\177\000\
\\011\000\177\000\013\000\177\000\026\000\177\000\027\000\177\000\
\\031\000\177\000\032\000\177\000\035\000\177\000\036\000\177\000\
\\038\000\177\000\039\000\177\000\043\000\177\000\044\000\177\000\
\\045\000\177\000\000\000\
\\001\000\001\000\184\000\005\000\184\000\007\000\184\000\008\000\040\000\
\\009\000\184\000\010\000\184\000\011\000\184\000\012\000\039\000\
\\013\000\184\000\014\000\184\000\026\000\184\000\027\000\184\000\
\\028\000\184\000\031\000\184\000\032\000\184\000\035\000\184\000\
\\036\000\184\000\038\000\184\000\039\000\184\000\043\000\184\000\
\\044\000\184\000\045\000\184\000\000\000\
\\001\000\001\000\185\000\005\000\185\000\007\000\185\000\009\000\185\000\
\\010\000\185\000\011\000\185\000\013\000\185\000\014\000\185\000\
\\026\000\185\000\027\000\185\000\028\000\185\000\031\000\185\000\
\\032\000\185\000\035\000\185\000\036\000\185\000\038\000\185\000\
\\039\000\185\000\043\000\185\000\044\000\185\000\045\000\185\000\000\000\
\\001\000\001\000\186\000\005\000\186\000\007\000\186\000\009\000\186\000\
\\010\000\186\000\011\000\186\000\013\000\186\000\014\000\186\000\
\\026\000\186\000\027\000\186\000\028\000\186\000\031\000\186\000\
\\032\000\186\000\035\000\186\000\036\000\186\000\038\000\186\000\
\\039\000\186\000\043\000\186\000\044\000\186\000\045\000\186\000\000\000\
\\001\000\001\000\187\000\005\000\187\000\007\000\187\000\009\000\187\000\
\\011\000\187\000\013\000\187\000\026\000\187\000\027\000\187\000\
\\031\000\187\000\032\000\187\000\035\000\187\000\036\000\187\000\
\\038\000\187\000\039\000\187\000\043\000\187\000\044\000\187\000\
\\045\000\187\000\000\000\
\\001\000\001\000\188\000\005\000\188\000\007\000\188\000\009\000\188\000\
\\011\000\188\000\013\000\188\000\026\000\188\000\027\000\188\000\
\\031\000\188\000\032\000\188\000\035\000\188\000\036\000\188\000\
\\038\000\188\000\039\000\188\000\043\000\188\000\044\000\188\000\
\\045\000\188\000\000\000\
\\001\000\002\000\018\000\003\000\017\000\004\000\016\000\008\000\015\000\
\\009\000\178\000\016\000\014\000\030\000\013\000\033\000\012\000\
\\034\000\011\000\037\000\010\000\041\000\009\000\042\000\008\000\000\000\
\\001\000\002\000\018\000\003\000\017\000\004\000\016\000\008\000\015\000\
\\009\000\038\000\016\000\014\000\030\000\013\000\033\000\012\000\
\\034\000\011\000\037\000\010\000\041\000\009\000\042\000\008\000\000\000\
\\001\000\002\000\018\000\003\000\017\000\004\000\016\000\008\000\015\000\
\\016\000\014\000\030\000\013\000\033\000\012\000\034\000\011\000\
\\037\000\010\000\041\000\009\000\042\000\008\000\000\000\
\\001\000\002\000\033\000\000\000\
\\001\000\002\000\042\000\000\000\
\\001\000\002\000\049\000\000\000\
\\001\000\002\000\050\000\000\000\
\\001\000\002\000\051\000\000\000\
\\001\000\002\000\059\000\000\000\
\\001\000\002\000\059\000\013\000\058\000\000\000\
\\001\000\002\000\083\000\012\000\082\000\029\000\081\000\000\000\
\\001\000\002\000\085\000\003\000\017\000\004\000\016\000\008\000\015\000\
\\016\000\014\000\030\000\013\000\033\000\012\000\034\000\011\000\
\\037\000\010\000\041\000\009\000\042\000\008\000\000\000\
\\001\000\002\000\086\000\000\000\
\\001\000\002\000\088\000\009\000\146\000\000\000\
\\001\000\002\000\088\000\009\000\146\000\013\000\146\000\000\000\
\\001\000\002\000\088\000\013\000\146\000\000\000\
\\001\000\002\000\093\000\003\000\017\000\004\000\016\000\008\000\015\000\
\\016\000\014\000\030\000\013\000\033\000\012\000\034\000\011\000\
\\037\000\010\000\041\000\009\000\042\000\008\000\000\000\
\\001\000\002\000\107\000\000\000\
\\001\000\002\000\111\000\003\000\017\000\004\000\016\000\008\000\015\000\
\\016\000\014\000\030\000\013\000\033\000\012\000\034\000\011\000\
\\037\000\010\000\041\000\009\000\042\000\008\000\000\000\
\\001\000\002\000\114\000\000\000\
\\001\000\002\000\121\000\000\000\
\\001\000\005\000\184\000\008\000\040\000\010\000\106\000\012\000\039\000\
\\013\000\184\000\014\000\184\000\026\000\184\000\027\000\184\000\
\\028\000\184\000\000\000\
\\001\000\005\000\076\000\007\000\075\000\009\000\179\000\000\000\
\\001\000\005\000\105\000\013\000\189\000\000\000\
\\001\000\005\000\122\000\009\000\147\000\013\000\147\000\000\000\
\\001\000\006\000\067\000\028\000\066\000\000\000\
\\001\000\006\000\102\000\000\000\
\\001\000\006\000\113\000\019\000\112\000\000\000\
\\001\000\007\000\056\000\009\000\055\000\000\000\
\\001\000\007\000\078\000\009\000\182\000\039\000\182\000\000\000\
\\001\000\008\000\040\000\010\000\099\000\012\000\039\000\014\000\184\000\
\\026\000\184\000\027\000\184\000\028\000\184\000\038\000\184\000\
\\043\000\184\000\044\000\184\000\045\000\184\000\000\000\
\\001\000\008\000\040\000\010\000\119\000\012\000\039\000\014\000\184\000\
\\026\000\184\000\027\000\184\000\028\000\184\000\038\000\184\000\
\\043\000\184\000\044\000\184\000\045\000\184\000\000\000\
\\001\000\008\000\068\000\000\000\
\\001\000\009\000\148\000\013\000\148\000\000\000\
\\001\000\009\000\180\000\000\000\
\\001\000\009\000\181\000\000\000\
\\001\000\009\000\183\000\039\000\183\000\000\000\
\\001\000\009\000\077\000\000\000\
\\001\000\009\000\091\000\000\000\
\\001\000\009\000\101\000\000\000\
\\001\000\011\000\062\000\000\000\
\\001\000\011\000\118\000\000\000\
\\001\000\011\000\124\000\000\000\
\\001\000\011\000\131\000\000\000\
\\001\000\013\000\190\000\000\000\
\\001\000\013\000\191\000\000\000\
\\001\000\013\000\073\000\000\000\
\\001\000\013\000\108\000\000\000\
\\001\000\019\000\065\000\000\000\
\\001\000\019\000\074\000\000\000\
\\001\000\019\000\127\000\000\000\
\\001\000\028\000\052\000\000\000\
\\001\000\028\000\100\000\000\000\
\\001\000\031\000\054\000\000\000\
\\001\000\035\000\089\000\000\000\
\\001\000\036\000\053\000\000\000\
\\001\000\036\000\115\000\000\000\
\\001\000\038\000\137\000\043\000\032\000\044\000\031\000\045\000\030\000\000\000\
\\001\000\038\000\138\000\000\000\
\\001\000\038\000\139\000\043\000\139\000\044\000\139\000\045\000\139\000\000\000\
\\001\000\038\000\140\000\043\000\140\000\044\000\140\000\045\000\140\000\000\000\
\\001\000\038\000\141\000\043\000\141\000\044\000\141\000\045\000\141\000\000\000\
\\001\000\038\000\142\000\043\000\142\000\044\000\142\000\045\000\142\000\000\000\
\\001\000\038\000\143\000\043\000\143\000\044\000\143\000\045\000\143\000\000\000\
\\001\000\038\000\144\000\043\000\144\000\044\000\144\000\045\000\144\000\000\000\
\\001\000\038\000\145\000\043\000\145\000\044\000\145\000\045\000\145\000\000\000\
\\001\000\038\000\149\000\043\000\149\000\044\000\149\000\045\000\149\000\000\000\
\\001\000\038\000\150\000\043\000\150\000\044\000\150\000\045\000\150\000\000\000\
\\001\000\038\000\151\000\043\000\151\000\044\000\151\000\045\000\151\000\000\000\
\\001\000\038\000\152\000\043\000\152\000\044\000\152\000\045\000\152\000\000\000\
\\001\000\038\000\153\000\043\000\153\000\044\000\153\000\045\000\153\000\000\000\
\\001\000\038\000\154\000\043\000\154\000\044\000\154\000\045\000\154\000\000\000\
\\001\000\038\000\048\000\000\000\
\\001\000\039\000\079\000\000\000\
\\001\000\040\000\097\000\000\000\
\\001\000\040\000\125\000\000\000\
\\001\000\040\000\129\000\000\000\
\\001\000\040\000\134\000\000\000\
\\001\000\043\000\032\000\044\000\031\000\045\000\030\000\000\000\
\"
val actionRowNumbers =
"\031\000\015\000\019\000\006\000\
\\002\000\001\000\016\000\021\000\
\\107\000\032\000\031\000\031\000\
\\031\000\030\000\013\000\012\000\
\\024\000\031\000\033\000\031\000\
\\031\000\031\000\031\000\090\000\
\\089\000\088\000\086\000\101\000\
\\034\000\035\000\036\000\080\000\
\\084\000\082\000\018\000\057\000\
\\022\000\038\000\029\000\020\000\
\\025\000\069\000\003\000\005\000\
\\004\000\087\000\031\000\077\000\
\\054\000\061\000\031\000\031\000\
\\031\000\023\000\031\000\075\000\
\\027\000\078\000\051\000\066\000\
\\026\000\058\000\102\000\039\000\
\\040\000\041\000\042\000\083\000\
\\008\000\010\000\067\000\028\000\
\\045\000\029\000\029\000\014\000\
\\031\000\007\000\091\000\103\000\
\\044\000\092\000\095\000\059\000\
\\081\000\068\000\055\000\031\000\
\\031\000\017\000\052\000\050\000\
\\063\000\064\000\065\000\046\000\
\\076\000\031\000\047\000\056\000\
\\048\000\085\000\011\000\037\000\
\\031\000\094\000\093\000\070\000\
\\097\000\060\000\031\000\049\000\
\\053\000\031\000\074\000\071\000\
\\104\000\031\000\099\000\079\000\
\\043\000\009\000\105\000\031\000\
\\072\000\031\000\062\000\031\000\
\\096\000\106\000\100\000\073\000\
\\031\000\098\000\000\000"
val gotoT =
"\
\\010\000\005\000\011\000\004\000\012\000\003\000\013\000\134\000\
\\014\000\002\000\015\000\001\000\000\000\
\\000\000\
\\000\000\
\\016\000\020\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\001\000\027\000\002\000\026\000\003\000\025\000\006\000\024\000\
\\007\000\023\000\000\000\
\\000\000\
\\010\000\032\000\011\000\004\000\012\000\003\000\014\000\002\000\
\\015\000\001\000\000\000\
\\010\000\033\000\011\000\004\000\012\000\003\000\014\000\002\000\
\\015\000\001\000\000\000\
\\010\000\034\000\011\000\004\000\012\000\003\000\014\000\002\000\
\\015\000\001\000\000\000\
\\010\000\035\000\011\000\004\000\012\000\003\000\014\000\002\000\
\\015\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\010\000\039\000\011\000\004\000\012\000\003\000\014\000\002\000\
\\015\000\001\000\000\000\
\\000\000\
\\010\000\041\000\011\000\004\000\012\000\003\000\014\000\002\000\
\\015\000\001\000\000\000\
\\010\000\042\000\011\000\004\000\012\000\003\000\014\000\002\000\
\\015\000\001\000\000\000\
\\010\000\043\000\011\000\004\000\012\000\003\000\014\000\002\000\
\\015\000\001\000\000\000\
\\010\000\044\000\011\000\004\000\012\000\003\000\014\000\002\000\
\\015\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\001\000\045\000\002\000\026\000\003\000\025\000\006\000\024\000\
\\007\000\023\000\000\000\
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
\\019\000\055\000\000\000\
\\008\000\059\000\010\000\058\000\011\000\004\000\012\000\003\000\
\\014\000\002\000\015\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\009\000\062\000\010\000\061\000\011\000\004\000\012\000\003\000\
\\014\000\002\000\015\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\010\000\067\000\011\000\004\000\012\000\003\000\014\000\002\000\
\\015\000\001\000\000\000\
\\010\000\068\000\011\000\004\000\012\000\003\000\014\000\002\000\
\\015\000\001\000\000\000\
\\010\000\069\000\011\000\004\000\012\000\003\000\014\000\002\000\
\\015\000\001\000\000\000\
\\000\000\
\\009\000\070\000\010\000\061\000\011\000\004\000\012\000\003\000\
\\014\000\002\000\015\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\004\000\078\000\000\000\
\\010\000\082\000\011\000\004\000\012\000\003\000\014\000\002\000\
\\015\000\001\000\000\000\
\\000\000\
\\005\000\085\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\010\000\090\000\011\000\004\000\012\000\003\000\014\000\002\000\
\\015\000\001\000\000\000\
\\008\000\092\000\010\000\058\000\011\000\004\000\012\000\003\000\
\\014\000\002\000\015\000\001\000\000\000\
\\008\000\093\000\010\000\058\000\011\000\004\000\012\000\003\000\
\\014\000\002\000\015\000\001\000\000\000\
\\000\000\
\\009\000\094\000\010\000\061\000\011\000\004\000\012\000\003\000\
\\014\000\002\000\015\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\005\000\096\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\010\000\101\000\011\000\004\000\012\000\003\000\014\000\002\000\
\\015\000\001\000\000\000\
\\010\000\102\000\011\000\004\000\012\000\003\000\014\000\002\000\
\\015\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\010\000\107\000\011\000\004\000\012\000\003\000\014\000\002\000\
\\015\000\001\000\000\000\
\\010\000\108\000\011\000\004\000\012\000\003\000\014\000\002\000\
\\015\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\019\000\114\000\000\000\
\\010\000\115\000\011\000\004\000\012\000\003\000\014\000\002\000\
\\015\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\010\000\118\000\011\000\004\000\012\000\003\000\014\000\002\000\
\\015\000\001\000\000\000\
\\000\000\
\\000\000\
\\010\000\121\000\011\000\004\000\012\000\003\000\014\000\002\000\
\\015\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\010\000\124\000\011\000\004\000\012\000\003\000\014\000\002\000\
\\015\000\001\000\000\000\
\\000\000\
\\000\000\
\\005\000\126\000\000\000\
\\000\000\
\\000\000\
\\010\000\128\000\011\000\004\000\012\000\003\000\014\000\002\000\
\\015\000\001\000\000\000\
\\000\000\
\\010\000\130\000\011\000\004\000\012\000\003\000\014\000\002\000\
\\015\000\001\000\000\000\
\\000\000\
\\010\000\131\000\011\000\004\000\012\000\003\000\014\000\002\000\
\\015\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\010\000\133\000\011\000\004\000\012\000\003\000\014\000\002\000\
\\015\000\001\000\000\000\
\\000\000\
\\000\000\
\"
val numstates = 135
val numrules = 55
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
 | ID of unit ->  (string) | ifThenElseExp of unit ->  (A.exp)
 | notIfThenElseExp of unit ->  (A.exp)
 | unmatchedIfThenElseExp of unit ->  (A.exp)
 | matchedIfThenElseExp of unit ->  (A.exp)
 | recordList of unit ->  ( ( A.symbol * A.exp * A.pos )  list)
 | comparisonOper of unit ->  (A.oper)
 | arithmeticOper of unit ->  (A.oper) | oper of unit ->  (A.oper)
 | lvalue of unit ->  (A.var) | recordExp of unit ->  (A.exp)
 | startExp of unit ->  (A.exp) | atomExp of unit ->  (A.exp)
 | exp0 of unit ->  (A.exp) | exp of unit ->  (A.exp)
 | letExps of unit ->  ( ( A.exp * A.pos )  list)
 | exps of unit ->  (A.exp list) | fundec of unit ->  (A.dec)
 | vardec of unit ->  (A.dec) | tyfields of unit ->  (A.field list)
 | ty of unit ->  (A.ty) | tydec of unit ->  (A.dec)
 | dec of unit ->  (A.dec) | decs of unit ->  (A.dec list)
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
fn _ => MlyValue.VOID
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
) => let val  result = MlyValue.decs (fn _ => let val  (dec as dec1) =
 dec1 ()
 in (dec::nil)
end)
 in ( LrTable.NT 0, ( result, dec1left, dec1right), rest671)
end
|  ( 1, ( ( _, ( MlyValue.decs decs1, _, decs1right)) :: ( _, ( 
MlyValue.dec dec1, dec1left, _)) :: rest671)) => let val  result = 
MlyValue.decs (fn _ => let val  (dec as dec1) = dec1 ()
 val  (decs as decs1) = decs1 ()
 in (dec::decs)
end)
 in ( LrTable.NT 0, ( result, dec1left, decs1right), rest671)
end
|  ( 2, ( ( _, ( MlyValue.tydec tydec1, tydec1left, tydec1right)) :: 
rest671)) => let val  result = MlyValue.dec (fn _ => let val  (tydec
 as tydec1) = tydec1 ()
 in (tydec)
end)
 in ( LrTable.NT 1, ( result, tydec1left, tydec1right), rest671)
end
|  ( 3, ( ( _, ( MlyValue.vardec vardec1, vardec1left, vardec1right))
 :: rest671)) => let val  result = MlyValue.dec (fn _ => let val  (
vardec as vardec1) = vardec1 ()
 in (vardec)
end)
 in ( LrTable.NT 1, ( result, vardec1left, vardec1right), rest671)
end
|  ( 4, ( ( _, ( MlyValue.fundec fundec1, fundec1left, fundec1right))
 :: rest671)) => let val  result = MlyValue.dec (fn _ => let val  (
fundec as fundec1) = fundec1 ()
 in (fundec)
end)
 in ( LrTable.NT 1, ( result, fundec1left, fundec1right), rest671)
end
|  ( 5, ( ( _, ( MlyValue.ty ty1, _, ty1right)) :: _ :: ( _, ( 
MlyValue.ID ID1, _, _)) :: ( _, ( _, (TYPEleft as TYPE1left), _)) :: 
rest671)) => let val  result = MlyValue.tydec (fn _ => let val  (ID
 as ID1) = ID1 ()
 val  (ty as ty1) = ty1 ()
 in (A.TypeDec([{name=Symbol.symbol(ID), ty=ty, pos=TYPEleft}]))
end)
 in ( LrTable.NT 2, ( result, TYPE1left, ty1right), rest671)
end
|  ( 6, ( ( _, ( MlyValue.ID ID1, (IDleft as ID1left), ID1right)) :: 
rest671)) => let val  result = MlyValue.ty (fn _ => let val  (ID as 
ID1) = ID1 ()
 in (A.NameTy(Symbol.symbol(ID), IDleft))
end)
 in ( LrTable.NT 3, ( result, ID1left, ID1right), rest671)
end
|  ( 7, ( ( _, ( _, _, RBRACE1right)) :: ( _, ( MlyValue.tyfields 
tyfields1, _, _)) :: ( _, ( _, LBRACE1left, _)) :: rest671)) => let
 val  result = MlyValue.ty (fn _ => let val  (tyfields as tyfields1) =
 tyfields1 ()
 in (A.RecordTy(tyfields))
end)
 in ( LrTable.NT 3, ( result, LBRACE1left, RBRACE1right), rest671)
end
|  ( 8, ( ( _, ( MlyValue.ID ID1, _, ID1right)) :: _ :: ( _, ( _, (
ARRAYleft as ARRAY1left), _)) :: rest671)) => let val  result = 
MlyValue.ty (fn _ => let val  (ID as ID1) = ID1 ()
 in (A.ArrayTy(Symbol.symbol(ID), ARRAYleft))
end)
 in ( LrTable.NT 3, ( result, ARRAY1left, ID1right), rest671)
end
|  ( 9, ( rest671)) => let val  result = MlyValue.tyfields (fn _ => (
[]))
 in ( LrTable.NT 4, ( result, defaultPos, defaultPos), rest671)
end
|  ( 10, ( ( _, ( MlyValue.ID ID2, _, ID2right)) :: _ :: ( _, ( 
MlyValue.ID ID1, ID1left, _)) :: rest671)) => let val  result = 
MlyValue.tyfields (fn _ => let val  ID1 = ID1 ()
 val  ID2 = ID2 ()
 in (
[{name=Symbol.symbol(ID1), escape=ref false, typ=Symbol.symbol(ID2), pos=ID1left}]
)
end)
 in ( LrTable.NT 4, ( result, ID1left, ID2right), rest671)
end
|  ( 11, ( ( _, ( MlyValue.tyfields tyfields1, _, tyfields1right)) ::
 _ :: ( _, ( MlyValue.ID ID2, _, _)) :: _ :: ( _, ( MlyValue.ID ID1, 
ID1left, _)) :: rest671)) => let val  result = MlyValue.tyfields (fn _
 => let val  ID1 = ID1 ()
 val  ID2 = ID2 ()
 val  (tyfields as tyfields1) = tyfields1 ()
 in (
{name=Symbol.symbol(ID1), escape=ref false, typ=Symbol.symbol(ID2), pos=ID1left}::tyfields
)
end)
 in ( LrTable.NT 4, ( result, ID1left, tyfields1right), rest671)
end
|  ( 12, ( ( _, ( MlyValue.exp exp1, _, exp1right)) :: _ :: ( _, ( 
MlyValue.ID ID1, _, _)) :: ( _, ( _, (VARleft as VAR1left), _)) :: 
rest671)) => let val  result = MlyValue.vardec (fn _ => let val  (ID
 as ID1) = ID1 ()
 val  (exp as exp1) = exp1 ()
 in (
A.VarDec({name=Symbol.symbol(ID), escape=ref false, typ=NONE, init=exp, pos=VARleft})
)
end)
 in ( LrTable.NT 5, ( result, VAR1left, exp1right), rest671)
end
|  ( 13, ( ( _, ( MlyValue.exp exp2, _, exp2right)) :: _ :: _ :: ( _, 
( MlyValue.exp exp1, _, _)) :: _ :: ( _, ( MlyValue.ID ID2, ID2left, _
)) :: _ :: ( _, ( MlyValue.ID ID1, _, _)) :: ( _, ( _, (VARleft as 
VAR1left), _)) :: rest671)) => let val  result = MlyValue.vardec (fn _
 => let val  ID1 = ID1 ()
 val  ID2 = ID2 ()
 val  exp1 = exp1 ()
 val  exp2 = exp2 ()
 in (
A.VarDec({name=Symbol.symbol(ID1), escape=ref false, typ=NONE, init=A.ArrayExp({typ=Symbol.symbol(ID2), size=exp1, init=exp2, pos=ID2left}), pos=VARleft})
)
end)
 in ( LrTable.NT 5, ( result, VAR1left, exp2right), rest671)
end
|  ( 14, ( ( _, ( MlyValue.exp exp1, _, exp1right)) :: _ :: ( _, ( 
MlyValue.ID ID2, ID2left, _)) :: _ :: ( _, ( MlyValue.ID ID1, _, _))
 :: ( _, ( _, (VARleft as VAR1left), _)) :: rest671)) => let val  
result = MlyValue.vardec (fn _ => let val  ID1 = ID1 ()
 val  ID2 = ID2 ()
 val  (exp as exp1) = exp1 ()
 in (
A.VarDec({name=Symbol.symbol(ID1), escape=ref false, typ=SOME((Symbol.symbol(ID2), ID2left)), init=exp, pos=VARleft})
)
end)
 in ( LrTable.NT 5, ( result, VAR1left, exp1right), rest671)
end
|  ( 15, ( ( _, ( MlyValue.exp exp2, _, exp2right)) :: _ :: _ :: ( _, 
( MlyValue.exp exp1, _, _)) :: _ :: ( _, ( MlyValue.ID ID3, ID3left, _
)) :: _ :: ( _, ( MlyValue.ID ID2, ID2left, _)) :: _ :: ( _, ( 
MlyValue.ID ID1, _, _)) :: ( _, ( _, (VARleft as VAR1left), _)) :: 
rest671)) => let val  result = MlyValue.vardec (fn _ => let val  ID1 =
 ID1 ()
 val  ID2 = ID2 ()
 val  ID3 = ID3 ()
 val  exp1 = exp1 ()
 val  exp2 = exp2 ()
 in (
A.VarDec({name=Symbol.symbol(ID1), escape=ref false, typ=SOME((Symbol.symbol(ID2), ID2left)), init=A.ArrayExp({typ=Symbol.symbol(ID3), size=exp1, init=exp2, pos=ID3left}), pos=VARleft}) 
)
end)
 in ( LrTable.NT 5, ( result, VAR1left, exp2right), rest671)
end
|  ( 16, ( ( _, ( MlyValue.exp exp1, _, exp1right)) :: _ :: _ :: ( _, 
( MlyValue.tyfields tyfields1, _, _)) :: _ :: ( _, ( MlyValue.ID ID1,
 _, _)) :: ( _, ( _, (FUNCTIONleft as FUNCTION1left), _)) :: rest671))
 => let val  result = MlyValue.fundec (fn _ => let val  (ID as ID1) = 
ID1 ()
 val  (tyfields as tyfields1) = tyfields1 ()
 val  (exp as exp1) = exp1 ()
 in (
A.FunctionDec([{name=Symbol.symbol(ID), params=tyfields, result=NONE, body=exp, pos=FUNCTIONleft}])
)
end)
 in ( LrTable.NT 6, ( result, FUNCTION1left, exp1right), rest671)
end
|  ( 17, ( ( _, ( MlyValue.exp exp1, _, exp1right)) :: _ :: ( _, ( 
MlyValue.ID ID2, ID2left, _)) :: _ :: _ :: ( _, ( MlyValue.tyfields 
tyfields1, _, _)) :: _ :: ( _, ( MlyValue.ID ID1, _, _)) :: ( _, ( _,
 (FUNCTIONleft as FUNCTION1left), _)) :: rest671)) => let val  result
 = MlyValue.fundec (fn _ => let val  ID1 = ID1 ()
 val  (tyfields as tyfields1) = tyfields1 ()
 val  ID2 = ID2 ()
 val  (exp as exp1) = exp1 ()
 in (
A.FunctionDec([{name=Symbol.symbol(ID1), params=tyfields, result=SOME((Symbol.symbol(ID2), ID2left)), body=exp, pos=FUNCTIONleft}])
)
end)
 in ( LrTable.NT 6, ( result, FUNCTION1left, exp1right), rest671)
end
|  ( 18, ( ( _, ( MlyValue.exp exp1, exp1left, exp1right)) :: rest671)
) => let val  result = MlyValue.startExp (fn _ => let val  (exp as 
exp1) = exp1 ()
 in (exp)
end)
 in ( LrTable.NT 12, ( result, exp1left, exp1right), rest671)
end
|  ( 19, ( ( _, ( MlyValue.exp0 exp01, exp01left, exp01right)) :: 
rest671)) => let val  result = MlyValue.exp (fn _ => let val  (exp0
 as exp01) = exp01 ()
 in (exp0)
end)
 in ( LrTable.NT 9, ( result, exp01left, exp01right), rest671)
end
|  ( 20, ( ( _, ( MlyValue.exp exp1, _, exp1right)) :: ( _, ( 
MlyValue.oper oper1, _, _)) :: ( _, ( MlyValue.atomExp atomExp1, (
atomExpleft as atomExp1left), _)) :: rest671)) => let val  result = 
MlyValue.exp (fn _ => let val  (atomExp as atomExp1) = atomExp1 ()
 val  (oper as oper1) = oper1 ()
 val  (exp as exp1) = exp1 ()
 in (A.OpExp({left=atomExp, oper=oper, right=exp, pos=atomExpleft}))

end)
 in ( LrTable.NT 9, ( result, atomExp1left, exp1right), rest671)
end
|  ( 21, ( ( _, ( MlyValue.exp exp1, _, exp1right)) :: _ :: ( _, ( 
MlyValue.atomExp atomExp1, (atomExpleft as atomExp1left), _)) :: 
rest671)) => let val  result = MlyValue.exp (fn _ => let val  (atomExp
 as atomExp1) = atomExp1 ()
 val  (exp as exp1) = exp1 ()
 in (
A.IfExp({test=atomExp, then'= exp, else'= SOME(A.IntExp(0)), pos=atomExpleft})
)
end)
 in ( LrTable.NT 9, ( result, atomExp1left, exp1right), rest671)
end
|  ( 22, ( ( _, ( MlyValue.exp exp1, _, exp1right)) :: _ :: ( _, ( 
MlyValue.atomExp atomExp1, (atomExpleft as atomExp1left), _)) :: 
rest671)) => let val  result = MlyValue.exp (fn _ => let val  (atomExp
 as atomExp1) = atomExp1 ()
 val  (exp as exp1) = exp1 ()
 in (
A.IfExp({test=atomExp, then'= A.IntExp(1), else'= SOME(exp), pos=atomExpleft})
)
end)
 in ( LrTable.NT 9, ( result, atomExp1left, exp1right), rest671)
end
|  ( 23, ( ( _, ( MlyValue.atomExp atomExp1, atomExp1left, 
atomExp1right)) :: rest671)) => let val  result = MlyValue.exp0 (fn _
 => let val  (atomExp as atomExp1) = atomExp1 ()
 in (atomExp)
end)
 in ( LrTable.NT 10, ( result, atomExp1left, atomExp1right), rest671)

end
|  ( 24, ( ( _, ( _, _, END1right)) :: ( _, ( MlyValue.letExps 
letExps1, _, _)) :: _ :: ( _, ( MlyValue.decs decs1, _, _)) :: ( _, (
 _, (LETleft as LET1left), _)) :: rest671)) => let val  result = 
MlyValue.exp0 (fn _ => let val  (decs as decs1) = decs1 ()
 val  (letExps as letExps1) = letExps1 ()
 in (A.LetExp({decs=decs, body=A.SeqExp(letExps), pos=LETleft}))
end)
 in ( LrTable.NT 10, ( result, LET1left, END1right), rest671)
end
|  ( 25, ( ( _, ( MlyValue.exp exp2, _, exp2right)) :: _ :: ( _, ( 
MlyValue.exp exp1, _, _)) :: ( _, ( _, (WHILEleft as WHILE1left), _))
 :: rest671)) => let val  result = MlyValue.exp0 (fn _ => let val  (
exp as exp1) = exp1 ()
 val  exp2 = exp2 ()
 in (A.WhileExp({test=exp, body=exp, pos=WHILEleft}))
end)
 in ( LrTable.NT 10, ( result, WHILE1left, exp2right), rest671)
end
|  ( 26, ( ( _, ( MlyValue.exp exp3, _, exp3right)) :: _ :: ( _, ( 
MlyValue.exp exp2, _, _)) :: _ :: ( _, ( MlyValue.exp exp1, _, _)) ::
 _ :: ( _, ( MlyValue.ID ID1, _, _)) :: ( _, ( _, (FORleft as FOR1left
), _)) :: rest671)) => let val  result = MlyValue.exp0 (fn _ => let
 val  (ID as ID1) = ID1 ()
 val  (exp as exp1) = exp1 ()
 val  exp2 = exp2 ()
 val  exp3 = exp3 ()
 in (
A.ForExp({var=Symbol.symbol(ID), escape=ref false, lo=exp1, hi=exp2, body=exp, pos=FORleft})
)
end)
 in ( LrTable.NT 10, ( result, FOR1left, exp3right), rest671)
end
|  ( 27, ( ( _, ( MlyValue.exp exp2, _, exp2right)) :: _ :: ( _, ( 
MlyValue.exp exp1, _, _)) :: ( _, ( _, (IFleft as IF1left), _)) :: 
rest671)) => let val  result = MlyValue.exp0 (fn _ => let val  exp1 = 
exp1 ()
 val  exp2 = exp2 ()
 in (A.IfExp({test=exp1, then'=exp2, else'=NONE, pos= IFleft}))
end)
 in ( LrTable.NT 10, ( result, IF1left, exp2right), rest671)
end
|  ( 28, ( ( _, ( MlyValue.exp exp3, _, exp3right)) :: _ :: ( _, ( 
MlyValue.exp exp2, _, _)) :: _ :: ( _, ( MlyValue.exp exp1, _, _)) :: 
( _, ( _, (IFleft as IF1left), _)) :: rest671)) => let val  result = 
MlyValue.exp0 (fn _ => let val  exp1 = exp1 ()
 val  exp2 = exp2 ()
 val  exp3 = exp3 ()
 in (A.IfExp({test=exp1, then'=exp2, else'=SOME(exp3), pos= IFleft}))

end)
 in ( LrTable.NT 10, ( result, IF1left, exp3right), rest671)
end
|  ( 29, ( ( _, ( MlyValue.INT INT1, INT1left, INT1right)) :: rest671)
) => let val  result = MlyValue.atomExp (fn _ => let val  (INT as INT1
) = INT1 ()
 in (A.IntExp(INT))
end)
 in ( LrTable.NT 11, ( result, INT1left, INT1right), rest671)
end
|  ( 30, ( ( _, ( MlyValue.STRING STRING1, (STRINGleft as STRING1left)
, STRING1right)) :: rest671)) => let val  result = MlyValue.atomExp
 (fn _ => let val  (STRING as STRING1) = STRING1 ()
 in (A.StringExp(STRING, STRINGleft))
end)
 in ( LrTable.NT 11, ( result, STRING1left, STRING1right), rest671)

end
|  ( 31, ( ( _, ( _, _, RPAREN1right)) :: ( _, ( MlyValue.exps exps1,
 _, _)) :: _ :: ( _, ( MlyValue.ID ID1, (IDleft as ID1left), _)) :: 
rest671)) => let val  result = MlyValue.atomExp (fn _ => let val  (ID
 as ID1) = ID1 ()
 val  (exps as exps1) = exps1 ()
 in (A.CallExp({func=Symbol.symbol(ID), args=exps, pos=IDleft}))
end)
 in ( LrTable.NT 11, ( result, ID1left, RPAREN1right), rest671)
end
|  ( 32, ( ( _, ( MlyValue.lvalue lvalue1, lvalue1left, lvalue1right))
 :: rest671)) => let val  result = MlyValue.atomExp (fn _ => let val 
 (lvalue as lvalue1) = lvalue1 ()
 in (A.VarExp(lvalue))
end)
 in ( LrTable.NT 11, ( result, lvalue1left, lvalue1right), rest671)

end
|  ( 33, ( ( _, ( _, NIL1left, NIL1right)) :: rest671)) => let val  
result = MlyValue.atomExp (fn _ => (A.NilExp))
 in ( LrTable.NT 11, ( result, NIL1left, NIL1right), rest671)
end
|  ( 34, ( ( _, ( _, _, RPAREN1right)) :: ( _, ( MlyValue.letExps 
letExps1, _, _)) :: _ :: ( _, ( MlyValue.exp exp1, _, _)) :: ( _, ( _,
 (LPARENleft as LPAREN1left), _)) :: rest671)) => let val  result = 
MlyValue.atomExp (fn _ => let val  (exp as exp1) = exp1 ()
 val  (letExps as letExps1) = letExps1 ()
 in (A.SeqExp((exp, LPARENleft)::letExps))
end)
 in ( LrTable.NT 11, ( result, LPAREN1left, RPAREN1right), rest671)

end
|  ( 35, ( ( _, ( MlyValue.exp exp1, _, exp1right)) :: ( _, ( _, (
MINUSleft as MINUS1left), _)) :: rest671)) => let val  result = 
MlyValue.atomExp (fn _ => let val  (exp as exp1) = exp1 ()
 in (
A.OpExp({left=A.IntExp(0), oper=A.MinusOp, right=exp, pos=MINUSleft}))

end)
 in ( LrTable.NT 11, ( result, MINUS1left, exp1right), rest671)
end
|  ( 36, ( ( _, ( MlyValue.recordExp recordExp1, recordExp1left, 
recordExp1right)) :: rest671)) => let val  result = MlyValue.atomExp
 (fn _ => let val  (recordExp as recordExp1) = recordExp1 ()
 in (recordExp)
end)
 in ( LrTable.NT 11, ( result, recordExp1left, recordExp1right), 
rest671)
end
|  ( 37, ( ( _, ( MlyValue.exp exp1, _, exp1right)) :: _ :: ( _, ( 
MlyValue.lvalue lvalue1, (lvalueleft as lvalue1left), _)) :: rest671))
 => let val  result = MlyValue.atomExp (fn _ => let val  (lvalue as 
lvalue1) = lvalue1 ()
 val  (exp as exp1) = exp1 ()
 in (A.AssignExp({var=lvalue, exp=exp, pos=lvalueleft}))
end)
 in ( LrTable.NT 11, ( result, lvalue1left, exp1right), rest671)
end
|  ( 38, ( ( _, ( _, (BREAKleft as BREAK1left), BREAK1right)) :: 
rest671)) => let val  result = MlyValue.atomExp (fn _ => (
A.BreakExp(BREAKleft)))
 in ( LrTable.NT 11, ( result, BREAK1left, BREAK1right), rest671)
end
|  ( 39, ( ( _, ( _, _, RPAREN1right)) :: ( _, ( _, LPAREN1left, _))
 :: rest671)) => let val  result = MlyValue.atomExp (fn _ => (A.NilExp
))
 in ( LrTable.NT 11, ( result, LPAREN1left, RPAREN1right), rest671)

end
|  ( 40, ( ( _, ( _, _, RPAREN1right)) :: ( _, ( MlyValue.exp exp1, _,
 _)) :: ( _, ( _, LPAREN1left, _)) :: rest671)) => let val  result = 
MlyValue.atomExp (fn _ => let val  (exp as exp1) = exp1 ()
 in (exp)
end)
 in ( LrTable.NT 11, ( result, LPAREN1left, RPAREN1right), rest671)

end
|  ( 41, ( rest671)) => let val  result = MlyValue.exps (fn _ => (nil)
)
 in ( LrTable.NT 7, ( result, defaultPos, defaultPos), rest671)
end
|  ( 42, ( ( _, ( MlyValue.exp exp1, exp1left, exp1right)) :: rest671)
) => let val  result = MlyValue.exps (fn _ => let val  (exp as exp1) =
 exp1 ()
 in (exp::nil)
end)
 in ( LrTable.NT 7, ( result, exp1left, exp1right), rest671)
end
|  ( 43, ( ( _, ( MlyValue.exps exps1, _, exps1right)) :: _ :: ( _, ( 
MlyValue.exp exp1, exp1left, _)) :: rest671)) => let val  result = 
MlyValue.exps (fn _ => let val  (exp as exp1) = exp1 ()
 val  (exps as exps1) = exps1 ()
 in (exp::exps)
end)
 in ( LrTable.NT 7, ( result, exp1left, exps1right), rest671)
end
|  ( 44, ( ( _, ( MlyValue.exps exps1, _, exps1right)) :: _ :: ( _, ( 
MlyValue.exp exp1, exp1left, _)) :: rest671)) => let val  result = 
MlyValue.exps (fn _ => let val  (exp as exp1) = exp1 ()
 val  (exps as exps1) = exps1 ()
 in (exp::exps)
end)
 in ( LrTable.NT 7, ( result, exp1left, exps1right), rest671)
end
|  ( 45, ( ( _, ( MlyValue.exp exp1, (expleft as exp1left), exp1right)
) :: rest671)) => let val  result = MlyValue.letExps (fn _ => let val 
 (exp as exp1) = exp1 ()
 in ((exp, expleft)::nil)
end)
 in ( LrTable.NT 8, ( result, exp1left, exp1right), rest671)
end
|  ( 46, ( ( _, ( MlyValue.letExps letExps1, _, letExps1right)) :: _
 :: ( _, ( MlyValue.exp exp1, (expleft as exp1left), _)) :: rest671))
 => let val  result = MlyValue.letExps (fn _ => let val  (exp as exp1)
 = exp1 ()
 val  (letExps as letExps1) = letExps1 ()
 in ((exp, expleft)::letExps)
end)
 in ( LrTable.NT 8, ( result, exp1left, letExps1right), rest671)
end
|  ( 47, ( ( _, ( MlyValue.ID ID1, (IDleft as ID1left), ID1right)) :: 
rest671)) => let val  result = MlyValue.lvalue (fn _ => let val  (ID
 as ID1) = ID1 ()
 in (A.SimpleVar(Symbol.symbol(ID) , IDleft))
end)
 in ( LrTable.NT 14, ( result, ID1left, ID1right), rest671)
end
|  ( 48, ( ( _, ( MlyValue.ID ID1, _, ID1right)) :: _ :: ( _, ( 
MlyValue.lvalue lvalue1, (lvalueleft as lvalue1left), _)) :: rest671))
 => let val  result = MlyValue.lvalue (fn _ => let val  (lvalue as 
lvalue1) = lvalue1 ()
 val  ID1 = ID1 ()
 in (A.FieldVar(lvalue, Symbol.symbol("a") , lvalueleft))
end)
 in ( LrTable.NT 14, ( result, lvalue1left, ID1right), rest671)
end
|  ( 49, ( ( _, ( _, _, RBRACK1right)) :: ( _, ( MlyValue.exp exp1, _,
 _)) :: _ :: ( _, ( MlyValue.lvalue lvalue1, (lvalueleft as 
lvalue1left), _)) :: rest671)) => let val  result = MlyValue.lvalue
 (fn _ => let val  (lvalue as lvalue1) = lvalue1 ()
 val  (exp as exp1) = exp1 ()
 in (A.SubscriptVar(lvalue, exp , lvalueleft))
end)
 in ( LrTable.NT 14, ( result, lvalue1left, RBRACK1right), rest671)

end
|  ( 50, ( ( _, ( _, _, RBRACE1right)) :: _ :: ( _, ( MlyValue.ID ID1,
 (IDleft as ID1left), _)) :: rest671)) => let val  result = 
MlyValue.recordExp (fn _ => let val  (ID as ID1) = ID1 ()
 in (A.RecordExp({fields=[], typ=Symbol.symbol(ID), pos=IDleft}))
end)
 in ( LrTable.NT 13, ( result, ID1left, RBRACE1right), rest671)
end
|  ( 51, ( ( _, ( _, _, RBRACE1right)) :: ( _, ( MlyValue.recordList 
recordList1, _, _)) :: _ :: ( _, ( MlyValue.ID ID1, (IDleft as ID1left
), _)) :: rest671)) => let val  result = MlyValue.recordExp (fn _ =>
 let val  (ID as ID1) = ID1 ()
 val  (recordList as recordList1) = recordList1 ()
 in (
A.RecordExp({fields=recordList, typ=Symbol.symbol(ID), pos=IDleft}))

end)
 in ( LrTable.NT 13, ( result, ID1left, RBRACE1right), rest671)
end
|  ( 52, ( ( _, ( MlyValue.exp exp1, _, exp1right)) :: _ :: ( _, ( 
MlyValue.ID ID1, (IDleft as ID1left), _)) :: rest671)) => let val  
result = MlyValue.recordList (fn _ => let val  (ID as ID1) = ID1 ()
 val  (exp as exp1) = exp1 ()
 in ([(Symbol.symbol(ID), exp, IDleft)])
end)
 in ( LrTable.NT 18, ( result, ID1left, exp1right), rest671)
end
|  ( 53, ( ( _, ( MlyValue.exp exp2, _, exp2right)) :: _ :: _ :: ( _, 
( MlyValue.exp exp1, _, _)) :: _ :: ( _, ( MlyValue.ID ID2, ID2left, _
)) :: _ :: ( _, ( MlyValue.ID ID1, ID1left, _)) :: rest671)) => let
 val  result = MlyValue.recordList (fn _ => let val  ID1 = ID1 ()
 val  ID2 = ID2 ()
 val  exp1 = exp1 ()
 val  exp2 = exp2 ()
 in (
[(Symbol.symbol(ID1), A.ArrayExp({typ=Symbol.symbol(ID2), size=exp1, init=exp2, pos=ID2left}), ID1left)]
)
end)
 in ( LrTable.NT 18, ( result, ID1left, exp2right), rest671)
end
|  ( 54, ( ( _, ( MlyValue.recordList recordList1, _, recordList1right
)) :: _ :: ( _, ( MlyValue.exp exp1, _, _)) :: _ :: ( _, ( MlyValue.ID
 ID1, (IDleft as ID1left), _)) :: rest671)) => let val  result = 
MlyValue.recordList (fn _ => let val  (ID as ID1) = ID1 ()
 val  (exp as exp1) = exp1 ()
 val  (recordList as recordList1) = recordList1 ()
 in ((Symbol.symbol(ID), exp, IDleft)::recordList)
end)
 in ( LrTable.NT 18, ( result, ID1left, recordList1right), rest671)

end
| _ => raise (mlyAction i392)
end
val void = MlyValue.VOID
val extract = fn a => (fn MlyValue.startExp x => x
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
