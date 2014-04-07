#actual start of the main program
#implements a recursive version of N!
#
# Main program:
# void main()
#{  int N, f;
#   printf("Enter N: ");
#   scanf("%d", N); 
#   f = fact(N);
#   printf("\nN! = %d", f);
#   return;
#}
#
# int fact(int n)
# {
#   if (n < 1)
#	return 1;
#   else return (n * fact(n-1));
# }
# main assumes:
#  f is in $s0 and N is in $s1


	.globl main
main:				#main has to be a global label
	addu	$s7, $0, $ra	#save the return address in a global register

		#Prompt and input the value of N
        .data
        .globl  inputNmsg
inputNmsg:      .asciiz         "\nEnter N :"
        .text
        li      $v0, 4          #print_str (system call 4)
        la      $a0, inputNmsg  # takes the address of string as an argument
        syscall
        li      $v0, 5
        syscall
        add     $s1, $0, $v0    #The value of N has been read into $s1
		#Call the factorial function
	add	$a0, $0, $s1 	#set the parameter to N for fact call
	jal	fact
	add	$s0, $0, $v0	#f = fact(N);

		#Output the result
	.data
	.globl	outputMsg
outputMsg:	.asciiz		"\nN! = "
	.text
	li      $v0, 4          #print_str (system call 4) 
        la      $a0, outputMsg  # takes the address of string as an argument 
        syscall  		#  output the label
        li      $v0, 1
        add     $a0, $0, $s0
        syscall                 #  output f

                       #Usual stuff at the end of the main
        addu    $ra, $0, $s7    #restore the return address
        jr      $ra             #return to the main program
        add     $0, $0, $0      #nop

	.globl 	fact 
fact:
	sub	$sp, $sp, 8	#make space on the stack for two items
	sw	$ra, 4($sp)	#save the return address on the stack 
	sw	$a0, 0($sp)     #save the argument n on the stack 
	slt	$t0, $a0, 1	#test for n < 1
	beq	$t0, $zero, L1	#if (n >= 1) go to L1
	add	$v0, $zero, 1	#otherwise return 1
	add	$sp, $sp, 8	#  (just pop the saved items off stack since no call
	jr	$ra		#  and return)
L1:
	sub	$a0, $a0, 1	#when n >= 1:  decrement the argument
	jal	fact		#call fact(n-1)
	lw	$a0, 0($sp)	#restore the value of argument n
	lw	$ra, 4($sp)	#restore the return address
	add	$sp, $sp, 8	#release the save area on the stack
	mul	$v0, $a0, $v0	#yes it's a multiply!  (n*fact(n-1))
	jr	$ra		#return
	


