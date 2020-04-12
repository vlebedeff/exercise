#include <assert.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <stdarg.h>
#include <float.h>

typedef struct {
    uint64_t nrows;
    uint64_t ncols;
    uint64_t nitems;
    double *data;
} Matrix;

Matrix *matrix_new(uint64_t, uint64_t);
Matrix *matrix_init(Matrix *, ...);
double  matrix_get(const Matrix *, uint64_t, uint64_t);
void    matrix_set(const Matrix *m, uint64_t row, uint64_t col, double value);
bool    matrix_eq(Matrix *, Matrix *);
void    matrix_print(Matrix *);
Matrix *matrix_copy(Matrix *);
void    matrix_destroy(Matrix *m);
void    matrix_ndestroy(unsigned short, ...);
Matrix *gaussian_elimination(Matrix *);

int main(int argc, char *argv[])
{
    void do_test();
    void do_run();
    do_test();
    do_run();
    return 0;
}

void do_run()
{
    uint64_t nrows, offset;
    Matrix *m, *result;
    double x;
    scanf("%lu", &nrows);

    if (nrows == 0) {
        return;
    }

    m = matrix_new(nrows, nrows + 1);
    offset = 0;

    for (offset = 0; offset < m->nitems; offset++) {
        scanf("%le", &x);
        *(m->data + offset) = x;
    }

    result = gaussian_elimination(m);
    matrix_print(result);
    matrix_ndestroy(2, m, result);
}

void do_test()
{
    void test_matrix_new();
    void test_matrix_init();
    void test_matrix_copy();
    void test_matrix_get();
    test_matrix_new();
    test_matrix_init();
    test_matrix_copy();
    test_matrix_get();
}

void test_matrix_new()
{
    Matrix *m = matrix_new(10, 42);
    assert(m->nrows == 10);
    assert(m->ncols == 42);
    assert(m->nitems == 420);
}

void test_matrix_init()
{
    Matrix *m = matrix_new(2, 3);
    matrix_init(
        m,
        1.0, 2.0, 3.0,
        7.0, 6.0, 5.0
    );
    assert(*(m->data) == 1);
    assert(*(m->data + 1) == 2.0);
    assert(*(m->data + 2) == 3.0);
    assert(*(m->data + 3) == 7.0);
    assert(*(m->data + 4) == 6.0);
    assert(*(m->data + 5) == 5.0);
    matrix_destroy(m);
}

void test_matrix_copy()
{
    Matrix *m1, *m2;
    m1 = matrix_new(2, 3);
    matrix_init(
        m1,
        1.0, 2.0, 3.0,
        7.0, 6.0, 5.0
    );
    m2 = matrix_copy(m1);
    assert(*(m2->data) == 1.0);
    assert(*(m2->data + 1) == 2.0);
    assert(*(m2->data + 2) == 3.0);
    assert(*(m2->data + 3) == 7.0);
    assert(*(m2->data + 4) == 6.0);
    assert(*(m2->data + 5) == 5.0);
    matrix_ndestroy(2, m1, m2);
}

void test_matrix_get()
{
    // Example 1
    Matrix *m = matrix_new(2, 3);
    matrix_init(
        m,
        1.0, 2.0, 3.0,
        7.0, 6.0, 5.0
    );
    assert(matrix_get(m, 0, 0) == 1.0);
    assert(matrix_get(m, 0, 1) == 2.0);
    assert(matrix_get(m, 0, 2) == 3.0);
    assert(matrix_get(m, 1, 0) == 7.0);
    assert(matrix_get(m, 1, 1) == 6.0);
    assert(matrix_get(m, 1, 2) == 5.0);
    matrix_destroy(m);
}

Matrix *matrix_new(uint64_t nrows, uint64_t ncols)
{
    Matrix *m;
    m = malloc(sizeof(*m));
    m->nrows = nrows;
    m->ncols = ncols;
    m->nitems = nrows * ncols;
    m->data = calloc(sizeof(*(m->data)), nrows * ncols);
    return m;
}

Matrix *matrix_init(Matrix *m, ...)
{
    va_list args;
    uint64_t i;
    va_start(args, m);

    for (i = 0; i < m->nitems; i++) {
        *(m->data + i) = va_arg(args, double);
    }

    va_end(args);
    return m;
}

double matrix_get(const Matrix *m, uint64_t i, uint64_t j)
{
    if (i >= m->nrows) {
        perror("matrix_get: invalid row index");
        exit(1);
    }

    if (j >= m->ncols) {
        perror("matrix_get: invalid column index");
        exit(1);
    }

    uint64_t offset = i * m->ncols + j;
    return *(m->data + offset);
}


bool matrix_eq(Matrix *m1, Matrix *m2)
{
    if (m1->nrows != m2->nrows) {
        return false;
    }

    if (m1->ncols != m2->ncols) {
        return false;
    }

    uint64_t i, j;

    for (i = 0; i < m1->nrows; ++i) {
        for (j = 0; j < m1->ncols; ++j) {
            double item1 = matrix_get(m1, i, j);
            double item2 = matrix_get(m2, i, j);
            double item1_low = item1 - DBL_EPSILON * 10;
            double item1_high = item1 + DBL_EPSILON * 10;

            if (item2 < item1_low || item2 > item1_high) {
                return false;
            }
        }
    }

    return true;
}

Matrix *matrix_copy(Matrix *m)
{
    Matrix *mcopy = matrix_new(m->nrows, m->ncols);
    uint64_t i;

    for (i = 0; i < mcopy->nitems; i++) {
        *(mcopy->data + i) = *(m->data + i);
    }

    return mcopy;
}

void matrix_set(const Matrix *m, uint64_t row, uint64_t col, double value)
{
    if (row < m->nrows && col < m->ncols) {
        uint64_t offset = row * m->ncols + col;
        *(m->data + offset) = value;
    }
}

void matrix_print(Matrix *m)
{
    uint64_t i;

    for (i = 0; i < m->nitems; i++) {
        printf((i + 1) % m->ncols == 0 ? "%12.6f\n" : "%12.6f", *(m->data + i));
    }
}

void matrix_destroy(Matrix *m)
{
    free(m->data);
    free(m);
}

void matrix_ndestroy(unsigned short n, ...)
{
    va_list args;
    Matrix *m;
    va_start(args, n);

    for (; n > 0; n--) {
        m = va_arg(args, Matrix *);
        matrix_destroy(m);
    }

    va_end(args);
}

Matrix *gaussian_elimination(Matrix *original)
{
    Matrix *m, *result;
    uint64_t i, j, k, pivot;
    double fbuf, factor;
    m = matrix_copy(original);

    for (i = 0; i < (m->nrows - 1); ++i) {
        // find the row with the highest absolute value in col i
        pivot = i;

        for (j = i + 1; j < m->nrows; ++j) {
            if (fabs(matrix_get(m, j, i)) > fabs(matrix_get(m, pivot, i))) {
                pivot = j;
            }
        }

        // swap it with the ith row
        if (pivot != i) {
            for (j = 0; j < m->ncols; ++j) {
                fbuf = matrix_get(m, i, j);
                matrix_set(m, i, j, matrix_get(m, pivot, j));
                matrix_set(m, pivot, j, fbuf);
            }
        }

        // eliminate column i under ith row
        for (j = i + 1; j < m->nrows; ++j) {
            factor = matrix_get(m, j, i) / matrix_get(m, i, i);

            for (k = 0; k < m->ncols; ++k) {
                fbuf = matrix_get(m, j, k) - matrix_get(m, i, k) * factor;
                matrix_set(m, j, k, fbuf);
            }
        }
    }

    result = matrix_new(1, m->nrows);

    for (i = m->nrows; i > 0; --i) {
        fbuf = matrix_get(m, i - 1, m->ncols - 1);

        for (j = i; j < m->ncols - 1; ++j) {
            fbuf -= matrix_get(m, i - 1, j) * matrix_get(result, 0, j);
        }

        matrix_set(result, 0, i - 1, fbuf / matrix_get(m, i - 1, i - 1));
    }

    return result;
}
