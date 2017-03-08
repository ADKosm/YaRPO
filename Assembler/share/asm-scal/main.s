	.file	"main.c"
	.text
	.globl	c_dot
	.type	c_dot, @function
c_dot:
.LFB14:
	.cfi_startproc
	xorps	%xmm0, %xmm0
	xorl	%eax, %eax
.L3:
	movss	(%rdi,%rax,4), %xmm1
	mulss	(%rsi,%rax,4), %xmm1
	incq	%rax
	cmpq	$8, %rax
	addss	%xmm1, %xmm0
	jne	.L3
	ret
	.cfi_endproc
.LFE14:
	.size	c_dot, .-c_dot
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC3:
	.string	"C: %g\n"
	.section	.rodata
	.align 16
.LC0:
	.long	1065353216
	.long	1073741824
	.long	1077936128
	.long	1082130432
	.long	1084227584
	.long	1086324736
	.long	1088421888
	.long	1090519040
	.align 16
.LC1:
	.long	1091567616
	.long	1092616192
	.long	1093664768
	.long	1094713344
	.long	1095761920
	.long	1097859072
	.long	1098907648
	.section	.text.startup,"ax",@progbits
	.globl	main
	.type	main, @function
main:
.LFB15:
	.cfi_startproc
	subq	$72, %rsp
	.cfi_def_cfa_offset 80
	movl	$.LC0, %esi
	movl	$8, %ecx
	leaq	32(%rsp), %rdi
	rep movsl
	leaq	4(%rsp), %rdi
	movl	$.LC1, %esi
	movb	$7, %cl
	rep movsl
	leaq	4(%rsp), %rsi
	leaq	32(%rsp), %rdi
	call	c_dot
	cvtss2sd	%xmm0, %xmm0
	movl	$.LC3, %esi
	movl	$1, %edi
	movb	$1, %al
	call	__printf_chk
	xorl	%eax, %eax
	addq	$72, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE15:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 4.8.4-2ubuntu1~14.04.3) 4.8.4"
	.section	.note.GNU-stack,"",@progbits
