/* define a recursive function */


let
	type myint = int
	type  arrtype = array of myint

	var arr1:arrtype := arrtype [10] of 0

	type rectype = {name:string , id:int}
	var rec1 := rectype {name="Name", id=0}

	type list = {first: int, rest: list}
	var st := "abc"
	type i = int
	var a:i := 2
	/* calculate n! */
	function nfactor(n: int): int =
		if  n = 0 
			then 1
			else n * nfactor(n-1)
	var b := a+nfactor(a)
in
	arr1[1] := 1;
	rec1.name := "asd";
	for i:=10 to -1 do 
		i := i - 1;
	st := "asd";
	nfactor(10)
end
