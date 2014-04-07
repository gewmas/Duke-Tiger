MOVE(
 TEMP t101,
 CONST 0)
L345:
addi $t105, $zero, 0
sw $t105, $t101
j $t106 
L344:
MOVE(
 TEMP t102,
 CONST 1)
L347:
addi $t112, $zero, 1
sw $t112, $t102
j $t113 
L346:
MOVE(
 TEMP t103,
 CONST 2)
L349:
addi $t119, $zero, 2
sw $t119, $t103
j $t120 
L348:
MOVE(
 TEMP t104,
 CONST 10)
L351:
addi $t126, $zero, 10
sw $t126, $t104
j $t127 
L350:
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
 TEMP t101,
 TEMP t104)
L353:
addi $t133, $t101, 1
sw $t133, $t102
add $t134, $t103, $t102
sw $t134, $t103
addi $t136, $zero, 2
mul $t135, $t102, $t136
sw $t135, $t101
sw $t104, $t101
j $t137 
L352:
