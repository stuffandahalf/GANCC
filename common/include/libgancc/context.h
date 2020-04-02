#ifndef LIB_GANCC_CONTEXT_H
#define LIB_GANCC_CONTEXT_H

struct context {
	size_t column;
	size_t line;
	const char *fname;
	struct context *parent;
};

struct context *init_context(struct context *cntxt);
void free_context(struct context *cntxt);

extern struct context *cntxt;

#endif /* defined(LIB_GANCC_CONTEXT_H) */
