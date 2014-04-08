main:
addi $t102, $t102, -72
sw $t103, $t102
sw $t102, $t103
li $t101, 321
lw $t102, $t103
sw $t102, $t103
addi $t105, $zero, 10
addi $t106, $zero, 4
mul $t104, $t105, $t106
add $t103, $t102, $t104
sw $t103, $t102
j L18 
L18:
main:
addi $sp, $sp, -72
sw $fp, $sp
sw $sp, $fp
li $v0, 321
lw $sp, $fp
sw $sp, $fp
addi $a0, $zero, 10
addi $a1, $zero, 4
mul $ra, $a0, $a1
add $fp, $sp, $ra
sw $fp, $sp
j L18 
L18:
