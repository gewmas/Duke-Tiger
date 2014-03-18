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
			val fraglist = Semant.transProg(exp)
			fun printTree [] = (print "empty printTree\n")
				| printTree(a::l) = (
					case a of
						Frame.PROC{body,frame} => (
								Printtree.printtree(TextIO.openOut("output/T"^filename),body);
								printTree(l)
							)
						| Frame.STRING(label,s) => ()
					)
		in
			printTree fraglist;
			fraglist
		end
end



