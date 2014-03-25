structure Main : 
sig 
	structure Frame : FRAME = MipsFrame
	val main : string -> Frame.frag list 
end 
=
struct
	structure Frame : FRAME = MipsFrame

	fun printParse(outstream,exp) = 
		PrintAbsyn.print(outstream, exp)

	fun printFragProc(outstream,body) = 
		 Printtree.printtree(outstream,body)

	fun printFragString(outstream,label,s) =
		TextIO.output(outstream,"Frame.STRING Label:"^Symbol.name(label)^" string:"^s^"\n")

	fun processFrag(outstream,Frame.PROC{body,frame}) =
			let
				(*CH8 Basic Blocks and Traces*)
				val linearizedStmList = Canon.linearize(body)
				val basicBlocksResult = Canon.basicBlocks(linearizedStmList)
				val traceScheduleResult = Canon.traceSchedule(basicBlocksResult)

				fun traverseResult [] = ()
					| traverseResult(a::l) = (
							printFragProc(outstream,a);
							traverseResult(l)
						) 
				val changedBody : Tree.stm list = traceScheduleResult
			in
				(*With Canon*)
				traverseResult(changedBody)

				(*No Canon*)
			 	(*printFragProc(outstream,body)*)
			end
		| processFrag(outstream,Frame.STRING(label,s)) = 
			printFragString(outstream,label,s)

	fun main filename =
		let
			val exp = Parse.parse(filename)
			val fraglist = Semant.transProg(exp)

			val parseOutstream = TextIO.openOut("output/PARSE"^filename)

			val treeClearFileOutstream = TextIO.openOut("output/TREE"^filename)
            val () = TextIO.output(treeClearFileOutstream,"")
			val treeOutstream = TextIO.openAppend("output/TREE"^filename)

			fun traverseFrag [] = ()
				| traverseFrag(a::l) = (processFrag(treeOutstream,a); traverseFrag(l))

			
		in
			printParse(parseOutstream,exp);
			traverseFrag(fraglist);

			fraglist
		end
end



