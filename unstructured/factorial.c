#include <stdio.h>

int main() {
    int i, j, num;
    printf("Enter the number: ");
    scanf("%d", &num);
    for (i = 1, j = 1; i <= num; i++)
        j *= i;
    printf("The factorial is: %d\n", j);
}
