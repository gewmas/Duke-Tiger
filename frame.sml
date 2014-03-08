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
	(*datatype frag = 
		PROC of {body:Tree.stm,frame:frame} 
		| STRING of Temp.label * string*)

	(*val FP : Temp.temp
	val wordSize : int
	val exp : access -> Tree.exp -> Tree.exp*)
end

structure MipsFrame : FRAME = 
struct
	datatype access = InFrame of int | InReg of Temp.temp

	(*Store information about a frame:name,formals,local variable*)
	(*p142 Frame should not know anything about static links.*)
	type frame = {name:Temp.label, formals:access list}

	(*
	 * Temps are abstract name for local variable; 
	 * labels are abstract names for static memory addresses.
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

	(*datatype frag = 
		PROC of {body:Tree.stm,frame:frame} 
		| STRING of Temp.label * string*)
end