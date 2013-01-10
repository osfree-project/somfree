#include <rhbopt.h>

#ifdef _WIN32
#	include <windows.h>
#	define DLLPATHENV    "PATH"
#else
#	ifdef HAVE_DLFCN_H
#		include <dlfcn.h>
#	endif
#endif

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#ifdef _WIN32
#	define HAVE_DLOPEN
static void *dlsym(void *mod,const char *name)
{
	return GetProcAddress(mod,name);
}
static void *dlopen(const char *name,int flags)
{
	return LoadLibrary(name);
}
static void dlclose(void *pv)
{
	FreeLibrary(pv);
}
static const char *dlerror(void)
{
	return 0;
}
#else
#	include <unistd.h>
#endif

#define printf do not use

#if defined(HAVE_DLOPEN) && !defined(BUILD_STATIC)
	#include <shlb.h>
#endif

int main(int argc,char **argv)
{
	FILE *fp=NULL;
	char *outputFilename=NULL;
	int i=1;
#if defined(HAVE_DLOPEN) && !defined(BUILD_STATIC)
	void *dll=NULL;
#endif
	
	while (i < argc)
	{
		char *p=argv[i++];

		if (!strcmp(p,"-o"))
		{
			outputFilename=argv[i++];
		}
	}

	if (outputFilename)
	{
		fp=fopen(outputFilename,"w");

        if (!fp)
        {
            fprintf(stderr,"failed to create %s\n",outputFilename);
            return 1;
        }
	}

	if (!fp) fp=stdout;

#if defined(HAVE_DLOPEN) && !defined(BUILD_STATIC)
	dll=dlopen(sz_dllname_shlb,
			0
#ifdef RTLD_NOW
			|RTLD_NOW
#endif
#ifdef RTLD_GLOBAL
			|RTLD_GLOBAL
#endif
			);

	if (!dll)
	{
		char *p=getenv(DLLPATHENV);

		if (p)
		{
			int j=strlen(sz_dllname_shlb);
			fprintf(fp,"/* dlopen(%s) failed with %s, now trying path %s */\n",
						sz_dllname_shlb,dlerror(),p);

			while (*p)
			{
				int i=0;
				char buf[256];

				while (p[i] && (p[i]!=':')) i++;

				if ((i+j+2)<sizeof(buf))
				{
					memcpy(buf,p,i);
					buf[i]='/';
					memcpy(buf+i+1,sz_dllname_shlb,j+1);					

					fprintf(fp,"/* trying %s */\n",buf);

					dll=dlopen(buf,
							0
							#ifdef RTLD_GLOBAL
								|RTLD_GLOBAL
							#endif
							#ifdef RTLD_NOW
								|RTLD_NOW
							#endif
						);

					if (dll) 
					{
						fprintf(fp,"/* found %s */\n",buf);
						fprintf(fp,"#define SHLBTEST_LIBRARY_PATH  \"%s\"\n",DLLPATHENV);
						break;
					}
				}

				p+=i;

				while (*p==':') p++;
			}
		}
		else
		{
			fprintf(stderr,"getenv(%s) failed\n",DLLPATHENV);
		}
	}

	if (!dll) 
	{
		char buf[256]={0};
		const char *p=dlerror();
		if (!p) p="unknown dlerror()";
		strncpy(buf,p,sizeof(buf));
		fprintf(stderr,"/* dlopen(%s), %s */\n",sz_dllname_shlb,buf);

		if (fp && (fp!=stdout))
		{
			fclose(fp);

			if (outputFilename)
			{
				unlink(outputFilename);
			}
		}

		return 1;
	}

	if (dlsym(dll,"_SOMInitModule"))
	{
		fprintf(fp,"#define USE_DLSYM_UNDERSCORE     \"_\"\n");
	}
	else
	{
		if (dlsym(dll,"SOMInitModule"))
		{
			fprintf(fp,"/* #define USE_DLSYM_UNDERSCORE not required */\n");
		}
		else
		{
			fprintf(stderr,"#error dlopen(\"[_]SOMInitModule\") failed\n");
			dlclose(dll);

			if (fp && (fp!=stdout))
			{
				fclose(fp);

				if (outputFilename)
				{
					unlink(outputFilename);
				}
			}

			return 1;
		}
	}

	dlclose(dll);
#else
	fprintf(fp,"/* platform does not have HAVE_DLOPEN */\n");
#endif

	if (fp && (fp!=stdout))
	{
		fclose(fp);
	}

	return 0;
}
