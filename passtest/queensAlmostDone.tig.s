.data
L6302:
.word 8
.asciiz "errorExp"
.data
L6296:
.word 8
.asciiz "errorExp"
.data
L6290:
.word 8
.asciiz "errorExp"
.data
L6284:
.word 8
.asciiz "errorExp"
.data
L6278:
.word 8
.asciiz "errorExp"
.data
L6272:
.word 8
.asciiz "errorExp"
.data
L6265:
.word 8
.asciiz "errorExp"
.data
L6259:
.word 8
.asciiz "errorExp"
.data
L6253:
.word 8
.asciiz "errorExp"
.data
L6247:
.word 8
.asciiz "errorExp"
.data
L6238:
.word 1
.asciiz "\n"
.data
L6234:
.word 1
.asciiz "\n"
.data
L6227:
.word 8
.asciiz "errorExp"
.data
L6221:
.word 2
.asciiz " ."
.data
L6220:
.word 2
.asciiz " O"
.text
printboard:
#save calleesaves:
addi $sp, $sp, -104
sw $fp, 0($sp)
sw $ra, 20($sp)
sw $s0, 24($sp)
sw $s1, 28($sp)
sw $s2, 32($sp)
sw $s3, 36($sp)
sw $s4, 40($sp)
sw $s5, 44($sp)
sw $s6, 48($sp)
sw $s7, 52($sp)
addi $fp, $sp, 104
#save arguments:
sw $a0, -4($fp)
sw $a1, -8($fp)
sw $a2, -12($fp)
sw $a3, -16($fp)
#body:
addi $t1, $zero, 0
addi $t0, $zero, 1
sub $t0, $t1, $t0
sw $t0, -4($fp)
L6236:
lw $t0, -4($fp)
addi $t0, $t0, 1
sw $t0, -4($fp)
addi $t1, $zero, 0
addi $t0, $zero, 1
sub $t0, $t1, $t0
sw $t0, -8($fp)
L6232:
lw $t0, -8($fp)
addi $t0, $t0, 1
sw $t0, -8($fp)
move $t0, $fp
lw $t1, -4($fp)
lw $t0, -104($fp)
lw $t0, -12($t0)
lw $t0, 0($t0)
blt $t1, $t0, L6223
L6225:
#save arguments to reg
la $a0, L6227
#save callersave
sw $t0, 56($sp)
sw $t1, 60($sp)
sw $t2, 64($sp)
sw $t3, 68($sp)
sw $t4, 72($sp)
sw $t5, 76($sp)
sw $t6, 80($sp)
sw $t7, 84($sp)
sw $t8, 88($sp)
sw $t9, 92($sp)
#call function
jal tig_print
#load callersave
lw $t9, 92($sp)
lw $t8, 88($sp)
lw $t7, 84($sp)
lw $t6, 80($sp)
lw $t5, 76($sp)
lw $t4, 72($sp)
lw $t3, 68($sp)
lw $t2, 64($sp)
lw $t1, 60($sp)
lw $t0, 56($sp)
#load callersave finish
#FP <- S7 finish here.:
move $t0, $v0
L6226:
lw $t0, -104($fp)
lw $t2, -12($t0)
addi $t1, $zero, 4
lw $t0, -4($fp)
addi $t0, $t0, 1
mul $t0, $t1, $t0
add $t0, $t2, $t0
lw $t1, 0($t0)
lw $t0, -8($fp)
beq $t1, $t0, L6228
L6229:
la $t0, L6221
L6230:
#save arguments to reg
move $a0, $t0
#save callersave
sw $t0, 56($sp)
sw $t1, 60($sp)
sw $t2, 64($sp)
sw $t3, 68($sp)
sw $t4, 72($sp)
sw $t5, 76($sp)
sw $t6, 80($sp)
sw $t7, 84($sp)
sw $t8, 88($sp)
sw $t9, 92($sp)
#call function
jal tig_print
#load callersave
lw $t9, 92($sp)
lw $t8, 88($sp)
lw $t7, 84($sp)
lw $t6, 80($sp)
lw $t5, 76($sp)
lw $t4, 72($sp)
lw $t3, 68($sp)
lw $t2, 64($sp)
lw $t1, 60($sp)
lw $t0, 56($sp)
#load callersave finish
#FP <- S7 finish here.:
lw $t2, -8($fp)
lw $t0, -104($fp)
lw $t1, -4($t0)
addi $t0, $zero, 1
sub $t1, $t1, $t0
addi $t0, $zero, 1
sub $t0, $t1, $t0
ble $t2, $t0, L6232
L6218:
#save arguments to reg
la $a0, L6234
#save callersave
sw $t0, 56($sp)
sw $t1, 60($sp)
sw $t2, 64($sp)
sw $t3, 68($sp)
sw $t4, 72($sp)
sw $t5, 76($sp)
sw $t6, 80($sp)
sw $t7, 84($sp)
sw $t8, 88($sp)
sw $t9, 92($sp)
#call function
jal tig_print
#load callersave
lw $t9, 92($sp)
lw $t8, 88($sp)
lw $t7, 84($sp)
lw $t6, 80($sp)
lw $t5, 76($sp)
lw $t4, 72($sp)
lw $t3, 68($sp)
lw $t2, 64($sp)
lw $t1, 60($sp)
lw $t0, 56($sp)
#load callersave finish
#FP <- S7 finish here.:
lw $t2, -4($fp)
lw $t0, -104($fp)
lw $t1, -4($t0)
addi $t0, $zero, 1
sub $t1, $t1, $t0
addi $t0, $zero, 1
sub $t0, $t1, $t0
ble $t2, $t0, L6236
L6217:
#save arguments to reg
la $a0, L6238
#save callersave
sw $t0, 56($sp)
sw $t1, 60($sp)
sw $t2, 64($sp)
sw $t3, 68($sp)
sw $t4, 72($sp)
sw $t5, 76($sp)
sw $t6, 80($sp)
sw $t7, 84($sp)
sw $t8, 88($sp)
sw $t9, 92($sp)
#call function
jal tig_print
#load callersave
lw $t9, 92($sp)
lw $t8, 88($sp)
lw $t7, 84($sp)
lw $t6, 80($sp)
lw $t5, 76($sp)
lw $t4, 72($sp)
lw $t3, 68($sp)
lw $t2, 64($sp)
lw $t1, 60($sp)
lw $t0, 56($sp)
#load callersave finish
#FP <- S7 finish here.:
move $v0, $v0
#load calleesaves:
lw $s7, 52($sp)
lw $s6, 48($sp)
lw $s5, 44($sp)
lw $s4, 40($sp)
lw $s3, 36($sp)
lw $s2, 32($sp)
lw $s1, 28($sp)
lw $s0, 24($sp)
lw $ra, 20($sp)
lw $t0, 0($sp)
move $fp, $t0
addi $sp, $sp, 104
jr $ra
L6223:
lw $t1, -4($fp)
addi $t0, $zero, 0
bge $t1, $t0, L6226
L6322:
j L6225 
L6224:
j L6225 
L6228:
la $t0, L6220
j L6230 
L6321:
.text
try:
#save calleesaves:
addi $sp, $sp, -104
sw $fp, 0($sp)
sw $ra, 20($sp)
sw $s0, 24($sp)
sw $s1, 28($sp)
sw $s2, 32($sp)
sw $s3, 36($sp)
sw $s4, 40($sp)
sw $s5, 44($sp)
sw $s6, 48($sp)
sw $s7, 52($sp)
addi $fp, $sp, 104
#save arguments:
sw $a0, -4($fp)
sw $a1, -8($fp)
sw $a2, -12($fp)
sw $a3, -16($fp)
#body:
lw $t1, -4($fp)
lw $t0, -104($fp)
lw $t0, -4($t0)
beq $t1, $t0, L6317
L6318:
addi $t1, $zero, 0
addi $t0, $zero, 1
sub $t0, $t1, $t0
sw $t0, -8($fp)
L6316:
lw $t0, -8($fp)
addi $t0, $t0, 1
sw $t0, -8($fp)
lw $t1, -8($fp)
lw $t0, -104($fp)
lw $t0, -8($t0)
lw $t0, 0($t0)
blt $t1, $t0, L6298
L6300:
#save arguments to reg
la $a0, L6302
#save callersave
sw $t0, 56($sp)
sw $t1, 60($sp)
sw $t2, 64($sp)
sw $t3, 68($sp)
sw $t4, 72($sp)
sw $t5, 76($sp)
sw $t6, 80($sp)
sw $t7, 84($sp)
sw $t8, 88($sp)
sw $t9, 92($sp)
#call function
jal tig_print
#load callersave
lw $t9, 92($sp)
lw $t8, 88($sp)
lw $t7, 84($sp)
lw $t6, 80($sp)
lw $t5, 76($sp)
lw $t4, 72($sp)
lw $t3, 68($sp)
lw $t2, 64($sp)
lw $t1, 60($sp)
lw $t0, 56($sp)
#load callersave finish
#FP <- S7 finish here.:
move $t0, $v0
L6301:
lw $t0, -104($fp)
lw $t2, -8($t0)
addi $t1, $zero, 4
lw $t0, -8($fp)
addi $t0, $t0, 1
mul $t0, $t1, $t0
add $t0, $t2, $t0
lw $t1, 0($t0)
addi $t0, $zero, 0
beq $t1, $t0, L6303
L6304:
li $t1, 0
L6305:
addi $t0, $zero, 1
beq $t1, $t0, L6308
L6309:
li $t1, 0
L6310:
addi $t0, $zero, 1
beq $t1, $t0, L6313
L6314:
lw $t2, -8($fp)
lw $t0, -104($fp)
lw $t1, -4($t0)
addi $t0, $zero, 1
sub $t1, $t1, $t0
addi $t0, $zero, 1
sub $t0, $t1, $t0
ble $t2, $t0, L6316
L6241:
li $t0, 0
L6319:
move $v0, $t0
#load calleesaves:
lw $s7, 52($sp)
lw $s6, 48($sp)
lw $s5, 44($sp)
lw $s4, 40($sp)
lw $s3, 36($sp)
lw $s2, 32($sp)
lw $s1, 28($sp)
lw $s0, 24($sp)
lw $ra, 20($sp)
lw $t0, 0($sp)
move $fp, $t0
addi $sp, $sp, 104
jr $ra
L6317:
#update static link for FP
move $s7, $fp
lw $t0, 0($fp)
move $fp, $t0
#save callersave
sw $t0, 56($sp)
sw $t1, 60($sp)
sw $t2, 64($sp)
sw $t3, 68($sp)
sw $t4, 72($sp)
sw $t5, 76($sp)
sw $t6, 80($sp)
sw $t7, 84($sp)
sw $t8, 88($sp)
sw $t9, 92($sp)
#call function
jal printboard
#load callersave
lw $t9, 92($sp)
lw $t8, 88($sp)
lw $t7, 84($sp)
lw $t6, 80($sp)
lw $t5, 76($sp)
lw $t4, 72($sp)
lw $t3, 68($sp)
lw $t2, 64($sp)
lw $t1, 60($sp)
lw $t0, 56($sp)
#load callersave finish
move $fp, $s7
#FP <- S7 finish here.:
move $t0, $v0
j L6319 
L6298:
lw $t1, -8($fp)
addi $t0, $zero, 0
bge $t1, $t0, L6301
L6352:
j L6300 
L6299:
j L6300 
L6303:
li $t4, 1
lw $t1, -8($fp)
lw $t0, -4($fp)
add $t1, $t1, $t0
lw $t0, -104($fp)
lw $t0, -16($t0)
lw $t0, 0($t0)
blt $t1, $t0, L6292
L6294:
#save arguments to reg
la $a0, L6296
#save callersave
sw $t0, 56($sp)
sw $t1, 60($sp)
sw $t2, 64($sp)
sw $t3, 68($sp)
sw $t4, 72($sp)
sw $t5, 76($sp)
sw $t6, 80($sp)
sw $t7, 84($sp)
sw $t8, 88($sp)
sw $t9, 92($sp)
#call function
jal tig_print
#load callersave
lw $t9, 92($sp)
lw $t8, 88($sp)
lw $t7, 84($sp)
lw $t6, 80($sp)
lw $t5, 76($sp)
lw $t4, 72($sp)
lw $t3, 68($sp)
lw $t2, 64($sp)
lw $t1, 60($sp)
lw $t0, 56($sp)
#load callersave finish
#FP <- S7 finish here.:
move $t0, $v0
L6295:
lw $t0, -104($fp)
lw $t3, -16($t0)
addi $t2, $zero, 4
lw $t1, -8($fp)
lw $t0, -4($fp)
add $t0, $t1, $t0
addi $t0, $t0, 1
mul $t0, $t2, $t0
add $t0, $t3, $t0
lw $t1, 0($t0)
addi $t0, $zero, 0
beq $t1, $t0, L6306
L6307:
li $t4, 0
L6306:
move $t1, $t4
j L6305 
L6292:
lw $t1, -8($fp)
lw $t0, -4($fp)
add $t1, $t1, $t0
addi $t0, $zero, 0
bge $t1, $t0, L6295
L6353:
j L6294 
L6293:
j L6294 
L6308:
li $t3, 1
lw $t0, -8($fp)
addi $t1, $t0, 7
lw $t0, -4($fp)
sub $t1, $t1, $t0
lw $t0, -104($fp)
lw $t0, -20($t0)
lw $t0, 0($t0)
blt $t1, $t0, L6286
L6288:
#save arguments to reg
la $a0, L6290
#save callersave
sw $t0, 56($sp)
sw $t1, 60($sp)
sw $t2, 64($sp)
sw $t3, 68($sp)
sw $t4, 72($sp)
sw $t5, 76($sp)
sw $t6, 80($sp)
sw $t7, 84($sp)
sw $t8, 88($sp)
sw $t9, 92($sp)
#call function
jal tig_print
#load callersave
lw $t9, 92($sp)
lw $t8, 88($sp)
lw $t7, 84($sp)
lw $t6, 80($sp)
lw $t5, 76($sp)
lw $t4, 72($sp)
lw $t3, 68($sp)
lw $t2, 64($sp)
lw $t1, 60($sp)
lw $t0, 56($sp)
#load callersave finish
#FP <- S7 finish here.:
move $t0, $v0
L6289:
lw $t0, -104($fp)
lw $t4, -20($t0)
addi $t2, $zero, 4
lw $t0, -8($fp)
addi $t1, $t0, 7
lw $t0, -4($fp)
sub $t0, $t1, $t0
addi $t0, $t0, 1
mul $t0, $t2, $t0
add $t0, $t4, $t0
lw $t1, 0($t0)
addi $t0, $zero, 0
beq $t1, $t0, L6311
L6312:
li $t3, 0
L6311:
move $t1, $t3
j L6310 
L6286:
lw $t0, -8($fp)
addi $t1, $t0, 7
lw $t0, -4($fp)
sub $t1, $t1, $t0
addi $t0, $zero, 0
bge $t1, $t0, L6289
L6354:
j L6288 
L6287:
j L6288 
L6313:
lw $t1, -8($fp)
lw $t0, -104($fp)
lw $t0, -8($t0)
lw $t0, 0($t0)
blt $t1, $t0, L6243
L6245:
#save arguments to reg
la $a0, L6247
#save callersave
sw $t0, 56($sp)
sw $t1, 60($sp)
sw $t2, 64($sp)
sw $t3, 68($sp)
sw $t4, 72($sp)
sw $t5, 76($sp)
sw $t6, 80($sp)
sw $t7, 84($sp)
sw $t8, 88($sp)
sw $t9, 92($sp)
#call function
jal tig_print
#load callersave
lw $t9, 92($sp)
lw $t8, 88($sp)
lw $t7, 84($sp)
lw $t6, 80($sp)
lw $t5, 76($sp)
lw $t4, 72($sp)
lw $t3, 68($sp)
lw $t2, 64($sp)
lw $t1, 60($sp)
lw $t0, 56($sp)
#load callersave finish
#FP <- S7 finish here.:
move $t0, $v0
L6246:
lw $t0, -104($fp)
lw $t2, -8($t0)
addi $t1, $zero, 4
lw $t0, -8($fp)
addi $t0, $t0, 1
mul $t0, $t1, $t0
add $t1, $t2, $t0
addi $t0, $zero, 1
sw $t0, 0($t1)
lw $t1, -8($fp)
lw $t0, -4($fp)
add $t1, $t1, $t0
lw $t0, -104($fp)
lw $t0, -16($t0)
lw $t0, 0($t0)
blt $t1, $t0, L6249
L6251:
#save arguments to reg
la $a0, L6253
#save callersave
sw $t0, 56($sp)
sw $t1, 60($sp)
sw $t2, 64($sp)
sw $t3, 68($sp)
sw $t4, 72($sp)
sw $t5, 76($sp)
sw $t6, 80($sp)
sw $t7, 84($sp)
sw $t8, 88($sp)
sw $t9, 92($sp)
#call function
jal tig_print
#load callersave
lw $t9, 92($sp)
lw $t8, 88($sp)
lw $t7, 84($sp)
lw $t6, 80($sp)
lw $t5, 76($sp)
lw $t4, 72($sp)
lw $t3, 68($sp)
lw $t2, 64($sp)
lw $t1, 60($sp)
lw $t0, 56($sp)
#load callersave finish
#FP <- S7 finish here.:
move $t0, $v0
L6252:
lw $t0, -104($fp)
lw $t3, -16($t0)
addi $t2, $zero, 4
lw $t1, -8($fp)
lw $t0, -4($fp)
add $t0, $t1, $t0
addi $t0, $t0, 1
mul $t0, $t2, $t0
add $t1, $t3, $t0
addi $t0, $zero, 1
sw $t0, 0($t1)
lw $t0, -8($fp)
addi $t1, $t0, 7
lw $t0, -4($fp)
sub $t1, $t1, $t0
lw $t0, -104($fp)
lw $t0, -20($t0)
lw $t0, 0($t0)
blt $t1, $t0, L6255
L6257:
#save arguments to reg
la $a0, L6259
#save callersave
sw $t0, 56($sp)
sw $t1, 60($sp)
sw $t2, 64($sp)
sw $t3, 68($sp)
sw $t4, 72($sp)
sw $t5, 76($sp)
sw $t6, 80($sp)
sw $t7, 84($sp)
sw $t8, 88($sp)
sw $t9, 92($sp)
#call function
jal tig_print
#load callersave
lw $t9, 92($sp)
lw $t8, 88($sp)
lw $t7, 84($sp)
lw $t6, 80($sp)
lw $t5, 76($sp)
lw $t4, 72($sp)
lw $t3, 68($sp)
lw $t2, 64($sp)
lw $t1, 60($sp)
lw $t0, 56($sp)
#load callersave finish
#FP <- S7 finish here.:
move $t0, $v0
L6258:
lw $t0, -104($fp)
lw $t3, -20($t0)
addi $t2, $zero, 4
lw $t0, -8($fp)
addi $t1, $t0, 7
lw $t0, -4($fp)
sub $t0, $t1, $t0
addi $t0, $t0, 1
mul $t0, $t2, $t0
add $t1, $t3, $t0
addi $t0, $zero, 1
sw $t0, 0($t1)
lw $t1, -4($fp)
lw $t0, -104($fp)
lw $t0, -12($t0)
lw $t0, 0($t0)
blt $t1, $t0, L6261
L6263:
#save arguments to reg
la $a0, L6265
#save callersave
sw $t0, 56($sp)
sw $t1, 60($sp)
sw $t2, 64($sp)
sw $t3, 68($sp)
sw $t4, 72($sp)
sw $t5, 76($sp)
sw $t6, 80($sp)
sw $t7, 84($sp)
sw $t8, 88($sp)
sw $t9, 92($sp)
#call function
jal tig_print
#load callersave
lw $t9, 92($sp)
lw $t8, 88($sp)
lw $t7, 84($sp)
lw $t6, 80($sp)
lw $t5, 76($sp)
lw $t4, 72($sp)
lw $t3, 68($sp)
lw $t2, 64($sp)
lw $t1, 60($sp)
lw $t0, 56($sp)
#load callersave finish
#FP <- S7 finish here.:
move $t0, $v0
L6264:
lw $t0, -104($fp)
lw $t2, -12($t0)
addi $t1, $zero, 4
lw $t0, -4($fp)
addi $t0, $t0, 1
mul $t0, $t1, $t0
add $t1, $t2, $t0
lw $t0, -8($fp)
addi $t0, $t0, 1
sw $t0, 0($t1)
#save arguments to reg
lw $t0, -4($fp)
addi $t0, $t0, 1
move $a0, $t0
#update static link for FP
move $s7, $fp
lw $t0, 0($fp)
move $fp, $t0
#save callersave
sw $t0, 56($sp)
sw $t1, 60($sp)
sw $t2, 64($sp)
sw $t3, 68($sp)
sw $t4, 72($sp)
sw $t5, 76($sp)
sw $t6, 80($sp)
sw $t7, 84($sp)
sw $t8, 88($sp)
sw $t9, 92($sp)
#call function
jal try
#load callersave
lw $t9, 92($sp)
lw $t8, 88($sp)
lw $t7, 84($sp)
lw $t6, 80($sp)
lw $t5, 76($sp)
lw $t4, 72($sp)
lw $t3, 68($sp)
lw $t2, 64($sp)
lw $t1, 60($sp)
lw $t0, 56($sp)
#load callersave finish
move $fp, $s7
#FP <- S7 finish here.:
lw $t1, -8($fp)
lw $t0, -104($fp)
lw $t0, -8($t0)
lw $t0, 0($t0)
blt $t1, $t0, L6268
L6270:
#save arguments to reg
la $a0, L6272
#save callersave
sw $t0, 56($sp)
sw $t1, 60($sp)
sw $t2, 64($sp)
sw $t3, 68($sp)
sw $t4, 72($sp)
sw $t5, 76($sp)
sw $t6, 80($sp)
sw $t7, 84($sp)
sw $t8, 88($sp)
sw $t9, 92($sp)
#call function
jal tig_print
#load callersave
lw $t9, 92($sp)
lw $t8, 88($sp)
lw $t7, 84($sp)
lw $t6, 80($sp)
lw $t5, 76($sp)
lw $t4, 72($sp)
lw $t3, 68($sp)
lw $t2, 64($sp)
lw $t1, 60($sp)
lw $t0, 56($sp)
#load callersave finish
#FP <- S7 finish here.:
move $t0, $v0
L6271:
lw $t0, -104($fp)
lw $t2, -8($t0)
addi $t1, $zero, 4
lw $t0, -8($fp)
addi $t0, $t0, 1
mul $t0, $t1, $t0
add $t1, $t2, $t0
addi $t0, $zero, 0
sw $t0, 0($t1)
lw $t1, -8($fp)
lw $t0, -4($fp)
add $t1, $t1, $t0
lw $t0, -104($fp)
lw $t0, -16($t0)
lw $t0, 0($t0)
blt $t1, $t0, L6274
L6276:
#save arguments to reg
la $a0, L6278
#save callersave
sw $t0, 56($sp)
sw $t1, 60($sp)
sw $t2, 64($sp)
sw $t3, 68($sp)
sw $t4, 72($sp)
sw $t5, 76($sp)
sw $t6, 80($sp)
sw $t7, 84($sp)
sw $t8, 88($sp)
sw $t9, 92($sp)
#call function
jal tig_print
#load callersave
lw $t9, 92($sp)
lw $t8, 88($sp)
lw $t7, 84($sp)
lw $t6, 80($sp)
lw $t5, 76($sp)
lw $t4, 72($sp)
lw $t3, 68($sp)
lw $t2, 64($sp)
lw $t1, 60($sp)
lw $t0, 56($sp)
#load callersave finish
#FP <- S7 finish here.:
move $t0, $v0
L6277:
lw $t0, -104($fp)
lw $t3, -16($t0)
addi $t2, $zero, 4
lw $t1, -8($fp)
lw $t0, -4($fp)
add $t0, $t1, $t0
addi $t0, $t0, 1
mul $t0, $t2, $t0
add $t1, $t3, $t0
addi $t0, $zero, 0
sw $t0, 0($t1)
lw $t0, -8($fp)
addi $t1, $t0, 7
lw $t0, -4($fp)
sub $t1, $t1, $t0
lw $t0, -104($fp)
lw $t0, -20($t0)
lw $t0, 0($t0)
blt $t1, $t0, L6280
L6282:
#save arguments to reg
la $a0, L6284
#save callersave
sw $t0, 56($sp)
sw $t1, 60($sp)
sw $t2, 64($sp)
sw $t3, 68($sp)
sw $t4, 72($sp)
sw $t5, 76($sp)
sw $t6, 80($sp)
sw $t7, 84($sp)
sw $t8, 88($sp)
sw $t9, 92($sp)
#call function
jal tig_print
#load callersave
lw $t9, 92($sp)
lw $t8, 88($sp)
lw $t7, 84($sp)
lw $t6, 80($sp)
lw $t5, 76($sp)
lw $t4, 72($sp)
lw $t3, 68($sp)
lw $t2, 64($sp)
lw $t1, 60($sp)
lw $t0, 56($sp)
#load callersave finish
#FP <- S7 finish here.:
move $t0, $v0
L6283:
lw $t0, -104($fp)
lw $t3, -20($t0)
addi $t2, $zero, 4
lw $t0, -8($fp)
addi $t1, $t0, 7
lw $t0, -4($fp)
sub $t0, $t1, $t0
addi $t0, $t0, 1
mul $t0, $t2, $t0
add $t1, $t3, $t0
addi $t0, $zero, 0
sw $t0, 0($t1)
j L6314 
L6243:
lw $t1, -8($fp)
addi $t0, $zero, 0
bge $t1, $t0, L6246
L6355:
j L6245 
L6244:
j L6245 
L6249:
lw $t1, -8($fp)
lw $t0, -4($fp)
add $t1, $t1, $t0
addi $t0, $zero, 0
bge $t1, $t0, L6252
L6356:
j L6251 
L6250:
j L6251 
L6255:
lw $t0, -8($fp)
addi $t1, $t0, 7
lw $t0, -4($fp)
sub $t1, $t1, $t0
addi $t0, $zero, 0
bge $t1, $t0, L6258
L6357:
j L6257 
L6256:
j L6257 
L6261:
lw $t1, -4($fp)
addi $t0, $zero, 0
bge $t1, $t0, L6264
L6358:
j L6263 
L6262:
j L6263 
L6268:
lw $t1, -8($fp)
addi $t0, $zero, 0
bge $t1, $t0, L6271
L6359:
j L6270 
L6269:
j L6270 
L6274:
lw $t1, -8($fp)
lw $t0, -4($fp)
add $t1, $t1, $t0
addi $t0, $zero, 0
bge $t1, $t0, L6277
L6360:
j L6276 
L6275:
j L6276 
L6280:
lw $t0, -8($fp)
addi $t1, $t0, 7
lw $t0, -4($fp)
sub $t1, $t1, $t0
addi $t0, $zero, 0
bge $t1, $t0, L6283
L6361:
j L6282 
L6281:
j L6282 
L6351:
.text
tig_main:
#save calleesaves:
addi $sp, $sp, -116
sw $fp, 0($sp)
sw $ra, 20($sp)
sw $s0, 24($sp)
sw $s1, 28($sp)
sw $s2, 32($sp)
sw $s3, 36($sp)
sw $s4, 40($sp)
sw $s5, 44($sp)
sw $s6, 48($sp)
sw $s7, 52($sp)
addi $fp, $sp, 116
#save arguments:
sw $a0, -4($fp)
sw $a1, -8($fp)
sw $a2, -12($fp)
sw $a3, -16($fp)
#body:
addi $t0, $zero, 8
sw $t0, -4($fp)
addi $t0, $fp, -8
move $t1, $t0
lw $t0, -4($fp)
move $t0, $t0
#save arguments to reg
addi $a0, $t0, 1
#save arguments to reg
li $a1, 0
#save callersave
sw $t0, 56($sp)
sw $t1, 60($sp)
sw $t2, 64($sp)
sw $t3, 68($sp)
sw $t4, 72($sp)
sw $t5, 76($sp)
sw $t6, 80($sp)
sw $t7, 84($sp)
sw $t8, 88($sp)
sw $t9, 92($sp)
#call function
jal tig_initArray
#load callersave
lw $t9, 92($sp)
lw $t8, 88($sp)
lw $t7, 84($sp)
lw $t6, 80($sp)
lw $t5, 76($sp)
lw $t4, 72($sp)
lw $t3, 68($sp)
lw $t2, 64($sp)
lw $t1, 60($sp)
lw $t0, 56($sp)
#load callersave finish
#FP <- S7 finish here.:
move $t2, $v0
sw $t0, 0($t2)
sw $t2, 0($t1)
addi $t0, $fp, -12
move $t1, $t0
lw $t0, -4($fp)
move $t0, $t0
#save arguments to reg
addi $a0, $t0, 1
#save arguments to reg
li $a1, 0
#save callersave
sw $t0, 56($sp)
sw $t1, 60($sp)
sw $t2, 64($sp)
sw $t3, 68($sp)
sw $t4, 72($sp)
sw $t5, 76($sp)
sw $t6, 80($sp)
sw $t7, 84($sp)
sw $t8, 88($sp)
sw $t9, 92($sp)
#call function
jal tig_initArray
#load callersave
lw $t9, 92($sp)
lw $t8, 88($sp)
lw $t7, 84($sp)
lw $t6, 80($sp)
lw $t5, 76($sp)
lw $t4, 72($sp)
lw $t3, 68($sp)
lw $t2, 64($sp)
lw $t1, 60($sp)
lw $t0, 56($sp)
#load callersave finish
#FP <- S7 finish here.:
move $t2, $v0
sw $t0, 0($t2)
sw $t2, 0($t1)
addi $t0, $fp, -16
move $t2, $t0
lw $t1, -4($fp)
lw $t0, -4($fp)
add $t1, $t1, $t0
addi $t0, $zero, 1
sub $t0, $t1, $t0
move $t0, $t0
#save arguments to reg
addi $a0, $t0, 1
#save arguments to reg
li $a1, 0
#save callersave
sw $t0, 56($sp)
sw $t1, 60($sp)
sw $t2, 64($sp)
sw $t3, 68($sp)
sw $t4, 72($sp)
sw $t5, 76($sp)
sw $t6, 80($sp)
sw $t7, 84($sp)
sw $t8, 88($sp)
sw $t9, 92($sp)
#call function
jal tig_initArray
#load callersave
lw $t9, 92($sp)
lw $t8, 88($sp)
lw $t7, 84($sp)
lw $t6, 80($sp)
lw $t5, 76($sp)
lw $t4, 72($sp)
lw $t3, 68($sp)
lw $t2, 64($sp)
lw $t1, 60($sp)
lw $t0, 56($sp)
#load callersave finish
#FP <- S7 finish here.:
move $t1, $v0
sw $t0, 0($t1)
sw $t1, 0($t2)
addi $t0, $fp, -20
move $t2, $t0
lw $t1, -4($fp)
lw $t0, -4($fp)
add $t1, $t1, $t0
addi $t0, $zero, 1
sub $t0, $t1, $t0
move $t0, $t0
#save arguments to reg
addi $a0, $t0, 1
#save arguments to reg
li $a1, 0
#save callersave
sw $t0, 56($sp)
sw $t1, 60($sp)
sw $t2, 64($sp)
sw $t3, 68($sp)
sw $t4, 72($sp)
sw $t5, 76($sp)
sw $t6, 80($sp)
sw $t7, 84($sp)
sw $t8, 88($sp)
sw $t9, 92($sp)
#call function
jal tig_initArray
#load callersave
lw $t9, 92($sp)
lw $t8, 88($sp)
lw $t7, 84($sp)
lw $t6, 80($sp)
lw $t5, 76($sp)
lw $t4, 72($sp)
lw $t3, 68($sp)
lw $t2, 64($sp)
lw $t1, 60($sp)
lw $t0, 56($sp)
#load callersave finish
#FP <- S7 finish here.:
move $t1, $v0
sw $t0, 0($t1)
sw $t1, 0($t2)
#save arguments to reg
li $a0, 0
#update static link for FP
move $s7, $fp
move $fp, $fp
#save callersave
sw $t0, 56($sp)
sw $t1, 60($sp)
sw $t2, 64($sp)
sw $t3, 68($sp)
sw $t4, 72($sp)
sw $t5, 76($sp)
sw $t6, 80($sp)
sw $t7, 84($sp)
sw $t8, 88($sp)
sw $t9, 92($sp)
#call function
jal try
#load callersave
lw $t9, 92($sp)
lw $t8, 88($sp)
lw $t7, 84($sp)
lw $t6, 80($sp)
lw $t5, 76($sp)
lw $t4, 72($sp)
lw $t3, 68($sp)
lw $t2, 64($sp)
lw $t1, 60($sp)
lw $t0, 56($sp)
#load callersave finish
move $fp, $s7
#FP <- S7 finish here.:
move $v0, $v0
#load calleesaves:
lw $s7, 52($sp)
lw $s6, 48($sp)
lw $s5, 44($sp)
lw $s4, 40($sp)
lw $s3, 36($sp)
lw $s2, 32($sp)
lw $s1, 28($sp)
lw $s0, 24($sp)
lw $ra, 20($sp)
lw $t0, 0($sp)
move $fp, $t0
addi $sp, $sp, 116
jr $ra
L6447:



	#.file	1 "runtime.c"
	.option pic2
	.text
	.align 4
	.globl	tig_initArray
	.ent	tig_initArray
tig_initArray:
.LFB1:
	.frame	$fp,64,$ra		# vars= 16, regs= 3/0, args= 0, extra= 16
	.mask	0xd0000000,-16
	.fmask	0x00000000,0
	subu	$sp,$sp,64
.LCFI0:
	sd	$ra,48($sp)
.LCFI1:
	sd	$fp,40($sp)
.LCFI2:
.LCFI3:
	move	$fp,$sp
.LCFI4:
	.set	noat
	.set	at
	sw	$a0,16($fp)
	sw	$a1,20($fp)
	lw	$v1,16($fp)
	addu	$v0,$v1,1
	move	$v1,$v0
	sll	$v0,$v1,2
	move	$a0,$v0
	la	$t9,malloc
	jal	$ra,$t9
	sw	$v0,28($fp)
	lw	$v0,28($fp)
	lw	$v1,16($fp)
	sw	$v1,0($v0)
	li	$v0,1			# 0x1
	sw	$v0,24($fp)
.L3:
	lw	$v1,16($fp)
	addu	$v0,$v1,1
	lw	$v1,24($fp)
	slt	$v0,$v1,$v0
	bne	$v0,$zero,.L6
	b	.L4
.L6:
	lw	$v0,24($fp)
	move	$v1,$v0
	sll	$v0,$v1,2
	lw	$v1,28($fp)
	addu	$v0,$v0,$v1
	lw	$v1,20($fp)
	sw	$v1,0($v0)
.L5:
	lw	$v0,24($fp)
	addu	$v1,$v0,1
	sw	$v1,24($fp)
	b	.L3
.L4:
	lw	$v1,28($fp)
	move	$v0,$v1
	b	.L2
.L2:
	move	$sp,$fp
	ld	$ra,48($sp)
	ld	$fp,40($sp)
	addu	$sp,$sp,64
	j	$ra
.LFE1:
	.end	tig_initArray
	.align 4
	.globl	tig_allocRecord
	.ent	tig_allocRecord
tig_allocRecord:
.LFB2:
	.frame	$fp,64,$ra		# vars= 16, regs= 3/0, args= 0, extra= 16
	.mask	0xd0000000,-16
	.fmask	0x00000000,0
	subu	$sp,$sp,64
.LCFI5:
	sd	$ra,48($sp)
.LCFI6:
	sd	$fp,40($sp)
.LCFI7:
.LCFI8:
	move	$fp,$sp
.LCFI9:
	.set	noat
	.set	at
	sw	$a0,16($fp)
	lw	$a0,16($fp)
	la	$t9,malloc
	jal	$ra,$t9
	move	$v1,$v0
	move	$v0,$v1
	sw	$v0,28($fp)
	sw	$v0,24($fp)
	sw	$zero,20($fp)
.L8:
	lw	$v0,20($fp)
	lw	$v1,16($fp)
	slt	$v0,$v0,$v1
	bne	$v0,$zero,.L11
	b	.L9
.L11:
	addu	$v0,$fp,24
	lw	$v1,0($v0)
	sw	$zero,0($v1)
	addu	$v1,$v1,4
	sw	$v1,0($v0)
.L10:
	lw	$v0,20($fp)
	addu	$v1,$v0,4
	sw	$v1,20($fp)
	b	.L8
.L9:
	lw	$v1,28($fp)
	move	$v0,$v1
	b	.L7
.L7:
	move	$sp,$fp
	ld	$ra,48($sp)
	ld	$fp,40($sp)
	addu	$sp,$sp,64
	j	$ra
.LFE2:
	.end	tig_allocRecord
	.align 4
	.globl	tig_stringEqual
	.ent	tig_stringEqual
tig_stringEqual:
.LFB3:
	.frame	$fp,48,$ra		# vars= 16, regs= 2/0, args= 0, extra= 16
	.mask	0x50000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
.LCFI10:
	sd	$fp,40($sp)
.LCFI11:
.LCFI12:
	move	$fp,$sp
.LCFI13:
	.set	noat
	.set	at
	sw	$a0,16($fp)
	sw	$a1,20($fp)
	lw	$v0,16($fp)
	lw	$v1,20($fp)
	bne	$v0,$v1,.L13
	li	$v0,1			# 0x1
	b	.L12
.L13:
	lw	$v0,16($fp)
	lw	$v1,20($fp)
	lw	$v0,0($v0)
	lw	$v1,0($v1)
	beq	$v0,$v1,.L14
	move	$v0,$zero
	b	.L12
.L14:
	.set	noreorder
	nop
	.set	reorder
	sw	$zero,24($fp)
.L15:
	lw	$v0,16($fp)
	lw	$v1,24($fp)
	lw	$v0,0($v0)
	slt	$v1,$v1,$v0
	bne	$v1,$zero,.L18
	b	.L16
.L18:
	lw	$v0,16($fp)
	addu	$v1,$v0,4
	lw	$a0,24($fp)
	addu	$v0,$v1,$a0
	lw	$v1,20($fp)
	addu	$a0,$v1,4
	lw	$v1,24($fp)
	addu	$a0,$a0,$v1
	lbu	$v0,0($v0)
	lbu	$v1,0($a0)
	beq	$v0,$v1,.L17
	move	$v0,$zero
	b	.L12
.L19:
.L17:
	lw	$v0,24($fp)
	addu	$v1,$v0,1
	sw	$v1,24($fp)
	b	.L15
.L16:
	li	$v0,1			# 0x1
	b	.L12
.L12:
	move	$sp,$fp
	ld	$fp,40($sp)
	addu	$sp,$sp,48
	j	$ra
.LFE3:
	.end	tig_stringEqual
	.align 4
	.globl	tig_print
	.ent	tig_print
tig_print:
.LFB4:
	.frame	$fp,64,$ra		# vars= 16, regs= 3/0, args= 0, extra= 16
	.mask	0xd0000000,-16
	.fmask	0x00000000,0
	subu	$sp,$sp,64
.LCFI14:
	sd	$ra,48($sp)
.LCFI15:
	sd	$fp,40($sp)
.LCFI16:
.LCFI17:
	move	$fp,$sp
.LCFI18:
	.set	noat
	.set	at
	sw	$a0,16($fp)
	lw	$v0,16($fp)
	addu	$v1,$v0,4
	sw	$v1,24($fp)
	sw	$zero,20($fp)
.L21:
	lw	$v0,16($fp)
	lw	$v1,20($fp)
	lw	$v0,0($v0)
	slt	$v1,$v1,$v0
	bne	$v1,$zero,.L24
	b	.L22
.L24:
	lw	$v0,24($fp)
	lbu	$v1,0($v0)
	move	$a0,$v1
	la	$t9,putchar
	jal	$ra,$t9
.L23:
	lw	$v0,20($fp)
	addu	$v1,$v0,1
	sw	$v1,20($fp)
	lw	$v0,24($fp)
	addu	$v1,$v0,1
	sw	$v1,24($fp)
	b	.L21
.L22:
.L20:
	move	$sp,$fp
	ld	$ra,48($sp)
	ld	$fp,40($sp)
	addu	$sp,$sp,64
	j	$ra
.LFE4:
	.end	tig_print
	.globl	consts
	.data
	.align 4
consts:
	.word	0

	.byte	0x0
	.space	3
	.space	2040
	.globl	empty
	.align 4
empty:
	.word	0

	.byte	0x0
	.space	3
	.text
	.align 4
	.globl	main
	.ent	main
main:
.LFB5:
	.frame	$fp,64,$ra		# vars= 16, regs= 3/0, args= 0, extra= 16
	.mask	0xd0000000,-16
	.fmask	0x00000000,0
	subu	$sp,$sp,64
.LCFI19:
	sd	$ra,48($sp)
.LCFI20:
	sd	$fp,40($sp)
.LCFI21:
.LCFI22:
	move	$fp,$sp
.LCFI23:
	.set	noat
	.set	at
	.set	noreorder
	nop
	.set	reorder
	sw	$zero,16($fp)
.L26:
	lw	$v0,16($fp)
	slt	$v1,$v0,256
	bne	$v1,$zero,.L29
	b	.L27
.L29:
	lw	$v0,16($fp)
	move	$v1,$v0
	sll	$v0,$v1,3
	la	$v1,consts
	addu	$v0,$v1,$v0
	li	$v1,1			# 0x1
	sw	$v1,0($v0)
	lw	$v0,16($fp)
	move	$v1,$v0
	sll	$v0,$v1,3
	la	$v1,consts
	addu	$v0,$v0,$v1
	lbu	$v1,16($fp)
	sb	$v1,4($v0)
.L28:
	lw	$v0,16($fp)
	addu	$v1,$v0,1
	sw	$v1,16($fp)
	b	.L26
.L27:
	move	$a0,$zero
	la	$t9,tig_main
	jal	$t9
	move	$v1,$v0
	move	$v0,$v1
	b	.L25
.L25:
	move	$sp,$fp
	ld	$ra,48($sp)
	ld	$fp,40($sp)
	addu	$sp,$sp,64
	j	$ra
.LFE5:
	.end	main
	.align 4
	.globl	tig_ord
	.ent	tig_ord
tig_ord:
.LFB6:
	.frame	$fp,48,$ra		# vars= 16, regs= 2/0, args= 0, extra= 16
	.mask	0x50000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
.LCFI24:
	sd	$fp,40($sp)
.LCFI25:
.LCFI26:
	move	$fp,$sp
.LCFI27:
	.set	noat
	.set	at
	sw	$a0,16($fp)
	lw	$v0,16($fp)
	lw	$v1,0($v0)
	bne	$v1,$zero,.L31
	li	$v0,-1			# 0xffffffff
	b	.L30
	b	.L32
.L31:
	lw	$v0,16($fp)
	lbu	$v1,4($v0)
	move	$v0,$v1
	b	.L30
.L32:
.L30:
	move	$sp,$fp
	ld	$fp,40($sp)
	addu	$sp,$sp,48
	j	$ra
.LFE6:
	.end	tig_ord
	.align 4
	.globl	tig_chr
	.ent	tig_chr
tig_chr:
.LFB7:
	.frame	$fp,64,$ra		# vars= 16, regs= 3/0, args= 0, extra= 16
	.mask	0xd0000000,-16
	.fmask	0x00000000,0
	subu	$sp,$sp,64
.LCFI28:
	sd	$ra,48($sp)
.LCFI29:
	sd	$fp,40($sp)
.LCFI30:
.LCFI31:
	move	$fp,$sp
.LCFI32:
	.set	noat
	.set	at
	sw	$a0,16($fp)
	lw	$v0,16($fp)
	bltz	$v0,.L35
	lw	$v0,16($fp)
	slt	$v1,$v0,256
	beq	$v1,$zero,.L35
	b	.L34
.L35:
	li	$a0,1			# 0x1
	la	$t9,exit
	jal	$ra,$t9
.L34:
	lw	$v0,16($fp)
	move	$v1,$v0
	sll	$v0,$v1,3
	la	$a0,consts
	addu	$v1,$v0,$a0
	move	$v0,$v1
	b	.L33
.L33:
	move	$sp,$fp
	ld	$ra,48($sp)
	ld	$fp,40($sp)
	addu	$sp,$sp,64
	j	$ra
.LFE7:
	.end	tig_chr
	.align 4
	.globl	tig_size
	.ent	tig_size
tig_size:
.LFB8:
	.frame	$fp,48,$ra		# vars= 16, regs= 2/0, args= 0, extra= 16
	.mask	0x50000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
.LCFI33:
	sd	$fp,40($sp)
.LCFI34:
.LCFI35:
	move	$fp,$sp
.LCFI36:
	.set	noat
	.set	at
	sw	$a0,16($fp)
	lw	$v0,16($fp)
	lw	$v1,0($v0)
	move	$v0,$v1
	b	.L36
.L36:
	move	$sp,$fp
	ld	$fp,40($sp)
	addu	$sp,$sp,48
	j	$ra
.LFE8:
	.end	tig_size
.data
	.align 4
.LC0:

	.byte	0x73,0x75,0x62,0x73,0x74,0x72,0x69,0x6e
	.byte	0x67,0x28,0x5b,0x25,0x64,0x5d,0x2c,0x25
	.byte	0x64,0x2c,0x25,0x64,0x29,0x20,0x6f,0x75
	.byte	0x74,0x20,0x6f,0x66,0x20,0x72,0x61,0x6e
	.byte	0x67,0x65,0xa,0x0
	.text
	.align 4
	.globl	tig_substring
	.ent	tig_substring
tig_substring:
.LFB9:
	.frame	$fp,80,$ra		# vars= 32, regs= 3/0, args= 0, extra= 16
	.mask	0xd0000000,-16
	.fmask	0x00000000,0
	subu	$sp,$sp,80
.LCFI37:
	sd	$ra,64($sp)
.LCFI38:
	sd	$fp,56($sp)
.LCFI39:
.LCFI40:
	move	$fp,$sp
.LCFI41:
	.set	noat
	.set	at
	sw	$a0,16($fp)
	sw	$a1,20($fp)
	sw	$a2,24($fp)
	lw	$v0,20($fp)
	bltz	$v0,.L39
	lw	$v0,20($fp)
	lw	$v1,24($fp)
	addu	$v0,$v0,$v1
	lw	$v1,16($fp)
	lw	$a0,0($v1)
	slt	$v0,$a0,$v0
	bne	$v0,$zero,.L39
	b	.L38
.L39:
	lw	$v0,16($fp)
	la	$a0,.LC0
	lw	$a1,0($v0)
	lw	$a2,20($fp)
	lw	$a3,24($fp)
	la	$t9,printf
	jal	$ra,$t9
	li	$a0,1			# 0x1
	la	$t9,exit
	jal	$ra,$t9
.L38:
	lw	$v0,24($fp)
	li	$v1,1			# 0x1
	bne	$v0,$v1,.L40
	lw	$v0,16($fp)
	addu	$v1,$v0,4
	lw	$v0,20($fp)
	addu	$v1,$v1,$v0
	lbu	$v0,0($v1)
	move	$v1,$v0
	sll	$v0,$v1,3
	la	$a0,consts
	addu	$v1,$v0,$a0
	move	$v0,$v1
	b	.L37
.L40:
	lw	$v1,24($fp)
	addu	$v0,$v1,4
	move	$a0,$v0
	la	$t9,malloc
	jal	$ra,$t9
	sw	$v0,28($fp)
	lw	$v0,28($fp)
	lw	$v1,24($fp)
	sw	$v1,0($v0)
	sw	$zero,32($fp)
.L41:
	lw	$v0,32($fp)
	lw	$v1,24($fp)
	slt	$v0,$v0,$v1
	bne	$v0,$zero,.L44
	b	.L42
.L44:
	lw	$v0,28($fp)
	addu	$v1,$v0,4
	lw	$a0,32($fp)
	addu	$v0,$v1,$a0
	lw	$v1,16($fp)
	lw	$a0,20($fp)
	lw	$a1,32($fp)
	addu	$a0,$a0,$a1
	addu	$v1,$v1,4
	addu	$a0,$v1,$a0
	lbu	$v1,0($a0)
	sb	$v1,0($v0)
.L43:
	lw	$v0,32($fp)
	addu	$v1,$v0,1
	sw	$v1,32($fp)
	b	.L41
.L42:
	lw	$v1,28($fp)
	move	$v0,$v1
	b	.L37
.L37:
	move	$sp,$fp
	ld	$ra,64($sp)
	ld	$fp,56($sp)
	addu	$sp,$sp,80
	j	$ra
.LFE9:
	.end	tig_substring
	.align 4
	.globl	tig_concat
	.ent	tig_concat
tig_concat:
.LFB10:
	.frame	$fp,80,$ra		# vars= 32, regs= 3/0, args= 0, extra= 16
	.mask	0xd0000000,-16
	.fmask	0x00000000,0
	subu	$sp,$sp,80
.LCFI42:
	sd	$ra,64($sp)
.LCFI43:
	sd	$fp,56($sp)
.LCFI44:
.LCFI45:
	move	$fp,$sp
.LCFI46:
	.set	noat
	.set	at
	sw	$a0,16($fp)
	sw	$a1,20($fp)
	lw	$v0,16($fp)
	lw	$v1,0($v0)
	bne	$v1,$zero,.L46
	lw	$v1,20($fp)
	move	$v0,$v1
	b	.L45
	b	.L47
.L46:
	lw	$v0,20($fp)
	lw	$v1,0($v0)
	bne	$v1,$zero,.L48
	lw	$v1,16($fp)
	move	$v0,$v1
	b	.L45
	b	.L47
.L48:
	lw	$v0,16($fp)
	lw	$v1,20($fp)
	lw	$v0,0($v0)
	lw	$v1,0($v1)
	addu	$v0,$v0,$v1
	sw	$v0,28($fp)
	lw	$v1,28($fp)
	addu	$v0,$v1,4
	move	$a0,$v0
	la	$t9,malloc
	jal	$ra,$t9
	sw	$v0,32($fp)
	lw	$v0,32($fp)
	lw	$v1,28($fp)
	sw	$v1,0($v0)
	sw	$zero,24($fp)
.L50:
	lw	$v0,16($fp)
	lw	$v1,24($fp)
	lw	$v0,0($v0)
	slt	$v1,$v1,$v0
	bne	$v1,$zero,.L53
	b	.L51
.L53:
	lw	$v0,32($fp)
	addu	$v1,$v0,4
	lw	$a0,24($fp)
	addu	$v0,$v1,$a0
	lw	$v1,16($fp)
	addu	$a0,$v1,4
	lw	$v1,24($fp)
	addu	$a0,$a0,$v1
	lbu	$v1,0($a0)
	sb	$v1,0($v0)
.L52:
	lw	$v0,24($fp)
	addu	$v1,$v0,1
	sw	$v1,24($fp)
	b	.L50
.L51:
	.set	noreorder
	nop
	.set	reorder
	sw	$zero,24($fp)
.L54:
	lw	$v0,20($fp)
	lw	$v1,24($fp)
	lw	$v0,0($v0)
	slt	$v1,$v1,$v0
	bne	$v1,$zero,.L57
	b	.L55
.L57:
	lw	$v0,32($fp)
	lw	$v1,16($fp)
	lw	$a0,24($fp)
	lw	$a1,0($v1)
	addu	$v1,$a0,$a1
	addu	$a0,$v0,4
	addu	$v0,$a0,$v1
	lw	$v1,20($fp)
	addu	$a0,$v1,4
	lw	$v1,24($fp)
	addu	$a0,$a0,$v1
	lbu	$v1,0($a0)
	sb	$v1,0($v0)
.L56:
	lw	$v0,24($fp)
	addu	$v1,$v0,1
	sw	$v1,24($fp)
	b	.L54
.L55:
	lw	$v1,32($fp)
	move	$v0,$v1
	b	.L45
.L49:
.L47:
.L45:
	move	$sp,$fp
	ld	$ra,64($sp)
	ld	$fp,56($sp)
	addu	$sp,$sp,80
	j	$ra
.LFE10:
	.end	tig_concat
	.align 4
	.globl	tig_not
	.ent	tig_not
tig_not:
.LFB11:
	.frame	$fp,48,$ra		# vars= 16, regs= 2/0, args= 0, extra= 16
	.mask	0x50000000,-8
	.fmask	0x00000000,0
	subu	$sp,$sp,48
.LCFI47:
	sd	$fp,40($sp)
.LCFI48:
.LCFI49:
	move	$fp,$sp
.LCFI50:
	.set	noat
	.set	at
	sw	$a0,16($fp)
	lw	$v0,16($fp)
	xori	$a0,$v0,0x0
	sltu	$v1,$a0,1
	move	$v0,$v1
	b	.L58
.L58:
	move	$sp,$fp
	ld	$fp,40($sp)
	addu	$sp,$sp,48
	j	$ra
.LFE11:
	.end	tig_not
	.align 4
	.globl	tig_getchar
	.ent	tig_getchar
tig_getchar:
.LFB12:
	.frame	$fp,48,$ra		# vars= 0, regs= 3/0, args= 0, extra= 16
	.mask	0xd0000000,-16
	.fmask	0x00000000,0
	subu	$sp,$sp,48
.LCFI51:
	sd	$ra,32($sp)
.LCFI52:
	sd	$fp,24($sp)
.LCFI53:
.LCFI54:
	move	$fp,$sp
.LCFI55:
	.set	noat
	.set	at
	la	$t9,getchar
	jal	$ra,$t9
	move	$a0,$v0
	la	$t9,tig_chr
	jal	$ra,$t9
	move	$v1,$v0
	move	$v0,$v1
	b	.L59
.L59:
	move	$sp,$fp
	ld	$ra,32($sp)
	ld	$fp,24($sp)
	addu	$sp,$sp,48
	j	$ra
.LFE12:
	.end	tig_getchar
tig_flush:
  j $ra
  .end tig_flush
tig_exit:
  j exit
  .end tig_exit



# system calls for Tiger, when running on SPIM
#
# $Id: sysspim.s,v 1.1 2002/08/25 05:06:41 shivers Exp $

	.globl malloc
	.ent malloc
	.text
malloc:
	# round up the requested amount to a multiple of 4
	add $a0, $a0, 3
	srl $a0, $a0, 2
	sll $a0, $a0, 2

	# allocate the memory with sbrk()
	li $v0, 9
	syscall
	
	j $ra

	.end malloc

	

	.data
	.align 4
getchar_buf:	.byte 0,0

	.text
getchar:
	# read the character
	la $a0, getchar_buf
	li $a1, 2
	li $v0, 8
	syscall

	# return it
	lb $v0, ($a0)
	j $ra
	

	.data
	.align 4
putchar_buf:	.byte 0,0

	.text
putchar:
	# save the character so that it is NUL-terminated 
	la $t0, putchar_buf
	sb $a0, ($t0)

	# print it out
	la $a0, putchar_buf
	li $v0, 4
	syscall

	j $ra


	.text	
# just prints the format string, not the arguments
printf:
	li $v0, 4
	syscall
	j $ra


	.text
exit:
	li $v0, 10
	syscall
	
