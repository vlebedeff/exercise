#include "graph.h"
#include "stack.h"
#include "queue.h"

#include <stdlib.h>

Graph graph_new(unsigned capacity, bool is_directed) {
    Graph graph;
    graph.capacity = capacity;
    graph.is_directed = is_directed;
    graph.adjacency = calloc(capacity, sizeof(graph.adjacency));
    return graph;
}

void graph_edge_add(Graph graph, unsigned src, unsigned dst) {
    Node *node;
    node = malloc(sizeof(*node));
    node->value = dst;
    node->next = *(graph.adjacency + src);
    *(graph.adjacency + src) = node;
    if (!graph.is_directed) {
        node = malloc(sizeof(Node));
        node->value = src;
        node->next = *(graph.adjacency + dst);
        *(graph.adjacency + dst) = node;
    }
}

void graph_free(Graph graph) {
    for (int i = 0; i < graph.capacity; i++) {
        stack_free(graph.adjacency + i);
    }
    free(graph.adjacency);
}

Graph graph_reverse(Graph graph) {
    Graph reverse = graph_new(graph.capacity, graph.is_directed);
    for (unsigned i = 0; i < graph.capacity; ++i) {
        Node *edge = *(graph.adjacency + i);
        while (edge != NULL) {
            graph_edge_add(reverse, edge->value, i);
            edge = edge->next;
        }
    }
    return reverse;
}

bool graph_is_acyclic(Graph graph) {
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
                        return false;
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
    return true;
}

/*
 * Run DFS on the reverse graph
 * Remember postvisit order
 * Explore and remove components in descending postvisit order
 */
unsigned graph_scc_count(Graph graph) {
    Graph graph_rev = graph_reverse(graph);
    unsigned *visited = calloc(graph_rev.capacity, sizeof(*visited));
    unsigned v, u;
    Stack previsit = stack_new();
    Stack postvisit = stack_new();
    Stack stack = stack_new();
    for (unsigned i = 0; i < graph_rev.capacity; ++i) {
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
    unsigned scc_count = 0;
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

void graph_bfs_explore(Graph graph, unsigned v, void (discover)(unsigned, unsigned)) {
    unsigned *visited = calloc(graph.capacity, sizeof(*visited));
    *(visited + v) = 1;
    Queue queue = queue_new();
    queue_append(&queue, v);
    unsigned u;
    Node *adjacency;
    while (!queue_is_empty(queue)) {
        u = queue_shift(&queue);
        adjacency = *(graph.adjacency + u);
        while (adjacency != NULL) {
            if (*(visited + adjacency->value) == 0) {
                queue_append(&queue, adjacency->value);
                *(visited + adjacency->value) = 1;
            }
            discover(u, adjacency->value);
            adjacency = adjacency->next;
        }
    }
}

static int *distance;

void graph_bfs_discover_distance(unsigned u, unsigned v) {
    if (*(distance + v) == -1) {
        *(distance + v) = *(distance + u) + 1;
    }
}

int graph_distance(Graph graph, unsigned src, unsigned dst) {
    distance = calloc(graph.capacity, sizeof(*distance));
    for (int i = 0; i < graph.capacity; i++) {
        *(distance + i) = -1;
    }
    *(distance + src) = 0;
    graph_bfs_explore(graph, src, graph_bfs_discover_distance);
    int dist = *(distance + dst);
    free(distance);
    return dist;
}

static int  *colors;
static bool is_bipartite;

void graph_bfs_discover_bipartite(unsigned u, unsigned v) {
    if (*(colors + v) == -1) {
        *(colors + v) = !*(colors + u);
    }
    is_bipartite = is_bipartite && (*(colors + u) != *(colors + v));
}

bool graph_is_bipartite(Graph graph) {
    colors = calloc(graph.capacity, sizeof(*colors));
    for (int i = 0; i < graph.capacity; i++) {
        *(colors + i) = -1;
    }
    *colors = 0;
    is_bipartite = true;
    graph_bfs_explore(graph, 0, graph_bfs_discover_bipartite);
    return is_bipartite;
}
