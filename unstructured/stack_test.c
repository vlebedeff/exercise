#include "stack.h"

#include <assert.h>
#include <stdlib.h>

static void stack_test_new() {
    Stack stack = stack_new();
    assert(stack == NULL && "Empty stack is NULL pointer");
}

static void stack_test_is_empty_when_new() {
    Stack stack = stack_new();
    assert(stack_is_empty(stack) && "New stack is empty");
}

static void stack_test_is_not_empty_after_push() {
    Stack stack = stack_new();
    stack_push(&stack, 42);
    assert(!stack_is_empty(stack));
}

static void stack_test_push() {
    Stack stack = stack_new();
    stack_push(&stack, 42);
    stack_push(&stack, 142);
    assert(stack->value == 142);
    assert(stack->next->value == 42);
    assert(stack->next->next == NULL);
}

static void stack_test_pop() {
    Stack stack = stack_new();
    stack_push(&stack, 42);
    stack_push(&stack, 142);
    assert(stack_pop(&stack) == 142);
    assert(stack_pop(&stack) == 42);
    assert(stack_is_empty(stack));
}

static void stack_test_free() {
    Stack stack = stack_new();
    stack_push(&stack, 42);
    stack_push(&stack, 142);
    stack_free(&stack);
    assert(stack_is_empty(stack));
}

int main() {
    stack_test_new();
    stack_test_is_empty_when_new();
    stack_test_push();
    stack_test_is_not_empty_after_push();
    stack_test_pop();
    stack_test_free();
    return 0;
}
