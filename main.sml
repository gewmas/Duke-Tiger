structure Main : 
sig 
	structure Frame : FRAME = MipsFrame
	val main : string -> Frame.frag list 
end 
=
struct
	structure Frame : FRAME = MipsFrame
	fun main filename =
		let
			val exp = Parse.parse(filename)
			val fraglist = (FindEscape.findEscape(exp); Semant.transProg(exp))
		in
			fraglist
		end
end



