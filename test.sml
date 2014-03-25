structure Test =
struct
    structure Frame : FRAME = MipsFrame

    val globalfilename = ref ""

    fun printTree [] = (print "empty printTree\n")
        | printTree(a::l) = 
          let
            (*val treeClearFileOutstream = TextIO.openOut("output/TREE"^(!globalfilename))
            val () = TextIO.output(treeClearFileOutstream,"")*)
            val treeFileOutstream = TextIO.openAppend("output/TREE"^(!globalfilename))
            (*val () = TextIO.output(treeFileOutstream,"============New file begin===============")*)
          in
            (
              case a of
                Frame.PROC{body,frame} => (
                    print("test.sml printTree Frame.PROC\n");
                    Printtree.printtree(treeFileOutstream,body);
                    printTree(l)
                    )
                | Frame.STRING(label,s) => (
                      print("test.sml printTree Frame.STRING\n");
                      print("Frame.STRING "^Symbol.name(label)^" "^s^"\n");
                      TextIO.output(treeFileOutstream,"Frame.STRING Label:"^Symbol.name(label)^" string:"^s^"\n");
                      printTree(l)
                    )
                )
          end
         

        fun pt filename =
            let
                val fraglist = Main.main filename

                val () = globalfilename := filename
                val treeClearFileOutstream = TextIO.openOut("output/TREE"^(!globalfilename))
              val () = TextIO.output(treeClearFileOutstream,"")
            in
                print("\n===Parsing: "^filename^"===\n");
                PrintAbsyn.print(TextIO.openOut("output/PARSE"^filename), Parse.parse(filename));
                
                
                print("Test.sml fraglist length:"^Int.toString(List.length(fraglist))^"\n\n");


                
                printTree fraglist
            end

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

