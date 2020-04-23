#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#define STACK_CAPACITY 1000

double expr(const char *tokens[], int ntokens)
{
    double *stack, *result;
    stack = calloc(sizeof(*stack), STACK_CAPACITY);

    for (int i = 0; i < ntokens; ++i) {
        if (strcmp(tokens[i], "+") == 0) {
            *(stack - 2) += *(stack - 1);
            stack--;
        } else if (strcmp(tokens[i], "-") == 0) {
            *(stack - 2) -= *(stack - 1);
            stack--;
        } else if (strcmp(tokens[i], "*") == 0) {
            *(stack - 2) *= *(stack - 1);
            stack--;
        } else {
            *(stack++) = atof(tokens[i]);
        }
    }

    result = realloc(stack - 1, 1);
    return *result;
}
