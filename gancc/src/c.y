/* C89/C90 keywords */
%token AUTO BREAK CASE CHAR CONST CONTINUE DEFAULT DO DOUBLE ELSE ENUM EXTERN
%token FLOAT FOR GOTO IF INT LONG REGISTER RETURN SHORT SIGNED SIZEOF STATIC
%token STRUCT SWITCH TYPEDEF UNION UNSIGNED VOID VOLATILE WHILE

/* C99 keywords */
%token BOOL COMPLEX IMAGINARY

/* C11 keywords */
%token ALIGNAS ALIGNOF GENERIC NORETURN STATIC_ASSERT THREAD_LOCAL

%token ELLIPSIS
%token RSHIFT_ASSIGN LSHIFT_ASSIGN
%token ADD_ASSIGN SUB_ASSIGN MUL_ASSIGN DIV_ASSIGN MOD_ASSIGN
%token B_AND_ASSIGN B_XOR_ASSIGN B_OR_ASSIGN
%token RSHIFT_OP LSHIFT_OP
%token INC_OP DEC_OP
%token PTR_OP
%token L_AND_OP L_OR_OP
%token LE_OP GE_OP
%token EQ_OP NEQ_OP

/*%token POUND SEMICOLON COLON
%token LPAREN RPAREN
%token LBRACKET RBRACKET
%token LBRACE RBRACE
%token EQUALS*/

%token IDENTIFIER TYPE_NAME

%token CONSTANT STRING_LITERAL

%{
#include <stdio.h>
#include <stdlib.h>
#include <libgancc/lang.h>
#include <libgancc/context.h>
//#include <libgancc/constructs.h>

int yylex();
void yyerror(const char *str);
%}

%code requires {
	#include <libgancc/constructs.h>
}

%union {
	char *s;
	struct literal l;
}

%%
translation_unit
	: external_declaration
	| translation_unit external_declaration
	;

external_declaration
	: /*function_definition
	| */declaration
	;

 /*function_definition
	: declaration_specifiers IDENTIFIER
	;*/

declaration
	: declaration_specifiers init_declarator_list ';'
		{ printef_d("%s\n", $<s>1); }
	;

declaration_specifiers
	: storage_class_specifier
	| storage_class_specifier declaration_specifiers
	| type_specifier
	| type_specifier declaration_specifiers
	| type_qualifier
	| type_qualifier declaration_specifiers
	;

storage_class_specifier
	: /*TYPEDEF
	| */EXTERN
	| STATIC
	| AUTO
	| REGISTER
	;

type_specifier
	: VOID
	| CHAR
	| SHORT
	| INT
	| LONG
	| FLOAT
	| DOUBLE
	| SIGNED
	| UNSIGNED
	/*| struct_or_union_specifier*/
	/*| enum_specifier*/
	| TYPE_NAME
	;

type_qualifier
	: CONST
	| VOLATILE
	;
	
init_declarator_list
	: init_declarator
	| init_declarator_list ',' init_declarator
	;
	
init_declarator
	: declarator
	/*| declarator '=' initializer*/
	;

declarator
	: pointer direct_declarator
    | direct_declarator
    ;

pointer
	: '*'
	| '*' type_qualifier_list
	| '*' pointer
	| '*' type_qualifier_list pointer
	;

type_qualifier_list
	: type_qualifier
	| type_qualifier_list type_qualifier
	;

direct_declarator
	: IDENTIFIER
	/*| '(' declarator ')'*/
	/*| direct_declarator '[' constant_expression ']'*/
	/*| direct_declarator '[' ']'*/
	/*| direct_declarator '(' parameter_type_list ')'*/
	/*| direct_declarator '(' identifier_list ')'*/
	/*| direct_declarator '(' ')'*/
	;


parameter_type_list
	: parameter_list
	| parameter_list ',' ELLIPSIS
	;


parameter_list
	: parameter_declaration
	| parameter_list ',' parameter_declaration
	;
	

parameter_declaration
	: declaration_specifiers declarator
	| declaration_specifiers abstract_declarator
	| declaration_specifiers
	;
	

abstract_declarator
	: pointer
	| direct_abstract_declarator
	| pointer direct_abstract_declarator
	;


direct_abstract_declarator
	: '(' abstract_declarator ')'
	| '[' ']'
	/*| '[' constant_expression ']'*/
	| direct_abstract_declarator '[' ']'
	/*| direct_abstract_declarator '[' constant_expression ']'*/
	| '(' ')'
	| '(' parameter_type_list ')'
	| direct_abstract_declarator '(' ')'
	| direct_abstract_declarator '(' parameter_type_list ')'
	;

 /*
initializer
	: assignment_expression
	| '{' initializer_list '}'
	| '{' initializer_list ',' '}'
	; */

 /*
assignment_expression */
	/*: conditional_expression*/
	/*| unary_expression assignment_operator assignment expression
	; */

 /*
unary_expression
	:*/ /* postfix_expression
	| INC_OP unary_expression
	| DEC_OP unary_expression
	| unary_operator cast_expression
	| SIZEOF unary_expression */
	/*| SIZEOF '(' type_name ')'
	;*/

%%

void yyerror(const char *str)
{
	//fprintf(stderr, "Error: %s on line number %d\n", str, -1);
	printef("%s:%zd:%zd: Error: %s\n", cntxt->fname, cntxt->line, cntxt->column, str);
	exit(1);
}
