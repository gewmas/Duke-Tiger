#actual start of the main program
#implements a call to a function with 5 parameters

# int A = 109;
# void main()
# {
#    int f;
#    f = parm5leaf(5, -20, 13, 3, A);
#    printf("/n f = %d", f);
#    return;
# } 

# int parm5leaf(int g, int h, int i, int j, int k)
# {
#    int f1, f2;
#    f1 = (g + h);
#    f2 = (i + j) * k;
#    return f1 + f2;
#   }
# assumes:
# f is in $s0 in the main program.  Allocate f1 and f2 as
# automatic variables on the stack. 

	#allocate the static variables and messages
	.data
A:	.word	109
	.globl outputfMsg
outputfMsg:
	.asciiz	"\n f = "

	.text
	.globl main
main:				#main has to be a global label
	addu	$s7, $0, $ra	#save the return address in a global register

		#initialize the first four parameters
        addi    $a0, $0, 5      #g = 5
        addi    $a1, $0, -20    #h = -20
        addi    $a2, $0, 13     #i = 13
        addi    $a3, $0, 3      #j = 3
	lw	$t0, A		#push the fifth parameter on stack
	sub	$sp, $sp, 4	 
	sw	$t0, 0($sp)	
	jal	parm5leaf	#call the function parm5leaf 
	add	$s0, $0, $v0	#set f to the computed value

		#Now print out f
        li      $v0, 4          #print_str (system call 4)
        la      $a0, outputfMsg    # takes the address of string as an argument
        syscall			#output "\n f = "
        li      $v0, 1          #print_int (system call 1)
        add     $a0, $0, $s0    #put value to print in $a0
        syscall

                 #Usual stuff at the end of the main
        addu    $ra, $0, $s7    #restore the return address
        jr      $ra             #return to the main program
        add     $0, $0, $0      #nop

		#global leaf parmeter
	.globl  parm5leaf 
parm5leaf:
	sub	$sp, $sp, 12	#allocate a 3-word activation record
	sw	$fp, 8($sp)	#save $fp because we're going to use it 
	add	$fp, $sp, 8	#$fp points to bottom, $sp to top	
        add     $t0, $a0, $a1   #register $t0 contains g + h
	sw	$t0, -4($fp)	#f1 = g + h
        add     $t1, $a2, $a3   #register $t1 contains i + j
	lw	$t2, 4($fp)	#load the value of k from stack (5th parm)
  	mul	$t0, $t1, $t2	#$t0 has (i + j) * k
	sw	$t0, -8($fp)	#f2 = (i + j)*k
	lw	$t0, -4($fp)	#reload f1 into $t0
	lw	$t1, -8($fp)	#reload f2 into $t1 
	add	$v0, $t0, $t1	#returns f1 + f2
	lw	$fp, 8($sp) 	#restore $fp 
	add	$sp, $sp, 12	#adjust the stack before the return 
	jr	$ra		#return to the calling program



