#include <stdlib.h>

#include <stdio.h>

#include <libgancc/strtree.h>

static struct strnode *init_strnode(struct strnode *node)
{
	if (node == NULL) {
		return NULL;
	}

	node->chain = malloc(sizeof(struct rootstrnode));
	if (node->chain == NULL) {
		return NULL;
	}
	node->chain->lookup = NULL;
	node->chain->count = 0;
	node->c = '\0';
	node->i = 0;

	return node;
}

struct rootstrnode *generate_string_lookup(unsigned int count, struct strval *strings)
{
	size_t i, j;
	char *cp, c;
	int done;
	struct rootstrnode *root, *rsnp;

	root = malloc(sizeof(struct rootstrnode));
	if (root == NULL) {
		return NULL;
	}
	root->count = 0;
	root->lookup = NULL;

	for (i = 0; i < count; i++) {
		rsnp = root;
		//for (cp = strings[i].s; *cp != '\0'; cp++) {
		done = 0;
		while (!done) {
			if (*cp == '\0') {
				done = 1;
			}
			printf("%c\n", *cp);
			for (j = 0; j < rsnp->count; j++) {
				if (rsnp->lookup[j]->c == *cp) {
					rsnp = rsnp->lookup[j]->chain;
					goto next_char;
				}
			}

			rsnp->lookup = realloc(rsnp->lookup, sizeof(struct rootstrnode) * ++rsnp->count);
			if (rsnp->lookup == NULL) {
				free_rootstrnode(root);
				return NULL;
			}
			rsnp->lookup[rsnp->count - 1] = init_strnode(malloc(sizeof(struct strnode)));
			if (rsnp->lookup[rsnp->count - 1] == NULL) {
				free_rootstrnode(root);
				return NULL;
			}
			rsnp->lookup[rsnp->count - 1]->c = *cp;
			if (done) {
				rsnp->lookup[rsnp->count - 1]->i = strings[i].i;
			}

			rsnp = rsnp->lookup[rsnp->count - 1]->chain;
next_char:
			cp++;
		}
		/*rsnp = root;
		if (rsnp->lookup == NULL) {
			rsnp->lookup = malloc(sizeof(struct strnode *));
			if (rsnp->lookup == NULL) {
				free_strnode(root);
				return NULL;
			}
			rsnp->count = 1;
		}
		for (j = 0; j < rsnp->count)*/
	}

	return root;
}

static void free_strnode(struct strnode *node)
{
	size_t i;

	free_rootstrnode(node->chain);
	free(node);
}

void free_rootstrnode(struct rootstrnode *root)
{
	size_t i;

	for (i = 0; i < root->count; i++) {
		free_strnode(root->lookup[i]);
	}
	free(root->lookup);
	free(root);
}