#ifndef GANCC_CONSTRUCTS_H
#define GANCC_CONSTRUCTS_H

#define NODE_T(T) struct DONOTUSE_node_#T { T val; struct DONOTUSE_node_#T *next; }

#if defined(__STDC_VERSION__) && __STDC_VERSION__ >= 199901L
typedef long long int int_const;
typedef unsigned long long int uint_const;
#else
typedef long int int_const;
typedef unsigned long int uint_const;
#endif /* C99 */

#define LITERAL_TYPE_SIGNED_INT		1
#define LITERAL_TYPE_UNSIGNED_INT	2
#define LITERAL_TYPE_STRING			3

struct literal {
	int type;
	union {
		int_const	si;
		uint_const	ui;
		const char	*s;
	} val;
};

#endif /* defined(GANCC_CONSTRUCTS_H) */
