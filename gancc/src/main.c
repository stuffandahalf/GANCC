#include <stdio.h>
#include <stdlib.h>
#include <libgancc/configuration.h>
#include <libgancc/context.h>
#include <libgancc/lang.h>
#include <lang_parser.h>

int yyparse(void);

struct configuration config;

int main(int argc, char **argv)
{
	cntxt = init_context(malloc(sizeof(struct context)));
	cntxt->fname = "<stdin>";

	//config.version = 199901L;
	config.version = 0;
	
	yyparse();

	printef_d("%s:%zd:%zd\n", cntxt->fname, cntxt->line, cntxt->column);

	free_context(cntxt);
	return 0;
}
