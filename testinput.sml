/* define a recursive function */


let
	type rectype = {name:string , id:int}
	var rec1 := rectype {name="Name", id=0}
in
	rec1.name := "asd"
end
