%token AUTO BREAK CASE CHAR CONST CONTINUE DEFAULT DO DOUBLE ELSE ENUM EXTERN
%token FLOAT FOR GOTO IF INT LONG REGISTER RETURN SHORT SIGNED SIZEOF STATIC
%token STRUCT SWITCH TYPEDEF UNION UNSIGNED VOID VOLATILE WHILE

%token BOOL

%token POUND SEMICOLON
%token LPAREN RPAREN
%token LBRACKET RBRACKET
%token LBRACE RBRACE
%token EQUALS

%token IDENTIFIER

%token NUMBER STRING

%{
#include <stdio.h>
#include <stdlib.h>
#include <libgancc/lang.h>
//#include <libgancc/constructs.h>

int yylex();

void yyerror(const char *str)
{
	fprintf(stderr, "Error: %s on line number %d\n", str, -1);
	exit(1);
}
%}

%code requires {
    #include <libgancc/constructs.h>
}

%union {
    char *s;
    struct literal l;
}

%%
program : statement program
        | statement
        ;

statement : variable_decl
              { printef_d("Variable declared\n"); }
          /*| function_proto*/
          /*| function*/
          ;

variable_decl : type IDENTIFIER SEMICOLON
              | type IDENTIFIER EQUALS literal SEMICOLON
              ;

/*function_proto :*/

literal : NUMBER
        | STRING
        | IDENTIFIER
        ;

type : INT
     | LONG
     | SHORT
     | BOOL
     ;
%%
