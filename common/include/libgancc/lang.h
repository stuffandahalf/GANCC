#ifndef LIB_GANCC_LANG_H
#define LIB_GANCC_LANG_H

#include <stdio.h>
#include <stdlib.h>

#define printef(fmt, ...) fprintf(stderr, fmt, ##__VA_ARGS__)

#ifndef NDEBUG
#define printef_d(fmt, ...) printef("[%s:%d] >> " fmt, __FILE__, __LINE__, ##__VA_ARGS__)
#else
#define printef_d(fmt, ...)
#endif

#if defined(__STDC_VERSION__) && __STDC_VERSION__ >= 199901L
typedef unsigned long long int uint_max;
typedef signed long long int int_max;
#define PARSE_UINT	strtoull
#define PARSE_INT	strtoll
#else
typedef unsigned long int uint_max;
typedef signed long int int_max;
#define PARSE_UINT	strtoul
#define PARSE_INT	strtol
#endif /* C99 */

#endif
