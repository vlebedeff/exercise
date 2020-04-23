#include <stdio.h>

int main(int argc, char *argv[])
{
    char *s = "hello world";
    double *pd;
    printf("len: %lu\n", sizeof(s));
    printf("pd size: %lu\n", sizeof(pd));
    char *header        = "Content-Type";
    char *header1       = "Content-Type";
    char *content_type  = "application/json";
    char *content_type1 = "application/json";
    printf("Header addres: %p\n", header);
    printf("Header1 addres: %p\n", header1);
    printf("content_type address: %p\n", content_type);
    printf("content_type1 address: %p\n", content_type1);
    return 0;
}
