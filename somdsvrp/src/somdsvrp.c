#include <rhbopt.h>

#ifdef _WIN32
	#include <windows.h>
#endif

#include <rhbsomex.h>
#include <somd.h>
#include <po.h>
#include <repostry.h>
#define SOMDServerP_Class_Source
#include <somdsvrp.ih>

SOM_Scope SOMObject SOMSTAR SOMLINK somdsvrp_somdSOMObjFromRef(SOMDServerP SOMSTAR somSelf,Environment *ev,SOMDObject SOMSTAR ref)
{
	return SOMDServerP_parent_SOMDServer_somdSOMObjFromRef(somSelf,ev,ref);
}

SOM_Scope SOMDObject SOMSTAR SOMLINK somdsvrp_somdRefFromSOMObj(SOMDServerP SOMSTAR somSelf,Environment *ev,SOMObject SOMSTAR obj)
{
	if (obj)
	{
		if (SOMObject_somIsA(obj,_SOMPPersistentObject))
		{
			_IDL_SEQUENCE_octet seq={sizeof(obj),sizeof(obj),NULL};
			SOMDObject SOMSTAR ref=NULL;
			InterfaceDef SOMSTAR iface=NULL;
			Repository SOMSTAR rep=NULL;
			char buf[256]={':',':',0};

			strncat(buf,obj->mtab->className,sizeof(buf));
			seq._buffer=(void *)&obj;

			rep=RepositoryNew();
			if (rep) iface=Repository_lookup_id(rep,ev,buf);

			ref=SOMOA_create_constant(SOMD_SOMOAObject,ev,&seq,iface,SOMD_ImplDefObject);

			if (ref && !iface)
			{
				SOMDObject__set_type_id(ref,ev,buf);
			}

			if (iface) somReleaseObjectReference(iface);
			if (rep) somReleaseObjectReference(rep);
			return ref;
		}
	}

	return SOMDServerP_parent_SOMDServer_somdRefFromSOMObj(somSelf,ev,obj);
}

SOMInitModule_begin(somdsvrp)

   SOMInitModule_new(SOMDServerP);

SOMInitModule_end

#ifdef _PLATFORM_WIN32_
__declspec(dllexport) BOOL CALLBACK DllMain(HMODULE hInst,DWORD reason,LPVOID extra)
{
 	switch (reason)
    	{
        	case DLL_PROCESS_ATTACH:
				return DisableThreadLibraryCalls(hInst);
	        case DLL_PROCESS_DETACH:
           		return 1;
	}

   	return 1;
}
#endif
