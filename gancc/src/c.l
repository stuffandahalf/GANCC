#include <stdio.h>

#ifndef NDEBUG
#define printdf(fmt, ...) fprintf(stderr, fmt, ##__VA_ARGS__)
#else
#define printdf(fmt, ...)
#endif

#define TOKEN(tok) \
	printdf("%s\n", #tok); \
	return tok

%%

int		{ TOKEN(INT); }
long	{ TOKEN(LONG); }
short	{ TOKEN(SHORT); }


%%
