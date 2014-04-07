#actual start of the main program
#implements a swap of the values in two memory addresses
#to illustrate call by reference.
#
# int A = 5;
# int B = 10;
#
# void main()
# {
#    swap(&A, &B);
#    printf("\n A = %d  B = %d", A, B);
#    return;
# }
#
# void swap (int *x, int *y)
# {
#    int temp;
#    temp = *x;
#    *x = *y;
#    *y = temp;
# } 
	#Allocate the static variables and messages 
	.data
A:	.word  5
B:	.word  10

	.globl outputAMsg
outputAMsg:
	.asciiz	"\n A = "
	.globl outputBMsg
outputBMsg:
	.asciiz	"\n B = "
	.globl blankMsg
blankMsg:
	.asciiz	"   "

	#Test main program to call swap
	.text	
	.globl main
main:				#main has to be a global label
	addu	$s7, $0, $ra	#save the return address in a global register

	la	$a0, A		#address of A is first parameter of swap
	la	$a1, B		#address of B is second parameter of swap
	jal	swap		#swap(&A, &B);

                #Output A
        li      $v0, 4          #print_str (system call 4)
        la      $a0, outputAMsg #output "\n A = "
        syscall
        li      $v0, 1          #print_int
	lw	$a0, A		#value of A is the parameter 
        syscall
	li	$v0, 4 		#print_int
	la	$a0, blankMsg	#output some blanks

                #Output B
        li      $v0, 4          #print_str (system call 4)
        la      $a0, outputBMsg #output "\n B ="
        syscall
        li      $v0, 1          #print_int
        lw      $a0, B          #value of B is the parameter 
        syscall  

                       #Usual stuff at the end of the main
        addu    $ra, $0, $s7    #restore the return address
        jr      $ra             #return to the main program
        add     $0, $0, $0      #nop


	#void swap(int *x, int *y)
	.globl  swap 
swap:				#didn't need to save anything
	lw	$t0, 0($a0)	#$t0 has the value,  *x
	lw	$t1, 0($a1)	#$t1 has the value,  *y	
	sw	$t0, 0($a1)	#*y now has original value of *x
	sw	$t1, 0($a0)	#*x now has the original value of *y
	jr	$ra		#return



