#actual start of the main program
#implements a simple loop  (PH p. 126)
#  Loop:  g = g + A[i];
#         i = i + j;
#	  if (i != h) go to Loop;
#assumes:
#  variables f through i are in registers $s0 through $s4
#  address of A is in $s5

	.globl main
main:				#main has to be a global label
	addu	$s7, $0, $ra	#save the return address in a global register

                       #Initialize variables
        addi    $s0, $s0, 6     #f = 6
        addi    $s1, $0, 7      #g = 7
        addi    $s2, $0, 5      #h = 5 
        addi    $s3, $0, 3      #i = 3
        addi    $s4, $0, 1      #j = 1
	la	$s5, A		#$s5 has the starting address of A

			#Allocate 100-word array A while we think of it	
        .data
        .align  2               #Let's make sure that it's aligned  
	.globl  A
A:      .word   11,12,13,14,15,16,17,18,19,20 
        .space  360            #Being lazy, just allocate space for rest


	.text
Loop:
	add	$t1, $s3, $s3	#Temporary register $t1 = 2*i 
	add	$t1, $t1, $t1	#Double again so temporary register has 4*i
	add	$t1, $t1, $s5	#Add array start address so t1 has address of A[i]
	lw	$t0, 0($t1)	#Temporary register $t0 has value of A[i]
	add	$s1, $s1, $t0	# g = g + A[i]
	add	$s3, $s3, $s4	# i = i + j
	bne	$s3, $s2, Loop	# if (i != h) go to Loop

			#Output the value of g
	.data
	.globl	message1	
message1:	.asciiz "\nThe value of g is: "	#string to print
	.text
	li	$v0, 4		#print_str (system call 4)
	la	$a0, message1	# takes the address of string as an argument 
	syscall	
        li	$v0, 1		#print_int (system call 1)
        add	$a0, $0, $s1	#put value g in $a0 for printing
        syscall
	
                       #Usual stuff at the end of the main
	addu	$ra, $0, $s7	#restore the return address
	jr	$ra		#return to the main program
	add	$0, $0, $0	#nop
