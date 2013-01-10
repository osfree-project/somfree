#include <rhbopt.h>

#ifdef _WIN32
	#include <windows.h>
#endif

#define SOM_Module_omgestio_Source
#define SOM_Module_somestio_Source

#include <rhbsomex.h>

#include <somir.h>
#include <somd.h>

#include <omgestio.h>
#include <somestio.h>
#include <rhbsomex.h>

#if defined(USE_APPLE_SOM)
RHBOPT_CFM_init(SOMESTRM,initBlockPtr)
{
	if (initBlockPtr)
	{
		return 0;
	}
	return -1;
}
#endif

SOMInitModule_begin(somestrm)

	SOMInitModule_new(CosStream_Streamable);
	SOMInitModule_new(CosStream_StreamIO);
	SOMInitModule_new(CosStream_StreamableFactory);
	SOMInitModule_new(somStream_StreamIO);
	SOMInitModule_new(somStream_MemoryStreamIO);

		/* this interface is rather abstract and problematic
			it requires a dependancy on SOMOS which depends on SOMD 
			which depends on SOMESTRM... */

	SOMInitModule_new(somStream_Streamable);

SOMInitModule_end

/* these would go in the DEF file 

		somStream_StreamIOClassData
		somStream_StreamIOCClassData
		somStream_StreamIONewClass
		somStream_MemoryStreamIOCClassData
		somStream_MemoryStreamIOClassData
		somStream_MemoryStreamIONewClass
		somStream_StreamableCClassData
		somStream_StreamableNewClass
		somStream_StreamableClassData

  */

#ifdef _WIN32
__declspec(dllexport) BOOL CALLBACK DllMain(HMODULE hInst,DWORD reason,LPVOID extra)
{
 	switch (reason)
    	{
        	case DLL_PROCESS_ATTACH:
/*
				{
					char buf[1024];
					GetModuleFileName(hInst,buf,sizeof(buf));
                    somPrintf("(%s)",buf);
				}
*/
				return DisableThreadLibraryCalls(hInst);
	        case DLL_PROCESS_DETACH:
            		return 1;
	}

   	return 1;
}
#endif
