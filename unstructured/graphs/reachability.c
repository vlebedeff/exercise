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
    Node *node = NULL;
    return node;
}

void stack_push(Stack *stack, unsigned value) {
    Node *node = malloc(sizeof(Node));
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
    graph.adjacency = malloc(capacity * sizeof(graph.adjacency));
    for (int i = 0; i < capacity; i++) {
        *(graph.adjacency + i) = NULL;
    }
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

int graph_has_path(Graph graph, unsigned u, unsigned v) {
    if ((u >= graph.capacity) || (v >= graph.capacity)) {
        return 0;
    }
    if (u == v) {
        return 1;
    }
    unsigned *visited = calloc(graph.capacity, sizeof(*visited));
    Stack stack = stack_new();
    stack_push(&stack, u);
    unsigned vertex;
    while (!stack_is_empty(stack)) {
        vertex = stack_pop(&stack);
        visited[vertex] = 1;
        if (vertex == v) {
            free(visited);
            stack_free(&stack);
            return 1;
        }
        Node *edge = *(graph.adjacency + vertex);
        while (edge != NULL) {
            if (!visited[edge->value]) {
                stack_push(&stack, edge->value);
            }
            edge = edge->next;
        }
    }
    free(visited);
    return 0;
}

int main() {
    unsigned capacity, edge_count, u, v;
    scanf("%d %d", &capacity, &edge_count);
    Graph graph = graph_new(capacity);
    for (int i = 0; i < edge_count; i++) {
        scanf("%d %d", &u, &v);
        graph_edge_add(graph, u - 1, v - 1);
    }
    scanf("%d %d", &u, &v);
    printf("%d", graph_has_path(graph, u - 1 , v - 1));
}
