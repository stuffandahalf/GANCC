%{
#include <stdio.h>
#include <pp_parser.h>
#include <libgancc/lang.h>

//#define DEBUG_LEX 1

extern size_t line_num;

#ifdef DEBUG_LEX
#define TOKEN(tok) \
	printef_d("%s = %s\n", #tok, yytext); \
	yylval.s = yytext; \
	return tok
#else
#define TOKEN(tok) \
    yylval.s = yytext; \
    return tok
#endif

%}

int yywrap();

%%

#						{ TOKEN(POUND); }
\"                      { TOKEN(QUOTE); }
\<						{ TOKEN(LANGBRACKET); }
\>						{ TOKEN(RANGBRACKET); }
\(						{ TOKEN(LPAREN); }
\)						{ TOKEN(RPAREN); }

define					{ TOKEN(DEFINE); }
include					{ TOKEN(INCLUDE); }

\<.*\>                  { TOKEN(GLOBALINCLUDE); }
\".*\"                  { TOKEN(LOCALINCLUDE); }

[_a-zA-Z][_a-zA-Z]*		{ TOKEN(IDENTIFIER); }
\n                      { line_num++; TOKEN(NEWLINE); }
[ \t]
.

%%

int yywrap()
{
	printef_d("yywrap is called\n");
	return 1;
}
