	.globl strsort
	.ent strsort
	.text
strsort:
	# this function should sort an array of strings into
	# ascending order (smallest first)
	# you will do this by modifying the array in memory
	# $a0 is the array of strings (of type char **)
	# $a1 is the number of strings in that array
	# You should call strcmp(char * s0, char * s1)
    # move $s2, $a0 #save $a0
    addi $sp, $sp, -72
    sw $fp, 0($sp)
    sw $ra, 4($sp)
    sw $s0, 8($sp)
    sw $s1, 12($sp)
    sw $s2, 16($sp)
    sw $s3, 20($sp)
    sw $s4, 24($sp)
    sw $s5, 28($sp)
    sw $s6, 32($sp)
    sw $s7, 36($sp)
    addiu $fp, $sp, 68


    move $s0, $a0 #save $a0
    move $s1, $a1 #save $a1, n
    move $s2, $zero #outer loop, i=0   s2-----i
for1tst:
    addi $t4, $s1, -1 # n-1
    slt $t0, $s2, $t4 # i<n-1
    beq $t0, $zero, exit1
    addi $s3, $s2, 1 #inner loop, j=i+1    s3-------j
for2tst:
    slt $t1, $s3, $s1 # j<n
    beq $t1, $zero, exit2

#middle process
    
    li $t2, 4   #t1=4
    mul $t2, $s2, $t2 # t1=i*4
    add $s4, $s0, $t2  # s4 new a0 address a1 = a0 + i*4??

    li $t3, 4
    mul $t3, $s3, $t3  #t2 = j*4
    add $s5, $s0, $t3 # s5 new a0 address a0 = a0 + j*4

    lw $a0, 0($s4)  #can change the array?
    lw $a1, 0($s5)

    sw $t0,40($sp)
    sw $t1,44($sp)
    sw $t2,48($sp)
    sw $t3,52($sp)

    jal strcmp #jal sw before and lw after

    lw $t3,52($sp)
    lw $t2,48($sp)
    lw $t1,44($sp)
    lw $t0,40($sp)

    slti $t4, $v0, 0 # result < 0, t4=1
    bne $t4, $zero, next
    

#swap function, get each's address
    

    lw $s6, 0($s4)  #can change the array?
    lw $s7, 0($s5)

    sw $s6, 0($s5)   #dont't change twice!!!
    sw $s7, 0($s4)

next:
    #middle process
    addi $s3, $s3, 1 #j++
    j for2tst #next inner loop
exit2:
    addi $s2, $s2, 1 #i++
    j for1tst #next outer loop

	# to compare the strings.
	#  - It will return a negative number if s0 < s1
	#  - It will return if s0 == s1
	#  - It will return a positive number if s0 > s1
exit1:


    lw $s7, 36($sp)
    lw $s6, 32($sp)
    lw $s5, 28($sp)
    lw $s4, 24($sp)
    lw $s3, 20($sp)
    lw $s2, 16($sp)
    lw $s1, 12($sp)
    lw $s0, 8($sp)
    lw $ra, 4($sp)
    lw $fp, 0($sp)
    addi $sp, $sp, 72

    jr $ra
	.end strsort

	
	
# DO NOT EDIT BELOW THIS LINE

.data
stra1:
	.asciiz "a string to come first\n"
stra2:
	.asciiz "better be second\n"
stra3:
	.asciiz "better be third\n"
stra4:
	.asciiz "could be fourth\n"
stra5:
	.asciiz "definitely fifth\n"
stra6:
	.asciiz "definitely sixth\n"
stra7:
	.asciiz "totally seventh\n"
stra8:
	.asciiz "yes, this is last\n"

strb1:
	.asciiz "1\n"
strb2:
	.asciiz "2\n"
strb3:
	.asciiz "3\n"
strb4:
	.asciiz "4\n"
strb5:
	.asciiz "5\n"
colonSpace:
	.asciiz ": "
spcspc:
	.asciiz "  "
strNL:
	.asciiz "\n"
inputMesg:
	.asciiz "Input array: \n"
sortedMesg:
	.asciiz "Sorted array: \n"
calleeSaveFailMesg:
	.asciiz "You failed to save/restore a register properly!\n"
array1:
	.word stra8
	.word stra7
	.word stra4
	.word stra3
	.word stra1
	.word stra5
	.word stra2
	.word stra6

array2:
	.word strb5
	.word strb2
	.word strb1
	.word strb3
	.word strb4

arrays:
	.word array1
	.word array2
	.word 0
lengths:
	.word 8
	.word 5
	.word 0
checkVals:
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
	.word 0
.globl main
.ent main
.text
main: 

	addiu $sp, $sp, -64
	sw $fp, 0($sp)
	sw $ra, 4($sp)
	sw $s0, 8($sp)
	sw $s1, 12($sp)
	sw $s2, 16($sp)
	sw $s3, 20($sp)
	sw $s4, 24($sp)
	sw $s5, 28($sp)
	sw $s6, 32($sp)
	sw $s7, 36($sp)
	addiu $fp, $sp, 60

    la $s0, arrays #load address of arrays

    la $s1, lengths #load address of lengths

.Lmain_lp:
	lw $s2, 0($s0)
	beqz $s2, .Lmain_done
	lw $s3, 0($s1)
# print message
	la $a0, inputMesg
	li $v0, 4
	syscall
	#print array
	move $a0, $s2
	move $a1, $s3
	jal print_array
        la $t0, checkVals
	sw $sp, 0($t0)
	sw $fp, 4($t0)
	sw $s0, 8($t0)
	sw $s1, 12($t0)
	sw $s2, 16($t0)
	sw $s3, 20($t0)
	sw $s4, 24($t0)
	sw $s5, 28($t0)
	sw $s6, 32($t0)
	sw $s7, 36($t0)
	move $a0, $s2
	move $a1, $s3
    jal strsort   # strsort!!!
	la $t0, checkVals
	lw $t1, 0($t0)
	bne $t1, $sp, .Lmain_calleeSaveFail
	lw $t1, 4($t0)
	bne $t1, $fp, .Lmain_calleeSaveFail
	lw $t1, 8($t0)
	bne $t1, $s0, .Lmain_calleeSaveFail
	lw $t1, 12($t0)
	bne $t1, $s1, .Lmain_calleeSaveFail
	lw $t1, 16($t0)
	bne $t1, $s2, .Lmain_calleeSaveFail
	lw $t1, 20($t0)
	bne $t1, $s3, .Lmain_calleeSaveFail
	lw $t1, 24($t0)
	bne $t1, $s4, .Lmain_calleeSaveFail
	lw $t1, 28($t0)
	bne $t1, $s5, .Lmain_calleeSaveFail
	lw $t1, 32($t0)
	bne $t1, $s6, .Lmain_calleeSaveFail
	lw $t1, 36($t0)
	bne $t1, $s7, .Lmain_calleeSaveFail
	# print message
	la $a0, sortedMesg
	li $v0, 4
	syscall
	#print array
	move $a0, $s2
	move $a1, $s3
	jal print_array
	addiu $s0, $s0, 4
	addiu $s1, $s1, 4
	b .Lmain_lp
.Lmain_done:
	lw $s4, 24($sp)	
	lw $s3, 20($sp)	
	lw $s2, 16($sp)	
	lw $s1, 12($sp)	
	lw $s0, 8($sp)	
	lw $ra, 4($sp)
	lw $fp, 0($sp)
	addiu $sp, $sp, 64
	jr $ra
.Lmain_calleeSaveFail:
	la $a0, calleeSaveFailMesg
	li $v0, 4
	syscall
	li $v0, 10
	syscall
	li $v0, 17
	syscall
	j .Lmain_calleeSaveFail
.end main


.globl strcmp
.ent strcmp
.text
strcmp:	
	# s1 in $a0
	# s2 in $a1
	lbu $t0, 0($a0)
	lbu $t1, 0($a1)
	beqz $t0, .Lstrcmp_s0Done
	beqz $t1, .Lstrcmp_s0Greater
	blt $t0, $t1, .Lstrcmp_s0Less
	bgt $t0, $t1, .Lstrcmp_s0Greater
	addiu $a0, $a0, 1
	addiu $a1, $a1, 1
	b strcmp
.Lstrcmp_s0Done:
	beqz $t1, .Lstrcmp_stringsEq
.Lstrcmp_s0Less:
    la $v0, -1 #la??
	j  .Lstrcmp_ret
.Lstrcmp_s0Greater:	
	li $v0, 1
	j  .Lstrcmp_ret
.Lstrcmp_stringsEq:
	li $v0, 0
.Lstrcmp_ret:
	# Trash all caller saves and argument regs
	# To make sure students obey calling conventions!
        li $a0, 0xbad
	li $a1, 0xbad
	li $a2, 0xbad
	li $a3, 0xbad
	li $t0, 0xbad
	li $t1, 0xbad
	li $t2, 0xbad
	li $t3, 0xbad
	li $t4, 0xbad
	li $t5, 0xbad
	li $t6, 0xbad
	li $t7, 0xbad
	li $t8, 0xbad
	li $t9, 0xbad		
	jr $ra
	.end strcmp

	.globl print_array
	.ent print_array
	.text
print_array:
	#array pointer in s0
	#length in s1
	addiu $sp, $sp, -32
	sw $fp, 0($sp)
	sw $ra, 4($sp)
	sw $s0, 8($sp)
	sw $s1, 12($sp)
	sw $s2, 16($sp)
	sw $s3, 20($sp)
	sw $s4, 24($sp)
	addiu $fp, $sp, 28

	move $s0, $a0
	move $s1, $a1
	li $s2, 0
	bge $s2, $s1, .Lpar_end
.Lpar_lp:
	la $a0, spcspc
	li $v0, 4
	syscall
	move $a0, $s2
	li $v0, 1
	syscall
	la $a0, colonSpace
	li $v0, 4
	syscall
	lw $a0, 0($s0)
	li $v0, 4
	syscall
	la $a0, strNL
	li $v0, 4
	syscall
	addiu $s0, $s0, 4
	addiu $s2, $s2, 1
	blt $s2, $s1, .Lpar_lp
.Lpar_end:
	lw $s7, 36($sp)
	lw $s6, 32($sp)
	lw $s5, 28($sp)
	lw $s4, 24($sp)	
	lw $s3, 20($sp)	
	lw $s2, 16($sp)	
	lw $s1, 12($sp)	
	lw $s0, 8($sp)	
	lw $ra, 4($sp)
	lw $fp, 0($sp)
	addiu $sp, $sp, 32
	jr $ra
	.end print_array