#include <stdlib.h>
#include <libgancc/context.h>

struct context *cntxt;

struct context *init_context(struct context *cntxt)
{
	if (cntxt == NULL) {
		return NULL;
	}

	cntxt->column = 1;
	cntxt->line = 1;
	cntxt->fname = NULL;
	cntxt->parent = NULL;

	return cntxt;
}

void free_context(struct context *cntxt)
{
	if (cntxt == NULL) {
		return;
	}

	free_context(cntxt->parent);
	free(cntxt);
}