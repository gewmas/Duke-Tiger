.text
insideLetExp:
#save calleesaves:
addi $sp, $sp, -100
sw $fp, 0($sp)
sw $ra, 20($sp)
sw $s0, 24($sp)
sw $s1, 28($sp)
sw $s2, 32($sp)
sw $s3, 36($sp)
sw $s4, 40($sp)
sw $s5, 44($sp)
sw $s6, 48($sp)
sw $s7, 52($sp)
addi $fp, $sp, 100
#save arguments:
sw $a0, -4($fp)
sw $a1, -8($fp)
sw $a2, -12($fp)
sw $a3, -16($fp)
#body:
li $t0, 3
add $t0, $t1, $t0
move $v1, $t0
#load calleesaves:
lw $s7, 52($sp)
lw $s6, 48($sp)
lw $s5, 44($sp)
lw $s4, 40($sp)
lw $s3, 36($sp)
lw $s2, 32($sp)
lw $s1, 28($sp)
lw $s0, 24($sp)
lw $ra, 20($sp)
move $fp, $sp
addi $sp, $sp, 100
jr $ra
L21:
.text
test:
#save calleesaves:
addi $sp, $sp, -100
sw $fp, 0($sp)
sw $ra, 20($sp)
sw $s0, 24($sp)
sw $s1, 28($sp)
sw $s2, 32($sp)
sw $s3, 36($sp)
sw $s4, 40($sp)
sw $s5, 44($sp)
sw $s6, 48($sp)
sw $s7, 52($sp)
addi $fp, $sp, 100
#save arguments:
sw $a0, -4($fp)
sw $a1, -8($fp)
sw $a2, -12($fp)
sw $a3, -16($fp)
#body:
li $t0, 3
add $t0, $t1, $t0
move $v1, $t0
#load calleesaves:
lw $s7, 52($sp)
lw $s6, 48($sp)
lw $s5, 44($sp)
lw $s4, 40($sp)
lw $s3, 36($sp)
lw $s2, 32($sp)
lw $s1, 28($sp)
lw $s0, 24($sp)
lw $ra, 20($sp)
move $fp, $sp
addi $sp, $sp, 100
jr $ra
L22:
.text
main:
#save calleesaves:
addi $sp, $sp, -100
sw $fp, 0($sp)
sw $ra, 20($sp)
sw $s0, 24($sp)
sw $s1, 28($sp)
sw $s2, 32($sp)
sw $s3, 36($sp)
sw $s4, 40($sp)
sw $s5, 44($sp)
sw $s6, 48($sp)
sw $s7, 52($sp)
addi $fp, $sp, 100
#save arguments:
sw $a0, -4($fp)
sw $a1, -8($fp)
sw $a2, -12($fp)
sw $a3, -16($fp)
#body:
li $t0, 6
li $a0, 0
#save callersave
sw $t0, 56($sp)
sw $t1, 60($sp)
sw $t2, 64($sp)
sw $t3, 68($sp)
sw $t4, 72($sp)
sw $t5, 76($sp)
sw $t6, 80($sp)
sw $t7, 84($sp)
sw $t8, 88($sp)
sw $t9, 92($sp)
#call function
jal test
#load callersave
lw $t9, 92($sp)
lw $t8, 88($sp)
lw $t7, 84($sp)
lw $t6, 80($sp)
lw $t5, 76($sp)
lw $t4, 72($sp)
lw $t3, 68($sp)
lw $t2, 64($sp)
lw $t1, 60($sp)
lw $t0, 56($sp)
move $v1, $v1
#load calleesaves:
lw $s7, 52($sp)
lw $s6, 48($sp)
lw $s5, 44($sp)
lw $s4, 40($sp)
lw $s3, 36($sp)
lw $s2, 32($sp)
lw $s1, 28($sp)
lw $s0, 24($sp)
lw $ra, 20($sp)
move $fp, $sp
addi $sp, $sp, 100
jr $ra
L23:
