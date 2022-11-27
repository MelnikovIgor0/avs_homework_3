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
