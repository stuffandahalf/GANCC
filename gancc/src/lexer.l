%{
#include "parser.h"
#include "util.h"
//#include "y.tab.h"

int yywrap(void);
%}

%%

"#|%:"		{ return HASH; }
"{|<%"		{ return LBRACE; }
"}|%>"		{ return RBRACE; }
"("			{ return LPAREN; }
")"			{ return RPAREN; }
"[|<:"		{ return LBRACKET; }
"]|:>"		{ return RBRACKET; }
";"			{ return SEMICOL; }
"="			{ return EQUAL; }
","			{ return COMMA; }

"void"		{ return VOID; }
"unsigned"	{ return UNSIGNED; }
"int"		{ return INT; }
"short"		{ return SHORT; }
"long"		{ return LONG; }
"char"		{ return CHAR; }
"_Bool"		{
	if (lang_standard >= GANCC_C_STD_C99)
		return BOOL;
	else
		return IDENTIFIER;
}

\".*\"		{ return STRING_CONST; }
[1-9][0-9]*	{ return INTEGER_CONST; }
0[0-7]+		{ return OCTAL_CONST; }
0x[0-9]+	{ return HEX_CONST; }
[a-zA-Z_][a-zA-Z0-9_]*	{ return IDENTIFIER; }

"//.*\n"	{ cntxt->line++; }
"\n"		{ cntxt->line++; }

%%

int
yywrap(void)
{
	return 1;
}

