structure Test =
struct
    structure Frame : FRAME = MipsFrame

        fun pass() =
            (
                Main.compile "passtest/test1.tig";
                Main.compile "passtest/test3.tig";
                Main.compile "passtest/test4.tig";
                Main.compile "passtest/print.tig";
                Main.compile "passtest/while.tig";
                Main.compile "passtest/for.tig";
                Main.compile "passtest/testSL1.tig";
                Main.compile "passtest/testSL2.tig"
            )
        fun test() =
            (
                Main.compile "test/merge.tig";
                Main.compile "test/queens.tig"
            )

        fun file filename =
            let
                (*This affect the register assign!*)
                (*val () = Temp.clear()*)
            in
                print("\n===Processing: "^filename^"===\n");

                
                Main.compile filename
            end

          fun test1 () = 
            let
             fun test n = 
              if n = 50 then ()
              else 
                if n = 33 then test(n+1)
                else (
                 file("test/test"^Int.toString(n)^".tig");
                 test(n+1)
               ) 
          in
             file "test/merge.tig";
             file "test/queens.tig";

             test 1;
             print "***Test finish***\n"
         end

    fun print filename = PrintAbsyn.print(TextIO.openOut(filename^".t"), Parse.parse(filename))
end

