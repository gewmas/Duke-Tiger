#actual start of the main program
#to perform the calculation (PH p. 123)
#      if (i == j) go to L1;
#      f = g + h;
#  L1: f = f - i;
#
#assumes:
#  variables f through j are in registers $s0 through $s4


	.globl main
main:				#main has to be a global label
	addu	$s7, $0, $ra	#save the return address in a global register
	
                       #Initialize variables    
	addi	$s0, $0, 6	#f = 6
        addi	$s1, $0, 5	#g = 5
        addi	$s2, $0, -20	#h = -20
	addi	$s3, $0, 13	#i = 13
	addi	$s4, $0, 3	#j = 3

			#Example when condition i==j is false:
	beq	$s3, $s4, L1	#if (i == j) go to l1;  
	add	$s0, $s1, $s2	#f = g + h (skipped if i == j)
L1:	sub	$s0, $s0, $s3	#f = f - i (always executed)

                       #Output the value of f
	.data
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
