#actual start of the main program
#implements strcpy  (PH p. 143)
#illustrates byte arrays and passing of arrays as parameters.
#
# Main program:
# char A[] = "The quick brown fox\n";
# char B[100];

# void main()
# {
#   strcpy(B, A);
#   printf("\n String A: %s", A);
#   printf("\n String B: %s", B); 
#   return;
#}
#
# void strcpy (char x[], char y[])
# {	 
#    int i;
#    i = 0;
#    while ((x[i] = y[i]) != 0)  /* copy and test byte */
#       i = i + 1;
# }
#
# assumes that the address of x is in $a0, the address of y is in
# $a1 and i is in $s0.

	#Allocate the static variables for the program
	.data
A:	.asciiz	"The quick brown fox\n"
B:	.space 100
	.globl outputAmsg
outputAmsg:	
	.asciiz	"\n String A: "
	.globl outputBmsg
outputBmsg:
	.asciiz "\n String B: "
	
	#Start of the main program
	.text
	.globl main
main:				#main has to be a global label
	addu	$s7, $0, $ra	#save the return address in a global register

	la	$a0, B		#B is the first parameter (destination)
	la	$a1, A		#A is the secound parameter (source)
	jal	strcpy		#strcpy(B, A);

		#Output string A: 
        li      $v0, 4          #print_str (system call 4)
        la      $a0, outputAmsg #output "\n String A:"
        syscall
        li      $v0, 4		#print_str 
	la	$a0, A		#output the string A
        syscall

                #Output string B: 
        li      $v0, 4          #print_str (system call 4)
        la      $a0, outputBmsg #output "\n String B:"
        syscall
        li      $v0, 4          #print_str 
        la      $a0, B          #output the string B
        syscall

                       #Usual stuff at the end of the main
        addu    $ra, $0, $s7    #restore the return address
        jr      $ra             #return to the main program
        add     $0, $0, $0      #nop



	# void strcpy(char *d, const char *s)
	.globl  strcpy
				#i is in $s0, 
strcpy:
	sub	$sp, $sp, 4	#activation record is only one word
	sw	$s0, 4($sp)	#save $s0
	add	$s0, $0, $0	#i = 0;
L1:
	add	$t1, $a1, $s0	#address of y[i] is in $t1
	lb	$t2, 0($t1)	#$t2 = y[i]
	add	$t3, $a0, $s0	#address of x[i] is in $t3
	sb	$t2, 0($t3)	#x[i] = y[i]
	add	$s0, $s0, 1	#i = i + 1
	bne	$t2, $0, L1	#if y[i] != 0, go to L1
	lw	$s0, 4($sp)	#restore $s0
	add	$sp, $sp, 4	#restore the stack pointer
	jr	$ra		#return	




