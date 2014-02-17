/* define a recursive function */
let
var st := "abc";
st := "bcd";
type i = int;
var a:i := 2;

/* calculate n! */
function nfactor(n: int): int =
		if  n = 0 
			then 1
			else n * nfactor(n-1)
var b := a+nfactor(a);
in
	nfactor(10)
end

