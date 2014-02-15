structure Test =
struct 
  	fun test () = 
  		let
  			fun parseTest filename = 
  				(
  					print("===PrintAbsyn and Parse: "^filename^"===\n");
  					PrintAbsyn.print(TextIO.openOut("output/"^filename), Parse.parse(filename));
  					print("===Parse and Semant: "^filename^"===\n");
            Main.main filename
  				)

  			fun test n = 
  				if n = 50 then ()
  				else (
  					parseTest("test/test"^Int.toString(n)^".tig");
  					test(n+1)
  					) 
  		in
  			parseTest "test/merge.tig";
  			parseTest "test/queens.tig";
  			test 1;
  			print "***Test finish***\n"
  		end

    fun testprint () = PrintAbsyn.print(TextIO.openOut("testoutput.sml"), Parse.parse("testinput.sml"))
end

