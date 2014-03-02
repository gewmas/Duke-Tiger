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

	(*Store information about a frame:name,formals,local variable,static link*)
	(*Formals contains StaticLink at the first position*)
	type frame = {name:Temp.label, formals:access list}
	(*type frame = {name:Temp.label, formals:access list, locals:access list}*)

	(*TO-DO*)
	fun newFrame {name,formals} = {name=name,formals=[]}

	(*Getter of a frame, get name & formals*)
	fun name {name,formals} = name
	fun formals {name,formals} = formals

	(*TO-DO*)
	fun allocLocal fr = 
		let
		 	fun f boolean = InFrame(0)
		 in
		 	f
		 end 

	(*datatype frag = 
		PROC of {body:Tree.stm,frame:frame} 
		| STRING of Temp.label * string*)
end