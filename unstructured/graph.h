#include "stack.h"

#include <stdbool.h>

typedef struct Graph {
    Stack*   adjacency;
    unsigned capacity;
    bool     is_directed;
} Graph;

Graph    graph_new(unsigned capacity, bool is_directed);
void     graph_edge_add(Graph, unsigned src, unsigned dst);
unsigned graph_scc_count(Graph);
bool     graph_is_acyclic(Graph);
int      graph_distance(Graph, unsigned src, unsigned dst);
bool     graph_is_bipartite(Graph);
