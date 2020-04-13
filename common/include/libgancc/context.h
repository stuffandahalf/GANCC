#ifndef LIB_GANCC_CONTEXT_H
#define LIB_GANCC_CONTEXT_H

#include <libgancc/bitflag.h>

#define CONTEXT_FLAG_NEW_FILE		1
#define CONTEXT_FLAG_RETURN_FILE	2
#define CONTEXT_FLAG_SYSTEM_HEADER	3
#define CONTEXT_FLAG_EXTERN_C		4
#define CONTEXT_FLAG_MAX			CONTEXT_FLAG_EXTERN_C

struct context {
	size_t column;
	size_t line;
	const char *fname;
	unsigned int flags;
	struct context *parent;
};

struct context *init_context(struct context *cntxt);
void free_context(struct context *cntxt);

extern struct context *cntxt;

#endif /* defined(LIB_GANCC_CONTEXT_H) */
