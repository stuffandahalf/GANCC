#ifndef GANCC_CPP_LEXER_H
#define GANCC_CPP_LEXER_H	1

struct context {
	FILE *fp;
	int line;
	int col;

	struct context *next;
};

extern struct context *context_stack;
int yylex(void);
int push_context(struct context *c);
struct context *pop_context(void);

#endif /* GANCC_CPP_LEXER_H */

