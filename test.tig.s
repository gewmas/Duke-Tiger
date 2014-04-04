MOVE(
 TEMP t101,
 CONST 0)
L59:
addi $t106, $zero, 0
sw $t106, $t101
j $t107 
L58:
MOVE(
 TEMP t102,
 CONST 1)
L61:
addi $t108, $zero, 1
sw $t108, $t102
j $t109 
L60:
MOVE(
 TEMP t103,
 CONST 2)
L63:
addi $t110, $zero, 2
sw $t110, $t103
j $t111 
L62:
MOVE(
 TEMP t104,
 CONST 10)
L65:
addi $t112, $zero, 10
sw $t112, $t104
j $t113 
L64:
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
     L55,L56),
    SEQ(
     LABEL L55,
     SEQ(
      MOVE(
       TEMP t105,
       TEMP t102),
      SEQ(
       JUMP(
        NAME L57),
       SEQ(
        LABEL L56,
        SEQ(
         MOVE(
          TEMP t105,
          TEMP t103),
         LABEL L57)))))),
   TEMP t105)))
L67:
addi $t114, $t101, 1
sw $t114, $t102
add $t115, $t103, $t102
sw $t115, $t103
addi $t117, $zero, 2
mul $t116, $t102, $t117
sw $t116, $t101
blt $t101, $t104, L55
L56:
sw $t103, $t105
L57:
sw $t105, $t101
j $t118 
L55:
sw $t102, $t105
j $t119 
L66:
