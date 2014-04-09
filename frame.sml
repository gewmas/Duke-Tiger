signature FRAME = 
sig
	(*type access*)
	datatype access = InFrame of int | InReg of Temp.temp

	type frame
	type register = string

	(*User defined*)
	val accessInFrameConst : access -> int

	(*CH6*)
	val newFrame : {name: Temp.label, formals:bool list} -> frame
	val name : frame -> string
	val formals : frame -> access list
	val localsNumber : frame -> int ref
	val allocLocal : frame -> bool -> access
	val string : Temp.label * string -> string

	(*Registers*)
	val registers: register list
	val colorregs: register list
	val tempMap : register Temp.Table.table

	val calldefs : Temp.temp list
	val specialregs : Temp.temp list
	val argregs : Temp.temp list
	val calleesaves : Temp.temp list
	val callersaves : Temp.temp list


	(*CH7*)
	datatype frag = 
		PROC of {body:Tree.stm,frame:frame} 
		| STRING of Temp.label * string

	val FP : Temp.temp (*p155 frame pointer*)
	val SP : Temp.temp
	val RV : Temp.temp (*p168*)
	val RA : Temp.temp
	val wordSize : int

	val exp : access -> Tree.exp -> Tree.exp 


	val externalCall : string * Tree.exp list -> Tree.exp

	val procEntryExit1 : frame * Tree.stm -> Tree.stm (*p261*)
	val procEntryExit2 : frame * Assem.instr list -> Assem.instr list
	val procEntryExit3 : frame * Assem.instr list -> {prolog:string, body:Assem.instr list, epilog: string}


end

structure MipsFrame : FRAME = 
struct
	structure T = Tree
	structure A = Assem

	val allowPrint = false
	fun log info = if allowPrint then print("***frame*** "^info^"\n") else ()

	datatype access = InFrame of int | InReg of Temp.temp

	fun accessInFrameConst access = 
		case access of
			InFrame(n) => n
			| InReg(n) => n

	(*Getter of a frame, get name & formals*)
	fun name {name,formals,localsNumber} = Symbol.name(name)
	fun formals {name,formals,localsNumber} = formals
	fun localsNumber{name,formals,localsNumber} = localsNumber
	fun string (label, str) = "Label:"^Symbol.name(label)^" "^str^"\n"


	(*------------------------------- MIPS registers ---------------------------------*)
	(*====== register ====== assembly name ====== comment ======*)
	(*			
				r0				$zero			always 0
				r1				$at 			reserved for assembler
				r2-r3			$v0-v1			stores results 					(RV)
				r4-r7			$a0-a3			stores arguments 				(args)
				r8-r15			$t0-t7			Temporaries, 					(callersaves)
				r16-r23			$s0-s7			Contents saves for use later, 	(calleesaves)
				r24-r25			$t8-t9			More temporararies, 			(callersaves)
				r26-r27			$k0-k1			reserved by operating system
				r28				$gp				Global pointer
				r29				$sp  			Stack pointer 					(SP)
				r30 			$fp 			Frame pointer 					(FP)
				r31 			$ra 			Return address 					(RA)
	*)

	(*--------------- assign temp to special registers ------------------*)
	val ZERO = Temp.newtemp()
	val RV = Temp.newtemp()
	val SP = Temp.newtemp()
	val FP = Temp.newtemp()
	val RA = Temp.newtemp()

	val numOfSpecialRegisters = 5
	val specialRegistersName = ["zero", "v1", "sp", "fp", "ra"]
	val specialregs = [ZERO, RV, SP, FP, RA]

	(*-------------- assign temp to arguments --------------------------*)
	val numOfArguments = 4
	val argumentsName = ["a0","a1","a2","a3"]
	val argumentsTemp = List.tabulate(numOfArguments, (fn _ => Temp.newtemp()))

	(*-------------- assign temp to callersaves registers --------------*)
	val numOfCallersavesRegisters = 10
	val callersavesName = ["t0","t1","t2","t3","t4","t5","t6","t7","t8","t9"]
	val callersaves = List.tabulate(numOfCallersavesRegisters, (fn _ => Temp.newtemp()))

	(*-------------- assign temp to calleesaves registers -------------*)
	val numOfCalleesavesRegisters = 8
	val calleesavesName = ["s0","s1","s2","s3","s4","s5","s6","s7"]
	val calleesaves = List.tabulate(numOfCalleesavesRegisters, (fn _ => Temp.newtemp()))

	(*register pairs*)
	val allRegsName = specialRegistersName@argumentsName@callersavesName@calleesavesName
	val allRegsTemp = specialregs@argumentsTemp@callersaves@calleesaves
	val allRegsPair = ListPair.zip(allRegsTemp, allRegsName)

	(*TO-DO*)
	val calldefs = callersaves@[RA,RV]
	val argregs = argumentsTemp
	val colorregs = callersavesName@calleesavesName@argumentsName


	(*p260*)
	(*enter these register pairs into table*)
	val tempMap = 
		let
			fun f((temp, name), table) = Temp.Table.enter(table, temp, name)
		in
			foldr f Temp.Table.empty allRegsPair
		end

	fun getRegisterName(temp) = 
		case Temp.Table.look(tempMap, temp) of
			SOME(regName) => regName
			| NONE => (log("the register does not exist."); Temp.makestring temp)
		
	val registers = map getRegisterName allRegsTemp



	


	(*CH6*)
	(*
	 * Formals: Incoiming arguments (higher addresses +)
			  ||
	     frame pointer
			  ||
	   LocalsNumber: local variables    (lower addresses -)
	     	   ||
       RA...: return address, tempraries, saved registers
	 *)

	(*Store information about a frame:name,formals,local variable*)
	(*p142 Frame should not know anything about static links.*)
	type frame = {name:Temp.label, formals:access list, localsNumber: int ref}
	type register = string

	(*p137 MIPS view shift*)
	
	val wordSize = 4

	(*
	 * Temps are abstract name for local variable; 
	 * labels are abstract names for static memory addresses.
	 * 
	 * For each formal parameter, newFrame must caculate:
	 * 1 How the parameter will be seen from inside the function (in a register, or in a frame location)
	 * 2 What instructions must be produced to implement the "view shift"
	 *)
	(*Formals if InFrame(0,1,2,3...)*)
	fun newFrame {name,formals} = 
		let
			(*0 is the static link*)
			val count = ref (~1)
			fun tupleForAccess formalBoolean = 
				case formalBoolean of
					true => (
							count := !count+1;
							InFrame(!count * wordSize)
							)
					| false => InReg(Temp.newtemp())
			val formalsAccessList = map tupleForAccess formals

			val () = log("Frame.newFrame SP:"^Int.toString(SP)^" FormalsListLength:"^Int.toString(List.length(formalsAccessList)))
		in
			{name=name,formals=formalsAccessList,localsNumber=ref 0}
		end
		



	(*Locals number if InFrame(-1,-2,-3,....)*)
	fun allocLocal frame = 
		let
			val localsNumber = localsNumber frame
			val () = (localsNumber := !localsNumber+1)
		 	fun allocLocalFunction boolean = 
		 		case boolean of
		 			true => (
		 					(*log("Frame.allocLocal.InFrame");*)
		 					InFrame(0-(!localsNumber)*wordSize)
		 				)
		 			| false => (
		 					(*log("Frame.allocLocal.InReg");*)
		 					InReg(Temp.newtemp())
		 				)
		 in
		 	allocLocalFunction
		 end 


	(*CH7*)
	datatype frag = 
		PROC of {body:Tree.stm,frame:frame} 
		| STRING of Temp.label * string

	(*p156 Used by Translate to turn Frame.access into Tree expression. *)
	fun exp access =
		let
			fun processTreeExp tempFramePointer:Tree.exp =
				case access of
					InFrame(n) => (
							log("Frame.exp.InFrame:"^Int.toString(n));
							Tree.MEM(Tree.BINOP(Tree.PLUS,Tree.CONST(n), tempFramePointer))
						)
					| InReg(n) => (
							log("Frame.exp.InFrame");
							Tree.TEMP(n)
						)
		in
			processTreeExp
		end

	(*p165*)
	fun externalCall(s,args) = 
		Tree.CALL(Tree.NAME(Temp.namedlabel s), args)

	(*To-DO*)
	(*
		Example str_sort.s

	strsort:
		addi $sp, $sp, -72	updateSP
	    sw $fp, 0($sp) 
	    sw $ra, 4($sp)
	    sw $s0, 8($sp)		saveCalleeInstructions
	    sw $s1, 12($sp)
	    sw $s2, 16($sp)
	    sw $s3, 20($sp)
	    sw $s4, 24($sp)
	    sw $s5, 28($sp)
	    sw $s6, 32($sp)
	    sw $s7, 36($sp)
	    addiu $fp, $sp, 68	updateFP

	    ...
		program   			saveArgsInstructions
	    ...

	    lw $s7, 36($sp)		loadCalleeInstructions
	    lw $s6, 32($sp)
	    lw $s5, 28($sp)
	    lw $s4, 24($sp)
	    lw $s3, 20($sp)
	    lw $s2, 16($sp)
	    lw $s1, 12($sp)
	    lw $s0, 8($sp)
	    lw $ra, 4($sp)	
	    lw $fp, 0($sp)		restoreFP
	    addi $sp, $sp, 72	restoreSP

	    jr $ra   			jumpToRA
		.end strsort
	*)
	(*p167 Function Definition*)
	fun procEntryExit1 (frame, body) = 
		let
			(*init*)
			val localVariableNum = !(localsNumber frame)
			val raNum = 1
			val calleeSaveResgisterNum = 8
			val callerSaveResgisterNum = 10
			val outgoingArgumentsNum = 5
			val argumentNum = 4

			(*helper function*)
			fun combineStmListToSEQ stmlist : Tree.stm = 
				case List.length(stmlist) of
					0 => List.hd(stmlist)
					| 1 => List.hd(stmlist)
					| 2 => Tree.SEQ(List.hd(stmlist),List.nth(stmlist,1))
					| _ =>  Tree.SEQ(List.hd(stmlist),combineStmListToSEQ(List.tl(stmlist)))
			fun saveRegs(n) = 
				T.MOVE(T.MEM(T.BINOP(T.PLUS,T.TEMP SP,T.CONST((argumentNum+n+2)*wordSize))), T.TEMP(List.nth(calleesaves@callersaves,n)))
			fun loadRegs(n) = 
				let
					val i = List.length(calleesaves@callersaves)-n-1
				in
					T.MOVE(T.TEMP(List.nth(calleesaves@callersaves,i)), T.MEM(T.BINOP(T.PLUS,T.TEMP SP, T.CONST((argumentNum+i+2)*wordSize))))
				end
				

			(*Label*)
			val label = Temp.namedlabel(name(frame))

			(*Update $sp*)
			val frameSize = (localVariableNum+raNum+calleeSaveResgisterNum+callerSaveResgisterNum+outgoingArgumentsNum)*wordSize
			val updateSP = T.MOVE(T.TEMP SP, T.BINOP(T.MINUS, T.TEMP SP, T.CONST frameSize))

			(*Save static link*)
			(*有可能要找很多层 可能有问题*)
			val moveSLtoStack = T.MOVE(T.MEM(T.TEMP SP), T.TEMP FP)

			(*Save $ra*)
			
			val saveRA = T.MOVE(T.MEM(T.BINOP(T.PLUS,T.TEMP SP,T.CONST((argumentNum+1)*wordSize))), T.TEMP RA)

			(*Save $s0-$s7*)
			val saveCalleeInstructionsList = List.tabulate(List.length(calleesaves@callersaves),saveRegs)
			val saveCalleeInstructions = combineStmListToSEQ(saveCalleeInstructionsList) (*T.SEQ(map saveRegs (ListPair.zip(localMem, raAndCallee)))*)



			(*Update $fp*)
			val updateFP = T.MOVE(T.TEMP FP, T.BINOP(T.PLUS, T.TEMP SP, T.CONST(frameSize)))









			(*Save arguments $a0-$a3*)
			fun saveArgs(n) = 
				T.MOVE(T.MEM(T.BINOP(T.MINUS,T.TEMP FP,T.CONST((n+1)*wordSize))), T.TEMP(List.nth(argregs,n)))


			
			val saveArgumentsInstructionsList = List.tabulate(argumentNum,saveArgs)
			val saveArgumentsInstructions = combineStmListToSEQ(saveArgumentsInstructionsList)


			(*Restore $s0-$s7*)
			val loadCalleeInstructionsList = List.tabulate(List.length(calleesaves@callersaves),loadRegs)
			val loadCalleeInstructions = combineStmListToSEQ(loadCalleeInstructionsList)
			
			(*Restore $ra*)
			val restoreRA = T.MOVE(T.TEMP RA, T.MEM(T.BINOP(T.PLUS,T.TEMP SP,T.CONST((argumentNum+1)*wordSize))))

			(*Restore $fp*)
			val restoreFP = T.MOVE(T.TEMP FP, T.MEM(T.TEMP SP))


			(*Restore $sp*)
			val restoreSP = T.MOVE(T.TEMP SP, T.BINOP(T.PLUS, T.TEMP SP, T.CONST frameSize))

			(*JumpToRA*)
			(*seems to be wrong because RA has nowhere to jump*)
			val jumpToRA = T.JUMP(T.TEMP RA, [])

			(*step 11 -------------------------------------*)
			val () = log("ending the function")
		in
			(*
				Label 
			  	Update $sp(要知道localVariable+returnAddress+temporaries+savedRegisters+outgoingArguments+staticLink大小,所以只看numLocal是不够大存所有的)
			  	Save static link (其实就是sw $fp, 0($sp) 不过要注意不一个是$fp有可能是再上一层的p134第13行例子 ) (要在更新$fp前做)
			  	Save $ra
			  	Save $s0-$s7
			  	Update $fp
				
			  	Save arguments $a0-$a3 and (疑问argument1-argumentn??不用存，用SL找?) if escape
				
				...
			  	body
			  	...

			  	Restore $s0-$s7
			  	Restore $ra
			  	Restore $fp (lw $fp, 0($sp)) 其实就是找回之前的static link,回到nested function的上一层
			  	Restore $sp
			  	JumpToRA
			*)
			combineStmListToSEQ([
				T.LABEL(label),updateSP,moveSLtoStack,saveRA,saveCalleeInstructions,updateFP,
				(*T.LABEL(Temp.namedlabel("beforeBody")),*)saveArgumentsInstructions,body,(*T.LABEL(Temp.namedlabel("afterBody")),*)
				loadCalleeInstructions,restoreRA,restoreFP,restoreSP,jumpToRA])
		end
		
	fun procEntryExit2(frame,body) = 
		body @  [A.OPER{assem="", src=[ZERO,RA,SP] @ calleesaves, dst=[],jump=SOME[]}]
	

	fun procEntryExit3({name,formals,localsNumber},body) = 
    	{
    	 prolog = "PROCEDURE " ^ Symbol.name name ^ "\n",
     	 body = body,
     	 epilog = "END " ^ Symbol.name name ^ "\n"
     	}


end
