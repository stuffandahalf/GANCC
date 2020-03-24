%{
#include <stdio.h>
#include <lang_parser.h>

#ifndef NDEBUG
#define printdf(fmt, ...) fprintf(stderr, "[%s:%d] >> " fmt, __FILE__, __LINE__, ##__VA_ARGS__)
#else
#define printdf(fmt, ...)
#endif

#define TOKEN(tok) \
	printdf("%s = %s\n", #tok, yytext); \
	return tok

int yywrap();

%}

%%

\[						{ TOKEN(LBRACKET); }
\]						{ TOKEN(RBRACKET); }
\(						{ TOKEN(LPAREN); }
\)						{ TOKEN(LPAREN); }
\{						{ TOKEN(LBRACE); }
\}						{ TOKEN(RBRACE); }

int						{ TOKEN(INT); }
long					{ TOKEN(LONG); }
short					{ TOKEN(SHORT); }

[_a-zA-Z][_a-zA-Z0-9]*	{ TOKEN(IDENTIFIER); }

%%

int yywrap()
{
	printdf("yywrap is called\n");
	return 1;
}
