#include <stdio.h>
#include <stdlib.h>
#include "lexer.h"
#include "parser.h"

struct context *context_stack = NULL;

int
yylex(void)
{
	if (context_stack == NULL) {
		struct context *c = malloc(sizeof(struct context));
		if (c == NULL) {
			fprintf(stderr, "Failed to allocate new context\n");
			exit(1);
		}
		c->fp = stdin;
		c->line = 1;
		c->col = 1;
		push_context(c);
	}
}

int
push_context(struct context *c)
{
	c->next = context_stack;
	context_stack = c;
	return 1;
}

struct context *
pop_context(void)
{
	struct context *c;

	c = context_stack;
	context_stack = context_stack->next;
	c->next = NULL;

	return c;
}

