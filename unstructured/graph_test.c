#include "graph.h"

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>

/*
 * Strongly-connected components
 */
static void graph_test_scc_count() {
    char *fixtures[] = {
        "./test/fixtures/graphs/scc_001.txt",
        "./test/fixtures/graphs/scc_002.txt",
    };
    for (int f = 0; f < 2; f++) {
        FILE *fixture;
        unsigned capacity, edge_count, v1, v2, scc_count;
        fixture = fopen(fixtures[f], "r");
        fscanf(fixture, "%d %d\n", &capacity, &edge_count);
        Graph graph = graph_new(capacity, true);
        for (int i = 0; i < edge_count; i++) {
            fscanf(fixture, "%d %d\n", &v1, &v2);
            graph_edge_add(graph, v1 - 1, v2 - 1);
        }
        fscanf(fixture, "%d\n", &scc_count);
        fclose(fixture);
        assert(graph_scc_count(graph) == scc_count && fixtures[f]);
    }
}

/*
 * Acyclicity
 */
static void graph_test_is_acyclic() {
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
        Graph graph = graph_new(capacity, true);
        for (int i = 0; i < edge_count; i++) {
            fscanf(fixture, "%d %d\n", &v1, &v2);
            graph_edge_add(graph, v1 - 1, v2 - 1);
        }
        fscanf(fixture, "%d\n", &has_cycles);
        fclose(fixture);
        assert(graph_is_acyclic(graph) == !has_cycles && fixtures[f]);
    }
}

static void graph_test_distance() {
    char *fixtures[] = {
        "./test/fixtures/graphs/distance_001.txt",
        "./test/fixtures/graphs/distance_002.txt"
    };
    for (int f = 0; f < 2; f++) {
        FILE *fixture;
        unsigned capacity, edge_count, v1, v2;
        int distance;
        fixture = fopen(fixtures[f], "r");
        fscanf(fixture, "%d %d", &capacity, &edge_count);
        Graph graph = graph_new(capacity, false);
        for (int i = 0; i < edge_count; i++) {
            fscanf(fixture, "%d %d", &v1, &v2);
            graph_edge_add(graph, v1 - 1, v2 - 1);
        }
        fscanf(fixture, "%d %d", &v1, &v2);
        fscanf(fixture, "%d", &distance);
        fclose(fixture);
        assert(graph_distance(graph, v1 - 1, v2 - 1) == distance);
    }
}

static void graph_test_is_bipartite() {
    char *fixtures[] = {
        "./test/fixtures/graphs/bipartite_001.txt",
        "./test/fixtures/graphs/bipartite_002.txt"
    };
    for (int f = 0; f < 2; f++) {
        FILE *fixture;
        unsigned capacity, edge_count, v1, v2, is_bipartite;
        fixture = fopen(fixtures[f], "r");
        fscanf(fixture, "%d %d", &capacity, &edge_count);
        Graph graph = graph_new(capacity, false);
        for (int i = 0; i < edge_count; i++) {
            fscanf(fixture, "%d %d", &v1, &v2);
            graph_edge_add(graph, v1 - 1, v2 - 1);
        }
        fscanf(fixture, "%d", &is_bipartite);
        fclose(fixture);
        assert(graph_is_bipartite(graph) == is_bipartite && fixtures[f]);
    }
}

int main() {
    graph_test_scc_count();
    graph_test_is_acyclic();
    graph_test_distance();
    graph_test_is_bipartite();
    return 0;
}
