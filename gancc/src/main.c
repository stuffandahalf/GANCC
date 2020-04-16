#include <stdio.h>
#include <stdlib.h>
#if defined(HAVE_GETOPT_H)
#include <getopt.h>
#define USE_GETOPT_LONG
#elif defined(HAVE_UNISTD_H)
#include <unistd.h>
#else
#error No standard argument parser available
#endif /* HAVE_GETOPT_LONG */
#include <libgancc/context.h>
#include <libgancc/lang.h>
#include <gancc/parser.h>
#include <gancc/config.h>

int configure(int argc, char **argv);

struct configuration g_config;

int main(int argc, char **argv)
{
#ifdef USE_GETOPT_LONG
	printef_d("GETOPT_LONG\n");
#else
	printef_d("GETOPT\n");
#endif

	g_config.ecode = EXIT_SUCCESS;
	g_config.lang_version = GANCC_STD_C89;
	switch (configure(argc, argv)) {
	case -1:
		g_config.ecode = EXIT_FAILURE;
		/* FALL THROUGH */
	case 0:
		goto early_exit;
	}

	cntxt = init_context(malloc(sizeof(struct context)));
	cntxt->fname = "<stdin>";

	printef_d("C STANDARD %ld\n", g_config.lang_version);
	
	yyparse();

	printef_d("%s:%zd:%zd\n", cntxt->fname, cntxt->line, cntxt->column);

early_exit:
	free_context(cntxt);
	return g_config.ecode;
}

int configure(int argc, char **argv)
{
	int o;
	static const char *const help_fmt = "%s [-s std]\n";
#ifdef USE_GETOPT_LONG
	static struct option long_opts[] = {
		{ "std", required_argument, NULL, 's' },
		{ "help", no_argument, NULL, 'h' },
		{ 0, 0, 0, 0 }
	};
	while ((o = getopt_long(argc, argv, "-hs:", long_opts, NULL)) != -1) {
#else
	while ((o = getopt(argc, argv, "-hs:")) != -1) {
#endif
		switch (o) {
		case 1:
			/* Handle file arguments */
			break;
		case 's':
			printef_d("Standard option is %s\n", optarg);
			if (streq("c89", optarg) || streq("ansi", optarg)) {
				g_config.lang_version = GANCC_STD_C89;
			} else if (streq("c90", optarg)) {
				g_config.lang_version = GANCC_STD_C90;
			} else if (streq("c95", optarg)) {
				g_config.lang_version = GANCC_STD_C95;
			} else if (streq("c99", optarg)) {
				g_config.lang_version = GANCC_STD_C99;
			} else if (streq("c11", optarg)) {
				g_config.lang_version = GANCC_STD_C11;
			} else if (streq("c18", optarg)) {
				g_config.lang_version = GANCC_STD_C18;
			} else if (streq("c2x", optarg)) {
				g_config.lang_version = GANCC_STD_C2x;
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