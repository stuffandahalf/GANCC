#ifndef LIB_GANCC_LANG_H
#define LIB_GANCC_LANG_H

#include <stdio.h>

#define printef(fmt, ...) fprintf(stderr, fmt, ##__VA_ARGS__)

#ifndef NDEBUG
#define printef_d(fmt, ...) printef("[%s:%d] >> " fmt, __FILE__, __LINE__, ##__VA_ARGS__)
#else
#define printef_d(fmt, ...)
#endif

#endif
