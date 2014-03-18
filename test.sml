structure Test =
struct
    structure Frame : FRAME = MipsFrame

    fun printTree [] = (print "empty printTree\n")
        | printTree(a::l) = (
          case a of
            Frame.PROC{body,frame} => (
                Printtree.printtree(TextIO.openOut("output/TreePrint"),body);
                printTree(l)
              )
            | Frame.STRING(label,s) => ()
          )

    fun pt filename = 
          (
            print("\n===Parsing: "^filename^"===\n");
            PrintAbsyn.print(TextIO.openOut("output/P"^filename), Parse.parse(filename));
            (*print("\n===Parse and Semant: "^filename^"===\n");*)
            printTree (Main.main filename)
          )

  	fun test () = 
  		let
  			fun test n = 
  				if n = 50 then ()
  				else (
  					pt("test/test"^Int.toString(n)^".tig");
  					test(n+1)
  					) 
  		in
  			pt "test/merge.tig";
  			pt "test/queens.tig";
        
  			test 1;
  			print "***Test finish***\n"
  		end

    fun testprint () = PrintAbsyn.print(TextIO.openOut("testoutput.sml"), Parse.parse("testinput.sml"))
    fun testprint filename = PrintAbsyn.print(TextIO.openOut(filename^"output"), Parse.parse(filename))
end

