MOVE(
 TEMP t101,
 CONST 0)
L705:
addi $t106, $zero, 0
sw $t106, $t101
j $t107 
L704:
MOVE(
 TEMP t102,
 CONST 1)
L707:
addi $t108, $zero, 1
sw $t108, $t102
j $t109 
L706:
MOVE(
 TEMP t103,
 CONST 2)
L709:
addi $t110, $zero, 2
sw $t110, $t103
j $t111 
L708:
MOVE(
 TEMP t104,
 CONST 10)
L711:
addi $t112, $zero, 10
sw $t112, $t104
j $t113 
L710:
MOVE(
 TEMP t101,
 ESEQ(
  SEQ(
   MOVE(
    TEMP t102,
    BINOP(PLUS,
     TEMP t101,
     CONST 1)),
   SEQ(
    MOVE(
     TEMP t103,
     BINOP(PLUS,
      TEMP t103,
      TEMP t102)),
    MOVE(
     TEMP t101,
     BINOP(MUL,
      TEMP t102,
      CONST 2)))),
  ESEQ(
   SEQ(
    CJUMP(LT,
     TEMP t101,
     TEMP t104,
     L701,L702),
    SEQ(
     LABEL L701,
     SEQ(
      MOVE(
       TEMP t105,
       TEMP t102),
      SEQ(
       JUMP(
        NAME L703),
       SEQ(
        LABEL L702,
        SEQ(
         MOVE(
          TEMP t105,
          TEMP t103),
         LABEL L703)))))),
   TEMP t105)))
