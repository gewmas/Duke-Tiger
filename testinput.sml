/* This is illegal, since there are two functions with the same name
    in the same (consecutive) batch of mutually recursive functions.
   See also test48 */
let
	var a := 0
	var a := " "
	type str = string
	type rectype = {name:str , id:int}
	var rec1 := rectype {name="Name", id=0}
in
	a:= "abc";
	rec1.name := "asd"

end
