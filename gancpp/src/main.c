#include <stdio.h>
#include <pp_parser.h>

size_t line_num;

int main(int argc, char **argv)
{
	//printf("Hello from %s\n", argv[0]);
	yyparse();
	//yylex();
	return 0;
}
