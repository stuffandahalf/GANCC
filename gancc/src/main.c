#include <stdio.h>
#include <stdlib.h>
#ifdef HAVE_GETOPT_H
#include <getopt.h>
#else
#include <unistd.h>
#endif /* HAVE_GETOPT_LONG */
#include <libgancc/configuration.h>
#include <libgancc/context.h>
#include <libgancc/lang.h>
#include <lang_parser.h>

int yyparse(void);
int configure(int argc, char **argv);

int main(int argc, char **argv)
{
	config.ecode = EXIT_SUCCESS;
	config.lang_version = GANCC_STD_C89;
	switch (configure(argc, argv)) {
	case -1:
		config.ecode = EXIT_FAILURE;
		/* FALL THROUGH */
	case 0:
		goto early_exit;
	}

	cntxt = init_context(malloc(sizeof(struct context)));
	cntxt->fname = "<stdin>";

	printef_d("C STANDARD %ld\n", config.lang_version);
	
	yyparse();

	printef_d("%s:%zd:%zd\n", cntxt->fname, cntxt->line, cntxt->column);

early_exit:
	free_context(cntxt);
	return config.ecode;
}

int configure(int argc, char **argv)
{
	int o;
	static const char *const help_fmt = "%s [-s std]\n";
#ifdef HAVE_GETOPT_H
	static struct option long_opts[] = {
		{ "std", required_argument, NULL, 's' },
		{ "help", no_argument, NULL, 'h' },
		{ 0, 0, 0, 0 }
	};
	while ((o = getopt_long(argc, argv, "-hs:", long_opts, NULL)) >= 0) {
#else
	while ((o = getopt(argc, argv, "-hs:")) >= 0) {
#endif
		switch (o) {
		case 1:
			/* Handle file arguments */
			break;
		case 's':
			printef_d("Standard option is %s\n", optarg);
			if (streq("c89", optarg)) {
				config.lang_version = GANCC_STD_C89;
			} else if (streq("c90", optarg)) {
				config.lang_version = GANCC_STD_C90;
			} else if (streq("c95", optarg)) {
				config.lang_version = GANCC_STD_C95;
			} else if (streq("c99", optarg)) {
				config.lang_version = GANCC_STD_C99;
			} else if (streq("c11", optarg)) {
				config.lang_version = GANCC_STD_C11;
			} else if (streq("c18", optarg)) {
				config.lang_version = GANCC_STD_C18;
			} else if (streq("c2x", optarg)) {
				config.lang_version = GANCC_STD_C2x;
			} else {
				printef("Invalid C language standard\n");
				return -1;
			}
			break;
		case 'h':
			printf(help_fmt, argv[0]);
			return 0;
		case '?':
			printef(help_fmt, argv[0]);
			return -1;
		}
	}

	return 1;
}