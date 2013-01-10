#include <rhbopt.h>

#ifdef _WIN32
	#define SOMDLLEXPORT
#endif

#define SOMDDREP_DynamicRepository_Class_Source

#include <rhbsomdd.h>
#include <somddrep.ih>

SOM_Scope void SOMLINK somddrep_dynrep_somUninit(
		SOMDDREP_DynamicRepository SOMSTAR somSelf)
{
	SOMDDREP_DynamicRepository_parent_PortableServer_DynamicImpl_somUninit(somSelf);
}

SOM_Scope void SOMLINK somddrep_dynrep_somInit(
		SOMDDREP_DynamicRepository SOMSTAR somSelf)
{
	SOMDDREP_DynamicRepository_parent_PortableServer_DynamicImpl_somInit(somSelf);
}

SOM_Scope char *SOMLINK somddrep_dynrep_primary_interface(
		SOMDDREP_DynamicRepository SOMSTAR somSelf,
		Environment *ev,
		_IDL_SEQUENCE_octet *key,
		SOMObject SOMSTAR poa)
{
	return NULL;
}

SOM_Scope void SOMLINK somddrep_dynrep_invoke(
		SOMDDREP_DynamicRepository SOMSTAR somSelf,
		Environment *ev,
		ServerRequest SOMSTAR req)
{
}

SOM_Scope SOMObject SOMSTAR SOMLINK somddrep_dynrep_lookup_id(
		SOMDDREP_DynamicRepository SOMSTAR somSelf,
		Environment *ev,char *id)
{
	return NULL;
}
