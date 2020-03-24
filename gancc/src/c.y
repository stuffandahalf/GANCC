%token LPAREN RPAREN
%token LBRACKET RBRACKET
%token LBRACE RBRACE

%token IDENTIFIER
%token INT LONG SHORT

%{
#include <stdio.h>
#include <stdlib.h>

int yylex();

void yyerror(const char *str)
{
	fprintf(stderr, "Error: %s on line number %d\n", str, -1);
	exit(1);
}
%}

%%
program : program statement
		| statement
		;

statement : type
	  ;

type : INT
     | LONG
     | SHORT
     ;
%%
