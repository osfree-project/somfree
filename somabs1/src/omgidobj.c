#include <rhbopt.h>

#include <rhbsomex.h>

#ifndef USE_APPLE_SOM
#	include <somref.h>
#endif

#ifndef SOM_Module_omgidobj_Source
#define SOM_Module_omgidobj_Source
#endif
#define CosObjectIdentity_IdentifiableObject_Class_Source

#include <omgidobj.ih>

SOM_Scope CosObjectIdentity_ObjectIdentifier SOMLINK omgidobj_CosObjectIdentity_IdentifiableObject__get_constant_random_id(
	CosObjectIdentity_IdentifiableObject SOMSTAR somSelf,
	Environment *ev)
{
	SOM_IgnoreWarning(somSelf);
	SOM_IgnoreWarning(ev);

	return 0;
}

SOM_Scope boolean SOMLINK omgidobj_CosObjectIdentity_IdentifiableObject_is_identical(
	CosObjectIdentity_IdentifiableObject SOMSTAR somSelf,
	Environment *ev,
	/* in */ CosObjectIdentity_IdentifiableObject SOMSTAR other_object)
{
	SOM_IgnoreWarning(somSelf);
	SOM_IgnoreWarning(ev);
	SOM_IgnoreWarning(other_object);

	return 0;
}


SOM_Scope void SOMLINK omgidobj_CosObjectIdentity_IdentifiableObject_somInit(
	CosObjectIdentity_IdentifiableObject SOMSTAR somSelf)
{
#ifdef CosObjectIdentity_IdentifiableObject_parent_SOMRefObject_somInit
	CosObjectIdentity_IdentifiableObject_parent_SOMRefObject_somInit(somSelf);
#else
	CosObjectIdentity_IdentifiableObject_parent_SOMObject_somInit(somSelf);
#endif
}

SOM_Scope void SOMLINK omgidobj_CosObjectIdentity_IdentifiableObject_somUninit(
	CosObjectIdentity_IdentifiableObject SOMSTAR somSelf)
{
#ifdef CosObjectIdentity_IdentifiableObject_parent_SOMRefObject_somUninit
	CosObjectIdentity_IdentifiableObject_parent_SOMRefObject_somUninit(somSelf);
#else
	CosObjectIdentity_IdentifiableObject_parent_SOMObject_somUninit(somSelf);
#endif
}
