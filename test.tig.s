insideLetExp:
addi $sp, $sp, -92
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
addi $fp, $sp, 88
li $t0, 33333
lw $s7, 52($sp)
lw $s6, 48($sp)
lw $s5, 44($sp)
lw $s4, 40($sp)
lw $s3, 36($sp)
lw $s2, 32($sp)
lw $s1, 28($sp)
lw $s0, 24($sp)
lw $ra, 20($sp)
lw $fp, 0($sp)
addi $sp, $sp, 92
jr $ra
L20:
test:
addi $sp, $sp, -88
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
addi $fp, $sp, 84
li $t0, 33333
lw $s7, 52($sp)
lw $s6, 48($sp)
lw $s5, 44($sp)
lw $s4, 40($sp)
lw $s3, 36($sp)
lw $s2, 32($sp)
lw $s1, 28($sp)
lw $s0, 24($sp)
lw $ra, 20($sp)
lw $fp, 0($sp)
addi $sp, $sp, 88
jr $ra
L21:
main:
addi $sp, $sp, -92
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
addi $fp, $sp, 88
li $t0, 321
lw $s7, 52($sp)
lw $s6, 48($sp)
lw $s5, 44($sp)
lw $s4, 40($sp)
lw $s3, 36($sp)
lw $s2, 32($sp)
lw $s1, 28($sp)
lw $s0, 24($sp)
lw $ra, 20($sp)
lw $fp, 0($sp)
addi $sp, $sp, 92
jr $ra
L22:
