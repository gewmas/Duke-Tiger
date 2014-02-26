structure Main : 
	sig val main : string -> unit (*Translate.frag list*) 
end 
=
struct 
  fun main filename =
  	let
  		val exp = Parse.parse(filename)
  	in
  		Semant.transProg(exp)
  	end
end



