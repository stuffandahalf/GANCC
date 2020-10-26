#include <locale.h>
#include <stdio.h>

int
main(int argc, char **argv)
{
	setlocale(LC_ALL, "");
#ifndef NDEBUG
	printf("DEBUG\n");
#else
	printf("RELEASE\n");
#endif
	return 0;
}

