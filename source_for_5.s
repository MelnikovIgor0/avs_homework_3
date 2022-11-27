	.file	"source_for_5.c"
	.intel_syntax noprefix
	.text
	.globl	f
	.type	f, @function
f:
	endbr64
	push	rbp
	mov	rbp, rsp
	movsd	QWORD PTR -24[rbp], xmm0     # присваиваю rbp[-24] значение из регистра xmm0 (переданный параметр a в функцию f)
	movsd	QWORD PTR -32[rbp], xmm1     # присваиваю rbp[-32] значение из регистра xmm1 (переданный параметр b в функцию f)
	movsd	QWORD PTR -40[rbp], xmm2     # присваиваю rbp[-40] значение из регистра xmm2 (переданный параметр x в функцию f)
	movsd	xmm0, QWORD PTR -40[rbp]
	mulsd	xmm0, xmm0
	movsd	QWORD PTR -8[rbp], xmm0      # присваиваю rbp[-8] значение из регистра xmm0 (rpb[-8] это аналог локальной переменной h из функции f)
	movsd	xmm0, QWORD PTR -32[rbp]
	divsd	xmm0, QWORD PTR -8[rbp]
	addsd	xmm0, QWORD PTR -24[rbp]
	pop	rbp                              # выход из функции f (возвращаемой значение лежит в регистре xmm0)
	ret                                  # выход из функции f (возвращаемое значение лежит в регистре xmm0)
	.size	f, .-f
	.section	.rodata
.LC0:
	.string	"%lf"
.LC2:
	.string	"invalid interval!!!"
.LC9:
	.string	"%lf\n"
	.text
	.globl	main
	.type	main, @function
main:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 80
	mov	DWORD PTR -68[rbp], edi
	mov	QWORD PTR -80[rbp], rsi
	lea	rax, -40[rbp]
	mov	rsi, rax
	lea	rdi, .LC0[rip]
	mov	eax, 0
	call	__isoc99_scanf@PLT
	lea	rax, -48[rbp]
	mov	rsi, rax
	lea	rdi, .LC0[rip]
	mov	eax, 0
	call	__isoc99_scanf@PLT
	lea	rax, -56[rbp]
	mov	rsi, rax
	lea	rdi, .LC0[rip]
	mov	eax, 0
	call	__isoc99_scanf@PLT
	lea	rax, -64[rbp]
	mov	rsi, rax
	lea	rdi, .LC0[rip]
	mov	eax, 0
	call	__isoc99_scanf@PLT
	movsd	xmm1, QWORD PTR -64[rbp]
	movsd	xmm0, QWORD PTR -56[rbp]
	comisd	xmm0, xmm1
	jbe	.L4
	movsd	xmm1, QWORD PTR -56[rbp]
	movsd	xmm0, QWORD PTR -64[rbp]
	addsd	xmm0, xmm1
	movsd	QWORD PTR -56[rbp], xmm0
	movsd	xmm0, QWORD PTR -56[rbp]
	movsd	xmm1, QWORD PTR -64[rbp]
	subsd	xmm0, xmm1
	movsd	QWORD PTR -64[rbp], xmm0
	movsd	xmm0, QWORD PTR -56[rbp]
	movsd	xmm1, QWORD PTR -64[rbp]
	subsd	xmm0, xmm1
	movsd	QWORD PTR -56[rbp], xmm0
.L4:
	movsd	xmm1, QWORD PTR -56[rbp]
	pxor	xmm0, xmm0
	comisd	xmm0, xmm1
	jb	.L6
	movsd	xmm0, QWORD PTR -64[rbp]
	pxor	xmm1, xmm1
	comisd	xmm0, xmm1
	jb	.L6
	lea	rdi, .LC2[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L25
.L6:
	movsd	xmm0, QWORD PTR -64[rbp]
	movsd	xmm1, QWORD PTR -56[rbp]
	subsd	xmm0, xmm1
	movapd	xmm1, xmm0
	movsd	xmm0, QWORD PTR -64[rbp]
	movsd	xmm2, QWORD PTR -56[rbp]
	subsd	xmm0, xmm2
	mulsd	xmm1, xmm0
	movsd	xmm0, QWORD PTR -64[rbp]
	movsd	xmm2, QWORD PTR -56[rbp]
	subsd	xmm0, xmm2
	mulsd	xmm0, xmm1
	movsd	QWORD PTR -32[rbp], xmm0
	movsd	xmm0, QWORD PTR -32[rbp]
	comisd	xmm0, QWORD PTR .LC3[rip]
	jbe	.L10
	movsd	xmm0, QWORD PTR .LC4[rip]
	comisd	xmm0, QWORD PTR -32[rbp]
	jbe	.L10
	movsd	xmm0, QWORD PTR -32[rbp]
	cvttsd2si	eax, xmm0
	add	eax, 1
	mov	DWORD PTR -4[rbp], eax
	jmp	.L13
.L10:
	movsd	xmm0, QWORD PTR -32[rbp]
	comisd	xmm0, QWORD PTR .LC4[rip]
	jb	.L33
	mov	DWORD PTR -4[rbp], 100000
	jmp	.L13
.L33:
	mov	DWORD PTR -4[rbp], 100
.L13:
	sal	DWORD PTR -4[rbp]
	movsd	xmm0, QWORD PTR -56[rbp]
	movq	xmm1, QWORD PTR .LC5[rip]
	andpd	xmm1, xmm0
	movsd	xmm0, QWORD PTR .LC6[rip]
	comisd	xmm0, xmm1
	ja	.L16
	movsd	xmm0, QWORD PTR -64[rbp]
	movq	xmm1, QWORD PTR .LC5[rip]
	andpd	xmm1, xmm0
	movsd	xmm0, QWORD PTR .LC6[rip]
	comisd	xmm0, xmm1
	jbe	.L17
.L16:
	mov	edx, DWORD PTR -4[rbp]
	mov	eax, edx
	sal	eax, 2
	add	eax, edx
	add	eax, eax
	mov	DWORD PTR -4[rbp], eax
.L17:
	pxor	xmm0, xmm0
	movsd	QWORD PTR -16[rbp], xmm0
	mov	DWORD PTR -20[rbp], 1
	jmp	.L19
.L24:
	mov	eax, DWORD PTR -20[rbp]
	sub	eax, 1
	cvtsi2sd	xmm0, eax
	cvtsi2sd	xmm1, DWORD PTR -4[rbp]
	divsd	xmm0, xmm1
	movapd	xmm1, xmm0
	movsd	xmm0, QWORD PTR -64[rbp]
	movsd	xmm2, QWORD PTR -56[rbp]
	subsd	xmm0, xmm2
	mulsd	xmm1, xmm0
	movsd	xmm0, QWORD PTR -56[rbp]
	addsd	xmm1, xmm0
	pxor	xmm0, xmm0
	comisd	xmm0, xmm1
	jb	.L20
	mov	eax, DWORD PTR -20[rbp]
	add	eax, 1
	cvtsi2sd	xmm0, eax
	cvtsi2sd	xmm1, DWORD PTR -4[rbp]
	divsd	xmm0, xmm1
	movapd	xmm1, xmm0
	movsd	xmm0, QWORD PTR -64[rbp]
	movsd	xmm2, QWORD PTR -56[rbp]
	subsd	xmm0, xmm2
	mulsd	xmm1, xmm0
	movsd	xmm0, QWORD PTR -56[rbp]
	addsd	xmm0, xmm1
	pxor	xmm1, xmm1
	comisd	xmm0, xmm1
	jnb	.L34
.L20:
	mov	eax, DWORD PTR -20[rbp]
	sub	eax, 1
	cvtsi2sd	xmm0, eax
	cvtsi2sd	xmm1, DWORD PTR -4[rbp]
	divsd	xmm0, xmm1
	movapd	xmm1, xmm0
	movsd	xmm0, QWORD PTR -64[rbp]
	movsd	xmm2, QWORD PTR -56[rbp]
	subsd	xmm0, xmm2
	mulsd	xmm1, xmm0
	movsd	xmm0, QWORD PTR -56[rbp]
	addsd	xmm1, xmm0
	movsd	xmm0, QWORD PTR -48[rbp]
	mov	rax, QWORD PTR -40[rbp]
	movapd	xmm2, xmm1                            # присваиваю регистру xmm2 значение регистра xmm1 (регистр xmm2 сейчас будет использоваться для передачи параметра x в функцию f)
	movapd	xmm1, xmm0                            # присваиваю регистру xmm1 значение регистра xmm0 (регистр xmm1 сейчас будет использоваться для передачи параметра b в функцию f)
	movq	xmm0, rax                             # присваиваю регистру xmm0 значение регистра rax (регистр xmm0 сейчас будет использоваться для передачи параметра a в функцию f)
	call	f                                     # вызов функции f (после выполнения функции возвращаемое ей значение лежит в регистре xmm0)
	movsd	xmm1, QWORD PTR -16[rbp]
	addsd	xmm0, xmm1
	movsd	QWORD PTR -16[rbp], xmm0
	cvtsi2sd	xmm0, DWORD PTR -20[rbp]
	cvtsi2sd	xmm1, DWORD PTR -4[rbp]
	divsd	xmm0, xmm1
	movapd	xmm1, xmm0
	movsd	xmm0, QWORD PTR -64[rbp]
	movsd	xmm2, QWORD PTR -56[rbp]
	subsd	xmm0, xmm2
	mulsd	xmm1, xmm0
	movsd	xmm0, QWORD PTR -56[rbp]
	addsd	xmm1, xmm0
	movsd	xmm0, QWORD PTR -48[rbp]
	mov	rax, QWORD PTR -40[rbp]
	movapd	xmm2, xmm1                            # присваиваю регистру xmm2 значение регистра xmm1 (регистр xmm2 сейчас будет использоваться для передачи параметра x в функцию f)
	movapd	xmm1, xmm0                            # присваиваю регистру xmm1 значение регистра xmm0 (регистр xmm1 сейчас будет использоваться для передачи параметра b в функцию f)
	movq	xmm0, rax                             # присваиваю регистру xmm0 значение регистра rax (регистр xmm0 сейчас будет использоваться для передачи параметра a в функцию f)
	call	f                                     # вызов функции f (после выполнения функции возвращаемое ей значение лежит в регистре xmm0)
	movsd	xmm1, QWORD PTR .LC7[rip]
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
	movsd	xmm0, QWORD PTR -64[rbp]
	movsd	xmm2, QWORD PTR -56[rbp]
	subsd	xmm0, xmm2
	mulsd	xmm1, xmm0
	movsd	xmm0, QWORD PTR -56[rbp]
	addsd	xmm1, xmm0
	movsd	xmm0, QWORD PTR -48[rbp]
	mov	rax, QWORD PTR -40[rbp]
	movapd	xmm2, xmm1                            # присваиваю регистру xmm2 значение регистра xmm1 (регистр xmm2 сейчас будет использоваться для передачи параметра x в функцию f)
	movapd	xmm1, xmm0                            # присваиваю регистру xmm1 значение регистра xmm0 (регистр xmm1 сейчас будет использоваться для передачи параметра b в функцию f)
	movq	xmm0, rax                             # присваиваю регистру xmm0 значение регистра rax (регистр xmm0 сейчас будет использоваться для передачи параметра a в функцию f)
	call	f                                     # вызов функции f (после выполнения функции возвращаемое ей значение лежит в регистре xmm0)
	movsd	xmm1, QWORD PTR -16[rbp]
	addsd	xmm0, xmm1
	movsd	QWORD PTR -16[rbp], xmm0
	jmp	.L23
.L34:
	nop
.L23:
	add	DWORD PTR -20[rbp], 2
.L19:
	mov	eax, DWORD PTR -4[rbp]
	cmp	eax, DWORD PTR -20[rbp]
	jg	.L24
	movsd	xmm0, QWORD PTR -64[rbp]
	movsd	xmm1, QWORD PTR -56[rbp]
	subsd	xmm0, xmm1
	cvtsi2sd	xmm1, DWORD PTR -4[rbp]
	divsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR .LC8[rip]
	divsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR -16[rbp]
	mulsd	xmm0, xmm1
	movsd	QWORD PTR -16[rbp], xmm0
	mov	rax, QWORD PTR -16[rbp]
	movq	xmm0, rax
	lea	rdi, .LC9[rip]
	mov	eax, 1
	call	printf@PLT
	mov	eax, 0
.L25:
	leave
	ret
	.size	main, .-main
	.section	.rodata
	.align 8
.LC3:
	.long	0
	.long	1079574528
	.align 8
.LC4:
	.long	0
	.long	1090021888
	.align 16
.LC5:
	.long	4294967295
	.long	2147483647
	.long	0
	.long	0
	.align 8
.LC6:
	.long	0
	.long	1072693248
	.align 8
.LC7:
	.long	0
	.long	1074790400
	.align 8
.LC8:
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
