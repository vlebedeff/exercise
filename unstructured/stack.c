#include "node.h"
#include "stack.h"

#include <assert.h>
#include <stdbool.h>
#include <stdlib.h>

Stack stack_new() {
    return NULL;
}

bool stack_is_empty(Stack stack) {
    return stack == NULL;
}

void stack_push(Stack *stack, unsigned value) {
    Node *node = malloc(sizeof(*node));
    node->value = value;
    node->next = *stack;
    *stack = node;
}

unsigned stack_pop(Stack *stack) {
    assert(!stack_is_empty(*stack));
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
