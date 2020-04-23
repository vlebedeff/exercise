/* Exercise 5-10 */

#include <assert.h>

extern double expr(const char *tokens[], int ntokens);

void test_example_1()
{
    const char *tokens[] = {"2", "3", "4", "+", "*"};
    assert(expr(tokens, 5) == (2 * (3 + 4)));
}

void test_example_2()
{
    const char *tokens[] = {"4", "3", "2", "+", "*"};
    assert(expr(tokens, 5) == (4 * (3 + 2)));
}

void test_example_3()
{
    const char *tokens[] = {"3", "4", "5", "*", "-"};
    assert(expr(tokens, 5) == (3 - (4 * 5)));
}

void test_example_4()
{
    const char *tokens[] = {"3", "5", "+", "7", "2", "-", "*"};
    assert(expr(tokens, 7) == 40);
}

int main(int argc, char *argv[])
{
    test_example_1();
    test_example_2();
    test_example_3();
    test_example_4();
    return 0;
}
