main:
sw $t0, $t1
sw $t1, $t0
addi $t2, $zero, 72
sub $t1, $t1, $t2
sw $t1, $t1
li $t2, 321
addi $t2, $t2, 10
lw $t0, $t0
sw $t0, $t0
addi $t2, $zero, 10
addi $t0, $zero, 4
mul $t0, $t2, $t0
add $t0, $t1, $t0
sw $t0, $t1
j L18 
L18:
