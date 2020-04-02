%{
#include <stdio.h>
#include <stdlib.h>
#include <libgancc/lang.h>
#include <libgancc/configuration.h>
#include <libgancc/context.h>
#include <lang_parser.h>

#define DEBUG_LEX   1

#define DEFAULT_ASSIGN  yylval.s = yytext
#define INT_ASSIGN(base) { \
	if (yytext[0] == '-') { \
		yylval.l.type = LITERAL_TYPE_SIGNED_INT; \
		yylval.l.val.si = PARSE_INT(yytext, NULL, base); \
	} else { \
		yylval.l.type = LITERAL_TYPE_UNSIGNED_INT; \
		yylval.l.val.ui = PARSE_UINT(yytext, NULL, base); \
	} \
}
#define CHAR_ASSIGN { \
	/* */ \
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
	AB_TOKEN(config.lang_version >= (c_std), main_tok, main_assign, alt_tok, alt_assign)

#define TOKEN(tok, assign) \
	STD_TOKEN(GANCC_STD_C89, tok, assign, 0, DEFAULT_ASSIGN)

int yywrap(void);
void count(void);
_Bool is_typename(const char *identifier);

%}

L						[a-zA-Z_]
D						[0-9]
O						[0-7]
H						[0-9a-fA-F]

/* numeric suffixes */
E						[eE][+-]?{D}+
FS						[fFlL]
IS						[uUlL]*

%%

"auto"					{ TOKEN(AUTO, DEFAULT_ASSIGN); }
"break"					{ TOKEN(BREAK, DEFAULT_ASSIGN); }
"case"					{ TOKEN(CASE, DEFAULT_ASSIGN); }
"char"					{ TOKEN(CHAR, DEFAULT_ASSIGN); }
"const"					{ TOKEN(CONST, DEFAULT_ASSIGN); }
"continue"				{ TOKEN(CONTINUE, DEFAULT_ASSIGN); }
"default"				{ TOKEN(DEFAULT, DEFAULT_ASSIGN); }
"do"					{ TOKEN(DO, DEFAULT_ASSIGN); }
"double"				{ TOKEN(DOUBLE, DEFAULT_ASSIGN); }
"else"					{ TOKEN(ELSE, DEFAULT_ASSIGN); }
"enum"					{ TOKEN(ENUM, DEFAULT_ASSIGN); }
"extern"				{ TOKEN(EXTERN, DEFAULT_ASSIGN); }
"float"					{ TOKEN(FLOAT, DEFAULT_ASSIGN); }
"for"					{ TOKEN(FOR, DEFAULT_ASSIGN); }
"goto"					{ TOKEN(GOTO, DEFAULT_ASSIGN); }
"if"					{ TOKEN(IF, DEFAULT_ASSIGN); }
"int"					{ TOKEN(INT, DEFAULT_ASSIGN); }
"long"					{ TOKEN(LONG, DEFAULT_ASSIGN); }
"register"				{ TOKEN(REGISTER, DEFAULT_ASSIGN); }
"return"				{ TOKEN(RETURN, DEFAULT_ASSIGN); }
"short"					{ TOKEN(SHORT, DEFAULT_ASSIGN); }
"signed"				{ TOKEN(SIGNED, DEFAULT_ASSIGN); }
"sizeof"				{ TOKEN(SIZEOF, DEFAULT_ASSIGN); }
"static"				{ TOKEN(STATIC, DEFAULT_ASSIGN); }
"struct"				{ TOKEN(STRUCT, DEFAULT_ASSIGN); }
"switch"				{ TOKEN(SWITCH, DEFAULT_ASSIGN); }
"typedef"				{ TOKEN(TYPEDEF, DEFAULT_ASSIGN); }
"union"					{ TOKEN(UNION, DEFAULT_ASSIGN); }
"unsigned"				{ TOKEN(UNSIGNED, DEFAULT_ASSIGN); }
"void"					{ TOKEN(VOID, DEFAULT_ASSIGN); }
"volatile"				{ TOKEN(VOLATILE, DEFAULT_ASSIGN); }
"while"					{ TOKEN(WHILE, DEFAULT_ASSIGN); }

 /* C99 keywords */
"_Bool"					{ STD_TOKEN(GANCC_STD_C99, BOOL, DEFAULT_ASSIGN, IDENTIFIER, DEFAULT_ASSIGN); }
"_Complex"				{ STD_TOKEN(GANCC_STD_C99, COMPLEX, DEFAULT_ASSIGN, IDENTIFIER, DEFAULT_ASSIGN); }
"_Imaginary"			{ STD_TOKEN(GANCC_STD_C99, COMPLEX, DEFAULT_ASSIGN, IDENTIFIER, DEFAULT_ASSIGN); }

 /* C11 keywords */
"_Alignas"				{ STD_TOKEN(GANCC_STD_C11, ALIGNAS, DEFAULT_ASSIGN, IDENTIFIER, DEFAULT_ASSIGN); }
"_Alignof"				{ STD_TOKEN(GANCC_STD_C11, ALIGNOF, DEFAULT_ASSIGN, IDENTIFIER, DEFAULT_ASSIGN); }
"_Generic"				{ STD_TOKEN(GANCC_STD_C11, GENERIC, DEFAULT_ASSIGN, IDENTIFIER, DEFAULT_ASSIGN); }
"_Noreturn"				{ STD_TOKEN(GANCC_STD_C11, NORETURN, DEFAULT_ASSIGN, IDENTIFIER, DEFAULT_ASSIGN); }
"_Static_assert"		{ STD_TOKEN(GANCC_STD_C11, STATIC_ASSERT, DEFAULT_ASSIGN, IDENTIFIER, DEFAULT_ASSIGN); }
"_Thread_local"			{ STD_TOKEN(GANCC_STD_C11, THREAD_LOCAL, DEFAULT_ASSIGN, IDENTIFIER, DEFAULT_ASSIGN); }

"..."					{ TOKEN(ELLIPSIS, DEFAULT_ASSIGN); }
">>="					{ TOKEN(RSHIFT_ASSIGN, DEFAULT_ASSIGN); }
"<<="					{ TOKEN(LSHIFT_ASSIGN, DEFAULT_ASSIGN); }
"+="					{ TOKEN(ADD_ASSIGN, DEFAULT_ASSIGN); }
"-="					{ TOKEN(SUB_ASSIGN, DEFAULT_ASSIGN); }
"*="					{ TOKEN(MUL_ASSIGN, DEFAULT_ASSIGN); }
"/="					{ TOKEN(DIV_ASSIGN, DEFAULT_ASSIGN); }
"%="					{ TOKEN(MOD_ASSIGN, DEFAULT_ASSIGN); }
"&="					{ TOKEN(B_AND_ASSIGN, DEFAULT_ASSIGN); }
"^="					{ TOKEN(B_XOR_ASSIGN, DEFAULT_ASSIGN); }
"|="					{ TOKEN(B_OR_ASSIGN, DEFAULT_ASSIGN); }
">>"					{ TOKEN(RSHIFT_OP, DEFAULT_ASSIGN); }
"<<"					{ TOKEN(LSHIFT_OP, DEFAULT_ASSIGN); }
"++"					{ TOKEN(INC_OP, DEFAULT_ASSIGN); }
"--"					{ TOKEN(DEC_OP, DEFAULT_ASSIGN); }
"->"					{ TOKEN(PTR_OP, DEFAULT_ASSIGN); }
"&&"					{ TOKEN(L_AND_OP, DEFAULT_ASSIGN); }
"||"					{ TOKEN(L_OR_OP, DEFAULT_ASSIGN); }
"<="					{ TOKEN(LE_OP, DEFAULT_ASSIGN); }
">="					{ TOKEN(GE_OP, DEFAULT_ASSIGN); }
"=="					{ TOKEN(EQ_OP, DEFAULT_ASSIGN); }
"!="					{ TOKEN(NEQ_OP, DEFAULT_ASSIGN); }
";"						{ TOKEN(';', DEFAULT_ASSIGN); }
("{"|"<%")				{ TOKEN('{', DEFAULT_ASSIGN); }
("}"|"%>")				{ TOKEN('}', DEFAULT_ASSIGN); }
","						{ TOKEN(',', DEFAULT_ASSIGN); }
":"						{ TOKEN(':', DEFAULT_ASSIGN); }
"="						{ TOKEN('=', DEFAULT_ASSIGN); }
"("						{ TOKEN('(', DEFAULT_ASSIGN); }
")"						{ TOKEN(')', DEFAULT_ASSIGN); }
("["|"<:")				{ TOKEN('[', DEFAULT_ASSIGN); }
("]"|":>")				{ TOKEN(']', DEFAULT_ASSIGN); }
"."						{ TOKEN('.', DEFAULT_ASSIGN); }
"&"						{ TOKEN('&', DEFAULT_ASSIGN); }
"!"						{ TOKEN('!', DEFAULT_ASSIGN); }
"~"						{ TOKEN('~', DEFAULT_ASSIGN); }
"-"						{ TOKEN('-', DEFAULT_ASSIGN); }
"+"						{ TOKEN('+', DEFAULT_ASSIGN); }
"*"						{ TOKEN('*', DEFAULT_ASSIGN); }
"/"						{ TOKEN('/', DEFAULT_ASSIGN); }
"%"						{ TOKEN('%', DEFAULT_ASSIGN); }
"<"						{ TOKEN('<', DEFAULT_ASSIGN); }
">"						{ TOKEN('>', DEFAULT_ASSIGN); }
"^"						{ TOKEN('^', DEFAULT_ASSIGN); }
"|"						{ TOKEN('|', DEFAULT_ASSIGN); }
"?"						{ TOKEN('?', DEFAULT_ASSIGN); }
"#"						{ TOKEN('#', DEFAULT_ASSIGN); }

-?[1-9]{D}*				{ TOKEN(CONSTANT, INT_ASSIGN(10)); }    /* Matches all base 10 numbers */
-?0{O}*					{ TOKEN(CONSTANT, INT_ASSIGN(8)); }     /* Matches base 8 numbers */
-?0[xX]{H}+				{ TOKEN(CONSTANT, INT_ASSIGN(16)); }    /* Matches base 16 numbers */
 /* Need to add floating point numbers */
L?'(\\.|[^\\'])+'		{ TOKEN(CONSTANT, CHAR_ASSIGN); }       /* Character constant */
L?\".*\"				{ TOKEN(STRING_LITERAL, DEFAULT_ASSIGN); }

{L}({L}|{D})*			{ AB_TOKEN(is_typename(yytext), TYPE_NAME, DEFAULT_ASSIGN, IDENTIFIER, DEFAULT_ASSIGN); }

[ \t\n\v\f]				{ count(); }
.						{ /* ignore bad chars */ }

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

_Bool is_typename(const char *identifier)
{
	return 0;
}
