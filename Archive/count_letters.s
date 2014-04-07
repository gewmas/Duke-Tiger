## int
## count_letters(char str[], int str_len, char c) {
##   int count = 0;
##   for (int i = 0 ; i < str_len ; ++ i) {
## 	 if (str[i] == c) {
## 		count ++;
## 	 }
##   }
##   return count;
## }

.data 

str:  .asciiz	"how is everything?"
str2: .asciiz	"ssasasassassaaa"
substr: .asciiz "sa"

.text

main:
	sub	$sp, $sp, 4
	sw	$ra, 0($sp)

	la	$a0, str
	li	$a1, 18
	li	$a2, 'v'
	jal	count_letters
	move	$a0, $v0
	jal	print
	
	la	$a0, str2
	li	$a1, 15
	la	$a2, substr
	li	$a3, 2
	jal	count_substring
	move	$a0, $v0
	jal	print

	lw	$ra, 0($sp)
	add	$sp, $sp, 4
	jr	$ra

# print function
#
# argument $a0: number to print

print:
	li   	$v0, 1         # load the syscall option for printing ints
	syscall              # print the element

	li   	$a0, 32        # print a black space (ASCII 32)
	li   	$v0, 11        # load the syscall option for printingchars
	syscall              # print the char
	
	jr      $ra          # return to the calling procedure



count_letters:
	li	$v0, 0		# count
	li	$t0, 0		# i
cl_loop:
	bge	$t0, $a1, cl_exit
	add	$t1, $a0, $t0	# &A[i]
	lb	$t2, 0($t1)	# A[i]
	bne	$t2, $a2, cl_skip

	add	$v0, $v0, 1
	
cl_skip: 
	 add	$t0, $t0, 1
	 j	cl_loop

cl_exit:
	jr	$ra


## ------

count_substring:
	li	$v0, 0		# count
	li	$t0, 0		# i
	sub	$t1, $a1, $a3	# str_len - substr_len
cs_loop:
	bge	$t0, $t1, cs_exit	

	li	$t2, 1	  	# match = TRUE
	li	$t3, 0		# j
	
cs_iloop:
	bge	$t3, $a3, cs_done_inner

	add	$t4, $a0, $t0	# &str[i]
	add	$t4, $t4, $t3	# &str[i+j]
	lb	$t4, 0($t4)	# str[i+j]
	add	$t5, $a2, $t3	# &sub_str[j]
	lb	$t5, 0($t5)	# sub_str[j]
	beq 	$t4, $t5, cs_skip

	li	$t2, 0		# match = FALSE
	j	cs_done_inner	# break

cs_skip:
	add	$t3, $t3, 1	# j ++
	j	cs_iloop

cs_done_inner:
	beq	$t2, $0, cs_skip2

	add	$v0, $v0, 1	# count ++

cs_skip2:
	add	$t0, $t0, 1	# i ++
	j	cs_loop

cs_exit:
	jr	$ra		# return count
