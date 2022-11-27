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
