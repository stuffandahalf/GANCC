#define _POSIX_C_SOURCE	200112L

#include <locale.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include "util.h"
#include "parser.h"

int configure(int argc, char **argv);
int push_context(const char *path);
struct context *pop_context(void);
static void free_resources(void);

static size_t fnamec;
static char **fnames;
static FILE *fptr;

int lang_standard;
struct context *cntxt = NULL;

int
main(int argc, char **argv)
{
	int i;
	
	setlocale(LC_ALL, "");
	atexit(free_resources);
	
#ifndef NDEBUG
	printf("DEBUG\n");
#else
	printf("RELEASE\n");
#endif

	if (!configure(argc, argv)) {
		return 1;
	}

	fprintf(stderr, DEBUG_MSG "C Standard is %d\n", lang_standard);
	if (fnamec > 0) {
		for (i = 0; i < fnamec; i++) {
			if(!push_context(fnames[i])) {
				return 1;
			}
			fptr = fopen(fnames[i], "r");
			if (!fptr) {
				fprintf(stderr, ERROR_MSG "Failed to open file \"%s\" for reading\n", fnames[i]);
				return 1;
			}
			
			yyin = fptr;
			yyparse();
			yyin = stdin;
			
			fclose(fptr);
			fptr = NULL;
			free(pop_context());
			// open file
			// assign file to yyin
			// run yyparse
		} 
	} else {
		if (!push_context("<stdin>")) {
			return 1;
		}
		yyparse();
	}
	return 0;
}

int
configure(int argc, char **argv)
{
	char c;
	
	fnamec = 0;
	fnames = calloc(3, sizeof(char *));
	if (!fnames) {
		fprintf(stderr, ERROR_MSG "Failed to allocate filename buffer\n");
		return 0;
	}
	lang_standard = GANCC_C_STD_ANSI;
	
	while ((c = getopt(argc, argv, ":cD:EgI:L:o:O:sUC:")) != -1) {
		switch (c) {
		case 'c':
			break;
		case 'D':
			break;
		case 'E':
			break;
		case 'g':
			break;
		case 'I':
			break;
		case 'L':
			break;
		case 'o':
			break;
		case 'O':
			break;
		case 's':
			break;
		case 'U':
			break;
		case 'C':
			if (!strcmp(optarg, "ansi")) {
				lang_standard = GANCC_C_STD_ANSI;
			} else if (!strcmp(optarg, "95")) {
				lang_standard = GANCC_C_STD_C95;
			} else if (!strcmp(optarg, "99")) {
				lang_standard = GANCC_C_STD_C99;
			} else if (!strcmp(optarg, "11")) {
				lang_standard = GANCC_C_STD_C11;
			} else if (!strcmp(optarg, "18")) {
				lang_standard = GANCC_C_STD_C18;
			} else if (!strcmp(optarg, "2x")) {
				lang_standard = GANCC_C_STD_C2x;
			} else {
				fprintf(stderr, ERROR_MSG "Unrecognized C standard %s\n",
					optarg);
				return 0;
			}
			break;
		case '?':
		default:
			fprintf(stderr, ERROR_MSG "Unreconized option: '-%c\n", optopt);
			break;
		}
	}
	
	for ( ; optind < argc; optind++) {
		if (access(argv[optind], R_OK)) {
			fprintf(stderr, ERROR_MSG
				"Unable to open file \"%s\" for reading\n", argv[optind]);
			return 0;
		} else {
			
		}
	}
	
	return 1;
}

static void
free_resources(void)
{
	int i;
	struct context *cptr;
	
	while (cntxt) {
		cptr = pop_context();
		free(cptr);
	}
	
	free(fnames);
	fnames = NULL;
}

int
push_context(const char *path)
{
	struct context *new;
	
	new = malloc(sizeof(struct context));
	if (!new) {
		fprintf(stderr, ERROR_MSG "Failed to allocate context frame\n");
		return 0;
	}
	
	new->fname = path;
	new->line = 0;
	new->col = 0;
	new->next = cntxt;
	
	cntxt = new;
	
	return 1;
}

struct context *
pop_context(void)
{
	struct context *cptr;
	
	cptr = cntxt;
	cntxt = cptr->next;
	return cptr;
}
