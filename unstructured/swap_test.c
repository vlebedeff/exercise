/* Exercise 4-14 */

#include <assert.h>

#define swap(t, x, y) { t w = x; x = y; y = w; }

void test_swap_example_1()
{
    int x, y;
    x = 1;
    y = 2;
    swap(int, x, y);
    assert(x == 2 && y == 1);
}

void test_swap_example_2()
{
    double d1, d2;
    d1 = 42.0;
    d2 = 3.14;
    swap(double, d1, d2);
    assert(d1 == 3.14 && d2 == 42.0);
}

int main()
{
    test_swap_example_1();
    test_swap_example_2();
    return 0;
}
