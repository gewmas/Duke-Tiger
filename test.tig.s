Label:L301 string
Label:L300 test
MOVE(
 TEMP t624,
 CONST 123)
L303:
addi $t627, $zero, 123
sw $t627, $t624
j $t628 
L302:
MOVE(
 TEMP t625,
 CONST 12)
L305:
addi $t629, $zero, 12
sw $t629, $t625
j $t630 
L304:
MOVE(
 TEMP t626,
 NAME L300)
L307:
sw $t631, $t626
j $t632 
L306:
MOVE(
 TEMP t101,
 ESEQ(
  SEQ(
   EXP(
    BINOP(PLUS,
     TEMP t626,
     CONST 186)),
   SEQ(
    EXP(
     NAME L301),
    EXP(
     BINOP(MUL,
      TEMP t624,
      CONST 7)))),
  BINOP(PLUS,
   TEMP t624,
   CONST 1)))
L309:
addi $t633, $t626, 186
addi $t636, $zero, 7
mul $t635, $t624, $t636
addi $t637, $t624, 1
sw $t637, $t101
j $t638 
L308:
