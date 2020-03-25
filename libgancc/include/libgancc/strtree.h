#ifndef LIB_GANCC_STRTREE_H
#define LIB_GANCC_STRTREE_H

struct rootstrnode {
	size_t count;
	struct strnode **lookup;
};

struct strnode {
    char c;
    int i;
    struct rootstrnode chain;
};

struct strval {
	char *s;
	int i;
};

#define STRVAL(str, val) {str, val}

struct strnode *init_strnode(struct strnode *node);
struct strnode *generate_string_lookup(unsigned int count, struct strval *strings);
void free_strnode(struct strnode *lookup);

#endif /* defined(LIB_GANCC_STRTREE_H */
