main:
addi $t158, $t158, -72
sw $t159, $t158
sw $t158, $t159
li $t101, 321
lw $t102, $t159
sw $t102, $t159
addi $t105, $zero, 10
addi $t106, $zero, 4
mul $t104, $t105, $t106
add $t103, $t158, $t104
sw $t103, $t158
j L18 
L18:
main:
addi $t1, $t1, -72
sw $t0, $t1
sw $t1, $t0
li $t2, 321
lw $t0, $t0
sw $t0, $t0
addi $t2, $zero, 10
addi $t0, $zero, 4
mul $t0, $t2, $t0
add $t0, $t1, $t0
sw $t0, $t1
j L18 
L18:
