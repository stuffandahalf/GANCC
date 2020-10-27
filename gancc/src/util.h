#ifndef GANCC_UTIL_H
#define GANCC_UTIL_H	1

#define ERROR_MSG	"ERROR: "
#define WARNING_MSG	"WARNING: "
#define DEBUG_MSG	"DEBUG: "

#define GANCC_C_STD_ANSI	89
#define GANCC_C_STD_C95		95
#define GANCC_C_STD_C99		99
#define GANCC_C_STD_C11		11
#define GANCC_C_STD_C18		18
#define GANCC_C_STD_C2x		20

struct context {
	const char *fname;
	unsigned long long int line;
	unsigned long long int col;
	struct context *next;
};

extern int lang_standard;
extern struct context *cntxt;

#endif /* GANCC_UTIL_H */

