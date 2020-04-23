#include <string.h>
#include <stdio.h>

int strrindex(const char src[], const char pattern[])
{
    int src_len = strlen(src);
    int pattern_len = strlen(pattern);

    if (src_len == 0 && pattern_len == 0) {
        return 0;
    }

    int i, j, k;

    for (i = src_len - pattern_len - 1; i >= 0; i--) {
        for(j = i, k = 0; pattern[k] != '\0' && src[j] == pattern[k]; j++, k++);

        if (k > 0 && pattern[k] == '\0') {
            return i;
        }
    }

    return -1;
}
