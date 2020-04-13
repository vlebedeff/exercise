/*
 * Strongly Connected Components
 */

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

typedef Node* Stack;

typedef struct Graph {
  Stack* adjacency;
  unsigned capacity;
} Graph;

typedef unsigned int uint;

// --- STACK ---
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
  while (e != NULL) {
    printf("%u", e->value + 1);
    e = e->next;
    if (e != NULL) {
      printf(" ");
    }
  }
  printf("\n");
}
// --- STACK ---

// --- GRAPH ---
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

Graph graph_reverse(Graph graph) {
  Graph reverse = graph_new(graph.capacity);
  for (uint i = 0; i < graph.capacity; ++i) {
    Node *edge = *(graph.adjacency + i);
    while (edge != NULL) {
      graph_edge_add(reverse, edge->value, i);
      edge = edge->next;
    }
  }
  return reverse;
}

/*
 * Run DFS on the reverse graph
 * Remember postvisit order
 * Explore and remove components in descending postvisit order
 */
uint graph_scc_count(Graph graph) {
  Graph graph_rev = graph_reverse(graph);
  uint *visited = calloc(graph_rev.capacity, sizeof(*visited));
  uint v, u;
  Stack previsit = stack_new();
  Stack postvisit = stack_new();
  Stack stack = stack_new();
  for (uint i = 0; i < graph_rev.capacity; ++i) {
    if (!visited[i]) {
      stack_push(&previsit, i);
      while (!stack_is_empty(previsit)) {
        v = previsit->value;
        if (!visited[v]) {
          Node *adjacency = *(graph_rev.adjacency + v);
          while (adjacency != NULL) {
            if (!visited[adjacency->value]) {
              stack_push(&previsit, adjacency->value);
            }
            adjacency = adjacency->next;
          }
          visited[v] = 1;
        } else {
          stack_pop(&previsit);
          if (visited[v] == 1) {
            stack_push(&postvisit, v);
            visited[v] = 2;
          }
        }
      }
    }
  }
  uint scc_count = 0;
  while (!stack_is_empty(postvisit)) {
    v = stack_pop(&postvisit);
    if (visited[v] != 3) {
      stack_push(&stack, v);
      while (!stack_is_empty(stack)) {
        u = stack_pop(&stack);
        Node *adjacency = *(graph.adjacency + u);
        while (adjacency != NULL) {
          if (visited[adjacency->value] != 3) {
            stack_push(&stack, adjacency->value);
          }
          adjacency = adjacency->next;
        }
        visited[u] = 3;
      }
      scc_count++;
    }
  }
  return scc_count;
}
// --- GRAPH ---

char * test_all() {
  char *fixtures[] = {
    "./test/fixtures/graphs/scc_001.txt",
    "./test/fixtures/graphs/scc_002.txt",
  };
  for (int f = 0; f < 2; f++) {
    FILE *fixture;
    unsigned capacity, edge_count, v1, v2, scc_count;
    fixture = fopen(fixtures[f], "r");
    fscanf(fixture, "%d %d\n", &capacity, &edge_count);
    Graph graph = graph_new(capacity);
    for (int i = 0; i < edge_count; i++) {
      fscanf(fixture, "%d %d\n", &v1, &v2);
      graph_edge_add(graph, v1 - 1, v2 - 1);
    }
    fscanf(fixture, "%d\n", &scc_count);
    fclose(fixture);
    mu_assert(
        (graph_scc_count(graph) == scc_count),
        fixtures[f]
    );
  }
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
    printf("%d\n", graph_scc_count(graph));
    graph_free(graph);
  }
}
