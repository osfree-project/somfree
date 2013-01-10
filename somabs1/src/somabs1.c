#include <rhbopt.h>

#ifdef _WIN32
#	include <windows.h>
#endif

#include <rhbsomex.h>

#ifndef USE_APPLE_SOM
#	include <somref.h>
#endif

#define SOM_Module_omgidobj_Source
#include <omgidobj.h>

SOMInitModule_begin(somabs1)

   SOMInitModule_new(CosObjectIdentity_IdentifiableObject);

SOMInitModule_end

#if defined(_PLATFORM_MACINTOSH_) && GENERATINGCFM
RHBOPT_CFM_init(SOMABS1,initBlockPtr)
{
	if (initBlockPtr)
	{
		return 0;
	}

	return -1;
}
#endif

#ifdef _WIN32
__declspec(dllexport) BOOL CALLBACK DllMain(HMODULE hInst,DWORD reason,LPVOID extra)
{
 	switch (reason)
    	{
        	case DLL_PROCESS_ATTACH:
/*				{
					char buf[1024];
					GetModuleFileName(hInst,buf,sizeof(buf));
                    somPrintf("(%s)",buf);
				}*/
				return DisableThreadLibraryCalls(hInst);
	        case DLL_PROCESS_DETACH:
           		return 1;
	}

   	return 1;
}
#endif
