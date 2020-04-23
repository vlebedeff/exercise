#include <stdio.h>

int main(int argc, char *argv[])
{
    char *s;
    short *si;
    long unsigned *lu;
    long double *ld;
    s = NULL;
    printf("S: %p\n", s);
    printf("Size of char pointer: %ld\n", sizeof(s));
    printf("Size of short pointer: %ld\n", sizeof(si));
    printf("Size of long unsigned pointer: %ld\n", sizeof(lu));
    printf("Size of long double pointer: %ld\n", sizeof(ld));
    return 0;
}
