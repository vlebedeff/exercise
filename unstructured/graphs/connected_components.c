#include <stdio.h>
#include <stdlib.h>

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
    node = malloc(sizeof(Node));
    node->value = src;
    node->next = *(graph.adjacency + dst);
    *(graph.adjacency + dst) = node;
}

void graph_free(Graph graph) {
    free(graph.adjacency);
}

unsigned graph_cc_count(Graph graph) {
    unsigned *visited = calloc(graph.capacity, sizeof(*visited));
    unsigned cc_count = 0;
    unsigned u;
    for (int v = 0; v < graph.capacity; v++) {
        if (!visited[v]) {
            Stack stack = stack_new();
            stack_push(&stack, v);
            while (!stack_is_empty(stack)) {
                u = stack_pop(&stack);
                visited[u] = 1;
                Node *edge = *(graph.adjacency + u);
                while (edge != NULL) {
                    if (!visited[edge->value]) {
                        stack_push(&stack, edge->value);
                    }
                    edge = edge->next;
                }
            }
            cc_count++;
        }
    }
    free(visited);
    return cc_count;
}

int main() {
    unsigned capacity, edge_count, u, v;
    scanf("%d %d", &capacity, &edge_count);
    Graph graph = graph_new(capacity);
    for (int i = 0; i < edge_count; i++) {
        scanf("%d %d", &u, &v);
        graph_edge_add(graph, u - 1, v - 1);
    }
    printf("%d\n", graph_cc_count(graph));
    graph_free(graph);
}
