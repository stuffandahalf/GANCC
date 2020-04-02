#include <stdio.h>
#include <stdlib.h>
#include <libgancc/context.h>
#include <libgancc/lang.h>
#include <lang_parser.h>

int yyparse(void);

int main(int argc, char **argv)
{
	/*printf("Hello World\n");*/

	cntxt = init_context(malloc(sizeof(struct context)));
	cntxt->fname = "<stdin>";

	yyparse();

	printef_d("%s:%zd:%zd\n", cntxt->fname, cntxt->line, cntxt->column);

	free_context(cntxt);
	return 0;
}
