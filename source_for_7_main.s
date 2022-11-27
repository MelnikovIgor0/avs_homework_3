	.intel_syntax noprefix
	.text
	.globl	f
	.type	f, @function
	.section	.rodata
.LC0:
	.string	"Wrong amount of arguments!!!"
.LC1:
	.string	"r"
	.align 8
.LC2:
	.string	"can not open file for input!!!"
.LC3:
	.string	"%lf"
.LC4:
	.string	"w"
	.align 8
.LC5:
	.string	"can not open file for output!!!"
.LC7:
	.string	"invalid interval!!!\n"
.LC14:
	.string	"%lf\n"
	.text
	.globl	main
	.type	main, @function
main:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 96
	mov	DWORD PTR -84[rbp], edi
	mov	QWORD PTR -96[rbp], rsi
	cmp	DWORD PTR -84[rbp], 3
	je	.L4
	lea	rdi, .LC0[rip]
	mov	eax, 0
	call	printf@PLT
	mov	eax, 0
	jmp	.L28
.L4:
	mov	rax, QWORD PTR -96[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC1[rip]
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -32[rbp], rax
	cmp	QWORD PTR -32[rbp], 0
	jne	.L6
	lea	rdi, .LC2[rip]
	mov	eax, 0
	call	printf@PLT
	mov	eax, 0
	jmp	.L28
.L6:
	lea	rdx, -56[rbp]
	mov	rax, QWORD PTR -32[rbp]
	lea	rsi, .LC3[rip]
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT
	lea	rdx, -64[rbp]
	mov	rax, QWORD PTR -32[rbp]
	lea	rsi, .LC3[rip]
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT
	lea	rdx, -72[rbp]
	mov	rax, QWORD PTR -32[rbp]
	lea	rsi, .LC3[rip]
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT
	lea	rdx, -80[rbp]
	mov	rax, QWORD PTR -32[rbp]
	lea	rsi, .LC3[rip]
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT
	movsd	xmm1, QWORD PTR -80[rbp]
	movsd	xmm0, QWORD PTR -72[rbp]
	comisd	xmm0, xmm1
	jbe	.L7
	movsd	xmm1, QWORD PTR -72[rbp]
	movsd	xmm0, QWORD PTR -80[rbp]
	addsd	xmm0, xmm1
	movsd	QWORD PTR -72[rbp], xmm0
	movsd	xmm0, QWORD PTR -72[rbp]
	movsd	xmm1, QWORD PTR -80[rbp]
	subsd	xmm0, xmm1
	movsd	QWORD PTR -80[rbp], xmm0
	movsd	xmm0, QWORD PTR -72[rbp]
	movsd	xmm1, QWORD PTR -80[rbp]
	subsd	xmm0, xmm1
	movsd	QWORD PTR -72[rbp], xmm0
.L7:
	mov	rax, QWORD PTR -96[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC4[rip]
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -40[rbp], rax
	cmp	QWORD PTR -40[rbp], 0
	jne	.L9
	lea	rdi, .LC5[rip]
	mov	eax, 0
	call	printf@PLT
	mov	eax, 0
	jmp	.L28
.L9:
	movsd	xmm1, QWORD PTR -72[rbp]
	pxor	xmm0, xmm0
	comisd	xmm0, xmm1
	jb	.L10
	movsd	xmm0, QWORD PTR -80[rbp]
	pxor	xmm1, xmm1
	comisd	xmm0, xmm1
	jb	.L10
	mov	rax, QWORD PTR -40[rbp]
	mov	rcx, rax
	mov	edx, 20
	mov	esi, 1
	lea	rdi, .LC7[rip]
	call	fwrite@PLT
	mov	eax, 0
	jmp	.L28
.L10:
	movsd	xmm0, QWORD PTR -80[rbp]
	movsd	xmm1, QWORD PTR -72[rbp]
	subsd	xmm0, xmm1
	movapd	xmm1, xmm0
	movsd	xmm0, QWORD PTR -80[rbp]
	movsd	xmm2, QWORD PTR -72[rbp]
	subsd	xmm0, xmm2
	mulsd	xmm1, xmm0
	movsd	xmm0, QWORD PTR -80[rbp]
	movsd	xmm2, QWORD PTR -72[rbp]
	subsd	xmm0, xmm2
	mulsd	xmm0, xmm1
	movsd	QWORD PTR -48[rbp], xmm0
	movsd	xmm0, QWORD PTR -48[rbp]
	comisd	xmm0, QWORD PTR .LC8[rip]
	jbe	.L13
	movsd	xmm0, QWORD PTR .LC9[rip]
	comisd	xmm0, QWORD PTR -48[rbp]
	jbe	.L13
	movsd	xmm0, QWORD PTR -48[rbp]
	cvttsd2si	eax, xmm0
	add	eax, 1
	mov	DWORD PTR -4[rbp], eax
	jmp	.L16
.L13:
	movsd	xmm0, QWORD PTR -48[rbp]
	comisd	xmm0, QWORD PTR .LC9[rip]
	jb	.L36
	mov	DWORD PTR -4[rbp], 100000
	jmp	.L16
.L36:
	mov	DWORD PTR -4[rbp], 100
.L16:
	sal	DWORD PTR -4[rbp]
	movsd	xmm0, QWORD PTR -72[rbp]
	movq	xmm1, QWORD PTR .LC10[rip]
	andpd	xmm1, xmm0
	movsd	xmm0, QWORD PTR .LC11[rip]
	comisd	xmm0, xmm1
	ja	.L19
	movsd	xmm0, QWORD PTR -80[rbp]
	movq	xmm1, QWORD PTR .LC10[rip]
	andpd	xmm1, xmm0
	movsd	xmm0, QWORD PTR .LC11[rip]
	comisd	xmm0, xmm1
	jbe	.L20
.L19:
	mov	edx, DWORD PTR -4[rbp]
	mov	eax, edx
	sal	eax, 2
	add	eax, edx
	add	eax, eax
	mov	DWORD PTR -4[rbp], eax
.L20:
	pxor	xmm0, xmm0
	movsd	QWORD PTR -16[rbp], xmm0
	mov	DWORD PTR -20[rbp], 1
	jmp	.L22
.L27:
	mov	eax, DWORD PTR -20[rbp]
	sub	eax, 1
	cvtsi2sd	xmm0, eax
	cvtsi2sd	xmm1, DWORD PTR -4[rbp]
	divsd	xmm0, xmm1
	movapd	xmm1, xmm0
	movsd	xmm0, QWORD PTR -80[rbp]
	movsd	xmm2, QWORD PTR -72[rbp]
	subsd	xmm0, xmm2
	mulsd	xmm1, xmm0
	movsd	xmm0, QWORD PTR -72[rbp]
	addsd	xmm1, xmm0
	pxor	xmm0, xmm0
	comisd	xmm0, xmm1
	jb	.L23
	mov	eax, DWORD PTR -20[rbp]
	add	eax, 1
	cvtsi2sd	xmm0, eax
	cvtsi2sd	xmm1, DWORD PTR -4[rbp]
	divsd	xmm0, xmm1
	movapd	xmm1, xmm0
	movsd	xmm0, QWORD PTR -80[rbp]
	movsd	xmm2, QWORD PTR -72[rbp]
	subsd	xmm0, xmm2
	mulsd	xmm1, xmm0
	movsd	xmm0, QWORD PTR -72[rbp]
	addsd	xmm0, xmm1
	pxor	xmm1, xmm1
	comisd	xmm0, xmm1
	jnb	.L37
.L23:
	mov	eax, DWORD PTR -20[rbp]
	sub	eax, 1
	cvtsi2sd	xmm0, eax
	cvtsi2sd	xmm1, DWORD PTR -4[rbp]
	divsd	xmm0, xmm1
	movapd	xmm1, xmm0
	movsd	xmm0, QWORD PTR -80[rbp]
	movsd	xmm2, QWORD PTR -72[rbp]
	subsd	xmm0, xmm2
	mulsd	xmm1, xmm0
	movsd	xmm0, QWORD PTR -72[rbp]
	addsd	xmm1, xmm0
	movsd	xmm0, QWORD PTR -64[rbp]
	mov	rax, QWORD PTR -56[rbp]
	movapd	xmm2, xmm1
	movapd	xmm1, xmm0
	movq	xmm0, rax
	call	f
	movsd	xmm1, QWORD PTR -16[rbp]
	addsd	xmm0, xmm1
	movsd	QWORD PTR -16[rbp], xmm0
	cvtsi2sd	xmm0, DWORD PTR -20[rbp]
	cvtsi2sd	xmm1, DWORD PTR -4[rbp]
	divsd	xmm0, xmm1
	movapd	xmm1, xmm0
	movsd	xmm0, QWORD PTR -80[rbp]
	movsd	xmm2, QWORD PTR -72[rbp]
	subsd	xmm0, xmm2
	mulsd	xmm1, xmm0
	movsd	xmm0, QWORD PTR -72[rbp]
	addsd	xmm1, xmm0
	movsd	xmm0, QWORD PTR -64[rbp]
	mov	rax, QWORD PTR -56[rbp]
	movapd	xmm2, xmm1
	movapd	xmm1, xmm0
	movq	xmm0, rax
	call	f
	movsd	xmm1, QWORD PTR .LC12[rip]
	mulsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR -16[rbp]
	addsd	xmm0, xmm1
	movsd	QWORD PTR -16[rbp], xmm0
	mov	eax, DWORD PTR -20[rbp]
	add	eax, 1
	cvtsi2sd	xmm0, eax
	cvtsi2sd	xmm1, DWORD PTR -4[rbp]
	divsd	xmm0, xmm1
	movapd	xmm1, xmm0
	movsd	xmm0, QWORD PTR -80[rbp]
	movsd	xmm2, QWORD PTR -72[rbp]
	subsd	xmm0, xmm2
	mulsd	xmm1, xmm0
	movsd	xmm0, QWORD PTR -72[rbp]
	addsd	xmm1, xmm0
	movsd	xmm0, QWORD PTR -64[rbp]
	mov	rax, QWORD PTR -56[rbp]
	movapd	xmm2, xmm1
	movapd	xmm1, xmm0
	movq	xmm0, rax
	call	f
	movsd	xmm1, QWORD PTR -16[rbp]
	addsd	xmm0, xmm1
	movsd	QWORD PTR -16[rbp], xmm0
	jmp	.L26
.L37:
	nop
.L26:
	add	DWORD PTR -20[rbp], 2
.L22:
	mov	eax, DWORD PTR -4[rbp]
	cmp	eax, DWORD PTR -20[rbp]
	jg	.L27
	movsd	xmm0, QWORD PTR -80[rbp]
	movsd	xmm1, QWORD PTR -72[rbp]
	subsd	xmm0, xmm1
	cvtsi2sd	xmm1, DWORD PTR -4[rbp]
	divsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR .LC13[rip]
	divsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR -16[rbp]
	mulsd	xmm0, xmm1
	movsd	QWORD PTR -16[rbp], xmm0
	mov	rdx, QWORD PTR -16[rbp]
	mov	rax, QWORD PTR -40[rbp]
	movq	xmm0, rdx
	lea	rsi, .LC14[rip]
	mov	rdi, rax
	mov	eax, 1
	call	fprintf@PLT
	mov	eax, 0
.L28:
	leave
	ret
	.size	main, .-main
	.section	.rodata
	.align 8
.LC8:
	.long	0
	.long	1079574528
	.align 8
.LC9:
	.long	0
	.long	1090021888
	.align 16
.LC10:
	.long	4294967295
	.long	2147483647
	.long	0
	.long	0
	.align 8
.LC11:
	.long	0
	.long	1072693248
	.align 8
.LC12:
	.long	0
	.long	1074790400
	.align 8
.LC13:
	.long	0
	.long	1074266112
	.ident	"GCC: (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
