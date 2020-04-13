#include <stdio.h>
#include <stdlib.h>

#define LINE_SIZE 10
#define FULL_SIZE (LINE_SIZE * LINE_SIZE)
#define LINE_OFFSET_MAX (LINE_SIZE - 1)
#define COLOR_RESET "\033[0m"
#define COLOR_BOLD_RED(s) ("\033[1;31m" s COLOR_RESET)

int main() {
    unsigned *table;
    table = calloc(sizeof(*table), FULL_SIZE);
    for (int offset = 0; offset < FULL_SIZE; ++offset) {
        char *format = (offset % LINE_SIZE) == LINE_OFFSET_MAX ? COLOR_BOLD_RED("%4u\n") : "%4u";
        printf(format, *(table + offset));
    }
    return 0;
}
