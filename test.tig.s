MOVE(
 TEMP t101,
 CONST 0)
L1370:
addi $t106, $zero, 0
sw $t106, $t101
j $t107 
L1369:
MOVE(
 TEMP t102,
 CONST 1)
L1372:
addi $t108, $zero, 1
sw $t108, $t102
j $t109 
L1371:
MOVE(
 TEMP t103,
 CONST 2)
L1374:
addi $t110, $zero, 2
sw $t110, $t103
j $t111 
L1373:
MOVE(
 TEMP t104,
 CONST 10)
L1376:
addi $t112, $zero, 10
sw $t112, $t104
j $t113 
L1375:
MOVE(
 TEMP t121,
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
     L1366,L1367),
    SEQ(
     LABEL L1366,
     SEQ(
      MOVE(
       TEMP t105,
       TEMP t102),
      SEQ(
       JUMP(
        NAME L1368),
       SEQ(
        LABEL L1367,
        SEQ(
         MOVE(
          TEMP t105,
          TEMP t103),
         LABEL L1368)))))),
   TEMP t105)))
