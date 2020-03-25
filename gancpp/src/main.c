#include <stdio.h>
#include <pp_parser.h>

#include <libgancc/strtree.h>

size_t line_num;

int yyparse(void);

#define TOKEN_ANYCHAR		1
#define TOKEN_IDENTIFIER	2
#define TOKEN_POUND			11
#define TOKEN_LANGBRACKET	12
#define TOKEN_RANGBRACKET	13
#define TOKEN_LPAREN		14
#define TOKEN_RPAREN		15
#define TOKEN_IFDEF			20
#define TOKEN_IFNDEF		21
#define TOKEN_ELIF			22
#define TOKEN_ELSE			23
#define TOKEN_ENDIF			24
#define TOKEN_DEFINE		30
#define TOKEN_INCLUDE		31

static struct strval fixed_tokens[] = {
	STRVAL("#", TOKEN_POUND),
	STRVAL("<", TOKEN_LANGBRACKET),
	STRVAL(">", TOKEN_RANGBRACKET),
	STRVAL("(", TOKEN_LPAREN),
	STRVAL(")", TOKEN_RPAREN),

	STRVAL("ifdef", TOKEN_IFDEF),
	STRVAL("ifndef", TOKEN_IFNDEF),
	STRVAL("elif", TOKEN_ELIF),
	STRVAL("else", TOKEN_ELSE),
	STRVAL("endif", TOKEN_ENDIF),

	STRVAL("define", TOKEN_DEFINE),
	STRVAL("include", TOKEN_INCLUDE)
};

int main(int argc, char **argv)
{
	//printf("Hello from %s\n", argv[0]);
	//yyparse();
	//yylex();
	return 0;
}
