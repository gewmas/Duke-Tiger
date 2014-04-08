	.section	__TEXT,__text,regular,pure_instructions
	.globl	_initArray
	.align	4, 0x90
_initArray:                             ## @initArray
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp2:
	.cfi_def_cfa_offset 16
Ltmp3:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp4:
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movl	%edi, -4(%rbp)
	movl	%esi, -8(%rbp)
	movslq	-4(%rbp), %rax
	shlq	$2, %rax
	movq	%rax, %rdi
	callq	_malloc
	movq	%rax, -24(%rbp)
	movl	$0, -12(%rbp)
LBB0_1:                                 ## =>This Inner Loop Header: Depth=1
	movl	-12(%rbp), %eax
	cmpl	-4(%rbp), %eax
	jge	LBB0_4
## BB#2:                                ##   in Loop: Header=BB0_1 Depth=1
	movl	-8(%rbp), %eax
	movslq	-12(%rbp), %rcx
	movq	-24(%rbp), %rdx
	movl	%eax, (%rdx,%rcx,4)
## BB#3:                                ##   in Loop: Header=BB0_1 Depth=1
	movl	-12(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -12(%rbp)
	jmp	LBB0_1
LBB0_4:
	movq	-24(%rbp), %rax
	addq	$32, %rsp
	popq	%rbp
	ret
	.cfi_endproc

	.globl	_allocRecord
	.align	4, 0x90
_allocRecord:                           ## @allocRecord
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp7:
	.cfi_def_cfa_offset 16
Ltmp8:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp9:
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movl	%edi, -4(%rbp)
	movslq	-4(%rbp), %rdi
	callq	_malloc
	movq	%rax, -24(%rbp)
	movq	%rax, -16(%rbp)
	movl	$0, -8(%rbp)
LBB1_1:                                 ## =>This Inner Loop Header: Depth=1
	movl	-8(%rbp), %eax
	cmpl	-4(%rbp), %eax
	jge	LBB1_4
## BB#2:                                ##   in Loop: Header=BB1_1 Depth=1
	movq	-16(%rbp), %rax
	movq	%rax, %rcx
	addq	$4, %rcx
	movq	%rcx, -16(%rbp)
	movl	$0, (%rax)
## BB#3:                                ##   in Loop: Header=BB1_1 Depth=1
	movslq	-8(%rbp), %rax
	addq	$4, %rax
	movl	%eax, %ecx
	movl	%ecx, -8(%rbp)
	jmp	LBB1_1
LBB1_4:
	movq	-24(%rbp), %rax
	addq	$32, %rsp
	popq	%rbp
	ret
	.cfi_endproc

	.globl	_stringEqual
	.align	4, 0x90
_stringEqual:                           ## @stringEqual
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp12:
	.cfi_def_cfa_offset 16
Ltmp13:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp14:
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movq	-16(%rbp), %rsi
	cmpq	-24(%rbp), %rsi
	jne	LBB2_2
## BB#1:
	movl	$1, -4(%rbp)
	jmp	LBB2_11
LBB2_2:
	movq	-16(%rbp), %rax
	movl	(%rax), %ecx
	movq	-24(%rbp), %rax
	cmpl	(%rax), %ecx
	je	LBB2_4
## BB#3:
	movl	$0, -4(%rbp)
	jmp	LBB2_11
LBB2_4:
	movl	$0, -28(%rbp)
LBB2_5:                                 ## =>This Inner Loop Header: Depth=1
	movl	-28(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	(%rcx), %eax
	jge	LBB2_10
## BB#6:                                ##   in Loop: Header=BB2_5 Depth=1
	movslq	-28(%rbp), %rax
	movq	-16(%rbp), %rcx
	movzbl	4(%rcx,%rax), %edx
	movslq	-28(%rbp), %rax
	movq	-24(%rbp), %rcx
	movzbl	4(%rcx,%rax), %esi
	cmpl	%esi, %edx
	je	LBB2_8
## BB#7:
	movl	$0, -4(%rbp)
	jmp	LBB2_11
LBB2_8:                                 ##   in Loop: Header=BB2_5 Depth=1
	jmp	LBB2_9
LBB2_9:                                 ##   in Loop: Header=BB2_5 Depth=1
	movl	-28(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -28(%rbp)
	jmp	LBB2_5
LBB2_10:
	movl	$1, -4(%rbp)
LBB2_11:
	movl	-4(%rbp), %eax
	popq	%rbp
	ret
	.cfi_endproc

	.globl	_print
	.align	4, 0x90
_print:                                 ## @print
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp17:
	.cfi_def_cfa_offset 16
Ltmp18:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp19:
	.cfi_def_cfa_register %rbp
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rdi
	addq	$4, %rdi
	movq	%rdi, -24(%rbp)
	movl	$0, -12(%rbp)
LBB3_1:                                 ## =>This Inner Loop Header: Depth=1
	movl	-12(%rbp), %eax
	movq	-8(%rbp), %rcx
	cmpl	(%rcx), %eax
	jge	LBB3_4
## BB#2:                                ##   in Loop: Header=BB3_1 Depth=1
	movq	-24(%rbp), %rax
	movzbl	(%rax), %edi
	callq	_putchar
	movl	%eax, -28(%rbp)         ## 4-byte Spill
## BB#3:                                ##   in Loop: Header=BB3_1 Depth=1
	movl	-12(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -12(%rbp)
	movq	-24(%rbp), %rcx
	addq	$1, %rcx
	movq	%rcx, -24(%rbp)
	jmp	LBB3_1
LBB3_4:
	addq	$32, %rsp
	popq	%rbp
	ret
	.cfi_endproc

	.globl	_flush
	.align	4, 0x90
_flush:                                 ## @flush
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp22:
	.cfi_def_cfa_offset 16
Ltmp23:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp24:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movq	___stdoutp@GOTPCREL(%rip), %rax
	movq	(%rax), %rdi
	callq	_fflush
	movl	%eax, -4(%rbp)          ## 4-byte Spill
	addq	$16, %rsp
	popq	%rbp
	ret
	.cfi_endproc

	.globl	_main
	.align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp27:
	.cfi_def_cfa_offset 16
Ltmp28:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp29:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movl	$0, -4(%rbp)
	movl	$0, -8(%rbp)
LBB5_1:                                 ## =>This Inner Loop Header: Depth=1
	cmpl	$256, -8(%rbp)          ## imm = 0x100
	jge	LBB5_4
## BB#2:                                ##   in Loop: Header=BB5_1 Depth=1
	movq	_consts@GOTPCREL(%rip), %rax
	movslq	-8(%rbp), %rcx
	movl	$1, (%rax,%rcx,8)
	movl	-8(%rbp), %edx
	movb	%dl, %sil
	movslq	-8(%rbp), %rcx
	movb	%sil, 4(%rax,%rcx,8)
## BB#3:                                ##   in Loop: Header=BB5_1 Depth=1
	movl	-8(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -8(%rbp)
	jmp	LBB5_1
LBB5_4:
	movl	$0, %edi
	movb	$0, %al
	callq	_tigermain
	addq	$16, %rsp
	popq	%rbp
	ret
	.cfi_endproc

	.globl	_ord
	.align	4, 0x90
_ord:                                   ## @ord
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp32:
	.cfi_def_cfa_offset 16
Ltmp33:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp34:
	.cfi_def_cfa_register %rbp
	movq	%rdi, -16(%rbp)
	movq	-16(%rbp), %rdi
	cmpl	$0, (%rdi)
	jne	LBB6_2
## BB#1:
	movl	$-1, -4(%rbp)
	jmp	LBB6_3
LBB6_2:
	movq	-16(%rbp), %rax
	movzbl	4(%rax), %ecx
	movl	%ecx, -4(%rbp)
LBB6_3:
	movl	-4(%rbp), %eax
	popq	%rbp
	ret
	.cfi_endproc

	.globl	_chr
	.align	4, 0x90
_chr:                                   ## @chr
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp37:
	.cfi_def_cfa_offset 16
Ltmp38:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp39:
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	cmpl	$0, -4(%rbp)
	jl	LBB7_2
## BB#1:
	cmpl	$256, -4(%rbp)          ## imm = 0x100
	jl	LBB7_3
LBB7_2:
	leaq	L_.str(%rip), %rdi
	movl	-4(%rbp), %esi
	movb	$0, %al
	callq	_printf
	movl	$1, %edi
	movl	%eax, -8(%rbp)          ## 4-byte Spill
	callq	_exit
LBB7_3:
	movq	_consts@GOTPCREL(%rip), %rax
	movslq	-4(%rbp), %rcx
	shlq	$3, %rcx
	addq	%rcx, %rax
	addq	$16, %rsp
	popq	%rbp
	ret
	.cfi_endproc

	.globl	_size
	.align	4, 0x90
_size:                                  ## @size
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp42:
	.cfi_def_cfa_offset 16
Ltmp43:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp44:
	.cfi_def_cfa_register %rbp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rdi
	movl	(%rdi), %eax
	popq	%rbp
	ret
	.cfi_endproc

	.globl	_substring
	.align	4, 0x90
_substring:                             ## @substring
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp47:
	.cfi_def_cfa_offset 16
Ltmp48:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp49:
	.cfi_def_cfa_register %rbp
	subq	$48, %rsp
	movq	%rdi, -16(%rbp)
	movl	%esi, -20(%rbp)
	movl	%edx, -24(%rbp)
	cmpl	$0, -20(%rbp)
	jl	LBB9_2
## BB#1:
	movl	-20(%rbp), %eax
	addl	-24(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	(%rcx), %eax
	jle	LBB9_3
LBB9_2:
	leaq	L_.str1(%rip), %rdi
	movq	-16(%rbp), %rax
	movl	(%rax), %esi
	movl	-20(%rbp), %edx
	movl	-24(%rbp), %ecx
	movb	$0, %al
	callq	_printf
	movl	$1, %edi
	movl	%eax, -40(%rbp)         ## 4-byte Spill
	callq	_exit
LBB9_3:
	cmpl	$1, -24(%rbp)
	jne	LBB9_5
## BB#4:
	movq	_consts@GOTPCREL(%rip), %rax
	movslq	-20(%rbp), %rcx
	movq	-16(%rbp), %rdx
	movzbl	4(%rdx,%rcx), %esi
	movslq	%esi, %rcx
	shlq	$3, %rcx
	addq	%rcx, %rax
	movq	%rax, -8(%rbp)
	jmp	LBB9_10
LBB9_5:
	movslq	-24(%rbp), %rax
	addq	$4, %rax
	movq	%rax, %rdi
	callq	_malloc
	movq	%rax, -32(%rbp)
	movl	-24(%rbp), %ecx
	movq	-32(%rbp), %rax
	movl	%ecx, (%rax)
	movl	$0, -36(%rbp)
LBB9_6:                                 ## =>This Inner Loop Header: Depth=1
	movl	-36(%rbp), %eax
	cmpl	-24(%rbp), %eax
	jge	LBB9_9
## BB#7:                                ##   in Loop: Header=BB9_6 Depth=1
	movl	-20(%rbp), %eax
	addl	-36(%rbp), %eax
	movslq	%eax, %rcx
	movq	-16(%rbp), %rdx
	movb	4(%rdx,%rcx), %sil
	movslq	-36(%rbp), %rcx
	movq	-32(%rbp), %rdx
	movb	%sil, 4(%rdx,%rcx)
## BB#8:                                ##   in Loop: Header=BB9_6 Depth=1
	movl	-36(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -36(%rbp)
	jmp	LBB9_6
LBB9_9:
	movq	-32(%rbp), %rax
	movq	%rax, -8(%rbp)
LBB9_10:
	movq	-8(%rbp), %rax
	addq	$48, %rsp
	popq	%rbp
	ret
	.cfi_endproc

	.globl	_concat
	.align	4, 0x90
_concat:                                ## @concat
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp52:
	.cfi_def_cfa_offset 16
Ltmp53:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp54:
	.cfi_def_cfa_register %rbp
	subq	$48, %rsp
	movq	%rdi, -16(%rbp)
	movq	%rsi, -24(%rbp)
	movq	-16(%rbp), %rsi
	cmpl	$0, (%rsi)
	jne	LBB10_2
## BB#1:
	movq	-24(%rbp), %rax
	movq	%rax, -8(%rbp)
	jmp	LBB10_13
LBB10_2:
	movq	-24(%rbp), %rax
	cmpl	$0, (%rax)
	jne	LBB10_4
## BB#3:
	movq	-16(%rbp), %rax
	movq	%rax, -8(%rbp)
	jmp	LBB10_13
LBB10_4:
	movq	-16(%rbp), %rax
	movl	(%rax), %ecx
	movq	-24(%rbp), %rax
	addl	(%rax), %ecx
	movl	%ecx, -32(%rbp)
	movslq	-32(%rbp), %rax
	addq	$4, %rax
	movq	%rax, %rdi
	callq	_malloc
	movq	%rax, -40(%rbp)
	movl	-32(%rbp), %ecx
	movq	-40(%rbp), %rax
	movl	%ecx, (%rax)
	movl	$0, -28(%rbp)
LBB10_5:                                ## =>This Inner Loop Header: Depth=1
	movl	-28(%rbp), %eax
	movq	-16(%rbp), %rcx
	cmpl	(%rcx), %eax
	jge	LBB10_8
## BB#6:                                ##   in Loop: Header=BB10_5 Depth=1
	movslq	-28(%rbp), %rax
	movq	-16(%rbp), %rcx
	movb	4(%rcx,%rax), %dl
	movslq	-28(%rbp), %rax
	movq	-40(%rbp), %rcx
	movb	%dl, 4(%rcx,%rax)
## BB#7:                                ##   in Loop: Header=BB10_5 Depth=1
	movl	-28(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -28(%rbp)
	jmp	LBB10_5
LBB10_8:
	movl	$0, -28(%rbp)
LBB10_9:                                ## =>This Inner Loop Header: Depth=1
	movl	-28(%rbp), %eax
	movq	-24(%rbp), %rcx
	cmpl	(%rcx), %eax
	jge	LBB10_12
## BB#10:                               ##   in Loop: Header=BB10_9 Depth=1
	movslq	-28(%rbp), %rax
	movq	-24(%rbp), %rcx
	movb	4(%rcx,%rax), %dl
	movl	-28(%rbp), %esi
	movq	-16(%rbp), %rax
	addl	(%rax), %esi
	movslq	%esi, %rax
	movq	-40(%rbp), %rcx
	movb	%dl, 4(%rcx,%rax)
## BB#11:                               ##   in Loop: Header=BB10_9 Depth=1
	movl	-28(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -28(%rbp)
	jmp	LBB10_9
LBB10_12:
	movq	-40(%rbp), %rax
	movq	%rax, -8(%rbp)
LBB10_13:
	movq	-8(%rbp), %rax
	addq	$48, %rsp
	popq	%rbp
	ret
	.cfi_endproc

	.globl	_not
	.align	4, 0x90
_not:                                   ## @not
	.cfi_startproc
## BB#0:
	pushq	%rbp
Ltmp57:
	.cfi_def_cfa_offset 16
Ltmp58:
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
Ltmp59:
	.cfi_def_cfa_register %rbp
	movl	%edi, -4(%rbp)
	cmpl	$0, -4(%rbp)
	setne	%al
	xorb	$1, %al
	andb	$1, %al
	movzbl	%al, %eax
	popq	%rbp
	ret
	.cfi_endproc

	.section	__DATA,__data
	.globl	_empty                  ## @empty
	.align	2
_empty:
	.long	0                       ## 0x0
	.space	1
	.space	3

	.comm	_consts,2048,4          ## @consts
	.section	__TEXT,__cstring,cstring_literals
L_.str:                                 ## @.str
	.asciz	"chr(%d) out of range\n"

L_.str1:                                ## @.str1
	.asciz	"substring([%d],%d,%d) out of range\n"


.subsections_via_symbols
