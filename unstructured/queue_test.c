#include "queue.h"

#include <assert.h>
#include <stdlib.h>

static void queue_test_new() {
    Queue queue = queue_new();
    assert(queue.first == NULL);
    assert(queue.last == NULL);
}

int main() {
    queue_test_new();
    return 0;
}
