insideLetExp:
sw $t0, $t2
sw $t2, $t0
addi $t2, $zero, 123
sw $t2, -4($t0)
addi $t0, $t1, 5
lw $t0, $t0
sw $t0, $t0
addi $t1, $zero, 10
addi $t0, $zero, 4
mul $t0, $t1, $t0
add $t0, $t2, $t0
sw $t0, $t2
j L19 
L19:
main:
sw $t1, $t2
sw $t2, $t1
li $t3, 321
addi $t0, $zero, 123
sw $t0, -4($t1)
addi $t0, $t3, 5
addi $t0, $t3, 10
lw $t0, $t1
sw $t0, $t1
addi $t1, $zero, 10
addi $t0, $zero, 4
mul $t0, $t1, $t0
add $t0, $t2, $t0
sw $t0, $t2
j L20 
L20:
