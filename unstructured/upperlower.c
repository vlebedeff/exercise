/* Exercise 7-1 */

#include <wchar.h>
#include <stdio.h>
#include <ctype.h>
#include <string.h>

int main(int argc, char *argv[])
{
    wchar_t c;
    wchar_t (*f)(wchar_t);

    if (strcmp(argv[0], "./lower") == 0) {
        f = &tolower;
    } else {
        f = &toupper;
    }

    while ((c = getchar()) != EOF) {
        putchar((*f)(c));
    }

    return 0;
}
