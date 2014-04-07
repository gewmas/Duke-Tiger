#actual start of the main program
#to perform the calculation f = (g + h) - (i + j)  (PH p. 109)
#assumes:
#  variables f through j are in memory 

#where the variables are static variables

	.globl main
main:				#main has to be a global label
	addu	$s7, $0, $ra	#save the return address in a global register
        lw	$s1, g		#g = 5
        lw	$s2, h		#h = -20
	lw	$s3, i		#i = 13
	lw	$s4, j1		#j1 = 3 (uses j1 because j is an opcode)
	add	$t0, $s1, $s2	#register $t0 contains g + h
	add	$t1, $s3, $s4	#register $t1 contains i + j
        sub	$s0, $t0, $t1	#f = (g + h) - (i + j)
	sw	$s0, f	

	.data
f:	.word	1
g:	.word	5
h:	.word	-20
i:	.word	13
j1:	.word	3
	.globl	message	
message:	.asciiz "\nThe value of f is: "	#string to print
	.text
	li	$v0, 4		#print_str (system call 4)
	la	$a0, message 	# takes the address of string as an argument 
	syscall	

        li	$v0, 1		#print_int (system call 1)
        add	$a0, $0, $s0	#put value to print in $a0
        syscall

                       #Usual stuff at the end of the main
	addu	$ra, $0, $s7	#restore the return address
	jr	$ra		#return to the main program
	add	$0, $0, $0	#nop
