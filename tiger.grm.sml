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
\\001\000\001\000\172\000\005\000\172\000\007\000\172\000\009\000\172\000\
\\010\000\142\000\011\000\172\000\012\000\142\000\013\000\172\000\
\\015\000\172\000\016\000\172\000\017\000\172\000\018\000\172\000\
\\019\000\172\000\020\000\172\000\021\000\172\000\022\000\172\000\
\\023\000\172\000\024\000\172\000\026\000\172\000\027\000\172\000\
\\031\000\172\000\032\000\172\000\035\000\172\000\036\000\172\000\
\\038\000\172\000\039\000\172\000\043\000\172\000\044\000\172\000\
\\045\000\172\000\000\000\
\\001\000\002\000\018\000\003\000\017\000\004\000\016\000\008\000\015\000\
\\009\000\074\000\016\000\014\000\030\000\013\000\033\000\012\000\
\\034\000\011\000\037\000\010\000\041\000\009\000\042\000\008\000\000\000\
\\001\000\002\000\018\000\003\000\017\000\004\000\016\000\008\000\015\000\
\\016\000\014\000\030\000\013\000\033\000\012\000\034\000\011\000\
\\037\000\010\000\041\000\009\000\042\000\008\000\000\000\
\\001\000\002\000\055\000\000\000\
\\001\000\002\000\059\000\000\000\
\\001\000\002\000\065\000\000\000\
\\001\000\002\000\066\000\000\000\
\\001\000\003\000\064\000\000\000\
\\001\000\003\000\064\000\012\000\097\000\029\000\096\000\000\000\
\\001\000\006\000\082\000\028\000\081\000\000\000\
\\001\000\006\000\113\000\000\000\
\\001\000\006\000\121\000\019\000\120\000\000\000\
\\001\000\007\000\071\000\009\000\070\000\015\000\037\000\016\000\036\000\
\\017\000\035\000\018\000\034\000\019\000\033\000\020\000\032\000\
\\021\000\031\000\022\000\030\000\023\000\029\000\024\000\028\000\
\\026\000\027\000\027\000\026\000\000\000\
\\001\000\008\000\083\000\000\000\
\\001\000\009\000\090\000\000\000\
\\001\000\009\000\104\000\000\000\
\\001\000\009\000\112\000\000\000\
\\001\000\010\000\039\000\012\000\038\000\000\000\
\\001\000\011\000\075\000\015\000\037\000\016\000\036\000\017\000\035\000\
\\018\000\034\000\019\000\033\000\020\000\032\000\021\000\031\000\
\\022\000\030\000\023\000\029\000\024\000\028\000\026\000\027\000\
\\027\000\026\000\000\000\
\\001\000\011\000\078\000\015\000\037\000\016\000\036\000\017\000\035\000\
\\018\000\034\000\019\000\033\000\020\000\032\000\021\000\031\000\
\\022\000\030\000\023\000\029\000\024\000\028\000\026\000\027\000\
\\027\000\026\000\000\000\
\\001\000\013\000\076\000\000\000\
\\001\000\013\000\118\000\000\000\
\\001\000\015\000\037\000\016\000\036\000\017\000\035\000\018\000\034\000\
\\019\000\033\000\020\000\032\000\021\000\031\000\022\000\030\000\
\\023\000\029\000\024\000\028\000\026\000\027\000\027\000\026\000\000\000\
\\001\000\015\000\037\000\016\000\036\000\017\000\035\000\018\000\034\000\
\\019\000\033\000\020\000\032\000\021\000\031\000\022\000\030\000\
\\023\000\029\000\024\000\028\000\026\000\027\000\027\000\026\000\
\\031\000\069\000\000\000\
\\001\000\015\000\037\000\016\000\036\000\017\000\035\000\018\000\034\000\
\\019\000\033\000\020\000\032\000\021\000\031\000\022\000\030\000\
\\023\000\029\000\024\000\028\000\026\000\027\000\027\000\026\000\
\\035\000\067\000\000\000\
\\001\000\015\000\037\000\016\000\036\000\017\000\035\000\018\000\034\000\
\\019\000\033\000\020\000\032\000\021\000\031\000\022\000\030\000\
\\023\000\029\000\024\000\028\000\026\000\027\000\027\000\026\000\
\\036\000\068\000\000\000\
\\001\000\015\000\037\000\016\000\036\000\017\000\035\000\018\000\034\000\
\\019\000\033\000\020\000\032\000\021\000\031\000\022\000\030\000\
\\023\000\029\000\024\000\028\000\026\000\027\000\027\000\026\000\
\\036\000\102\000\000\000\
\\001\000\015\000\037\000\016\000\036\000\017\000\035\000\018\000\034\000\
\\019\000\033\000\020\000\032\000\021\000\031\000\022\000\030\000\
\\023\000\029\000\024\000\028\000\026\000\027\000\027\000\026\000\
\\039\000\093\000\000\000\
\\001\000\019\000\077\000\000\000\
\\001\000\019\000\080\000\000\000\
\\001\000\019\000\126\000\000\000\
\\001\000\028\000\111\000\000\000\
\\001\000\038\000\062\000\000\000\
\\001\000\040\000\092\000\000\000\
\\001\000\040\000\109\000\000\000\
\\001\000\043\000\047\000\044\000\046\000\045\000\045\000\000\000\
\\130\000\043\000\047\000\044\000\046\000\045\000\045\000\000\000\
\\131\000\000\000\
\\132\000\000\000\
\\133\000\000\000\
\\134\000\000\000\
\\135\000\000\000\
\\136\000\000\000\
\\137\000\000\000\
\\138\000\000\000\
\\139\000\002\000\101\000\000\000\
\\140\000\005\000\125\000\000\000\
\\141\000\000\000\
\\142\000\000\000\
\\143\000\015\000\037\000\016\000\036\000\017\000\035\000\018\000\034\000\
\\019\000\033\000\020\000\032\000\021\000\031\000\022\000\030\000\
\\023\000\029\000\024\000\028\000\026\000\027\000\027\000\026\000\000\000\
\\144\000\015\000\037\000\016\000\036\000\017\000\035\000\018\000\034\000\
\\019\000\033\000\020\000\032\000\021\000\031\000\022\000\030\000\
\\023\000\029\000\024\000\028\000\026\000\027\000\027\000\026\000\000\000\
\\145\000\015\000\037\000\016\000\036\000\017\000\035\000\018\000\034\000\
\\019\000\033\000\020\000\032\000\021\000\031\000\022\000\030\000\
\\023\000\029\000\024\000\028\000\026\000\027\000\027\000\026\000\000\000\
\\146\000\015\000\037\000\016\000\036\000\017\000\035\000\018\000\034\000\
\\019\000\033\000\020\000\032\000\021\000\031\000\022\000\030\000\
\\023\000\029\000\024\000\028\000\026\000\027\000\027\000\026\000\000\000\
\\147\000\005\000\089\000\007\000\088\000\015\000\037\000\016\000\036\000\
\\017\000\035\000\018\000\034\000\019\000\033\000\020\000\032\000\
\\021\000\031\000\022\000\030\000\023\000\029\000\024\000\028\000\
\\026\000\027\000\027\000\026\000\000\000\
\\148\000\000\000\
\\149\000\000\000\
\\150\000\000\000\
\\151\000\000\000\
\\152\000\000\000\
\\153\000\000\000\
\\154\000\000\000\
\\155\000\000\000\
\\156\000\000\000\
\\157\000\000\000\
\\158\000\000\000\
\\159\000\000\000\
\\160\000\000\000\
\\161\000\000\000\
\\162\000\000\000\
\\163\000\000\000\
\\164\000\000\000\
\\165\000\008\000\053\000\000\000\
\\166\000\000\000\
\\167\000\000\000\
\\168\000\000\000\
\\169\000\010\000\021\000\014\000\020\000\028\000\019\000\000\000\
\\170\000\000\000\
\\171\000\000\000\
\\173\000\000\000\
\\174\000\000\000\
\\175\000\000\000\
\\176\000\015\000\037\000\016\000\036\000\017\000\035\000\018\000\034\000\
\\019\000\033\000\020\000\032\000\021\000\031\000\022\000\030\000\
\\023\000\029\000\024\000\028\000\026\000\027\000\027\000\026\000\000\000\
\\177\000\026\000\027\000\027\000\026\000\000\000\
\\178\000\000\000\
\\179\000\000\000\
\\180\000\015\000\037\000\016\000\036\000\017\000\035\000\018\000\034\000\
\\019\000\033\000\020\000\032\000\021\000\031\000\022\000\030\000\
\\023\000\029\000\024\000\028\000\026\000\027\000\027\000\026\000\000\000\
\\181\000\015\000\037\000\016\000\036\000\017\000\035\000\018\000\034\000\
\\019\000\033\000\020\000\032\000\021\000\031\000\022\000\030\000\
\\023\000\029\000\024\000\028\000\026\000\027\000\027\000\026\000\000\000\
\\182\000\015\000\037\000\016\000\036\000\017\000\035\000\018\000\034\000\
\\019\000\033\000\020\000\032\000\021\000\031\000\022\000\030\000\
\\023\000\029\000\024\000\028\000\026\000\027\000\027\000\026\000\
\\032\000\103\000\000\000\
\\183\000\015\000\037\000\016\000\036\000\017\000\035\000\018\000\034\000\
\\019\000\033\000\020\000\032\000\021\000\031\000\022\000\030\000\
\\023\000\029\000\024\000\028\000\026\000\027\000\027\000\026\000\000\000\
\\184\000\015\000\037\000\016\000\036\000\017\000\035\000\018\000\034\000\
\\019\000\033\000\020\000\032\000\021\000\031\000\022\000\030\000\
\\023\000\029\000\024\000\028\000\026\000\027\000\027\000\026\000\000\000\
\\185\000\000\000\
\\186\000\000\000\
\\187\000\000\000\
\\188\000\015\000\037\000\016\000\036\000\017\000\035\000\018\000\034\000\
\\019\000\033\000\020\000\032\000\021\000\031\000\022\000\030\000\
\\023\000\029\000\024\000\028\000\026\000\027\000\027\000\026\000\000\000\
\\189\000\005\000\107\000\015\000\037\000\016\000\036\000\017\000\035\000\
\\018\000\034\000\019\000\033\000\020\000\032\000\021\000\031\000\
\\022\000\030\000\023\000\029\000\024\000\028\000\026\000\027\000\
\\027\000\026\000\000\000\
\\190\000\000\000\
\"
val actionRowNumbers =
"\003\000\076\000\085\000\084\000\
\\023\000\018\000\077\000\091\000\
\\036\000\003\000\003\000\003\000\
\\003\000\003\000\079\000\001\000\
\\072\000\003\000\004\000\003\000\
\\059\000\058\000\057\000\003\000\
\\071\000\070\000\068\000\066\000\
\\069\000\067\000\065\000\064\000\
\\061\000\060\000\063\000\062\000\
\\005\000\003\000\041\000\040\000\
\\039\000\037\000\033\000\008\000\
\\006\000\007\000\025\000\026\000\
\\024\000\083\000\013\000\002\000\
\\086\000\073\000\019\000\082\000\
\\021\000\029\000\020\000\038\000\
\\003\000\030\000\049\000\010\000\
\\014\000\003\000\003\000\003\000\
\\092\000\003\000\054\000\015\000\
\\080\000\074\000\093\000\003\000\
\\034\000\028\000\009\000\003\000\
\\008\000\046\000\027\000\089\000\
\\088\000\016\000\003\000\003\000\
\\081\000\095\000\003\000\075\000\
\\043\000\042\000\035\000\046\000\
\\050\000\032\000\017\000\011\000\
\\003\000\003\000\078\000\055\000\
\\056\000\005\000\094\000\008\000\
\\022\000\003\000\012\000\008\000\
\\090\000\087\000\096\000\045\000\
\\044\000\051\000\003\000\008\000\
\\047\000\052\000\031\000\046\000\
\\003\000\048\000\053\000\000\000"
val gotoT =
"\
\\006\000\005\000\010\000\127\000\011\000\003\000\012\000\002\000\
\\013\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\014\000\023\000\015\000\022\000\016\000\021\000\017\000\020\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\001\000\042\000\002\000\041\000\003\000\040\000\007\000\039\000\
\\008\000\038\000\000\000\
\\006\000\005\000\010\000\046\000\011\000\003\000\012\000\002\000\
\\013\000\001\000\000\000\
\\006\000\005\000\010\000\047\000\011\000\003\000\012\000\002\000\
\\013\000\001\000\000\000\
\\006\000\005\000\010\000\048\000\011\000\003\000\012\000\002\000\
\\013\000\001\000\000\000\
\\006\000\005\000\010\000\049\000\011\000\003\000\012\000\002\000\
\\013\000\001\000\000\000\
\\006\000\005\000\010\000\050\000\011\000\003\000\012\000\002\000\
\\013\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\006\000\005\000\010\000\052\000\011\000\003\000\012\000\002\000\
\\013\000\001\000\000\000\
\\000\000\
\\006\000\005\000\010\000\054\000\011\000\003\000\012\000\002\000\
\\013\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\006\000\005\000\010\000\055\000\011\000\003\000\012\000\002\000\
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
\\018\000\056\000\000\000\
\\006\000\005\000\010\000\058\000\011\000\003\000\012\000\002\000\
\\013\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\001\000\059\000\002\000\041\000\003\000\040\000\007\000\039\000\
\\008\000\038\000\000\000\
\\000\000\
\\006\000\061\000\000\000\
\\000\000\
\\000\000\
\\014\000\023\000\015\000\022\000\016\000\021\000\017\000\020\000\000\000\
\\014\000\023\000\015\000\022\000\016\000\021\000\017\000\020\000\000\000\
\\014\000\023\000\015\000\022\000\016\000\021\000\017\000\020\000\000\000\
\\014\000\023\000\015\000\022\000\016\000\021\000\017\000\020\000\000\000\
\\014\000\023\000\015\000\022\000\016\000\021\000\017\000\020\000\000\000\
\\006\000\005\000\009\000\071\000\010\000\070\000\011\000\003\000\
\\012\000\002\000\013\000\001\000\000\000\
\\014\000\023\000\015\000\022\000\016\000\021\000\017\000\020\000\000\000\
\\000\000\
\\014\000\023\000\015\000\022\000\016\000\021\000\017\000\020\000\000\000\
\\014\000\023\000\015\000\022\000\016\000\021\000\017\000\020\000\000\000\
\\000\000\
\\000\000\
\\014\000\023\000\015\000\022\000\016\000\021\000\017\000\020\000\000\000\
\\000\000\
\\006\000\005\000\010\000\077\000\011\000\003\000\012\000\002\000\
\\013\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\006\000\005\000\010\000\082\000\011\000\003\000\012\000\002\000\
\\013\000\001\000\000\000\
\\006\000\005\000\010\000\083\000\011\000\003\000\012\000\002\000\
\\013\000\001\000\000\000\
\\006\000\005\000\010\000\084\000\011\000\003\000\012\000\002\000\
\\013\000\001\000\000\000\
\\000\000\
\\006\000\005\000\009\000\085\000\010\000\070\000\011\000\003\000\
\\012\000\002\000\013\000\001\000\000\000\
\\014\000\023\000\015\000\022\000\016\000\021\000\017\000\020\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\006\000\005\000\010\000\089\000\011\000\003\000\012\000\002\000\
\\013\000\001\000\000\000\
\\000\000\
\\014\000\023\000\015\000\022\000\016\000\021\000\017\000\020\000\000\000\
\\004\000\093\000\006\000\092\000\000\000\
\\006\000\005\000\010\000\096\000\011\000\003\000\012\000\002\000\
\\013\000\001\000\000\000\
\\006\000\097\000\000\000\
\\005\000\098\000\000\000\
\\014\000\023\000\015\000\022\000\016\000\021\000\017\000\020\000\000\000\
\\014\000\023\000\015\000\022\000\016\000\021\000\017\000\020\000\000\000\
\\014\000\023\000\015\000\022\000\016\000\021\000\017\000\020\000\000\000\
\\000\000\
\\006\000\005\000\009\000\103\000\010\000\070\000\011\000\003\000\
\\012\000\002\000\013\000\001\000\000\000\
\\006\000\005\000\009\000\104\000\010\000\070\000\011\000\003\000\
\\012\000\002\000\013\000\001\000\000\000\
\\000\000\
\\014\000\023\000\015\000\022\000\016\000\021\000\017\000\020\000\000\000\
\\006\000\005\000\010\000\106\000\011\000\003\000\012\000\002\000\
\\013\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\000\000\
\\005\000\108\000\000\000\
\\014\000\023\000\015\000\022\000\016\000\021\000\017\000\020\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\006\000\005\000\010\000\112\000\011\000\003\000\012\000\002\000\
\\013\000\001\000\000\000\
\\006\000\005\000\010\000\113\000\011\000\003\000\012\000\002\000\
\\013\000\001\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\018\000\114\000\000\000\
\\014\000\023\000\015\000\022\000\016\000\021\000\017\000\020\000\000\000\
\\006\000\115\000\000\000\
\\000\000\
\\006\000\005\000\010\000\117\000\011\000\003\000\012\000\002\000\
\\013\000\001\000\000\000\
\\000\000\
\\006\000\120\000\000\000\
\\014\000\023\000\015\000\022\000\016\000\021\000\017\000\020\000\000\000\
\\014\000\023\000\015\000\022\000\016\000\021\000\017\000\020\000\000\000\
\\000\000\
\\000\000\
\\000\000\
\\014\000\023\000\015\000\022\000\016\000\021\000\017\000\020\000\000\000\
\\006\000\005\000\010\000\121\000\011\000\003\000\012\000\002\000\
\\013\000\001\000\000\000\
\\006\000\122\000\000\000\
\\000\000\
\\014\000\023\000\015\000\022\000\016\000\021\000\017\000\020\000\000\000\
\\000\000\
\\005\000\125\000\000\000\
\\006\000\005\000\010\000\126\000\011\000\003\000\012\000\002\000\
\\013\000\001\000\000\000\
\\000\000\
\\014\000\023\000\015\000\022\000\016\000\021\000\017\000\020\000\000\000\
\\000\000\
\"
val numstates = 128
val numrules = 61
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
 | ID of unit ->  (string)
 | recordList of unit ->  ( ( A.symbol * A.exp * A.pos )  list)
 | booleanOper of unit ->  (A.oper)
 | comparisonOper of unit ->  (A.oper)
 | arithmeticOper of unit ->  (A.oper) | oper of unit ->  (A.oper)
 | lvalue of unit ->  (A.var) | arrayExp of unit ->  (A.exp)
 | recordExp of unit ->  (A.exp) | exp of unit ->  (A.exp)
 | exps of unit ->  (A.exp list) | fundec of unit ->  (A.dec)
 | vardec of unit ->  (A.dec) | type_id of unit ->  (A.symbol)
 | tyfields of unit ->  (A.field list) | ty of unit ->  (A.ty)
 | tydec of unit ->  (A.dec) | dec of unit ->  (A.dec)
 | decs of unit ->  (A.dec list)
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
MlyValue.type_id type_id1, _, _)) :: ( _, ( _, TYPE1left, _)) :: 
rest671)) => let val  result = MlyValue.tydec (fn _ => let val  (
type_id as type_id1) = type_id1 ()
 val  (ty as ty1) = ty1 ()
 in (A.TypeDec([{name=type_id, ty=ty, pos=10}]))
end)
 in ( LrTable.NT 2, ( result, TYPE1left, ty1right), rest671)
end
|  ( 6, ( ( _, ( MlyValue.type_id type_id1, type_id1left, 
type_id1right)) :: rest671)) => let val  result = MlyValue.ty (fn _ =>
 let val  (type_id as type_id1) = type_id1 ()
 in (A.NameTy(type_id, 10))
end)
 in ( LrTable.NT 3, ( result, type_id1left, type_id1right), rest671)

end
|  ( 7, ( ( _, ( _, _, RBRACE1right)) :: ( _, ( MlyValue.tyfields 
tyfields1, _, _)) :: ( _, ( _, LBRACE1left, _)) :: rest671)) => let
 val  result = MlyValue.ty (fn _ => let val  (tyfields as tyfields1) =
 tyfields1 ()
 in (A.RecordTy(tyfields))
end)
 in ( LrTable.NT 3, ( result, LBRACE1left, RBRACE1right), rest671)
end
|  ( 8, ( ( _, ( MlyValue.type_id type_id1, _, type_id1right)) :: _ ::
 ( _, ( _, ARRAY1left, _)) :: rest671)) => let val  result = 
MlyValue.ty (fn _ => let val  (type_id as type_id1) = type_id1 ()
 in (A.ArrayTy(type_id, 10))
end)
 in ( LrTable.NT 3, ( result, ARRAY1left, type_id1right), rest671)
end
|  ( 9, ( rest671)) => let val  result = MlyValue.tyfields (fn _ => (
[]))
 in ( LrTable.NT 4, ( result, defaultPos, defaultPos), rest671)
end
|  ( 10, ( ( _, ( MlyValue.type_id type_id1, _, type_id1right)) :: _
 :: ( _, ( MlyValue.ID ID1, ID1left, _)) :: rest671)) => let val  
result = MlyValue.tyfields (fn _ => let val  ID1 = ID1 ()
 val  (type_id as type_id1) = type_id1 ()
 in ([{name=Symbol.symbol("a"), escape=ref true, typ=type_id, pos=10}]
)
end)
 in ( LrTable.NT 4, ( result, ID1left, type_id1right), rest671)
end
|  ( 11, ( ( _, ( MlyValue.tyfields tyfields1, _, tyfields1right)) ::
 _ :: ( _, ( MlyValue.type_id type_id1, _, _)) :: _ :: ( _, ( 
MlyValue.ID ID1, ID1left, _)) :: rest671)) => let val  result = 
MlyValue.tyfields (fn _ => let val  ID1 = ID1 ()
 val  type_id1 = type_id1 ()
 val  tyfields1 = tyfields1 ()
 in (
[{name=Symbol.symbol("a"), escape=ref true, typ=Symbol.symbol("a"), pos=10}]
)
end)
 in ( LrTable.NT 4, ( result, ID1left, tyfields1right), rest671)
end
|  ( 12, ( ( _, ( MlyValue.INT INT1, INT1left, INT1right)) :: rest671)
) => let val  result = MlyValue.type_id (fn _ => let val  (INT as INT1
) = INT1 ()
 in (Symbol.symbol(Int.toString(INT)))
end)
 in ( LrTable.NT 5, ( result, INT1left, INT1right), rest671)
end
|  ( 13, ( ( _, ( MlyValue.exp exp1, _, exp1right)) :: _ :: ( _, ( 
MlyValue.ID ID1, _, _)) :: ( _, ( _, VAR1left, _)) :: rest671)) => let
 val  result = MlyValue.vardec (fn _ => let val  ID1 = ID1 ()
 val  (exp as exp1) = exp1 ()
 in (
A.VarDec({name=Symbol.symbol("a"), escape=ref true, typ=NONE, init=exp, pos=10})
)
end)
 in ( LrTable.NT 6, ( result, VAR1left, exp1right), rest671)
end
|  ( 14, ( ( _, ( MlyValue.exp exp1, _, exp1right)) :: _ :: ( _, ( 
MlyValue.type_id type_id1, _, _)) :: _ :: ( _, ( MlyValue.ID ID1, _, _
)) :: ( _, ( _, VAR1left, _)) :: rest671)) => let val  result = 
MlyValue.vardec (fn _ => let val  ID1 = ID1 ()
 val  type_id1 = type_id1 ()
 val  (exp as exp1) = exp1 ()
 in (
A.VarDec({name=Symbol.symbol("a"), escape=ref true, typ=NONE, init=exp, pos=10})
)
end)
 in ( LrTable.NT 6, ( result, VAR1left, exp1right), rest671)
end
|  ( 15, ( ( _, ( MlyValue.exp exp1, _, exp1right)) :: _ :: _ :: ( _, 
( MlyValue.tyfields tyfields1, _, _)) :: _ :: ( _, ( MlyValue.ID ID1,
 _, _)) :: ( _, ( _, FUNCTION1left, _)) :: rest671)) => let val  
result = MlyValue.fundec (fn _ => let val  ID1 = ID1 ()
 val  (tyfields as tyfields1) = tyfields1 ()
 val  exp1 = exp1 ()
 in (
A.FunctionDec([{name=Symbol.symbol("a"), params=tyfields, result=NONE, body=A.NilExp, pos=10}])
)
end)
 in ( LrTable.NT 7, ( result, FUNCTION1left, exp1right), rest671)
end
|  ( 16, ( ( _, ( MlyValue.exp exp1, _, exp1right)) :: _ :: ( _, ( 
MlyValue.type_id type_id1, _, _)) :: _ :: _ :: ( _, ( 
MlyValue.tyfields tyfields1, _, _)) :: _ :: ( _, ( MlyValue.ID ID1, _,
 _)) :: ( _, ( _, FUNCTION1left, _)) :: rest671)) => let val  result =
 MlyValue.fundec (fn _ => let val  ID1 = ID1 ()
 val  (tyfields as tyfields1) = tyfields1 ()
 val  type_id1 = type_id1 ()
 val  exp1 = exp1 ()
 in (
A.FunctionDec([{name=Symbol.symbol("a"), params=tyfields, result=NONE, body=A.NilExp, pos=10}])
)
end)
 in ( LrTable.NT 7, ( result, FUNCTION1left, exp1right), rest671)
end
|  ( 17, ( ( _, ( MlyValue.exp exp1, exp1left, exp1right)) :: rest671)
) => let val  result = MlyValue.exps (fn _ => let val  (exp as exp1) =
 exp1 ()
 in (exp::nil)
end)
 in ( LrTable.NT 8, ( result, exp1left, exp1right), rest671)
end
|  ( 18, ( ( _, ( MlyValue.exps exps1, _, exps1right)) :: _ :: ( _, ( 
MlyValue.exp exp1, exp1left, _)) :: rest671)) => let val  result = 
MlyValue.exps (fn _ => let val  (exp as exp1) = exp1 ()
 val  (exps as exps1) = exps1 ()
 in (exp::exps)
end)
 in ( LrTable.NT 8, ( result, exp1left, exps1right), rest671)
end
|  ( 19, ( ( _, ( MlyValue.exps exps1, _, exps1right)) :: _ :: ( _, ( 
MlyValue.exp exp1, exp1left, _)) :: rest671)) => let val  result = 
MlyValue.exps (fn _ => let val  (exp as exp1) = exp1 ()
 val  (exps as exps1) = exps1 ()
 in (exp::exps)
end)
 in ( LrTable.NT 8, ( result, exp1left, exps1right), rest671)
end
|  ( 20, ( ( _, ( MlyValue.arithmeticOper arithmeticOper1, 
arithmeticOper1left, arithmeticOper1right)) :: rest671)) => let val  
result = MlyValue.oper (fn _ => let val  (arithmeticOper as 
arithmeticOper1) = arithmeticOper1 ()
 in (arithmeticOper)
end)
 in ( LrTable.NT 13, ( result, arithmeticOper1left, 
arithmeticOper1right), rest671)
end
|  ( 21, ( ( _, ( MlyValue.comparisonOper comparisonOper1, 
comparisonOper1left, comparisonOper1right)) :: rest671)) => let val  
result = MlyValue.oper (fn _ => let val  (comparisonOper as 
comparisonOper1) = comparisonOper1 ()
 in (comparisonOper)
end)
 in ( LrTable.NT 13, ( result, comparisonOper1left, 
comparisonOper1right), rest671)
end
|  ( 22, ( ( _, ( MlyValue.booleanOper booleanOper1, booleanOper1left,
 booleanOper1right)) :: rest671)) => let val  result = MlyValue.oper
 (fn _ => let val  (booleanOper as booleanOper1) = booleanOper1 ()
 in (booleanOper)
end)
 in ( LrTable.NT 13, ( result, booleanOper1left, booleanOper1right), 
rest671)
end
|  ( 23, ( ( _, ( _, TIMES1left, TIMES1right)) :: rest671)) => let
 val  result = MlyValue.arithmeticOper (fn _ => (A.TimesOp))
 in ( LrTable.NT 14, ( result, TIMES1left, TIMES1right), rest671)
end
|  ( 24, ( ( _, ( _, DIVIDE1left, DIVIDE1right)) :: rest671)) => let
 val  result = MlyValue.arithmeticOper (fn _ => (A.DivideOp))
 in ( LrTable.NT 14, ( result, DIVIDE1left, DIVIDE1right), rest671)

end
|  ( 25, ( ( _, ( _, PLUS1left, PLUS1right)) :: rest671)) => let val  
result = MlyValue.arithmeticOper (fn _ => (A.PlusOp))
 in ( LrTable.NT 14, ( result, PLUS1left, PLUS1right), rest671)
end
|  ( 26, ( ( _, ( _, MINUS1left, MINUS1right)) :: rest671)) => let
 val  result = MlyValue.arithmeticOper (fn _ => (A.MinusOp))
 in ( LrTable.NT 14, ( result, MINUS1left, MINUS1right), rest671)
end
|  ( 27, ( ( _, ( _, EQ1left, EQ1right)) :: rest671)) => let val  
result = MlyValue.comparisonOper (fn _ => (A.EqOp))
 in ( LrTable.NT 15, ( result, EQ1left, EQ1right), rest671)
end
|  ( 28, ( ( _, ( _, NEQ1left, NEQ1right)) :: rest671)) => let val  
result = MlyValue.comparisonOper (fn _ => (A.NeqOp))
 in ( LrTable.NT 15, ( result, NEQ1left, NEQ1right), rest671)
end
|  ( 29, ( ( _, ( _, GT1left, GT1right)) :: rest671)) => let val  
result = MlyValue.comparisonOper (fn _ => (A.GtOp))
 in ( LrTable.NT 15, ( result, GT1left, GT1right), rest671)
end
|  ( 30, ( ( _, ( _, LT1left, LT1right)) :: rest671)) => let val  
result = MlyValue.comparisonOper (fn _ => (A.LtOp))
 in ( LrTable.NT 15, ( result, LT1left, LT1right), rest671)
end
|  ( 31, ( ( _, ( _, GE1left, GE1right)) :: rest671)) => let val  
result = MlyValue.comparisonOper (fn _ => (A.GeOp))
 in ( LrTable.NT 15, ( result, GE1left, GE1right), rest671)
end
|  ( 32, ( ( _, ( _, LE1left, LE1right)) :: rest671)) => let val  
result = MlyValue.comparisonOper (fn _ => (A.LeOp))
 in ( LrTable.NT 15, ( result, LE1left, LE1right), rest671)
end
|  ( 33, ( ( _, ( _, AND1left, AND1right)) :: rest671)) => let val  
result = MlyValue.booleanOper (fn _ => (A.GtOp))
 in ( LrTable.NT 16, ( result, AND1left, AND1right), rest671)
end
|  ( 34, ( ( _, ( _, OR1left, OR1right)) :: rest671)) => let val  
result = MlyValue.booleanOper (fn _ => (A.GtOp))
 in ( LrTable.NT 16, ( result, OR1left, OR1right), rest671)
end
|  ( 35, ( ( _, ( MlyValue.ID ID1, ID1left, ID1right)) :: rest671)) =>
 let val  result = MlyValue.lvalue (fn _ => let val  (ID as ID1) = ID1
 ()
 in (A.SimpleVar(Symbol.symbol(ID) , 10))
end)
 in ( LrTable.NT 12, ( result, ID1left, ID1right), rest671)
end
|  ( 36, ( ( _, ( MlyValue.ID ID1, _, ID1right)) :: _ :: ( _, ( 
MlyValue.lvalue lvalue1, lvalue1left, _)) :: rest671)) => let val  
result = MlyValue.lvalue (fn _ => let val  (lvalue as lvalue1) = 
lvalue1 ()
 val  ID1 = ID1 ()
 in (A.FieldVar(lvalue, Symbol.symbol("a") , 10))
end)
 in ( LrTable.NT 12, ( result, lvalue1left, ID1right), rest671)
end
|  ( 37, ( ( _, ( _, _, RBRACK1right)) :: ( _, ( MlyValue.exp exp1, _,
 _)) :: _ :: ( _, ( MlyValue.lvalue lvalue1, lvalue1left, _)) :: 
rest671)) => let val  result = MlyValue.lvalue (fn _ => let val  (
lvalue as lvalue1) = lvalue1 ()
 val  (exp as exp1) = exp1 ()
 in (A.SubscriptVar(lvalue, exp , 10))
end)
 in ( LrTable.NT 12, ( result, lvalue1left, RBRACK1right), rest671)

end
|  ( 38, ( ( _, ( _, _, END1right)) :: ( _, ( MlyValue.exp exp1, _, _)
) :: _ :: ( _, ( MlyValue.decs decs1, _, _)) :: ( _, ( _, LET1left, _)
) :: rest671)) => let val  result = MlyValue.exp (fn _ => let val  (
decs as decs1) = decs1 ()
 val  (exp as exp1) = exp1 ()
 in (A.LetExp({decs=decs, body=exp, pos=10}))
end)
 in ( LrTable.NT 9, ( result, LET1left, END1right), rest671)
end
|  ( 39, ( ( _, ( MlyValue.lvalue lvalue1, lvalue1left, lvalue1right))
 :: rest671)) => let val  result = MlyValue.exp (fn _ => let val  (
lvalue as lvalue1) = lvalue1 ()
 in (A.VarExp(lvalue))
end)
 in ( LrTable.NT 9, ( result, lvalue1left, lvalue1right), rest671)
end
|  ( 40, ( ( _, ( _, NIL1left, NIL1right)) :: rest671)) => let val  
result = MlyValue.exp (fn _ => (A.NilExp))
 in ( LrTable.NT 9, ( result, NIL1left, NIL1right), rest671)
end
|  ( 41, ( ( _, ( _, _, RPAREN1right)) :: ( _, ( MlyValue.exps exps1,
 _, _)) :: _ :: ( _, ( MlyValue.exp exp1, _, _)) :: ( _, ( _, 
LPAREN1left, _)) :: rest671)) => let val  result = MlyValue.exp (fn _
 => let val  exp1 = exp1 ()
 val  exps1 = exps1 ()
 in (A.SeqExp([(A.NilExp, 10)]))
end)
 in ( LrTable.NT 9, ( result, LPAREN1left, RPAREN1right), rest671)
end
|  ( 42, ( ( _, ( MlyValue.INT INT1, INT1left, INT1right)) :: rest671)
) => let val  result = MlyValue.exp (fn _ => let val  (INT as INT1) = 
INT1 ()
 in (A.IntExp(INT))
end)
 in ( LrTable.NT 9, ( result, INT1left, INT1right), rest671)
end
|  ( 43, ( ( _, ( MlyValue.STRING STRING1, STRING1left, STRING1right))
 :: rest671)) => let val  result = MlyValue.exp (fn _ => let val  (
STRING as STRING1) = STRING1 ()
 in (A.StringExp(STRING, 10))
end)
 in ( LrTable.NT 9, ( result, STRING1left, STRING1right), rest671)
end
|  ( 44, ( ( _, ( _, _, RPAREN1right)) :: _ :: ( _, ( MlyValue.ID ID1,
 ID1left, _)) :: rest671)) => let val  result = MlyValue.exp (fn _ =>
 let val  ID1 = ID1 ()
 in (A.CallExp({func=Symbol.symbol("a"), args=[], pos=10}))
end)
 in ( LrTable.NT 9, ( result, ID1left, RPAREN1right), rest671)
end
|  ( 45, ( ( _, ( _, _, RPAREN1right)) :: ( _, ( MlyValue.exps exps1,
 _, _)) :: _ :: ( _, ( MlyValue.ID ID1, ID1left, _)) :: rest671)) =>
 let val  result = MlyValue.exp (fn _ => let val  ID1 = ID1 ()
 val  (exps as exps1) = exps1 ()
 in (A.CallExp({func=Symbol.symbol("a"), args=exps, pos=10}))
end)
 in ( LrTable.NT 9, ( result, ID1left, RPAREN1right), rest671)
end
|  ( 46, ( ( _, ( MlyValue.exp exp2, _, exp2right)) :: ( _, ( 
MlyValue.oper oper1, _, _)) :: ( _, ( MlyValue.exp exp1, exp1left, _))
 :: rest671)) => let val  result = MlyValue.exp (fn _ => let val  exp1
 = exp1 ()
 val  (oper as oper1) = oper1 ()
 val  exp2 = exp2 ()
 in (A.OpExp({left=exp1, oper=oper, right=exp2, pos=10}))
end)
 in ( LrTable.NT 9, ( result, exp1left, exp2right), rest671)
end
|  ( 47, ( ( _, ( MlyValue.exp exp1, _, exp1right)) :: ( _, ( _, 
MINUS1left, _)) :: rest671)) => let val  result = MlyValue.exp (fn _
 => let val  (exp as exp1) = exp1 ()
 in (A.OpExp({left=A.IntExp(0), oper=A.MinusOp, right=exp, pos=10}))

end)
 in ( LrTable.NT 9, ( result, MINUS1left, exp1right), rest671)
end
|  ( 48, ( ( _, ( MlyValue.recordExp recordExp1, recordExp1left, 
recordExp1right)) :: rest671)) => let val  result = MlyValue.exp (fn _
 => let val  (recordExp as recordExp1) = recordExp1 ()
 in (recordExp)
end)
 in ( LrTable.NT 9, ( result, recordExp1left, recordExp1right), 
rest671)
end
|  ( 49, ( ( _, ( MlyValue.arrayExp arrayExp1, arrayExp1left, 
arrayExp1right)) :: rest671)) => let val  result = MlyValue.exp (fn _
 => let val  (arrayExp as arrayExp1) = arrayExp1 ()
 in (arrayExp)
end)
 in ( LrTable.NT 9, ( result, arrayExp1left, arrayExp1right), rest671)

end
|  ( 50, ( ( _, ( MlyValue.exp exp1, _, exp1right)) :: _ :: ( _, ( 
MlyValue.lvalue lvalue1, lvalue1left, _)) :: rest671)) => let val  
result = MlyValue.exp (fn _ => let val  (lvalue as lvalue1) = lvalue1
 ()
 val  (exp as exp1) = exp1 ()
 in (A.AssignExp({var=lvalue, exp=exp, pos=10}))
end)
 in ( LrTable.NT 9, ( result, lvalue1left, exp1right), rest671)
end
|  ( 51, ( ( _, ( MlyValue.exp exp3, _, exp3right)) :: _ :: ( _, ( 
MlyValue.exp exp2, _, _)) :: _ :: ( _, ( MlyValue.exp exp1, _, _)) :: 
( _, ( _, IF1left, _)) :: rest671)) => let val  result = MlyValue.exp
 (fn _ => let val  exp1 = exp1 ()
 val  exp2 = exp2 ()
 val  exp3 = exp3 ()
 in (A.IfExp({test=exp1, then'=exp2, else'=SOME(exp3), pos=10}))
end)
 in ( LrTable.NT 9, ( result, IF1left, exp3right), rest671)
end
|  ( 52, ( ( _, ( MlyValue.exp exp2, _, exp2right)) :: _ :: ( _, ( 
MlyValue.exp exp1, _, _)) :: ( _, ( _, IF1left, _)) :: rest671)) =>
 let val  result = MlyValue.exp (fn _ => let val  exp1 = exp1 ()
 val  exp2 = exp2 ()
 in (A.IfExp({test=exp1, then'=exp2, else'=NONE, pos=10}))
end)
 in ( LrTable.NT 9, ( result, IF1left, exp2right), rest671)
end
|  ( 53, ( ( _, ( MlyValue.exp exp2, _, exp2right)) :: _ :: ( _, ( 
MlyValue.exp exp1, _, _)) :: ( _, ( _, WHILE1left, _)) :: rest671)) =>
 let val  result = MlyValue.exp (fn _ => let val  exp1 = exp1 ()
 val  exp2 = exp2 ()
 in (A.WhileExp({test=exp1, body=exp2, pos=10}))
end)
 in ( LrTable.NT 9, ( result, WHILE1left, exp2right), rest671)
end
|  ( 54, ( ( _, ( MlyValue.exp exp3, _, exp3right)) :: _ :: ( _, ( 
MlyValue.exp exp2, _, _)) :: _ :: ( _, ( MlyValue.exp exp1, _, _)) :: 
( _, ( _, FOR1left, _)) :: rest671)) => let val  result = MlyValue.exp
 (fn _ => let val  exp1 = exp1 ()
 val  exp2 = exp2 ()
 val  exp3 = exp3 ()
 in (
A.ForExp({var=Symbol.symbol("a"), escape=ref true, lo=exp1, hi=exp2, body=exp3, pos=10})
)
end)
 in ( LrTable.NT 9, ( result, FOR1left, exp3right), rest671)
end
|  ( 55, ( ( _, ( _, BREAK1left, BREAK1right)) :: rest671)) => let
 val  result = MlyValue.exp (fn _ => (A.BreakExp(10)))
 in ( LrTable.NT 9, ( result, BREAK1left, BREAK1right), rest671)
end
|  ( 56, ( ( _, ( _, _, RPAREN1right)) :: ( _, ( MlyValue.exp exp1, _,
 _)) :: ( _, ( _, LPAREN1left, _)) :: rest671)) => let val  result = 
MlyValue.exp (fn _ => let val  (exp as exp1) = exp1 ()
 in (exp)
end)
 in ( LrTable.NT 9, ( result, LPAREN1left, RPAREN1right), rest671)
end
|  ( 57, ( ( _, ( _, _, RBRACE1right)) :: ( _, ( MlyValue.recordList 
recordList1, _, _)) :: _ :: ( _, ( MlyValue.type_id type_id1, 
type_id1left, _)) :: rest671)) => let val  result = MlyValue.recordExp
 (fn _ => let val  type_id1 = type_id1 ()
 val  (recordList as recordList1) = recordList1 ()
 in (A.RecordExp({fields=recordList, typ=Symbol.symbol("a"), pos=10}))

end)
 in ( LrTable.NT 10, ( result, type_id1left, RBRACE1right), rest671)

end
|  ( 58, ( ( _, ( MlyValue.exp exp2, _, exp2right)) :: _ :: _ :: ( _, 
( MlyValue.exp exp1, _, _)) :: _ :: ( _, ( MlyValue.type_id type_id1, 
type_id1left, _)) :: rest671)) => let val  result = MlyValue.arrayExp
 (fn _ => let val  type_id1 = type_id1 ()
 val  exp1 = exp1 ()
 val  exp2 = exp2 ()
 in (
A.ArrayExp({typ=Symbol.symbol("a"), size=A.NilExp, init=A.NilExp, pos=10})
)
end)
 in ( LrTable.NT 11, ( result, type_id1left, exp2right), rest671)
end
|  ( 59, ( ( _, ( MlyValue.exp exp1, _, exp1right)) :: _ :: ( _, ( 
MlyValue.ID ID1, ID1left, _)) :: rest671)) => let val  result = 
MlyValue.recordList (fn _ => let val  ID1 = ID1 ()
 val  exp1 = exp1 ()
 in ([(Symbol.symbol("a"), A.NilExp, 10)])
end)
 in ( LrTable.NT 17, ( result, ID1left, exp1right), rest671)
end
|  ( 60, ( ( _, ( MlyValue.recordList recordList1, _, recordList1right
)) :: _ :: ( _, ( MlyValue.exp exp1, _, _)) :: _ :: ( _, ( MlyValue.ID
 ID1, ID1left, _)) :: rest671)) => let val  result = 
MlyValue.recordList (fn _ => let val  ID1 = ID1 ()
 val  exp1 = exp1 ()
 val  recordList1 = recordList1 ()
 in ([(Symbol.symbol("a"), A.NilExp, 10)])
end)
 in ( LrTable.NT 17, ( result, ID1left, recordList1right), rest671)

end
| _ => raise (mlyAction i392)
end
val void = MlyValue.VOID
val extract = fn a => (fn MlyValue.exp x => x
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
