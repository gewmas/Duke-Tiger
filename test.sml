structure Test =
struct
    structure Frame : FRAME = MipsFrame

        fun pass() =
            (
                Main.compile "passtest/test4.tig";
                Main.compile "passtest/testSL1.tig";
                Main.compile "passtest/testSL2.tig"
            )

        fun pt filename =
            let
                (*This affect the register assign!*)
                (*val () = Temp.clear()*)
            in
                print("\n===Processing: "^filename^"===\n");

                
                Main.compile filename
            end

          fun test () = 
            let
             fun test n = 
              if n = 50 then ()
              else 
                if n = 33 then test(n+1)
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
    fun testprint filename = PrintAbsyn.print(TextIO.openOut(filename^".t"), Parse.parse(filename))
end

