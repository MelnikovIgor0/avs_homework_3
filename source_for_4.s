	.intel_syntax noprefix                    # показывает, что синтаксис intel
	.text                                     # начало секции
	.globl	f                                 # объявляю символ f
	.type	f, @function                      # показываю, что f - функция
f:                                            # функция f
	push	rbp                               # сохраняю rbp на стеке
	mov	rbp, rsp                              # присваиваю регистру rbp значение из rsp
	movsd	QWORD PTR -8[rbp], xmm0           # кладу в rbp[-8] значение регистра xmm0 (rbp[-8] это аналог локальной переменной a в f)
	movsd	QWORD PTR -16[rbp], xmm1          # кладу в rbp[-16] значение регистра xmm1 (rbp[-16] это аналог локальной переменной b в f)
	movsd	QWORD PTR -24[rbp], xmm2          # кладу в rbp[-24] значение регистра xmm2 (rbp[-24] это аналог локальной переменной x в f)
	movsd	xmm0, QWORD PTR -24[rbp]          # присваиваю регистру xmm0 значение rbp[-24] (rbp[-24] это аналог локальной переменной x)
	movapd	xmm1, xmm0                        # присваиваю регистру xmm1 значение регистра xmm0
	mulsd	xmm1, xmm0                        # xmm1 = xmm1 * xmm0
	movsd	xmm0, QWORD PTR -16[rbp]          # присваиваю регистру xmm0 значение rbp[-16] (rbp[-16] это аналог локальной переменной b)
	divsd	xmm0, xmm1                        # xmm0 = xmm0 / xmm1
	addsd	xmm0, QWORD PTR -8[rbp]           # xmm0 = xmm0 + rbp[-8] (rbp[-8] это аналог локальной переменной a)
	pop	rbp                                   # выход из функции
	ret                                       # выход из функции
	.size	f, .-f
	.section	.rodata                       # секция .rodata
.LC0:                                         # метка LC0
	.string	"%lf"                             # строка, используемая для ввода вещественных чисел
.LC2:                                         # метка LC2
	.string	"invalid interval!!!"             # строка с ошибкой о неправильно заданном интервале
.LC9:                                         # метка LC9
	.string	"%lf\n"                           # строка, используемая для вывода вещественного числа
	.text                                     # начало секции
	.globl	main                              # объявляю символ main
	.type	main, @function                   # показываю, что main - функция
main:                                         # функция main
	push	rbp                               # сохраняю rbp на стеке
	mov	rbp, rsp                              # присваиваю регистру rbp значение из rsp
	sub	rsp, 80                               # сдвигаю регистр rsp на 80 (вычитаю 80)
	mov	DWORD PTR -68[rbp], edi               # аргумент argc кладется в edi
	mov	QWORD PTR -80[rbp], rsi               # аргумент argv кладется в rsi
	lea	rax, -40[rbp]                         # присваиваю решистру rax значение rbp[-40] (rbp[-40] это аналог переменной a из main)
	mov	rsi, rax                              # присваиваю регистру rsi значение регистра rax
	lea	rdi, .LC0[rip]                        # присваиваю регистру rdi значение метки .LC0 (строка формата ввода вещественного числа)
	mov	eax, 0                                # присваиваю регистру eax значение 0
	call	__isoc99_scanf@PLT                # вызываю макрос для считывания rbp[-40] (rbp[-40] это аналог переменной a из main)
	lea	rax, -48[rbp]                         # присваиваю решистру rax значение rbp[-48] (rbp[-48] это аналог переменной b из main)
	mov	rsi, rax                              # присваиваю регистру rsi значение регистра rax
	lea	rdi, .LC0[rip]                        # присваиваю регистру rdi значение метки .LC0 (строка формата ввода вещественного числа)
	mov	eax, 0                                # присваиваю регистру eax значение 0
	call	__isoc99_scanf@PLT                # вызываю макрос для считывания rbp[-40] (rbp[-40] это аналог переменной b из main)
	lea	rax, -56[rbp]                         # присваиваю решистру rax значение rbp[-56] (rbp[-56] это аналог переменной l из main)
	mov	rsi, rax                              # присваиваю регистру rsi значение регистра rax
	lea	rdi, .LC0[rip]                        # присваиваю регистру rdi значение метки .LC0 (строка формата ввода вещественного числа)
	mov	eax, 0                                # присваиваю регистру eax значение 0
	call	__isoc99_scanf@PLT                # вызываю макрос для считывания rbp[-40] (rbp[-40] это аналог переменной l из main)
	lea	rax, -64[rbp]                         # присваиваю решистру rax значение rbp[-64] (rbp[-64] это аналог переменной r из main)
	mov	rsi, rax                              # присваиваю регистру rsi значение регистра rax
	lea	rdi, .LC0[rip]                        # присваиваю регистру rdi значение метки .LC0 (строка формата ввода вещественного числа)
	mov	eax, 0                                # присваиваю регистру eax значение 0
	call	__isoc99_scanf@PLT                # вызываю макрос для считывания rbp[-40] (rbp[-40] это аналог переменной r из main)
	movsd	xmm1, QWORD PTR -64[rbp]          # присваиваю регистру xmm1 значение rbp[-64] (rbp[-64] это аналог переменной r из main)
	movsd	xmm0, QWORD PTR -56[rbp]          # присваиваю регистру xmm0 значение rbp[-56] (rbp[-56] это аналог переменной l из main)
	comisd	xmm0, xmm1                        # сравниваю значения регистров xmm0 и xmm1
	jbe	.L4                                   # если результат предыдущего сравнения <=, то переход на метку L4
	movsd	xmm1, QWORD PTR -56[rbp]          # присваиваю регистру xmm1 значение rbp[-56] (rbp[-56] это аналог переменной l из main)
	movsd	xmm0, QWORD PTR -64[rbp]          # присваиваю регистру xmm0 значение rbp[-64] (rbp[-64] это аналог переменной r из main)
	addsd	xmm0, xmm1                        # прибавляю к значение регистра xmm0 значение регистра xmm1
	movsd	QWORD PTR -56[rbp], xmm0          # присваиваю rbp[-56] значение регистра xmm0 (rbp[-56] это аналог пременной l)
	movsd	xmm0, QWORD PTR -56[rbp]          # присваиваю регистру xmm0 значение rbp[-56] (rbp[-56] это аналог пременной l)
	movsd	xmm1, QWORD PTR -64[rbp]          # присваиваю регистру xmm1 значение rbp[-64] (rbp[-64] это аналог пременной r)
	subsd	xmm0, xmm1                        # вычитаю из регистра xmm0 значение регистра xmm1
	movsd	QWORD PTR -64[rbp], xmm0          # присваиваю rbp[-64] значение регистра xmm0 (rbp[-64] это аналог переменной r)
	movsd	xmm0, QWORD PTR -56[rbp]          # присваиваю регистру xmm0 значение rbp[-56] (rbp[-56] это аналог переменной l)
	movsd	xmm1, QWORD PTR -64[rbp]          # присваиваю регистру xmm1 значение rbp[-64] (rbp[-64] это аналог переменной r)
	subsd	xmm0, xmm1                        # вычитаю из регистра xmm0 значение регистра xmm1
	movsd	QWORD PTR -56[rbp], xmm0          # присваиваю rbp[-56] значение регистра xmm0
.L4:                                          # метка L4
	movsd	xmm1, QWORD PTR -56[rbp]          # присваиваю регистру xmm1 значение rbp[-56] (rbp[-56] это аналог переменной l)
	pxor	xmm0, xmm0                        # присваиваю регистру xmm0 значение xmm0^xmm0 (зануляю значение регистра xmm0)
	comisd	xmm0, xmm1                        # сравниваю значения регистров xmm0 и xmm1
	jb	.L6                                   # если результат предыдущего сравнения <, то перехожу на метку L6
	movsd	xmm0, QWORD PTR -64[rbp]          # присваиваю регистру xmm0 значение rbp[-64] (rbp[-64] это аналог переменной r)
	pxor	xmm1, xmm1                        # присваиваю регистру xmm0 значение xmm1^xmm1 (зануляю значение регистра xmm1)
	comisd	xmm0, xmm1                        # сравниваю значения регистров xmm0 и xmm1
	jb	.L6                                   # если результат предыдущего сравнения <, то перехожу на метку L6
	lea	rdi, .LC2[rip]                        # присваиваю регистр rdi значение метки LC2 (LC2 сообщение о неправильных границах интегрирования)
	call	puts@PLT                          # вызываю макрос для вывода сообщения о неправильных границах интегрирования
	mov	eax, 0                                # присваиваю регистру eax значение 0
	jmp	.L25                                  # перехожу на метку L25
.L6:                                          # метка L6
	movsd	xmm0, QWORD PTR -64[rbp]          # присваиваю регистру xmm0 значение rbp[-64] (rbp[-64] это аналог переменной r)
	movsd	xmm1, QWORD PTR -56[rbp]          # присваиваю регистру xmm1 значение rbp[-56] (rbp[-56] это аналог переменной l)
	subsd	xmm0, xmm1                        # вычитаю из регистра xmm0 значение регистра xmm1
	movapd	xmm1, xmm0                        # присваиваю регистру xmm1 значение регистра xmm0
	movsd	xmm0, QWORD PTR -64[rbp]          # присваиваю регистру xmm0 значение rbp[-64] (rbp[-64] это аналог переменной r)
	movsd	xmm2, QWORD PTR -56[rbp]          # присваиваю регистру xmm2 значение rbp[-56] (rbp[-56] это аналог переменной l)
	subsd	xmm0, xmm2                        # вычитаю из регистра xmm0 значение регистра xmm2
	mulsd	xmm1, xmm0                        # присваиваю регистру xmm1 значение xmm1 * xmm0
	movsd	xmm0, QWORD PTR -64[rbp]          # присваиваю регистру xmm0 значение rbp[-64] (rbp[-64] это аналог переменной r)
	movsd	xmm2, QWORD PTR -56[rbp]          # присваиваю регистру xmm2 значение rbp[-56] (rbp[-56] это аналог переменной l)
	subsd	xmm0, xmm2                        # присваиваю регистру xmm0 значение xmm0 - xmm2
	mulsd	xmm0, xmm1                        # присваиваю регистру xmm0 значение xmm0 * xmm1
	movsd	QWORD PTR -32[rbp], xmm0          # присваиваю rbp[-32] значение регистра xmm0 (rbp[-32] это аналог переменной possible_amount_segments)
	movsd	xmm0, QWORD PTR -32[rbp]          # присваиваю регистру xmm0 значение rbp[-32] (rbp[-32] это аналог переменной possible_amount_segments)
	comisd	xmm0, QWORD PTR .LC3[rip]         # сравниваю значения регистра xmm0 и значение метки LC3 (там лежит 100000)
	jbe	.L10                                  # если результат предыдущего сравнения <=, то перехожу на метку L10
	movsd	xmm0, QWORD PTR .LC4[rip]         # присваиваю регистру xmm0 значение метки LC4 (там лежит 100)
	comisd	xmm0, QWORD PTR -32[rbp]          # сравниваю значение регистра xmm0 и rbp[-32] (rbp[-32] это аналог переменной possible_amount_segments)
	jbe	.L10                                  # если результат предыдущего сравнения <=, то перехожу на метку L10
	movsd	xmm0, QWORD PTR -32[rbp]          # присваиваю регистру xmm0 значение rbp[-32] (rbp[-32] это аналог переменной possible_amount_segments)
	cvttsd2si	eax, xmm0                     # присваиваю регистру eax значение регистра xmm0, приведенной к int
	add	eax, 1                                # увеличиваю значение регистра eax на 1
	mov	DWORD PTR -4[rbp], eax                # присваиваю rbp[-4] значение регистра eax (rbp[-4] это аналог переменной amount_segments)
	jmp	.L13                                  # перехожу на метку L13
.L10:                                         # метка L10
	movsd	xmm0, QWORD PTR -32[rbp]          # присваиваю регистру xmm0 значение rbp[-32]
	comisd	xmm0, QWORD PTR .LC4[rip]         # сравниваю значение регистра xmm0 и значение метки LC4 (там лежит 100)
	jb	.L33                                  # если результат предыдущего сравнения <, то перехожу на метку L33
	mov	DWORD PTR -4[rbp], 100000             # присваиваю rbp[-4] значение 100000 (rbp[-4] это аналог переменной amount_segments)
	jmp	.L13                                  # перехожу на метку L13
.L33:                                         # метка L33
	mov	DWORD PTR -4[rbp], 100                # присваиваю rbp[-4] значение 100
.L13:                                         # метка L13
	sal	DWORD PTR -4[rbp]                     # произвожу битовый сдвиг влево на 1 бит (фактически умножаю на 2 rbp[-4], аналог переменной amount_segments)
	movsd	xmm0, QWORD PTR -56[rbp]          # присваиваю регистру xmm0 значение rbp[-56] (rbp[-56] это аналог переменной l)
	movq	xmm1, QWORD PTR .LC5[rip]         # присваиваю регистру xmm1 значение по метке LC5 (там лежит вещественное число)
	andpd	xmm1, xmm0                        # присваиваю регистру xmm1 значение побитового И для xmm1 и xmm0
	movsd	xmm0, QWORD PTR .LC6[rip]         # присваиваю регистру xmm0 значение метки LC6 (там лежит вещественное число)
	comisd	xmm0, xmm1                        # сравниваю значения в регистрах xmm0 и xmm1
	ja	.L16                                  # если результат предыдущего сравнения >, то перехожу на метку L16
	movsd	xmm0, QWORD PTR -64[rbp]          # присваиваю регистру xmm0 значение rbp[-64] (rbp[-64] это аналог переменной r)
	movq	xmm1, QWORD PTR .LC5[rip]         # присваиваю регистру xmm1 значение метки LC5 (там лежит вещественное число)
	andpd	xmm1, xmm0                        # присваиваю регистру xmm1 значение побитового И для xmm1 и xmm0
	movsd	xmm0, QWORD PTR .LC6[rip]         # присваиваю регистру xmm0 значение метки LC6 (там лежит вещественное число)
	comisd	xmm0, xmm1                        # сравниваю значение в регистрах xmm0 и xmm1
	jbe	.L17                                  # если результат предыдущего сравнения <=, то перехожу на метку L17
.L16:                                         # метка L16
	mov	edx, DWORD PTR -4[rbp]                # присваиваю регистру edx значение rbp[-4] (rbp[-4] это аналог переменной amount_segments)
	mov	eax, edx                              # присваиваю регистру eax значение регистра edx
	sal	eax, 2                                # произвожу битовый сдвиг влево
	add	eax, edx                              # прибавляю к регистру eax значение регистра edx
	add	eax, eax                              # прибавляю к регистру eax значение регистра eax (фактически умножаю его на 2)
	mov	DWORD PTR -4[rbp], eax                # присвваиваю rbp[-4] значение регистра eax (rbp[-4] это аналог переменной amount_segments)
.L17:                                         # метка L17
	pxor	xmm0, xmm0                        # зануляю регистр xmm0 (xmm0^xmm0=0)
	movsd	QWORD PTR -16[rbp], xmm0          # присваиваю rbp[-16] значение регистра xmm0 (rbp[-16] это аналог переменной sum)
	mov	DWORD PTR -20[rbp], 1                 # присваиваю rbp[-20] значение 1 (rbp[-20] это аналог переменной i)
	jmp	.L19                                  # перехож на метку L19
.L24:                                         # метка L24
	mov	eax, DWORD PTR -20[rbp]               # присваиваю регистру eax значение rbp[-20] (rbp[-20] это аналог переменной i)
	sub	eax, 1                                # вычитаю из значения регистра eax 1
	cvtsi2sd	xmm0, eax                     # конвертирую целочисленное значение в вещественное (кладу значение в xmm0)
	cvtsi2sd	xmm1, DWORD PTR -4[rbp]       # конвертирую целочисленное значение в вещественное (кладу значение в xmm1)
	divsd	xmm0, xmm1                        # присваиваю xmm0 = xmm0 / xmm1
	movapd	xmm1, xmm0                        # присваиваю регистру xmm1 значение xmm0
	movsd	xmm0, QWORD PTR -64[rbp]          # присваиваю регистру xmm0 значение rbp[-64] (rbp[-64] это аналог переменной r)
	movsd	xmm2, QWORD PTR -56[rbp]          # присваиваю регистру xmm2 значение rbp[-56] (rbp[-56] это аналог переменной l)
	subsd	xmm0, xmm2                        # вычитаю из xmm0 значение регистра xmm2
	mulsd	xmm1, xmm0                        # xmm1 = xmm1 * xmm0
	movsd	xmm0, QWORD PTR -56[rbp]          # присваиваю регистру xmm0 значение rbp[-56] (rbp[-56] это аналог переменной l)
	addsd	xmm1, xmm0                        # xmm1 = xmm1 + xmm0
	pxor	xmm0, xmm0                        # зануляю xmm0 (xmm0 ^ xmm0 = 0)
	comisd	xmm0, xmm1                        # сравниваю значение регистров xmm0 и xmm1
	jb	.L20                                  # если результат предыдущего сравнения <, то перехожу на метрку L20
	mov	eax, DWORD PTR -20[rbp]               # присваиваю регистру eax значение rbp[-20] (rbp[-20] это аналог переменной i)
	add	eax, 1                                # прибавляю к значению регистра eax 1
	cvtsi2sd	xmm0, eax                     # конвертирую целочисленное значение в вещественное (кладу значение в xmm0)
	cvtsi2sd	xmm1, DWORD PTR -4[rbp]       # конвертирую целочисленное значение в вещественное (кладу значение в xmm1)
	divsd	xmm0, xmm1                        # присваиваю xmm0 = xmm0 / xmm1
	movapd	xmm1, xmm0                        # присваиваю регистру xmm1 значение xmm0
	movsd	xmm0, QWORD PTR -64[rbp]          # присваиваю регистру xmm0 значение rbp[-64] (rbp[-64] это аналог переменной r)
	movsd	xmm2, QWORD PTR -56[rbp]          # присваиваю регистру xmm2 значение rbp[-56] (rbp[-56] это аналог переменной l)
	subsd	xmm0, xmm2                        # вычитаю из xmm0 значение регистра xmm2
	mulsd	xmm1, xmm0                        # xmm1 = xmm1 * xmm0
	movsd	xmm0, QWORD PTR -56[rbp]          # присваиваю регистру xmm0 значение rbp[-56] (rbp[-56] это аналог переменной l)
	addsd	xmm0, xmm1                        # xmm0 = xmm0 + xmm1
	pxor	xmm1, xmm1                        # зануляю значение регистра xmm1 (xmm1^xmm1 = 0)
	comisd	xmm0, xmm1                        # сравниваю значения регистров xmm0 и xmm1
	jnb	.L34                                  # если результат предыдущего сравнения >=, то перехожу на метку L34
.L20:                                         # метка L20
	mov	eax, DWORD PTR -20[rbp]               # присваиваю регистру eax значение rbp[-20] (rbp[-20] это аналог переменной i)
	sub	eax, 1                                # вычитаю из значения регистра eax 1
	cvtsi2sd	xmm0, eax                     # конвертирую целочисленное значение в вещественное (кладу значение в xmm0)
	cvtsi2sd	xmm1, DWORD PTR -4[rbp]       # конвертирую целочисленное значение в вещественное (кладу значение в xmm1)
	divsd	xmm0, xmm1                        # xmm0 = xmm0 / xmm1
	movapd	xmm1, xmm0                        # присваиваю регистру xmm1 значение регистра xmm0
	movsd	xmm0, QWORD PTR -64[rbp]          # присваиваю регистру xmm0 значение rbp[-64] (rbp[-64] это аналог переменной r)
	movsd	xmm2, QWORD PTR -56[rbp]          # присваиваю регистру xmm2 значение rbp[-56] (rbp[-56] это аналог переменной l)
	subsd	xmm0, xmm2                        # вычитаю из xmm0 значение регистра xmm2
	mulsd	xmm1, xmm0                        # xmm1 = xmm1 * xmm0
	movsd	xmm0, QWORD PTR -56[rbp]          # присваиваю регистру xmm0 значение rbp[-56] (rbp[-56] это аналог переменной l)
	addsd	xmm1, xmm0                        # xmm1 = xmm1 + xmm0
	movsd	xmm0, QWORD PTR -48[rbp]          # присваиваю регистру xmm0 значение rbp[-48] (rbp[-48] это аналог переменной b)
	mov	rax, QWORD PTR -40[rbp]               # присваиваю регистру rax значение rbp[-40] (rbp[-40] это аналог переменной a)
	movapd	xmm2, xmm1                        # присваиваю регистру xmm2 значение регистра xmm1
	movapd	xmm1, xmm0                        # присваиваю регистру xmm1 значение регистра xmm0
	movq	xmm0, rax                         # присваиваю регистру xmm0 значение регистра rax
	call	f                                 # вызываю функцию f
	movsd	xmm1, QWORD PTR -16[rbp]          # присваиваю регистру xmm1 значение rbp[-16] (rbp[-16] это аналог переменной sum)
	addsd	xmm0, xmm1                        # xmm0 = xmm0 + xmm1
	movsd	QWORD PTR -16[rbp], xmm0          # присваиваю rbp[-16] значение регистра xmm0
	cvtsi2sd	xmm0, DWORD PTR -20[rbp]      # конвертирую целочисленное значение в вещественное (кладу значение в xmm0)
	cvtsi2sd	xmm1, DWORD PTR -4[rbp]       # конвертирую целочисленное значение в вещественное (кладу значение в xmm1)
	divsd	xmm0, xmm1                        # xmm0 = xmm0 / xmm1
	movapd	xmm1, xmm0                        # присваиваю регистру xmm1 значение регистра xmm0
	movsd	xmm0, QWORD PTR -64[rbp]          # присваиваю регистру xmm0 значение rbp[-64] (rbp[-64] это аналог переменной r)
	movsd	xmm2, QWORD PTR -56[rbp]          # присваиваю регистру xmm2 значение rbp[-56] (rbp[-56] это аналог переменной l)
	subsd	xmm0, xmm2                        # xmm0 = xmm0 - xmm2
	mulsd	xmm1, xmm0                        # xmm1 = xmm1 * xmm0
	movsd	xmm0, QWORD PTR -56[rbp]          # присваиваю регистру xmm0 значение rbp[-56] (rbp[-56] это аналог переменной l)
	addsd	xmm1, xmm0                        # xmm1 = xmm1 + xmm0
	movsd	xmm0, QWORD PTR -48[rbp]          # присваиваю регистру xmm0 значение rbp[-48] (rbp[-48] это аналог переменной b)
	mov	rax, QWORD PTR -40[rbp]               # присваиваю регистру rax значение rbo[-40] (rbp[-40] это аналог переменной a)
	movapd	xmm2, xmm1                        # присваиваю регистру xmm2 значение регистра xmm1
	movapd	xmm1, xmm0                        # присваиваю регистру xmm1 значение регистра xmm0
	movq	xmm0, rax                         # присваиваю регистру xmm0 значение регстра rax
	call	f                                 # вызываю функцию f
	movsd	xmm1, QWORD PTR .LC7[rip]         # присваиваю регистру xmm1 значение метки LC7 (там лежит значение 4)
	mulsd	xmm0, xmm1                        # xmm0 = xmm0 * xmm1
	movsd	xmm1, QWORD PTR -16[rbp]          # присваиваю регистру xmm1 значение rbp[-16] (rbp[-16] это аналог переменной sum)
	addsd	xmm0, xmm1                        # xmm0 = xmm0 + xmm1
	movsd	QWORD PTR -16[rbp], xmm0          # присваиваю rbp[-16] значение регистра xmm0
	mov	eax, DWORD PTR -20[rbp]               # присваиваю регистру eax значение rbp[-20] (rbp[-20] это аналог переменной i)
	add	eax, 1                                # прибавляю к регистру eax значение 1
	cvtsi2sd	xmm0, eax                     # конвертирую целочисленное значение в вещественное (кладу значение в xmm0)
	cvtsi2sd	xmm1, DWORD PTR -4[rbp]       # конвертирую целочисленное значение в вещественное (кладу значение в xmm1)
	divsd	xmm0, xmm1                        # xmm0 = xmm0 / xmm1
	movapd	xmm1, xmm0                        # присваиваю регистру xmm1 значение регистра xmm0
	movsd	xmm0, QWORD PTR -64[rbp]          # присваиваю регистру xmm0 значение rbp[-64] (rbp[-64] это аналог переменной r)
	movsd	xmm2, QWORD PTR -56[rbp]          # присваиваю регистру xmm2 значение rbp[-56] (rbp[-56] это аналог переменной l)
	subsd	xmm0, xmm2                        # xmm0 = xmm0 - xmm2
	mulsd	xmm1, xmm0                        # xmm1 = xmm1 * xmm0
	movsd	xmm0, QWORD PTR -56[rbp]          # присваиваю регистру xmm0 значение rbp[-56] (rbp[-56] это аналог переменной l)
	addsd	xmm1, xmm0                        # xmm1 = xmm1 + xmm0
	movsd	xmm0, QWORD PTR -48[rbp]          # присваиваю регистру xmm0 значение rbp[-48] (rbp[-48] это аналог переменной b)
	mov	rax, QWORD PTR -40[rbp]               # присваиваю регистру rax значение rbo[-40] (rbp[-40] это аналог переменной a)
	movapd	xmm2, xmm1                        # присваиваю регистру xmm2 значение регистра xmm1
	movapd	xmm1, xmm0                        # присваиваю регистру xmm1 значение регистра xmm0
	movq	xmm0, rax                         # присваиваю регистру xmm0 значение регстра rax
	call	f                                 # вызываю функцию f
	movsd	xmm1, QWORD PTR -16[rbp]          # присваиваю регистру xmm1 значение rbp[-16] (rbp[-16] это аналог перменной sum)
	addsd	xmm0, xmm1                        # xmm0 = xmm0 + xmm1
	movsd	QWORD PTR -16[rbp], xmm0          # присваиваю rbp[-16] значение регистра xmm0 (rbp[-16] это аналог переменной sum)
	jmp	.L23                                  # переход на метку L23
.L34:                                         # метка L34
	nop                                       # команда, которая ничего не делает
.L23:                                         # метка L23
	add	DWORD PTR -20[rbp], 2                 # rbp[-20] += 2 (rbp[-20] это аналог переменной i)
.L19:                                         # метка L19
	mov	eax, DWORD PTR -4[rbp]                # присваиваю регистру eax значение rbp[-4]
	cmp	eax, DWORD PTR -20[rbp]               # сравниваю значение регистра eax и rbp[-20] (rbp[-20] это аналог переменной i)
	jg	.L24                                  # если результат сравнения >, то перехожу на метку L24
	movsd	xmm0, QWORD PTR -64[rbp]          # присваиваю регистру xmm0 значение rbp[-64] (rbp[-64] это аналог переменной r)
	movsd	xmm1, QWORD PTR -56[rbp]          # присваиваю регистру xmm1 значение rbp[-56] (rbp[-56] это аналог переменной l)
	subsd	xmm0, xmm1                        # xmm0 = xmm0 - xmm1
	cvtsi2sd	xmm1, DWORD PTR -4[rbp]       # конвертирую целочисленное значение в вещественное (кладу значение в xmm1)
	divsd	xmm0, xmm1                        # xmm0 = xmm0 / xmm1
	movsd	xmm1, QWORD PTR .LC8[rip]         # присваиваю регистру xmm1 значение по метке LC8 (там лежит значение 3)
	divsd	xmm0, xmm1                        # xmm0 = xmm0 / xmm1
	movsd	xmm1, QWORD PTR -16[rbp]          # присваиваю регистру xmm1 значение rbp[-16] (rbp[-16] это аналог пеоеменной sum)
	mulsd	xmm0, xmm1                        # xmm0 = xmm0 * xmm1
	movsd	QWORD PTR -16[rbp], xmm0          # присваиваю rbp[-16] значение регистра xmm0
	mov	rax, QWORD PTR -16[rbp]               # присваиваю регситру rax значение rbp[-16]
	movq	xmm0, rax                         # присваиваю регистру xmm0 значение регистра rax
	lea	rdi, .LC9[rip]                        # присваиваю регистру rdi значение по метке LC9 (там лежит строка для вывода вещественного числа)
	mov	eax, 1                                # присваиваю регистру eax значение 1
	call	printf@PLT                        # вызываю макрос для вывода значений на консоль
	mov	eax, 0                                # присваиваю регистру eax значение 0
.L25:                                         # метка L25
	leave                                     # выход из функции
	ret                                       # выход из функции
	.size	main, .-main
	.section	.rodata
	.align 8
.LC3:                                         # метка LC3, тут лежит вещественное число
	.long	0
	.long	1079574528
	.align 8
.LC4:                                         # метка LC4, тут лежит вещественное число
	.long	0
	.long	1090021888
	.align 16
.LC5:                                         # метка LC5, тут лежит вещественное число
	.long	4294967295
	.long	2147483647
	.long	0
	.long	0
	.align 8
.LC6:                                         # метка LC6, тут лежит вещественное число
	.long	0
	.long	1072693248
	.align 8
.LC7:                                         # метка LC8, тут лежит вещественное число
	.long	0
	.long	1074790400
	.align 8
.LC8:                                         # метка LC9, тут лежит вещественное число
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
