/* Exercise 5-3 */

#include <assert.h>
#include <string.h>

extern char *mystrcat(char *s, char *t);

void test_example_1()
{
    char s[100] = "";
    char t[100] = "";
    mystrcat(s, t);
    assert(strcmp(s, "") == 0);
}

void test_example_2()
{
    char s[100] = "hello";
    char t[100] = "";
    mystrcat(s, t);
    assert(strcmp(s, "hello") == 0);
}

void test_example_3()
{
    char s[100] = "";
    char t[100] = "hello";
    mystrcat(s, t);
    assert(strcmp(s, "hello") == 0);
}

void test_example_4()
{
    char s[100] = "hello";
    char t[100] = " world";
    mystrcat(s, t);
    assert(strcmp(s, "hello world") == 0);
}

int main()
{
    test_example_1();
    test_example_2();
    test_example_3();
    return 0;
}
