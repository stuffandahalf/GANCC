#include <stdio.h>
#include <locale.h>
#include "parser.h"

int
main(int argc, char **argv)
{
	setlocale(LC_ALL, "");

	printf("Hello World!\n");
	yyparse();

	return 0;
}

