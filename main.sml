structure Main = struct

   structure Tr = Translate
   structure F = MipsFrame
   (*structure R = RegAlloc*)

 	(*fun getsome (SOME x) = x*)

   	fun emitproc out (F.PROC{body,frame}) =
    	    let 
            val _ = print ("emit " ^ F.name frame ^ "\n")
	          (*val _ = Printtree.printtree(out,body); *)
    		 	  val stms = Canon.linearize body
    	      (*val _ = app (fn s => Printtree.printtree(out,s)) stms; *)
    	      val stms' = Canon.traceSchedule(Canon.basicBlocks stms)
    		 	  val instrs = List.concat(map (Mips.codegen frame) stms') 
    	      

            (*No Liveness Analysis*)
            val format0 = Assem.format(Temp.makestring)

            (*Liveness Analysis & assign register according to allocation*)
            val (instrs',allocation) = RegAlloc.alloc(instrs,frame)
            val format1 = Assem.format(fn t => case Temp.Table.look(allocation,t)  of SOME(x) => x |NONE =>  "t9")
    	    in
            TextIO.output(out,".text\n");  
    	    	(*app (fn i => TextIO.output(out,format0 i)) instrs*)
            (*;*)
            app (fn i => TextIO.output(out,format1 i)) instrs'
    	    end
        | emitproc out (F.STRING(lab,s)) = (
              TextIO.output(out,".data\n");
              TextIO.output(out,F.string(lab,s))
            )

   	fun withOpenFile fname f = 
     	let 
     	  val out = TextIO.openOut fname
        val append =  TextIO.openAppend fname

        val runtimele =   TextIO.inputAll(TextIO.openIn "runtimele.s")
        val sysspim =  TextIO.inputAll(TextIO.openIn "sysspim.s")
      in 
        (f out before TextIO.closeOut out) handle e => (TextIO.closeOut out; raise e);
          TextIO.output(append,"\n");
          TextIO.output(append,"\n");
          TextIO.output(append,"\n");
          TextIO.output(append, runtimele);
          TextIO.output(append,"\n");
          TextIO.output(append,"\n");
          TextIO.output(append,"\n");
          TextIO.output(append, sysspim)
     	end 

   	fun compile filename = 
       	let 
       		val absyn = Parse.parse filename
        	val frags = (FindEscape.prog absyn; Semant.transProg absyn)
        in 
        	withOpenFile (filename ^ ".s") 
	     	(fn out => (app (emitproc out) frags))
       	end
end