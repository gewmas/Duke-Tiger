/* This is illegal, since there are two functions with the same name
    in the same (consecutive) batch of mutually recursive functions.
   See also test48 */
let
	function g(a:int):int = a
	function g(a:int):int = a
	type tree ={key: int, children: treelist}
	type treelist = {hd: tree, tl: treelist}
	type treelist = {hd: tree, tl: treelist}
	var d:int :=0
	type treelist = {hd: tree, tl: treelist}
	type treelist = {hd: tree, tl: treelist}
in
	0
end
