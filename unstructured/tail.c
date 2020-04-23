#define _POSIX_C_SOURCE 200809L
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

#define TAIL_SIZE 10

int main(int argc, char *argv[])
{
    char *tail[TAIL_SIZE], *line;
    size_t bufsize = 200;
    uint8_t i;
    line = malloc(sizeof(*line) * bufsize);

    for (i = 0; i < TAIL_SIZE; i++) {
        tail[i] = NULL;
    }

    while (getline(&line, &bufsize, stdin) != -1) {
        free(tail[0]);

        for (i = 0; i < (TAIL_SIZE - 1); i++) {
            tail[i] = tail[i + 1];
        }

        tail[i] = strdup(line);
    }

    for (i = 0; i < TAIL_SIZE; i++)
        if (tail[i] != NULL) {
            printf("%s", tail[i]);
        }

    return 0;
}
