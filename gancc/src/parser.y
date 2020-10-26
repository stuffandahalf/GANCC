%token LBRACE RBRACE
%token LPAREN RPAREN
%token LBRACKET RBRACKET
%token SEMICOL EQUAL COMMA
%token IDENTIFIER
%token INTEGER_CONST OCTAL_CONST HEX_CONST

%{
#include <stdio.h>

int yylex(void);
void yyerror(const char *s);
%}

%%

tl_unit
	: variable_decl
/*	| func_decl
	| func_defn*/
	;

variable_decl
	: /*var_mod type*/ variable_decl_list
	;

variable_decl_list
	: IDENTIFIER COMMA variable_decl_list
	| IDENTIFIER
	;

/*var_mod
	: 
	;

type
	:
	;*/

value
	: INTEGER_CONST
	| OCTAL_CONST
	| HEX_CONST
	;

%%

void
yyerror(const char *s)
{
	fprintf(stderr, "ERROR: %s\n", s);
}

