#include <stdio.h>
#include <lang_parser.h>

int main(int argc, char **argv)
{
	/*printf("Hello World\n");*/
	yyparse();
	return 0;
}
