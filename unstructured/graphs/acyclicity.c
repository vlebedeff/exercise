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

void stack_free(Stack *stack) {
  while (*stack != NULL) {
    Node *top = *stack;
    *stack = top->next;
    free(top);
  }
}

void stack_inspect(Stack stack) {
  Node *e = stack;
  printf("[");
  while (e != NULL) {
    printf("%u", e->value);
    e = e->next;
    if (e != NULL) {
      printf(", ");
    }
  }
  printf("]\n");
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
  free(graph.adjacency);
}

int graph_is_acyclic(Graph graph) {
  unsigned v = 0;
  unsigned u;
  Stack stack = stack_new();
  for (unsigned v = 0; v < graph.capacity; v++) {
    Node *edge = *(graph.adjacency + v);
    stack_free(&stack);
    unsigned *visited = calloc(graph.capacity, sizeof(*visited));
    if (edge != NULL) {
      do {
        stack_push(&stack, edge->value);
        edge = edge->next;
      } while (edge != NULL);
      while (!stack_is_empty(stack)) {
        u = stack_pop(&stack);
        visited[u] = 1;
        edge = *(graph.adjacency + u);
        while (edge != NULL) {
          if (edge->value == v) {
            stack_free(&stack);
            return 0;
          } else {
            if (!visited[edge->value]) {
              stack_push(&stack, edge->value);
            }
            edge = edge->next;
          }
        }
      }
    }
    free(visited);
  }
  return 1;
}

char * test_acyclicity() {
  char *fixtures[] = {
    "./test/fixtures/graphs/acyclicity_001.txt",
    "./test/fixtures/graphs/acyclicity_002.txt",
    "./test/fixtures/graphs/acyclicity_003.txt",
    "./test/fixtures/graphs/acyclicity_004.txt",
    "./test/fixtures/graphs/acyclicity_005.txt",
    "./test/fixtures/graphs/acyclicity_006.txt",
    "./test/fixtures/graphs/acyclicity_007.txt",
    "./test/fixtures/graphs/acyclicity_008.txt"
  };
  for (int f = 0; f < 8; f++) {
    FILE *fixture;
    unsigned capacity, edge_count, v1, v2, has_cycles;
    fixture = fopen(fixtures[f], "r");
    fscanf(fixture, "%d %d\n", &capacity, &edge_count);
    Graph graph = graph_new(capacity);
    for (int i = 0; i < edge_count; i++) {
      fscanf(fixture, "%d %d\n", &v1, &v2);
      graph_edge_add(graph, v1 - 1, v2 - 1);
    }
    fscanf(fixture, "%d\n", &has_cycles);
    fclose(fixture);
    mu_assert(
        (graph_is_acyclic(graph) == !has_cycles),
        fixtures[f]
    );
  }
  return 0;
}

char * test_all() {
  mu_run_test(test_acyclicity);
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
    printf("%d\n", !graph_is_acyclic(graph));
    graph_free(graph);
  }
}
