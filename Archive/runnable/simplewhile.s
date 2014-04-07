#actual start of the main program
#implements a while loop (PH p. 127) 
#   while (save[i] == k)
#         i = i + j;
#
#alternative form:
#	Loop: if (save[i] != k) go to Exit
#             i = i + j;
#             go to Loop;	
#	Exit:
#assumes:
#  variables i, j and k are in registers $s3, $s4 and $s5 
#  address of save is in $s6

	.globl main
main:				#main has to be a global label
	addu	$s7, $0, $ra	#save the return address in a global register

                       #Initialize variables
        add     $s3, $0, $0     #i = 0
        addi    $s4, $0, 1      #j = 1
	add	$s5, $0, $0	#k = 0 so program finds first nonzero value of save	
	la	$s6, save	#$s6 has the starting address of save 

			#Allocate 10-word array save
        .data
        .align  2               #Let's make sure that it's aligned  
	.globl  save 
save:   .word  0, 0, 0, 0, 0, 0, 0, 6, 3, 2  

	.text
Loop: 				
	add	$t1, $s3, $s3	#Temporary register $t1 = 2*i 
	add	$t1, $t1, $t1	#Double again so temporary register has 4*i
	add	$t1, $t1, $s6	#Add array start address so t1 has address of save[i]
	lw	$t0, 0($t1)	#Temporary register $t0 has value of save[i]
	bne	$t0, $s5, Exit	#If save[i] != k, go to Exit

	add	$s3, $s3, $s4	# i = i + j
	j	Loop		# go to Loop 
Exit:

                        #Output the value of i to see how far we got 
        .data
        .globl  message1
message1:       .asciiz "\nThe value of i is: " #string to print
        .text
        li      $v0, 4          #print_str (system call 4)
        la      $a0, message1   # takes the address of string as an argument
        syscall
        li      $v0, 1          #print_int (system call 1)
        add     $a0, $0, $s3    #put value i in $a0 for printing
        syscall
	
                       #Usual stuff at the end of the main
	addu	$ra, $0, $s7	#restore the return address
	jr	$ra		#return to the main program
	add	$0, $0, $0	#nop
