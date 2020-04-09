#include <assert.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>

typedef struct {
    uint64_t size;
    double *data;
} vector_t;

typedef struct {
    uint64_t nrows;
    uint64_t ncols;
    double *data;
} matrix_t;

vector_t *vector_new(uint64_t size);
void      vector_destroy(vector_t *v);
bool      vector_eq(const vector_t *const v1, const vector_t *const v2);
void      vector_set(vector_t *v, uint64_t idx, double val);

int main(int argc, char *argv[])
{
    void do_test();
    do_test();
    return 0;
}

void do_test()
{
    void test_vector_eq_1();
    void test_vector_eq_2();
    void test_vector_eq_3();
    void test_vector_eq_4();
    test_vector_eq_1();
    test_vector_eq_2();
    test_vector_eq_3();
    test_vector_eq_4();
}

void test_vector_eq_2()
{
    vector_t *v1 = vector_new(0);
    vector_t *v2 = vector_new(1);
    assert(vector_eq(v1, v2) != true);
    vector_destroy(v1);
    vector_destroy(v2);
}

void test_vector_eq_1()
{
    vector_t *v1 = vector_new(5);
    vector_t *v2 = vector_new(5);
    assert(vector_eq(v1, v2));
    vector_destroy(v1);
    vector_destroy(v2);
}

void test_vector_eq_3()
{
    vector_t *v1 = vector_new(3);
    vector_t *v2 = vector_new(3);
    vector_set(v1, 0, 1.0);
    vector_set(v1, 0, 2.0);
    assert(vector_eq(v1, v2) != true);
    vector_destroy(v1);
    vector_destroy(v2);
}

void test_vector_eq_4()
{
    vector_t *v1 = vector_new(10000);
    vector_t *v2 = vector_new(10000);
    vector_set(v1, 9999, 1);
    vector_set(v2, 9999, 1.001);
    assert(vector_eq(v1, v2) != true);
    vector_destroy(v1);
    vector_destroy(v2);
}

vector_t *vector_new(uint64_t size)
{
    vector_t *v;
    v = malloc(sizeof(*v));
    v->size = size;
    v->data = calloc(sizeof(*(v->data)), size);
    return v;
}

void vector_destroy(vector_t *v)
{
    free(v->data);
    free(v);
}

void vector_set(vector_t *v, uint64_t i, double val)
{
    if (i < v->size) {
        *(v->data + i) = val;
    } else {
        /* Realloc with new size */
    }
}

bool vector_eq(const vector_t *const v1, const vector_t *const v2)
{
    if (v1->size != v2->size) {
        return false;
    }

    for (uint64_t i = 0; i < v1->size; i++)
        if (*(v1->data + i) != *(v2->data + i)) {
            return false;
        }

    return true;
}
