#include <stdlib.h>

#include <stdio.h>

#include <libgancc/strtree.h>

static struct strtree *init_strtree(struct strtree *root)
{
	if (root == NULL) {
		return NULL;
	}
	root->count = 0;
	root->lookup = NULL;
	return root;
}

static struct strnode *init_strnode(struct strnode *node)
{
	if (node == NULL) {
		return NULL;
	}
	node->chain = init_strtree(malloc(sizeof(struct strtree)));
	if (node->chain == NULL) {
		return NULL;
	}
	node->c = '\0';
	node->i = 0;
	return node;
}

struct strtree *generate_strtree(unsigned int count, struct strval *strings)
{
	size_t i, j;
	char *cp, c;
	struct strtree *root, *snp;
	root = init_strtree(malloc(sizeof(struct strtree)));
	if (root == NULL) {
		return NULL;
	}

	for (i = 0; i < count; i++) {
		snp = root;
		for (cp = strings[i].s; *cp != '\0'; cp++) {
			for (j = 0; j < snp->count; j++) {
				if (snp->lookup[j] != NULL && snp->lookup[j]->c == *cp) {
					snp = snp->lookup[j]->chain;
					break;
				}
			}
			snp->lookup = realloc(snp->lookup, ++snp->count);
			if (snp->lookup == NULL) {
				free_strtree(root);
				return NULL;
			}
			snp->lookup[snp->count - 1] = malloc(sizeof(struct strnode));
			if (snp->lookup[snp->count - 1] == NULL) {
				free_strtree(root);
				return NULL;
			}
			snp->lookup[snp->count - 1]->c = *cp;
			snp = snp->lookup[snp->count - 1]->chain;
		}
	}

	return root;
}

static void free_strnode(struct strnode *node)
{
	free_strtree(node->chain);
	free(node);
}

void free_strtree(struct strtree *root)
{
	size_t i;
	if (root->lookup != NULL) {
		for (i = 0; i < root->count; i++) {
			free_strnode(root->lookup[i]);
		}
		free(root->lookup);
	}
	free(root);
}