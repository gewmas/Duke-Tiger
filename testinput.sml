/* define a recursive function */
let

/* calculate n! */
function nfactor(n: int): int =
		if  n = 0 
			then 1
			else n * nfactor(n-1)

in
	nfactor(10)
end

