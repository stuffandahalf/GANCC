%token EOF_TOK POUND
%token NEWLINE ESCAPE IDENTIFIER
%token DEFINE UNDEF
%token IF ELIF ELSE ENDIF
%token PRAGMA PRAGMA99

%{
#include <stdio.h>

int yylex(void);
void yyerror(const char *s);
%}

%%

lines
  : lines line
  | line
  | /* blank for EOF */
  ;

line
  : define
/*  | conditional
  | pragma*/
  ;

define
  : POUND DEFINE IDENTIFIER
  ;

%%

void
yyerror(const char *s)
{
	fprintf(stderr, "ERROR: %s\n", s);
}
