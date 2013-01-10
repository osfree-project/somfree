#ifndef SOMSTUBS_H
#define SOMSTUBS_H

#ifdef _WIN32
	#ifndef WIN32_LEAN_AND_MEAN
		#define WIN32_LEAN_AND_MEAN
	#endif
	#include <windows.h>
#endif
#include <som.h>
#include <stdio.h>

#ifdef SOM_RESOLVE_DATA
	#define SOMSTUB(x)    \
		x##ClassDataStructure * SOMLINK resolve_##x##ClassData(void) { return NULL; } \
		x##CClassDataStructure * SOMLINK resolve_##x##CClassData(void) { return NULL; } \
		SOMClass SOMSTAR SOMLINK x##NewClass(integer4 x,integer4 y) { \
				printf("SOMStub::NewClass(%s)\n",#x); \
				exit(1); \
				return NULL; }
#else
	#define SOMSTUB(x)    \
		x##ClassDataStructure x##ClassData;		\
		x##CClassDataStructure x##CClassData;	\
		SOMClass SOMSTAR SOMLINK x##NewClass(integer4 x,integer4 y) { \
				printf("SOMStub::NewClass(%s)\n",#x); \
				exit(1); \
				return NULL; }
#endif

#ifdef _WIN32
int CALLBACK DllMain(void *n,unsigned long r,void *d)
{
/*	switch (r)
	{
	case DLL_PROCESS_ATTACH:
		{
			char buf[256];
			if (GetModuleFileName(n,buf,sizeof(buf)))
			{
				MessageBox(GetDesktopWindow(),buf,__FILE__,MB_ICONERROR|MB_OK);
			}
		}
		break;
	}
	return 0;*/
	return 1;
}
#endif

#endif
