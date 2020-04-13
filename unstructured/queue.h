#include "node.h"

#include <stdbool.h>

typedef struct Queue {
  Node *first;
  Node *last;
} Queue;

Queue    queue_new();
bool     queue_is_empty(Queue);
void     queue_append(Queue*, unsigned value);
unsigned queue_shift(Queue*);
