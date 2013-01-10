#ifdef _WIN32
	#define SOMDLLEXPORT
#endif

#include <rhbopt.h>
#include <rhbsomdd.h>

#ifndef USE_THREADS

	#define SOMDDEventMgr_Class_Source

	#include <somddevm.ih>

	SOM_Scope void SOMLINK somddeman_somUninit(SOMDDEventMgr SOMSTAR somSelf)
	{
		SOMDDEventMgr_parent_SOMEEMan_somUninit(somSelf);
	}

	SOM_Scope void SOMLINK somddeman_somInit(SOMDDEventMgr SOMSTAR somSelf)
	{
		SOMDDEventMgr_parent_SOMEEMan_somInit(somSelf);
	}

	#ifdef SOMEEMan_someWait
	SOM_Scope void SOMLINK somddeman_someWait(SOMDDEventMgr SOMSTAR somSelf,Environment *ev,unsigned long delay)
	{
	#ifdef _PLATFORM_MACINTOSH_
		SOMDD_someWait(delay);
	#else
		SOMDDEventMgr_parent_SOMEEMan_someWait(somSelf,ev,delay);
	#endif
	}
	#endif

#endif
