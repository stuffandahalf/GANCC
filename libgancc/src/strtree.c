#include <stdlib.h>

#include <stdio.h>

#include <libgancc/strtree.h>

struct strnode *init_strnode(struct strnode *node)
{
	if (node == NULL) {
		return NULL;
	}

	node->lookup = NULL;
	node->count = 0;
	node->c = '\0';
	node->i = 0;
}

struct strnode *generate_string_lookup(unsigned int count, struct strval *strings)
{
	size_t i, j;
	char *cp, c;
	struct strnode *root, *snp;
	root = init_strnode(malloc(sizeof(struct strnode)));
	if (root == NULL) {
		return NULL;
	}

	for (i = 0; i < count; i++) {
		for (cp = strings[i].s; *cp != '\0'; cp++) {
			printf("%c\n", *cp);
		}
		/*snp = root;
		if (snp->lookup == NULL) {
			snp->lookup = malloc(sizeof(struct strnode *));
			if (snp->lookup == NULL) {
				free_strnode(root);
				return NULL;
			}
			snp->count = 1;
		}
		for (j = 0; j < snp->count)*/
	}
}

void free_strnode(struct strnode *node)
{
	size_t i;
	for (i = 0; i < node->count; i++) {
		free_strnode(node->lookup[i]);
	}
	free(node->lookup);
	free(node);
}