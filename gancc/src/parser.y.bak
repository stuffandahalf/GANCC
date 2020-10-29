%token LBRACE RBRACE
%token LPAREN RPAREN
%token LBRACKET RBRACKET
%token SEMICOL EQUAL COMMA
%token HASH
%token IDENTIFIER
%token INTEGER_CONST OCTAL_CONST HEX_CONST STRING_CONST
%token VOID UNSIGNED INT SHORT LONG CHAR BOOL

%{
#include <stdio.h>
#include "util.h"

int yylex(void);
void yyerror(const char *s);
%}

%%

tl_units
	: tl_unit tl_units
	| tl_unit
	| 
	;

tl_unit
	: variable_decl SEMICOL
/*	| func_decl */
	| func_defn
	;

variable_decl
	: modifier type variable_decl_list
	;

variable_decl_list
	: IDENTIFIER COMMA variable_decl_list
	| IDENTIFIER
	;

modifiers
	: modifier modifiers
	| modifier
	;

modifier
	: /*STATIC
	| EXTERN*/
	;

type
	: 
	| INT
	| UNSIGNED INT
	| SHORT
	| SHORT INT
	| UNSIGNED SHORT
	| UNSIGNED SHORT INT
	| LONG
	| LONG INT
	| UNSIGNED LONG
	| UNSIGNED LONG INT
	| LONG LONG
	| LONG LONG INT
	| UNSIGNED LONG LONG
	| UNSIGNED LONG LONG INT
	| BOOL
	;

value
	: INTEGER_CONST
	| OCTAL_CONST
	| HEX_CONST
	;

func_defn
	: modifier func_ret IDENTIFIER LPAREN func_args RPAREN block
	/*| modifier func_ret IDENTIFIER LPAREN func_arg_identifiers RPAREN kr_func_arg_defns block*/
	;

func_ret
	: VOID
	| type
	;

func_args
	: 
	| VOID
	| 
	;

block
	: LBRACE func_variable_decls /*statements*/ RBRACE
	;

func_variable_decls
	: variable_decl func_variable_decls
	| variable_decl
	;

/*statements
	: statement statements
	| statement
	;*/

%%

void
yyerror(const char *s)
{
	fprintf(stderr, "%s:%llu:%llu:" ERROR_MSG "%s\n", cntxt->fname, cntxt->line,
		cntxt->col, s);
}

