#include <stdlib.h>

typedef struct Node {
  int value;
  struct Node *next;
} Node;

typedef Node* Stack;

typedef struct Queue {
  Node *first;
  Node *last;
} Queue;

typedef struct Graph {
  Stack* adjacency;
  unsigned capacity;
} Graph;

typedef unsigned int uint;

Queue queue_new() {
  Queue queue;
  queue.first = NULL;
  queue.last = queue.first;
  return queue;
}

uint queue_is_empty(Queue queue) {
  return queue.first == queue.last && queue.first == NULL;
}

void queue_append(Queue *queue, uint v) {
  Node *node = malloc(sizeof(*node));
  node->value = v;
  if (queue_is_empty(*queue)) {
    queue->first = node;
    queue->last = node;
  } else {
    queue->last->next = node;
    queue->last = node;
  }
}

uint queue_shift(Queue *queue) {
  Node *node = queue->first;
  uint v = node->value;
  queue->first = queue->first->next;
  free(node);
  return v;
}
