#include <rhbopt.h>
#include <stdio.h>

#ifdef HAVE_DLFCN_H
#	include <dlfcn.h>
#endif

int main(int argc,char **argv)
{
	int i=1;

	while (i < argc)
	{
#if defined(HAVE_DLOPEN) && defined(HAVE_DLFCN_H)
		char *p=argv[i];

		void *dl=dlopen(p,0
				#ifdef RTLD_GLOBAL
					|RTLD_GLOBAL
				#endif
				#ifdef RTLD_NOW
					|RTLD_NOW
				#endif
					);
		if (dl)
		{
			dlclose(dl);
		}
		else
		{
			fprintf(stderr,
				"%s failed with %s\n",
				p,
				dlerror());
			return 1;
		}
#else
		if (!argv[i]) return 1;
#endif

		i++;
	}

	return 0;
}
