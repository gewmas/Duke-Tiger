signature FRAME = 
sig
	type frame
	datatype access = InFrame of int | InReg of Temp.temp

	(*CH6*)
	val newFrame : {name: Temp.label, formals:bool list} -> frame
	val name : frame -> Temp.label
	val formals : frame -> access list
	val allocLocal : frame -> bool -> access

	(*datatype frag = 
		PROC of {body:Tree.stm,frame:frame} 
		| STRING of Temp.label * string*)

	

	(*val FP : Temp.temp
	val wordSize : int
	val exp : access -> Tree.exp -> Tree.exp*)
end

structure MipsFrame : FRAME = 
struct
	type frame = unit (*TO-DO Not sure it is unit*)
	datatype access = InFrame of int | InReg of Temp.temp

	fun newFrame r = ()
	fun name fr = Symbol.symbol("a")
	fun formals fr = []
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