/* define a recursive function */


let
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
	for i:=10 to -1 do 
		i := i - 1;
	st := "asd";
	nfactor(10)
end

