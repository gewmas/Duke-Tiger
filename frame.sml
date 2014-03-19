signature FRAME = 
sig
	(*type access*)
	datatype access = InFrame of int | InReg of Temp.temp

	type frame

	(*User defined*)
	val accessInFrameConst : access -> int

	(*CH6*)
	val newFrame : {name: Temp.label, formals:bool list} -> frame
	val name : frame -> Temp.label
	val formals : frame -> access list
	val allocLocal : frame -> bool -> access

	(*CH7*)
	datatype frag = 
		PROC of {body:Tree.stm,frame:frame} 
		| STRING of Temp.label * string

	(*val RV : Temp.temp*) (*p168*)
	val FP : Temp.temp (*p155 frame pointer*)
	val wordSize : int
	val exp : access -> Tree.exp -> Tree.exp 


	val externalCall : string * Tree.exp list -> Tree.exp

	val procEntryExit1 : frame * Tree.stm -> Tree.stm (*p261*)

end

structure MipsFrame : FRAME = 
struct
	val allowPrint = true
	fun log info = if allowPrint then print("***frame*** "^info^"\n") else ()

	datatype access = InFrame of int | InReg of Temp.temp

	fun accessInFrameConst access = 
		case access of
			InFrame(n) => n
			| InReg(n) => n

	(*this should change accordingly, so that translate can call these to get FP*)
	(*TO-DO*)
	val FP = Temp.newtemp()



	(*TO-DO*)
	(*val SP = Temp.newtemp()*)
	(*TO-DO*)
	(*val RV = Temp.newtemp()*)
	val wordSize = 4

	(*CH6*)
	(*
	 * Incoiming arguments (higher addresses +)
			  ||
	     frame pointer
			  ||
	     local variables    (lower addresses -)
	     	   ||
        return address, tempraries, saved registers
	 *)

	(*Store information about a frame:name,formals,local variable*)
	(*p142 Frame should not know anything about static links.*)
	type frame = {name:Temp.label, formals:access list, localsNumber: int ref}

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
		in
			{name=name,formals=formalsAccessList,localsNumber=ref 0}
		end
		

	(*Getter of a frame, get name & formals*)
	fun name {name,formals,localsNumber} = name
	fun formals {name,formals,localsNumber} = formals
	fun localsNumber {name,formals,localsNumber} = localsNumber

	(*Locals number if InFrame(-1,-2,-3,....)*)
	fun allocLocal frame = 
		let
			val localsNumber = localsNumber frame
			val () = (localsNumber := !localsNumber+1)
		 	fun allocLocalFunction boolean = 
		 		case boolean of
		 			true => (
		 					log("Frame.allocLocal.InFrame");
		 					InFrame(0-(!localsNumber)*wordSize)
		 				)
		 			| false => (
		 					log("Frame.allocLocal.InReg");
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
							Tree.READ(Tree.MEM(Tree.BINOP(Tree.PLUS,Tree.CONST(n), tempFramePointer)))
						)
					| InReg(n) => (
							log("Frame.exp.InFrame");
							Tree.READ(Tree.TEMP(n))
						)
		in
			processTreeExp
		end

	(*p165*)
	fun externalCall(s,args) = 
		Tree.CALL(Tree.READ(Tree.NAME(Temp.namedlabel s)), args)

	(*To-DO*)
	(*p167 Function Definition*)
	fun procEntryExit1 (frame,body) = body

		
end