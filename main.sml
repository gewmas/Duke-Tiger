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
			fun printTree [] = ()
				| printTree(a::l) = (
					case a of
						Frame.PROC{body,frame} => (
								(*Printtree.printtree(TextIO.openOut("output/"^filename),a);*)
								(*printTree l*)
							)
						| Frame.STRING(label,s) => ()
					)
		in
			printTree fraglist;
			fraglist
		end
end



