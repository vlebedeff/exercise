#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define MAX 300
#define MIN 0
#define STEP 20

static char * render_temperatures() {
    char * output = malloc(512 * sizeof(char));
    sprintf(output, "%8s\t%8s\n", "Fahrenheit", "Celcius");
    for(int fahr = MAX; fahr >= MIN; fahr -= STEP)
        sprintf(output + strlen(output), "%8d\t%6.1f\n", fahr, ((5.0/9.0) * (fahr - 32)));
    return output;
}

int main() {
    puts(render_temperatures());
    return 0;
}
