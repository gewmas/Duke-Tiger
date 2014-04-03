MOVE(
 TEMP t11775,
 CONST 0)
L12862:
addi $t11780, $zero, 0
sw $t11780, $t11775
j $t11781 
L12861:
MOVE(
 TEMP t11776,
 CONST 1)
L12864:
addi $t11782, $zero, 1
sw $t11782, $t11776
j $t11783 
L12863:
MOVE(
 TEMP t11777,
 CONST 2)
L12866:
addi $t11784, $zero, 2
sw $t11784, $t11777
j $t11785 
L12865:
MOVE(
 TEMP t11778,
 CONST 10)
L12868:
addi $t11786, $zero, 10
sw $t11786, $t11778
j $t11787 
L12867:
MOVE(
 TEMP t11192,
 ESEQ(
  SEQ(
   MOVE(
    TEMP t11776,
    BINOP(PLUS,
     TEMP t11775,
     CONST 1)),
   SEQ(
    MOVE(
     TEMP t11777,
     BINOP(PLUS,
      TEMP t11777,
      TEMP t11776)),
    MOVE(
     TEMP t11775,
     BINOP(MUL,
      TEMP t11776,
      CONST 2)))),
  ESEQ(
   SEQ(
    CJUMP(LT,
     TEMP t11775,
     TEMP t11778,
     L12858,L12859),
    SEQ(
     LABEL L12858,
     SEQ(
      MOVE(
       TEMP t11779,
       TEMP t11776),
      SEQ(
       JUMP(
        NAME L12860),
       SEQ(
        LABEL L12859,
        SEQ(
         MOVE(
          TEMP t11779,
          TEMP t11777),
         LABEL L12860)))))),
   TEMP t11779)))
L12870:
addi $t11788, $t11775, 1
sw $t11788, $t11776
add $t11789, $t11777, $t11776
sw $t11789, $t11777
addi $t11791, $zero, 2
mul $t11790, $t11776, $t11791
sw $t11790, $t11775
blt $t11775, $t11778, L12858
L12859:
sw $t11777, $t11779
L12860:
sw $t11779, $t11192
j $t11792 
L12858:
sw $t11776, $t11779
j $t11793 
L12869:
