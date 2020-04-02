%{
#include <stdio.h>
#include <stdlib.h>
#include <libgancc/lang.h>
#include <lang_parser.h>

#define DEBUG_LEX   1

#if defined(DEBUG_LEX) && DEBUG_LEX
#define TOKEN(tok, assignment) \
    assignment; \
	printef_d("%s = %s\n", #tok, yytext); \
	return tok
#else
#define TOKEN(tok, assignment) \
    assignment; \
    return tok
#endif

#define DEFAULT_ASSIGN  yylval.s = yytext

#define NUMERIC_ASSIGN(base) { \
    if (yytext[0] == '-') { \
        yylval.l.type = LITERAL_TYPE_SIGNED_INT; \
        yylval.l.val.si = PARSE_INT(yytext, NULL, base); \
    } else { \
        yylval.l.type = LITERAL_TYPE_UNSIGNED_INT; \
        yylval.l.val.ui = PARSE_UINT(yytext, NULL, base); \
    } \
}

int yywrap();

%}

%%

#                       { TOKEN(POUND, DEFAULT_ASSIGN); }
=                       { TOKEN(EQUALS, DEFAULT_ASSIGN); }
;                       { TOKEN(SEMICOLON, DEFAULT_ASSIGN); }
\[						{ TOKEN(LBRACKET, DEFAULT_ASSIGN); }
\]						{ TOKEN(RBRACKET, DEFAULT_ASSIGN); }
\(						{ TOKEN(LPAREN, DEFAULT_ASSIGN); }
\)						{ TOKEN(LPAREN, DEFAULT_ASSIGN); }
\{						{ TOKEN(LBRACE, DEFAULT_ASSIGN); }
\}						{ TOKEN(RBRACE, DEFAULT_ASSIGN); }

int						{ TOKEN(INT, DEFAULT_ASSIGN); }
long					{ TOKEN(LONG, DEFAULT_ASSIGN); }
short					{ TOKEN(SHORT, DEFAULT_ASSIGN); }

-?[1-9][0-9]*           { TOKEN(NUMBER, NUMERIC_ASSIGN(10)); }  /* Matches all non-zero base 10 numbers */
-?0[0-7]*               { TOKEN(NUMBER, NUMERIC_ASSIGN(8)); }   /* Matches base 8 including 0 */
-?0[xX][0-9a-fA-F]+     { TOKEN(NUMBER, NUMERIC_ASSIGN(16)); }  /* Matches base 16 */
\".*\"                  { TOKEN(STRING, DEFAULT_ASSIGN); }

[_a-zA-Z][_a-zA-Z0-9]*	{ TOKEN(IDENTIFIER, ); }

%%

int yywrap()
{
	printef_d("yywrap is called\n");
	return 1;
}
