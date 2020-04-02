#ifndef LIB_GANCC_CONFIGURATION_H
#define LIB_GANCC_CONFIGURATION_H

struct configuration {
	int ecode;
	long lang_version;
};

extern struct configuration config;

#endif /* defined(LIB_GANCC_CONFIGURATION_H) */
