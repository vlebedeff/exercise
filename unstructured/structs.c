#include <stdio.h>
#include <stdint.h>

typedef struct {
    int x;
    int y;
} point_t;

typedef struct {
    uint32_t width;
    uint32_t height;
    point_t coords;
} rect_t;

point_t point_add(point_t p1, point_t p2) {
    p1.x += p2.x;
    p1.y += p2.y;
    return p1;
}

rect_t rect_move(rect_t r, int offsetx, int offsety) {
    r.coords.x += offsetx;
    r.coords.y += offsety;
    return r;
}

typedef struct person {
    char *first_name;  // 4
    char *last_name;   // 4
    char *title;       // 4
    short age;         // 4
}

int main(int argc, char *argv[])
{
    point_t p1, p2;

    p1.x = 5;
    p1.y = 5;

    p2.x = 3;
    p2.y = 4;

    point_t p3 = point_add(p1, p2);

    printf("Point 1: x = %d, y = %d %p\n", p1.x, p1.y, &p1);
    printf("Point 2: x = %d, y = %d %p\n", p2.x, p2.y, &p2);
    printf("Point 3: x = %d, y = %d %p\n", p3.x, p3.y, &p3);

    rect_t r1 = { .coords = { .x = 0, .y = 0 }, .width = 1, .height = 1 };
    rect_t r2 = rect_move(r1, 1, 2);
    rect_t r3 = rect_move(r2, 1, 2);

    printf(
            "Rectangle 1: x = %d, y = %d, width = %d, height = %d %p %p\n",
            r1.coords.x,
            r1.coords.y,
            r1.width,
            r1.height,
            &r1,
            &r1.coords
    );
    printf(
            "Rectangle 2: x = %d, y = %d, width = %d, height = %d %p %p\n",
            r2.coords.x,
            r2.coords.y,
            r2.width,
            r2.height,
            &r2,
            &r2.coords
    );
    printf(
            "Rectangle 3: x = %d, y = %d, width = %d, height = %d %p %p\n",
            r3.coords.x,
            r3.coords.y,
            r3.width,
            r3.height,
            &r3,
            &r3.coords
    );
    return 0;
}
