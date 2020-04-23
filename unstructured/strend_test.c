/* Exercise 5-4 */

#include <assert.h>
#include <stdbool.h>

extern bool strend(char *s, char *t);

void test_example_1()
{
    assert(strend("", "") == true);
}

void test_example_2()
{
    assert(strend("", "abc") == false);
}

void test_example_3()
{
    assert(strend("actg", "g") == true);
}

void test_example_4()
{
    assert(strend("actg", "tg") == true);
}

void test_example_5()
{
    assert(strend("actg", "ctg") == true);
}

void test_example_6()
{
    assert(strend("actg", "actg") == true);
}

void test_example_7()
{
    assert(strend("actg", "xyz") == false);
}

void test_example_8()
{
    assert(strend("actgactgactgactg", "actt") == false);
}

void test_example_9()
{
    assert(strend("The quick brown fox jumps over the lazy dog!", "cat") == false);
}

void test_example_10()
{
    assert(strend("The quick brown fox jumps over the lazy dog!", "dog!") == true);
}


int main()
{
    test_example_1();
    test_example_2();
    test_example_3();
    test_example_4();
    test_example_5();
    test_example_6();
    test_example_7();
    test_example_8();
    test_example_9();
    test_example_10();
    return 0;
}
