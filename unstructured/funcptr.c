#include <stdio.h>

typedef int (*funcptr)(int, int);

int add(int a, int b)
{
    return a + b;
}

int subtract(int a, int b)
{
    return a - b;
}

int compute(funcptr fn, int a, int b)
{
    return fn(a, b);
}

int main(int argc, char *argv[])
{
    printf("add 4 5: %d\n", compute(add, 4, 5));
    printf("subtract 4 5 %d\n", compute(subtract, 4, 5));
    return 0;
}
