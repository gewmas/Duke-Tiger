MOVE(
 TEMP t11675,
 CONST 0)
L12692:
addi $t11680, $zero, 0
sw $t11680, $t11675
j $t11681 
L12691:
MOVE(
 TEMP t11676,
 CONST 1)
L12694:
addi $t11682, $zero, 1
sw $t11682, $t11676
j $t11683 
L12693:
MOVE(
 TEMP t11677,
 CONST 2)
L12696:
addi $t11684, $zero, 2
sw $t11684, $t11677
j $t11685 
L12695:
MOVE(
 TEMP t11678,
 CONST 10)
L12698:
addi $t11686, $zero, 10
sw $t11686, $t11678
j $t11687 
L12697:
MOVE(
 TEMP t11192,
 ESEQ(
  SEQ(
   MOVE(
    TEMP t11676,
    BINOP(PLUS,
     TEMP t11675,
     CONST 1)),
   SEQ(
    MOVE(
     TEMP t11677,
     BINOP(PLUS,
      TEMP t11677,
      TEMP t11676)),
    MOVE(
     TEMP t11675,
     BINOP(MUL,
      TEMP t11676,
      CONST 2)))),
  ESEQ(
   SEQ(
    CJUMP(LT,
     TEMP t11675,
     TEMP t11678,
     L12688,L12689),
    SEQ(
     LABEL L12688,
     SEQ(
      MOVE(
       TEMP t11679,
       TEMP t11676),
      SEQ(
       JUMP(
        NAME L12690),
       SEQ(
        LABEL L12689,
        SEQ(
         MOVE(
          TEMP t11679,
          TEMP t11677),
         LABEL L12690)))))),
   TEMP t11679)))
L12700:
addi $t11688, $t11675, 1
sw $t11688, $t11676
add $t11689, $t11677, $t11676
sw $t11689, $t11677
addi $t11691, $zero, 2
mul $t11690, $t11676, $t11691
sw $t11690, $t11675
blt $t11675, $t11678, L12688
L12689:
sw $t11677, $t11679
L12690:
sw $t11679, $t11192
j $t11692 
L12688:
sw $t11676, $t11679
j $t11693 
L12699:
