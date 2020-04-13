#include "node.h"

#include <stdbool.h>

typedef Node* Stack;

Stack    stack_new();
bool     stack_is_empty(Stack);
void     stack_push(Stack*, unsigned);
unsigned stack_pop(Stack*);
void     stack_free(Stack*);
