#ifndef LIB_GANCC_STRTREE_H
#define LIB_GANCC_STRTREE_H

struct rootstrnode {
	size_t count;
	struct strnode **lookup;
};

struct strnode {
    char c;
    int i;
    struct rootstrnode *chain;
};

struct strval {
	char *s;
	int i;
};

#define STRVAL(str, val) {str, val}

struct rootstrnode *generate_string_lookup(unsigned int count, struct strval *strings);
void free_rootstrnode(struct rootstrnode *lookup);

#endif /* defined(LIB_GANCC_STRTREE_H */
