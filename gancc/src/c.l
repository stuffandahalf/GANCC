%{
#include <stdio.h>
#include <stdlib.h>
#include <libgancc/lang.h>
#include <libgancc/configuration.h>
#include <libgancc/context.h>
#include <lang_parser.h>

#define DEBUG_LEX   1

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

#if defined(DEBUG_LEX) && DEBUG_LEX
#define AB_TOKEN(test, a_tok, a_assign, b_tok, b_assign) \
    count(); \
    if ((test)) { \
        printef_d("%s = %s\n", #a_tok, yytext); \
        a_assign; \
        return a_tok; \
    } else { \
        printef_d("%s = %s\n", #b_tok, yytext); \
        b_assign; \
        return b_tok; \
    }
#else
#define AB_TOKEN(test, a_tok, a_assign, b_tok, b_assign) \
    count(); \
    if (test) { \
        a_assign; \
        return a_tok; \
    } else { \
        b_assign; \
        return b_tok; \
    }
#endif /* defined(DEBUG_LEX) && DEBUG_LEX */

#define STD_TOKEN(c_std, main_tok, main_assign, alt_tok, alt_assign) \
    AB_TOKEN(config.version >= (c_std), main_tok, main_assign, alt_tok, alt_assign)

#define TOKEN(tok, assign) \
    STD_TOKEN(0, tok, assign, 0, DEFAULT_ASSIGN)

int yywrap(void);
void count(void);

%}

D                       [0-9]
L                       [a-zA-Z_]
H                       [0-9a-fA-F]

/* numeric suffixes */
E                       [eE][+-]?{D}+
FS                      [fFlL]
IS                      [uUlL]*

%%

"auto"                  { TOKEN(AUTO, DEFAULT_ASSIGN); }
"break"                 { TOKEN(BREAK, DEFAULT_ASSIGN); }
"case"                  { TOKEN(CASE, DEFAULT_ASSIGN); }
"char"                  { TOKEN(CHAR, DEFAULT_ASSIGN); }
"const"                 { TOKEN(CONST, DEFAULT_ASSIGN); }
"continue"              { TOKEN(CONTINUE, DEFAULT_ASSIGN); }
"default"               { TOKEN(DEFAULT, DEFAULT_ASSIGN); }
"do"                    { TOKEN(DO, DEFAULT_ASSIGN); }
"double"                { TOKEN(DOUBLE, DEFAULT_ASSIGN); }
"else"                  { TOKEN(ELSE, DEFAULT_ASSIGN); }
"enum"                  { TOKEN(ENUM, DEFAULT_ASSIGN); }
"extern"                { TOKEN(EXTERN, DEFAULT_ASSIGN); }
"float"                 { TOKEN(FLOAT, DEFAULT_ASSIGN); }
"for"                   { TOKEN(FOR, DEFAULT_ASSIGN); }
"goto"                  { TOKEN(GOTO, DEFAULT_ASSIGN); }
"if"                    { TOKEN(IF, DEFAULT_ASSIGN); }
"int"					{ TOKEN(INT, DEFAULT_ASSIGN); }
"long"					{ TOKEN(LONG, DEFAULT_ASSIGN); }
"register"              { TOKEN(REGISTER, DEFAULT_ASSIGN); }
"return"                { TOKEN(RETURN, DEFAULT_ASSIGN); }
"short"					{ TOKEN(SHORT, DEFAULT_ASSIGN); }
"signed"                { TOKEN(SIGNED, DEFAULT_ASSIGN); }
"sizeof"                { TOKEN(SIZEOF, DEFAULT_ASSIGN); }
"static"                { TOKEN(STATIC, DEFAULT_ASSIGN); }
"struct"                { TOKEN(STRUCT, DEFAULT_ASSIGN); }
"switch"                { TOKEN(SWITCH, DEFAULT_ASSIGN); }
"typedef"               { TOKEN(TYPEDEF, DEFAULT_ASSIGN); }
"union"                 { TOKEN(UNION, DEFAULT_ASSIGN); }
"unsigned"              { TOKEN(UNSIGNED, DEFAULT_ASSIGN); }
"void"                  { TOKEN(VOID, DEFAULT_ASSIGN); }
"volatile"              { TOKEN(VOLATILE, DEFAULT_ASSIGN); }
"while"                 { TOKEN(WHILE, DEFAULT_ASSIGN); }
"_Bool"                 { STD_TOKEN(199901L, BOOL, DEFAULT_ASSIGN, IDENTIFIER, DEFAULT_ASSIGN); }

#                       { TOKEN(POUND, DEFAULT_ASSIGN); }
=                       { TOKEN(EQUALS, DEFAULT_ASSIGN); }
;                       { TOKEN(SEMICOLON, DEFAULT_ASSIGN); }
\(						{ TOKEN(LPAREN, DEFAULT_ASSIGN); }
\)						{ TOKEN(LPAREN, DEFAULT_ASSIGN); }
("["|"<:")				{ TOKEN(LBRACKET, DEFAULT_ASSIGN); }
("]"|":>")				{ TOKEN(RBRACKET, DEFAULT_ASSIGN); }
("{"|"<%")				{ TOKEN(LBRACE, DEFAULT_ASSIGN); }
("}"|"%>")				{ TOKEN(RBRACE, DEFAULT_ASSIGN); }

-?[1-9][0-9]*           { TOKEN(NUMBER, NUMERIC_ASSIGN(10)); }  /* Matches all non-zero base 10 numbers */
-?0[0-7]*               { TOKEN(NUMBER, NUMERIC_ASSIGN(8)); }   /* Matches base 8 including 0 */
-?0[xX][0-9a-fA-F]+     { TOKEN(NUMBER, NUMERIC_ASSIGN(16)); }  /* Matches base 16 */
\".*\"                  { TOKEN(STRING, DEFAULT_ASSIGN); }

[_a-zA-Z][_a-zA-Z0-9]*	{ TOKEN(IDENTIFIER, ); }

[ \t\n\v\f]             { count(); }
.                       { /* ignore bad chars */ }

%%

int yywrap(void)
{
	printef_d("yywrap is called\n");
	return 1;
}

void count(void)
{
    char *c;
    for (c = yytext; *c != '\0'; c++) {
        if (*c == '\n') {
            cntxt->line++;
            cntxt->column = 1;
        } else {
            cntxt->column++;
        }
    }
}