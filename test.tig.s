L22:
addi $ra, $zero, 0
sw $ra, $t0
j $ra 
L21:
L24:
addi $ra, $zero, 1
sw $ra, $t0
j $ra 
L23:
L26:
addi $ra, $zero, 2
sw $ra, $t0
j $ra 
L25:
L28:
addi $ra, $zero, 10
sw $ra, $t0
j $ra 
L27:
L30:
addi $ra, $t0, 1
sw $ra, $t1
add $ra, $t0, $t1
sw $ra, $t0
addi $ra, $zero, 2
mul $ra, $t1, $ra
sw $ra, $t0
sw $ra, $t0
j $ra 
L29:
