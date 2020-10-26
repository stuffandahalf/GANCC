#include "parser.h"

%%

"{"		{ return LBRACE; }
"}"		{ return RBRACE; }
"("		{ return LPAREN; }
")"		{ return RPAREN; }
"["		{ return LBRACKET; }
"]"		{ return RBRACKET; }
";"		{ return SEMICOL; }
"="		{ return EQUAL; }

[1-9][0-9]*	{ return INTEGER_CONST; }
0[0-7]+		{ return OCTAL_CONST; }
0x[0-9]+	{ return HEX_CONST; }
[a-zA-Z_][a-zA-Z0-9_]*	{ return IDENTIFIER; }

%%
