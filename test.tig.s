main:
sw $t159, $t158
sw $t158, $t159
addi $t107, $zero, 13
addi $t108, $zero, 4
mul $t106, $t107, $t108
sub $t105, $t158, $t106
sw $t105, $t158
sw $t161, 0($t159)
sw $t160, -20($t159)
sw $t175, -24($t159)
sw $t176, -28($t159)
sw $t177, -32($t159)
sw $t178, -36($t159)
sw $t179, -40($t159)
sw $t180, -44($t159)
sw $t181, -48($t159)
sw $t182, -52($t159)
li $t101, 0
li $t102, 1
li $t103, 2
li $t104, 10
addi $t109, $t101, 3
sw $t109, $t157
lw $t160, -20($t159)
lw $t175, -24($t159)
lw $t176, -28($t159)
lw $t177, -32($t159)
lw $t178, -36($t159)
lw $t179, -40($t159)
lw $t180, -44($t159)
lw $t181, -48($t159)
lw $t182, -52($t159)
lw $t110, $t159
sw $t110, $t159
addi $t113, $zero, 13
addi $t114, $zero, 4
mul $t112, $t113, $t114
add $t111, $t158, $t112
sw $t111, $t158
j $t160 
L21:
