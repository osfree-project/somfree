#include <rhbopt.h>

#ifdef _WIN32
	#include <windows.h>
	#include <winsock.h>
	#include <process.h>
#endif

#include <time.h>

#include <rhbemani.h>
#include <somobj.h>
#include <emtypes.h>
#include <event.h>
#include <eventmsk.h>
#include <eman.h>
#include <emregdat.h>
#include <clientev.h>
#include <workprev.h>
#include <timerev.h>
#include <stdio.h>
#include <rhbeman.h>

SOMInitModule_begin(somem)

   SOMInitModule_new(SOMEEMan);
   SOMInitModule_new(SOMEEvent);
   SOMInitModule_new(SOMEClientEvent);
   SOMInitModule_new(SOMETimerEvent);
#ifdef RHBEMAN_SINKS
   SOMInitModule_new(SOMESinkEvent);
#endif
   SOMInitModule_new(SOMEWorkProcEvent);
   SOMInitModule_new(SOMEEMRegisterData);

SOMInitModule_end

#ifdef _PLATFORM_WIN32_
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


