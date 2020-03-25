%token POUND QUOTE
%token LANGBRACKET RANGBRACKET
%token LPAREN RPAREN
%token DEFINE INCLUDE
%token IDENTIFIER NEWLINE
 /*HEADERPATH MACROVAL*/
%token GLOBALINCLUDE LOCALINCLUDE

%union {
    char *s;
    long l;
    double d;
}

%{
#include <stdio.h>
#include <stdlib.h>
#include <libgancc/lang.h>

//#define YYSTYPE char *

int yylex();
void include(char **include, char end);

void yyerror(const char *str)
{
	fprintf(stderr, "Error: Invalid preprocessor token \"%s\"\n", str);
	exit(1);
}

%}

%%

source : line source
       | line
       ;

line : NEWLINE
     | directive NEWLINE
	 | ".*" NEWLINE
	     { printf("Anything line\n"); }
     ;

directive : include
          | define
          ;

include : POUND INCLUDE LOCALINCLUDE
            { printf("%s\n", $<s>3); }
        | POUND INCLUDE GLOBALINCLUDE
            { printf("%s\n", $<s>3); }
        ;

define : POUND DEFINE IDENTIFIER /*".*(\\\n.*)*"*/ /*NEWLINE */
           { printef_d("MACRO DEFINITION\n"); printef_d("%s\n", $<s>$); }
       ;

%%


