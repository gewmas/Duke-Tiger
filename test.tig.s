MOVE(
 TEMP t11499,
 CONST 0)
L12306:
addi $t11504, $zero, 0
sw $t11504, $t11499
j $t11505 
L12305:
MOVE(
 TEMP t11500,
 CONST 1)
L12308:
addi $t11506, $zero, 1
sw $t11506, $t11500
j $t11507 
L12307:
MOVE(
 TEMP t11501,
 CONST 2)
L12310:
addi $t11508, $zero, 2
sw $t11508, $t11501
j $t11509 
L12309:
MOVE(
 TEMP t11502,
 CONST 10)
L12312:
addi $t11510, $zero, 10
sw $t11510, $t11502
j $t11511 
L12311:
MOVE(
 TEMP t11192,
 ESEQ(
  SEQ(
   MOVE(
    TEMP t11500,
    BINOP(PLUS,
     TEMP t11499,
     CONST 1)),
   SEQ(
    MOVE(
     TEMP t11501,
     BINOP(PLUS,
      TEMP t11501,
      TEMP t11500)),
    MOVE(
     TEMP t11499,
     BINOP(MUL,
      TEMP t11500,
      CONST 2)))),
  ESEQ(
   SEQ(
    CJUMP(LT,
     TEMP t11499,
     TEMP t11502,
     L12302,L12303),
    SEQ(
     LABEL L12302,
     SEQ(
      MOVE(
       TEMP t11503,
       TEMP t11500),
      SEQ(
       JUMP(
        NAME L12304),
       SEQ(
        LABEL L12303,
        SEQ(
         MOVE(
          TEMP t11503,
          TEMP t11501),
         LABEL L12304)))))),
   TEMP t11503)))
L12314:
addi $t11512, $t11499, 1
sw $t11512, $t11500
add $t11513, $t11501, $t11500
sw $t11513, $t11501
addi $t11515, $zero, 2
mul $t11514, $t11500, $t11515
sw $t11514, $t11499
blt $t11499, $t11502, L12302
L12303:
sw $t11501, $t11503
L12304:
sw $t11503, $t11192
j $t11516 
L12302:
sw $t11500, $t11503
j $t11517 
L12313:
