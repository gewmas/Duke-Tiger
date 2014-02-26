let
	/*Print s on standard output*/
	function print(s: string) = ()


	/*Flush the standard output bufer*/
	function flush() = ()


	/*Read a character from standard input; return empty string on end of file.*/
	function getchar() : string = ("string")


	/*Give ASCII value of first character of s; yields -1 if s is empty string.*/
	function ord(s: string) : int = (0)


	/*Single-character string from ASCII value i; halt program if i out of range.*/
	function chr(i: int) : string = ("string")


	/*Number of characters in s.*/
	function size(s: string) : int = (0)


	/*substring of string s, starting with character first, n character long. 
		Characters are numbered starting at 0*/
	function substring(s:string, first:int, n:int) : string = ("string")


	/*Concatnation of s1 and s2.*/
	function concat(s1: string, s2: string) : string = ("string")


	/*Return (i=0).*/
	function not(i: int) : int = (i = 0) 


	/*Terminate execution with code i*/
	function exit(i: int) = ()
in
	()
end