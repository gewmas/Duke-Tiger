signature FRAME = 
sig
	type frame
	(*type access*)
	datatype access = InFrame of int | InReg of Temp.temp

	(*CH6*)
	val newFrame : {name: Temp.label, formals:bool list} -> frame
	val name : frame -> Temp.label
	val formals : frame -> access list
	val allocLocal : frame -> bool -> access

	(*CH7*)
	datatype frag = 
		PROC of {body:Tree.stm,frame:frame} 
		| STRING of Temp.label * string

	val FP : Temp.temp (*frame pointer*)
	val wordSize : int
	val exp : access -> Tree.exp -> Tree.exp 

	val externalCall : string * Tree.exp list -> Tree.exp
	
	val RV : Temp.temp

	val procEntryExit1 : frame * Tree.stm -> Tree.stm
end

structure MipsFrame : FRAME = 
struct
	datatype access = InFrame of int | InReg of Temp.temp

	(*CH6*)

	(*Store information about a frame:name,formals,local variable*)
	(*p142 Frame should not know anything about static links.*)
	type frame = {name:Temp.label, formals:access list}

	(*
	 * Temps are abstract name for local variable; 
	 * labels are abstract names for static memory addresses.
	 * 
	 * For each formal parameter, newFrame must caculate:
	 * 1 How the parameter will be seen from inside the function (in a register, or in a frame location)
	 * 2 What instructions must be produced to implement the "view shift"
	 *)
	(*TO-DO How to assign frame&reg?*)
	fun newFrame {name,formals} = 
		let
			fun tupleForAccess formalBoolean = 
				case formalBoolean of
					true => InFrame(Temp.newtemp())
					| false => InReg(Temp.newtemp())
			val formalsAccessList = map tupleForAccess formals
		in
			{name=name,formals=formalsAccessList}
		end
		

	(*Getter of a frame, get name & formals*)
	fun name {name,formals} = name
	fun formals {name,formals} = formals

	(*TO-DO How to assign frame&reg?*)
	fun allocLocal frame = 
		let
		 	fun allocLocalFunction boolean = 
		 		case boolean of
		 			true => InFrame(0)
		 			| false => InReg(0)
		 in
		 	allocLocalFunction
		 end 


	(*CH7*)
	datatype frag = 
		PROC of {body:Tree.stm,frame:frame} 
		| STRING of Temp.label * string

	(*TO-DO*)
	val FP = Temp.newtemp()
	(*TO-DO*)
	val wordSize = 0

	(*TO-DO*)
	(*p156 Used by Translate to turn Frame.access into Tree expression. *)
	fun exp access =
		let
			fun processTreeExp tempFramePointer:Tree.exp =
				case access of
					InFrame(n) => Tree.READ(Tree.MEM(Tree.BINOP(Tree.PLUS,tempFramePointer,Tree.CONST(n))))
					| InReg(n) => Tree.READ(Tree.TEMP(n))
		in
			processTreeExp
		end

	(*TO-DO*)
	fun externalCall(s,args) = 
		Tree.CALL(Tree.READ(Tree.NAME(Temp.namedlabel s)), args)
	(*TO-DO*)
	val RV = 0
	(*To-DO*)
	fun procEntryExit1 (frame,body) = body
end