# Отчет по ИДЗ №2 по курсу архитектуры вычислительных систем.

Мельников Игорь Сергеевич, группа БПИ218. Вариант 27.

Разработать программу интегрирования функции y = a + b / x^2 (задаётся двумя числами а, b) в заданном диапазоне (задаётся так же) методом Симпсона (точность вычислений = 0.0001).

Комментарий: в результате обсуждений с семинаристом были обговорены некоторые ограничения:
1) Запрет на вычисление интеграла на отрезке, на котором лежит 0;
2) Ввиду особенностей представления вещественных чисел с плавающей точкой, при вычислении значений интеграла на отрезке, близко подходящем к 0, точность вычислений в 0.0001 не гарантируется.

## Задания на 4 балла

### Исходный код программы на C (файл source_for_4.c):

```c
#include <stdio.h>
#include <math.h>

double f(double a, double b, double x) {
    return (a + b / (x * x));
}

int main(int argc, char* argv[]) {
    double a, b, l, r;
    scanf("%lf",&a);
    scanf("%lf",&b);
    scanf("%lf",&l);
    scanf("%lf",&r);
    if (r < l) {
        l += r;
        r = l - r;
        l -= r;
    }
    if (l <= 0 && r >= 0) {
        printf("invalid interval!!!\n");
        return 0;
    }
    double possible_amount_segments = (r - l) * (r - l) * (r - l);
    int amount_segments;
    if (possible_amount_segments > 100 && possible_amount_segments < 100000) {
        amount_segments = (int)possible_amount_segments + 1;
    } else if (possible_amount_segments >= 100000) {
        amount_segments = 100000;
    } else {
        amount_segments = 100;
    }
    amount_segments *= 2;
    if (fabs(l) < 1 || fabs(r) < 1) {
        amount_segments *= 10;
    }
    double sum = 0;
    for (int i = 1; i <= amount_segments - 1; i += 2) {
        if (l + (double)(i - 1) / amount_segments * (r - l) <= 0 && l + (double)(i + 1) / amount_segments * (r - l) >= 0) {
            continue;
        }
        sum += f(a, b, l + (double)(i - 1) / amount_segments * (r - l));
        sum += 4 * f(a, b, l + (double)(i) / amount_segments * (r - l));
        sum += f(a, b, l + (double)(i + 1) / amount_segments * (r - l));
    }
    sum *= ((r - l) / amount_segments / 3);
    printf("%lf\n", sum);
    return 0;
}
```

### Получение ассемблерного файла без использования оптимизаций:

```sh
gcc -O0 -Wall -masm=intel -S source_for_4.c -o source_for_4.s
```

### Получение ассемблерного файла с использованием оптимизаций:

```sh
gcc -masm=intel -fno-asynchronous-unwind-tables -fno-jump-tables -fno-stack-protector -fno-exceptions ./source_for_4.c -S -o ./source_for_4.s
```

### Провожу преобразования в ассемблерном коде, убираю ненужные конструкции

### Комментирую ассемблирный код (файл source_for_4.s):

```assembly
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
```

### Получение исполняемого файла из ассемблерной программы:
```sh
gcc source_for_4.s -o source_for_4
```

### Делаю прогон тестов для source_for_4 (тесты приложены в архиве tests.tar.gz):

тест 1:
Ввод: "2 3 1 3"
Вывод программы на C: "6.0000000"
Вывод программы на ассемблере: "6.0000000"
Вердикт: OK

тест 2:
Ввод: "1 1 -1 1"
Вывод программы на C: "invalid interval!!!"
Вывод программы на ассемблере: "invalid interval!!!"
Вердикт: OK

тест 3:
Ввод: "2 3 3 1"
Вывод программы на C: "6.000000"
Вывод программы на ассемблере: "6.000000"
Вердикт: OK

тест 4:
Ввод: "5 7 2 9"
Вывод программы на C: "37.722222"
Вывод программы на ассемблере: "37.722222"
Вердикт: OK

тест 5:
Ввод: "32 71 -2424 -57"
Вывод программы на C: "75745.216324"
Вывод программы на ассемблере: "75745.216324"
Вердикт: OK

### Программа проходит все составленные тесты

## Задания на 5 баллов

### Модифицирую код на C так, чтобы выделить в нем функцию, которая принимает параметры и содержит локальные переменные (файл source_for_5.c):

```c
#include <stdio.h>
#include <math.h>

double f(double a, double b, double x) {
    double h = x * x;
    return a + b / h;
}

int main(int argc, char* argv[]) {
    double a, b, l, r;
    scanf("%lf",&a);
    scanf("%lf",&b);
    scanf("%lf",&l);
    scanf("%lf",&r);
    if (r < l) {
        l += r;
        r = l - r;
        l -= r;
    }
    if (l <= 0 && r >= 0) {
        printf("invalid interval!!!\n");
        return 0;
    }
    double possible_amount_segments = (r - l) * (r - l) * (r - l);
    int amount_segments;
    if (possible_amount_segments > 100 && possible_amount_segments < 100000) {
        amount_segments = (int)possible_amount_segments + 1;
    } else if (possible_amount_segments >= 100000) {
        amount_segments = 100000;
    } else {
        amount_segments = 100;
    }
    amount_segments *= 2;
    if (fabs(l) < 1 || fabs(r) < 1) {
        amount_segments *= 10;
    }
    double sum = 0;
    for (int i = 1; i <= amount_segments - 1; i += 2) {
        if (l + (double)(i - 1) / amount_segments * (r - l) <= 0 && l + (double)(i + 1) / amount_segments * (r - l) >= 0) {
            continue;
        }
        sum += f(a, b, l + (double)(i - 1) / amount_segments * (r - l));
        sum += 4 * f(a, b, l + (double)(i) / amount_segments * (r - l));
        sum += f(a, b, l + (double)(i + 1) / amount_segments * (r - l));
    }
    sum *= ((r - l) / amount_segments / 3);
    printf("%lf\n", sum);
    return 0;
}
```

### Получение ассемблированного файла с использованием оптимизаций:

```sh
gcc -masm=intel -fno-asynchronous-unwind-tables -fno-jump-tables -fno-stack-protector -fno-exceptions ./source_for_5.c -S -o ./source_for_5.s
```

### Проставляю комментарии в ассемблерный код (файл source_for_5.s):

```assembly
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
```

### Получение исполняемого файла из ассемблерной программы:

```sh
gcc source_for_5.s -o source_for_5
```

### Делаю прогон тестов для source_for_5 (тесты приложены в архиве tests.tar.gz):

тест 1:
Ввод: "2 3 1 3"
Вывод программы на C: "6.0000000"
Вывод программы на ассемблере: "6.0000000"
Вердикт: OK

тест 2:
Ввод: "1 1 -1 1"
Вывод программы на C: "invalid interval!!!"
Вывод программы на ассемблере: "invalid interval!!!"
Вердикт: OK

тест 3:
Ввод: "2 3 3 1"
Вывод программы на C: "6.000000"
Вывод программы на ассемблере: "6.000000"
Вердикт: OK

тест 4:
Ввод: "5 7 2 9"
Вывод программы на C: "37.722222"
Вывод программы на ассемблере: "37.722222"
Вердикт: OK

тест 5:
Ввод: "32 71 -2424 -57"
Вывод программы на C: "75745.216324"
Вывод программы на ассемблере: "75745.216324"
Вердикт: OK

### Программа проходит все составленные тесты

## Задания на 6 баллов

### Модифицирую ассемблерный код из файла source_for_5.s так, чтобы максимально использовать регистры (файл source_for_6.s):

```assembly
	.intel_syntax noprefix
	.text
	.globl	f
	.type	f, @function
f:
	endbr64
	push	rbp
	mov	rbp, rsp
	movsd	QWORD PTR -24[rbp], xmm0
	movsd	QWORD PTR -32[rbp], xmm1
	movsd	QWORD PTR -40[rbp], xmm2
	movsd	xmm0, QWORD PTR -40[rbp]
	mulsd	xmm0, xmm0
	movsd	QWORD PTR -8[rbp], xmm0
	movsd	xmm0, QWORD PTR -32[rbp]
	divsd	xmm0, QWORD PTR -8[rbp]
	addsd	xmm0, QWORD PTR -24[rbp]
	pop	rbp
	ret
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
	push	r13                       # регистр r13 - используется для хранения переменной i - счетчика цикла
	push	r12                       # регистр r12 - используется для хранения переменной amount_segments
	sub	rsp, 64
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
	mov	r12d, eax                            # регистр r12 - используется для хранения переменной amount_segments
	jmp	.L13
.L10:
	movsd	xmm0, QWORD PTR -32[rbp]
	comisd	xmm0, QWORD PTR .LC4[rip]
	jb	.L33
	mov	r12d, 100000                         # регистр r12 - используется для хранения переменной amount_segments
	jmp	.L13
.L33:
	mov	r12d, 100                            # регистр r12 - используется для хранения переменной amount_segments
.L13:
	mov	eax, r12d                            # регистр r12 - используется для хранения переменной amount_segments
	add	eax, eax
	mov	r12d, eax                            # регистр r12 - используется для хранения переменной amount_segments
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
	mov	edx, r12d                            # регистр r12 - используется для хранения переменной amount_segments
	mov	eax, edx
	sal	eax, 2
	add	eax, edx
	add	eax, eax
	mov	r12d, eax                            # регистр r12 - используется для хранения переменной amount_segments
.L17:
	pxor	xmm0, xmm0
	movsd	QWORD PTR -24[rbp], xmm0
	mov	r13d, 1                              # регистр r13 - используется для хранения переменной i - счетчика цикла
	jmp	.L19
.L24:
	mov	eax, r13d                            # регистр r13 - используется для хранения переменной i - счетчика цикла
	sub	eax, 1
	cvtsi2sd	xmm0, eax
	mov	eax, r12d                            # регистр r12 - используется для хранения переменной amount_segments
	cvtsi2sd	xmm1, eax
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
	mov	eax, r13d                            # регистр r13 - используется для хранения переменной i - счетчика цикла
	add	eax, 1
	cvtsi2sd	xmm0, eax
	mov	eax, r12d                            # регистр r12 - используется для хранения переменной amount_segments
	cvtsi2sd	xmm1, eax
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
	mov	eax, r13d                            # регистр r13 - используется для хранения переменной i - счетчика цикла
	sub	eax, 1
	cvtsi2sd	xmm0, eax
	mov	eax, r12d                            # регистр r12 - используется для хранения переменной amount_segments
	cvtsi2sd	xmm1, eax
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
	movapd	xmm2, xmm1
	movapd	xmm1, xmm0
	movq	xmm0, rax
	call	f
	movsd	xmm1, QWORD PTR -24[rbp]
	addsd	xmm0, xmm1
	movsd	QWORD PTR -24[rbp], xmm0
	mov	eax, r13d                            # регистр r13 - используется для хранения переменной i - счетчика цикла
	cvtsi2sd	xmm0, eax
	mov	eax, r12d                            # регистр r12 - используется для хранения переменной amount_segments
	cvtsi2sd	xmm1, eax
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
	movapd	xmm2, xmm1
	movapd	xmm1, xmm0
	movq	xmm0, rax
	call	f
	movsd	xmm1, QWORD PTR .LC7[rip]
	mulsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR -24[rbp]
	addsd	xmm0, xmm1
	movsd	QWORD PTR -24[rbp], xmm0
	mov	eax, r13d                            # регистр r13 - используется для хранения переменной i - счетчика цикла
	add	eax, 1
	cvtsi2sd	xmm0, eax
	mov	eax, r12d                            # регистр r12 - используется для хранения переменной amount_segments
	cvtsi2sd	xmm1, eax
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
	movapd	xmm2, xmm1
	movapd	xmm1, xmm0
	movq	xmm0, rax
	call	f
	movsd	xmm1, QWORD PTR -24[rbp]
	addsd	xmm0, xmm1
	movsd	QWORD PTR -24[rbp], xmm0
	jmp	.L23
.L34:
	nop
.L23:
	mov	eax, r13d                            # регистр r13 - используется для хранения переменной i - счетчика цикла
	add	eax, 2
	mov	r13d, eax                            # регистр r13 - используется для хранения переменной i - счетчика цикла
.L19:
	mov	edx, r12d                            # регистр r12 - используется для хранения переменной amount_segments
	mov	eax, r13d
	cmp	edx, eax
	jg	.L24
	movsd	xmm0, QWORD PTR -64[rbp]
	movsd	xmm1, QWORD PTR -56[rbp]
	subsd	xmm0, xmm1
	mov	eax, r12d                            # регистр r12 - используется для хранения переменной amount_segments
	cvtsi2sd	xmm1, eax
	divsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR .LC8[rip]
	divsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR -24[rbp]
	mulsd	xmm0, xmm1
	movsd	QWORD PTR -24[rbp], xmm0
	mov	rax, QWORD PTR -24[rbp]
	movq	xmm0, rax
	lea	rdi, .LC9[rip]
	mov	eax, 1
	call	printf@PLT
	mov	eax, 0
.L25:
	add	rsp, 64
	pop	r12                                  # регистр r12 - используется для хранения переменной amount_segments
	pop	r13                                  # регистр r13 - используется для хранения переменной i - счетчика цикла
	pop	rbp
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
```

### Делаю прогон тестов для source_for_6 (тесты приложены в архиве tests.tar.gz):

тест 1:
Ввод: "2 3 1 3"
Вывод программы на C: "6.0000000"
Вывод программы на ассемблере: "6.0000000"
Вердикт: OK

тест 2:
Ввод: "1 1 -1 1"
Вывод программы на C: "invalid interval!!!"
Вывод программы на ассемблере: "invalid interval!!!"
Вердикт: OK

тест 3:
Ввод: "2 3 3 1"
Вывод программы на C: "6.000000"
Вывод программы на ассемблере: "6.000000"
Вердикт: OK

тест 4:
Ввод: "5 7 2 9"
Вывод программы на C: "37.722222"
Вывод программы на ассемблере: "37.722222"
Вердикт: OK

тест 5:
Ввод: "32 71 -2424 -57"
Вывод программы на C: "75745.216324"
Вывод программы на ассемблере: "75745.216324"
Вердикт: OK

### Программа проходит все составленные тесты

### Сравниваю размеры исполняемых файлов, полученных из ассемблерного кода без использования регистров (source_for_5) и с использованием регистров (source_for_6):

Файл source_for_5 весит 16,8 килобайт, source_for_6 весит 16,8 килобайт. Значит, размеры файлов примерно одинаковы.

## Задания на 7 баллов

### Модифицирую код на c (тот, что был на 5 баллов), чтобы он вводил и выводил через файлы (файл source_for_7.c):

```c
#include <stdio.h>
#include <math.h>
#include <stdlib.h>

double f(double a, double b, double x) {
    double h = x * x;
    return a + b / h;
}

int main(int argc, char* argv[]) {
    if (argc != 3) {
        printf("Wrong amount of arguments!!!");
        return 0;
    }
    double a, b, l, r;
    FILE *file_input_stream = fopen(argv[1], "r");
    if (file_input_stream == NULL) {
        printf("can not open file for input!!!");
        return 0;
    }
    fscanf(file_input_stream, "%lf",&a);
    fscanf(file_input_stream, "%lf",&b);
    fscanf(file_input_stream, "%lf",&l);
    fscanf(file_input_stream, "%lf",&r);
    if (r < l) {
        l += r;
        r = l - r;
        l -= r;
    }
    FILE *file_output_stream = fopen(argv[2], "w");
    if (file_output_stream == NULL) {
        printf("can not open file for output!!!");
        return 0;
    }
    if (l <= 0 && r >= 0) {
        fprintf(file_output_stream, "invalid interval!!!\n");
        return 0;
    }
    double possible_amount_segments = (r - l) * (r - l) * (r - l);
    int amount_segments;
    if (possible_amount_segments > 100 && possible_amount_segments < 100000) {
        amount_segments = (int)possible_amount_segments + 1;
    } else if (possible_amount_segments >= 100000) {
        amount_segments = 100000;
    } else {
        amount_segments = 100;
    }
    amount_segments *= 2;
    if (fabs(l) < 1 || fabs(r) < 1) {
        amount_segments *= 10;
    }
    double sum = 0;
    for (int i = 1; i <= amount_segments - 1; i += 2) {
        if (l + (double)(i - 1) / amount_segments * (r - l) <= 0 && l + (double)(i + 1) / amount_segments * (r - l) >= 0) {
            continue;
        }
        sum += f(a, b, l + (double)(i - 1) / amount_segments * (r - l));
        sum += 4 * f(a, b, l + (double)(i) / amount_segments * (r - l));
        sum += f(a, b, l + (double)(i + 1) / amount_segments * (r - l));
    }
    sum *= ((r - l) / amount_segments / 3);
    fprintf(file_output_stream, "%lf\n", sum);
    return 0;
}
```

### Получение ассемблированного файла с использованием оптимизаций (source_for_7.s):

```sh
gcc -masm=intel -fno-asynchronous-unwind-tables -fno-jump-tables -fno-stack-protector -fno-exceptions ./source_for_7.c -S -o ./source_for_7.s
```

### Теперь разбиваю файл source_for_7.s на 2 единицы компиляции (файлы source_for_7_f.s и source_for_7_main.s)

### Получаю исполняемый файл (файл source_for_7):

```sh
gcc source_for_7.s -o source_for_7
```

### Делаю прогон тестов для source_for_7 (тесты приложены в архиве tests.tar.gz):

тест 1:
Ввод: "2 3 1 3"
Вывод программы на C: "6.0000000"
Вывод программы на ассемблере: "6.0000000"
Вердикт: OK

тест 2:
Ввод: "1 1 -1 1"
Вывод программы на C: "invalid interval!!!"
Вывод программы на ассемблере: "invalid interval!!!"
Вердикт: OK

тест 3:
Ввод: "2 3 3 1"
Вывод программы на C: "6.000000"
Вывод программы на ассемблере: "6.000000"
Вердикт: OK

тест 4:
Ввод: "5 7 2 9"
Вывод программы на C: "37.722222"
Вывод программы на ассемблере: "37.722222"
Вердикт: OK

тест 5:
Ввод: "32 71 -2424 -57"
Вывод программы на C: "75745.216324"
Вывод программы на ассемблере: "75745.216324"
Вердикт: OK

### Программа проходит все составленные тесты
