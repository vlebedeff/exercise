/* Exercise 4-1 */

#include <assert.h>

extern int strrindex(char src[], char pattern[]);

void test_strrindex_example_1()
{
    assert(strrindex("hello", "e") == 1);
}

void test_strrindex_example_2()
{
    assert(strrindex("hello", "l") == 3);
}

void test_strrindex_example_3()
{
    assert(strrindex("hello", "a") == -1);
}

void test_strrindex_example_4()
{
    assert(strrindex("ACTGGTCAGGTCA", "GG") == 8);
}

void test_strrindex_example_5()
{
    assert(strrindex("", "GG") == -1);
}

void test_strrindex_example_6()
{
    assert(strrindex("ACTGGTCAGGTCA", "") == -1);
}

void test_strrindex_example_7()
{
    assert(strrindex("", "") == 0);
}

int main()
{
    test_strrindex_example_1();
    test_strrindex_example_2();
    test_strrindex_example_3();
    test_strrindex_example_4();
    test_strrindex_example_5();
    test_strrindex_example_6();
    test_strrindex_example_7();
    return 0;
}
