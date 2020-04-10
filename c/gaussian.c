#include <assert.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#define TEST

typedef struct {
    uint64_t size;
    double *data;
} Vector;

typedef struct {
    uint64_t nrows;
    uint64_t ncols;
    double *data;
} Matrix;

Vector *vector_new(uint64_t size);
Vector *vector_new_with_data(uint64_t, double[]);
void    vector_destroy(Vector *v);
bool    vector_eq(const Vector *const v1, const Vector *const v2);
void    vector_set(Vector *v, uint64_t idx, double val);

Matrix *matrix_new(uint64_t nrows, uint64_t ncols);
void    matrix_set(const Matrix *m, uint64_t row, uint64_t col, double value);
void    matrix_destroy(Matrix *m);

Vector *gaussian_elimination(Matrix *m);

int main(int argc, char *argv[])
{
#ifdef TEST
    void do_test();
    do_test();
#endif
    return 0;
}

#ifdef TEST

void do_test()
{
    void test_vector_eq_1();
    void test_vector_eq_2();
    void test_vector_eq_3();
    void test_vector_eq_4();
    void test_gaussian_elimination_1();
    test_vector_eq_1();
    test_vector_eq_2();
    test_vector_eq_3();
    test_vector_eq_4();
}

void test_vector_eq_1()
{
    Vector *v1 = vector_new(5);
    Vector *v2 = vector_new(5);
    assert(vector_eq(v1, v2));
    vector_destroy(v1);
    vector_destroy(v2);
}

void test_vector_eq_2()
{
    Vector *v1 = vector_new(0);
    Vector *v2 = vector_new(1);
    assert(vector_eq(v1, v2) != true);
    vector_destroy(v1);
    vector_destroy(v2);
}

void test_vector_eq_3()
{
    Vector *v1 = vector_new(3);
    Vector *v2 = vector_new(3);
    vector_set(v1, 0, 1.0);
    vector_set(v1, 0, 2.0);
    assert(vector_eq(v1, v2) != true);
    vector_destroy(v1);
    vector_destroy(v2);
}

void test_vector_eq_4()
{
    Vector *v1 = vector_new(10000);
    Vector *v2 = vector_new(10000);
    vector_set(v1, 9999, 1);
    vector_set(v2, 9999, 1.001);
    assert(vector_eq(v1, v2) != true);
    vector_destroy(v1);
    vector_destroy(v2);
}

void test_vector_eq_5()
{
    Vector *v1 = vector_new(3);
    Vector *v2 = vector_new_with_data(3, (double) { 0, 0, 0 });
    assert(vector_eq(v1, v2));
    vector_destroy(v1);
    vector_destroy(v2);
}

void test_gaussian_elimination_1()
{
    Matrix *m = matrix_new(3, 4);
    // *INDENT-OFF*
    matrix_set(m, 0, 0, 1);  matrix_set(m, 0, 1, 3);  matrix_set(m, 0, 2, -4); matrix_set(m, 0, 3, 8);
    matrix_set(m, 1, 0, 1);  matrix_set(m, 1, 1, 1);  matrix_set(m, 1, 2, -2); matrix_set(m, 1, 3, 2);
    matrix_set(m, 2, 0, -1); matrix_set(m, 2, 1, -2); matrix_set(m, 2, 2, 5);  matrix_set(m, 2, 3, -1);
    // *INDENT-ON*
    Vector *expected = vector_new(3);
    vector_set(expected, 0, 1);
    vector_set(expected, 1, 5);
    vector_set(expected, 2, 2);
    Vector *actual = gaussian_elimination(m);
    assert(vector_eq(actual, expected));
    vector_destroy(expected);
    vector_destroy(actual);
    matrix_destroy(m);
}

#endif

Vector *vector_new(uint64_t size)
{
    Vector *v;
    v = malloc(sizeof(*v));
    v->size = size;
    v->data = calloc(sizeof(*(v->data)), size);
    return v;
}

void vector_destroy(Vector *v)
{
    free(v->data);
    free(v);
}

void vector_set(Vector *v, uint64_t i, double val)
{
    if (i < v->size) {
        *(v->data + i) = val;
    } else {
        /* Realloc with new size */
    }
}

bool vector_eq(const Vector *const v1, const Vector *const v2)
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

Matrix *matrix_new(uint64_t nrows, uint64_t ncols)
{
    Matrix *m;
    m = malloc(sizeof(*m));
    m->nrows = nrows;
    m->ncols = ncols;
    m->data = calloc(sizeof(*(m->data)), nrows * ncols);
    return m;
}

void matrix_set(const Matrix *m, uint64_t row, uint64_t col, double value)
{
    if (row < m->nrows && col < m->ncols) {
        uint64_t offset = row * m->ncols + col;
        *(m->data + offset) = value;
    }
}

void matrix_destroy(Matrix *m)
{
    free(m->data);
    free(m);
}

Vector *gaussian_elimination(Matrix *m)
{
    Vector *v = vector_new(3);
    vector_set(v, 0, 1);
    vector_set(v, 1, 5);
    vector_set(v, 2, 2);
    return v;
}
