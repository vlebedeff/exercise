#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define KNRM  "\x1B[0m"
#define KRED  "\x1B[31m"
#define KGRN  "\x1B[32m"

#define mu_assert(test, message) \
  do { \
    if (test) { \
      printf("%s+ %s%s\n", KGRN, message, KNRM); \
    } else { \
      printf("%s- %s%s\n", KRED, message, KNRM); \
      return message; \
    } \
  } while (0)
#define mu_run_test(test) do { char *message = test(); \
  if (message) return message; } while (0)

typedef struct Node {
  int value;
  struct Node *next;
} Node;

typedef struct Graph {
  Node** adjacency;
  unsigned capacity;
} Graph;

typedef Node* Stack;

Stack stack_new() {
  return NULL;
}

void stack_push(Stack *stack, unsigned value) {
  Node *node = malloc(sizeof(node));
  node->value = value;
  node->next = *stack;
  *stack = node;
}

int stack_is_empty(Stack stack) {
  return stack == NULL;
}

unsigned stack_pop(Stack *stack) {
  Node *pop = *stack;
  *stack = (*stack)->next;
  unsigned value = pop->value;
  free(pop);
  return value;
}

Stack stack_reverse(Stack stack) {
  Stack reverse = stack_new();
  Node *node = stack;
  while (node != NULL) {
    stack_push(&reverse, node->value);
    node = node->next;
  }
  return reverse;
}

void stack_free(Stack *stack) {
  while (*stack != NULL) {
    Node *top = *stack;
    *stack = top->next;
    free(top);
  }
}

void stack_inspect(Stack stack) {
  Node *e = stack;
  while (e != NULL) {
    printf("%u", e->value + 1);
    e = e->next;
    if (e != NULL) {
      printf(" ");
    }
  }
  printf("\n");
}

Graph graph_new(unsigned capacity) {
  Graph graph;
  graph.capacity = capacity;
  graph.adjacency = calloc(capacity, sizeof(graph.adjacency));
  return graph;
}

void graph_edge_add(Graph graph, unsigned src, unsigned dst) {
  Node *node;
  node = malloc(sizeof(*node));
  node->value = dst;
  node->next = *(graph.adjacency + src);
  *(graph.adjacency + src) = node;
}

void graph_free(Graph graph) {
  // TODO free adjacency for each vertex
  free(graph.adjacency);
}

Stack graph_topology(Graph graph) {
  unsigned *visited = calloc(graph.capacity, sizeof(*visited));
  Stack previsit = stack_new();
  Stack postvisit = stack_new();
  for (int i = 0; i < graph.capacity; i++) {
    stack_push(&previsit, i);
    unsigned p;
    while (!stack_is_empty(previsit)) {
      p = previsit->value;
      if (!visited[p]) {
        visited[p] = 1;
        Node *adjacency = *(graph.adjacency + p);
        while (adjacency != NULL) {
          if (!visited[adjacency->value]) {
            stack_push(&previsit, adjacency->value);
          }
          adjacency = adjacency->next;
        }
      } else {
        stack_pop(&previsit);
        if (visited[p] == 1) {
          stack_push(&postvisit, p);
          visited[p] = 2;
        }
      }
    }
  }
  free(visited);
  return postvisit;
}

char * test_topology() {
  char *fixtures[] = {
  };
  for (int f = 0; f < 1; f++) {
    FILE *fixture;
    unsigned capacity, edge_count, v1, v2;
    fixture = fopen(fixtures[f], "r");
    fscanf(fixture, "%d %d\n", &capacity, &edge_count);
    Graph graph = graph_new(capacity);
    for (int i = 0; i < edge_count; i++) {
      fscanf(fixture, "%d %d\n", &v1, &v2);
      graph_edge_add(graph, v1 - 1, v2 - 1);
    }
    fclose(fixture);
    // TODO test topological order
  }
  return 0;
}

char * test_all() {
  mu_run_test(test_topology);
  return 0;
}

int main(int argc, char *argv[]) {
  if (argc > 1 && strcmp(argv[1], "--test") == 0) {
    char *failures = test_all();
    if (!failures) {
      printf("%s%s%s\n", KGRN, "ALL TESTS PASS", KNRM);
    }
  } else {
    unsigned capacity, edge_count, u, v;
    scanf("%d %d", &capacity, &edge_count);
    Graph graph = graph_new(capacity);
    for (int i = 0; i < edge_count; i++) {
      scanf("%d %d", &u, &v);
      graph_edge_add(graph, u - 1, v - 1);
    }
    Stack topology = graph_topology(graph);
    graph_free(graph);
    stack_inspect(topology);
    stack_free(&topology);
  }
}
