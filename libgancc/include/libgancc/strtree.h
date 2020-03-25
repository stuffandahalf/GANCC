#ifndef LIB_GANCC_STRTREE_H
#define LIB_GANCC_STRTREE_H

struct strtree {
	size_t count;
	struct strnode **lookup;
};

struct strnode {
    char c;
    int i;
    struct strtree *chain;
};

struct strval {
	char *s;
	int i;
};

#define STRVAL(str, val) {str, val}

struct strtree *generate_strtree(unsigned int count, struct strval *strings);
void free_strtree(struct strtree *tree);

#endif /* defined(LIB_GANCC_STRTREE_H */
