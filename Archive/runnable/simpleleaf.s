#actual start of the main program
#implements a leaf example (PH p. 134)
#   int leaf_example (int g, int h, int i, int j)
#   {
#       int f;
#       f = (g + h) - (i + j);
#       return f;
#   }
#assumes:
#  f is in $s0 and g, h, i and j are in registers $a0 through $a3


	.globl main
main:				#main has to be a global label
	addu	$s7, $0, $ra	#save the return address in a global register

	addi	$s0, $0, -1	#initialize $s0 to -1
        addi    $a0, $0, 5      #g = 5
        addi    $a1, $0, -20    #h = -20
        addi    $a2, $0, 13     #i = 13
        addi    $a3, $0, 3      #j = 3
	jal	leaf_example	#call the function leaf_example	
	add	$s0, $0, $v0	#set f to the computed value

		#Now print out f
        .data
        .globl  message
message:        .asciiz "\nThe value of f is: " #string to print
        .text
        li      $v0, 4          #print_str (system call 4)
        la      $a0, message    # takes the address of string as an argument
        syscall

        li      $v0, 1          #print_int (system call 1)
        add     $a0, $0, $s0    #put value to print in $a0
        syscall

                       #Usual stuff at the end of the main
        addu    $ra, $0, $s7    #restore the return address
        jr      $ra             #return to the main program
        add     $0, $0, $0      #nop

	.globl  leaf_example
leaf_example:
	sub	$sp, $sp, 12	#make space on the stack for three items
	sw	$t1, 8($sp)	#save register $t1       
	sw	$t0, 4($sp)     #save register $t2
	sw	$s0, 0($sp)     #save register $s0
        add     $t0, $a0, $a1   #register $t0 contains g + h
        add     $t1, $a2, $a3   #register $t1 contains i + j
        sub     $s0, $t0, $t1   #f = (g + h) - (i + j)
	add	$v0, $s0, $0	#returns f
	lw	$s0, 0($sp) 	#restore register $s0
	lw	$t0, 4($sp)	#restore register $t0
	lw	$t1, 8($sp)	#restore register $t1
	add	$sp, $sp, 12	#adjust the stack before the return 
	jr	$ra		#return to the calling program



