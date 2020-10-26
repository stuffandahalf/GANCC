#ifndef GANCC_TOKEN_H
#define GANCC_TOKEN_H	1

#define TOKEN_TYPE_TL_UNIT	0
#define TOKEN_TYPE_VARIABLE	1
#define TOKEN_TYPE_FUNCTION	2

struct generic_prod {
	int type;
};

struct variable_decl_tok {
	int type;
	
	int var_type;
};

struct int_prod {
	int type;
	
	long long int value;
};

struct uint_prod {
	int type;
	
	unsigned long long int value;
};

struct float_prod {
	int type;
	
	long double value;
};

struct assignment_prod {
	int type;
	
	union {
		struct int_prod *intgr;
		struct uint_prod *uintgr;
		struct float_prod *flt;
	} value;
};

#endif
