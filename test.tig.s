MOVE(
 TEMP t101,
 CONST 0)
L2592:
addi $t105, $zero, 0
sw $t105, $t101
j $t106 
L2591:
MOVE(
 TEMP t102,
 CONST 1)
L2594:
addi $t112, $zero, 1
sw $t112, $t102
j $t113 
L2593:
MOVE(
 TEMP t103,
 CONST 2)
L2596:
addi $t119, $zero, 2
sw $t119, $t103
j $t120 
L2595:
MOVE(
 TEMP t104,
 CONST 10)
L2598:
addi $t126, $zero, 10
sw $t126, $t104
j $t127 
L2597:
MOVE(
 TEMP t102,
 BINOP(PLUS,
  TEMP t101,
  CONST 1))
MOVE(
 TEMP t103,
 BINOP(PLUS,
  TEMP t103,
  TEMP t102))
MOVE(
 TEMP t101,
 BINOP(MUL,
  TEMP t102,
  CONST 2))
MOVE(
 TEMP t121,
 TEMP t104)
L2600:
addi $t133, $t101, 1
sw $t133, $t102
add $t134, $t103, $t102
sw $t134, $t103
addi $t136, $zero, 2
mul $t135, $t102, $t136
sw $t135, $t101
sw $t104, $t121
j $t137 
L2599:
