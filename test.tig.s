MOVE(
 TEMP t101,
 CONST 0)
L1283:
addi $t106, $zero, 0
sw $t106, $t101
j $t107 
L1282:
MOVE(
 TEMP t102,
 CONST 1)
L1285:
addi $t108, $zero, 1
sw $t108, $t102
j $t109 
L1284:
MOVE(
 TEMP t103,
 CONST 2)
L1287:
addi $t110, $zero, 2
sw $t110, $t103
j $t111 
L1286:
MOVE(
 TEMP t104,
 CONST 10)
L1289:
addi $t112, $zero, 10
sw $t112, $t104
j $t113 
L1288:
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
     L1279,L1280),
    SEQ(
     LABEL L1279,
     SEQ(
      MOVE(
       TEMP t105,
       TEMP t102),
      SEQ(
       JUMP(
        NAME L1281),
       SEQ(
        LABEL L1280,
        SEQ(
         MOVE(
          TEMP t105,
          TEMP t103),
         LABEL L1281)))))),
   TEMP t105)))
L1291:
addi $t114, $t101, 1
sw $t114, $t102
add $t115, $t103, $t102
sw $t115, $t103
addi $t117, $zero, 2
mul $t116, $t102, $t117
sw $t116, $t101
blt $t101, $t104, L1279
L1280:
sw $t103, $t105
L1281:
sw $t105, $t101
j $t118 
L1279:
sw $t102, $t105
j $t119 
L1290:
