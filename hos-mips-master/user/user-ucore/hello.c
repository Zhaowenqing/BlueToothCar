#include <ulib.h>
#include <stdio.h>
#include <dir.h>

#define printf(...)                     fprintf(1, __VA_ARGS__)
#define BUFSIZE                         4096

int main(int argc, char **argv)
{
	hello();
	return 0;
}
