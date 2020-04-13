#include <stdio.h>

int main(int argc, char *argv[])
{
    char *s = "hello world";
    double *pd;
    printf("len: %lu\n", sizeof(s));
    printf("pd size: %lu\n", sizeof(pd));
    return 0;
}
