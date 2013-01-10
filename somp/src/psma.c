#include <rhbopt.h>
/* code generater for psma.idl */

#define SOMPPersistentStorageMgr_Class_Source
#include <rhbsomp.h>
#include <snglicls.h>
#include <psma.ih>
#include <rhbsomex.h>

/* overridden methods for ::SOMPPersistentStorageMgr */
/* overridden method ::SOMObject::somInit */
SOM_Scope void SOMLINK psma_somInit(
	SOMPPersistentStorageMgr SOMSTAR somSelf)
{
	RHBOPT_unused(somSelf)
#ifdef SOMPPersistentStorageMgr_parent_SOMObject_somInit
	SOMPPersistentStorageMgr_parent_SOMObject_somInit(somSelf);
#else
	SOMPPersistentStorageMgr_parent_SOMRefObject_somInit(somSelf);
#endif
}
/* overridden method ::SOMObject::somUninit */
SOM_Scope void SOMLINK psma_somUninit(
	SOMPPersistentStorageMgr SOMSTAR somSelf)
{
	Environment ev;
	SOM_InitEnvironment(&ev);
	SOMMSingleInstance_sommSingleInstanceFreed(somSelf->mtab->classObject,&ev,somSelf);
#ifdef SOMPPersistentStorageMgr_parent_SOMObject_somUninit
	SOMPPersistentStorageMgr_parent_SOMObject_somUninit(somSelf);
#else
	SOMPPersistentStorageMgr_parent_SOMRefObject_somUninit(somSelf);
#endif
	SOM_UninitEnvironment(&ev);
}
/* introduced methods for ::SOMPPersistentStorageMgr */
/* introduced method ::SOMPPersistentStorageMgr::sompStoreObject */
SOM_Scope void SOMLINK psma_sompStoreObject(
	SOMPPersistentStorageMgr SOMSTAR somSelf,
	Environment *ev,
	/* in */ SOMPPersistentObject SOMSTAR thisObject)
{
	RHBOPT_unused(somSelf)
	RHBOPT_unused(ev)
	RHBOPT_unused(thisObject)
}
/* overridden method ::SOMPPersistentStorageMgr::sompRestoreObject */
SOM_Scope SOMObject SOMSTAR SOMLINK psma_sompRestoreObject(
	SOMPPersistentStorageMgr SOMSTAR somSelf,
	Environment *ev,
	/* in */ SOMPPersistentId SOMSTAR objectID)
{
	SOMObject SOMSTAR __result=NULL;
	RHBOPT_unused(somSelf)
	RHBOPT_unused(ev)
	RHBOPT_unused(objectID)
	return __result;
}
/* overridden method ::SOMPPersistentStorageMgr::sompStoreObjectWithoutChildren */
SOM_Scope void SOMLINK psma_sompStoreObjectWithoutChildren(
	SOMPPersistentStorageMgr SOMSTAR somSelf,
	Environment *ev,
	/* in */ SOMPPersistentObject SOMSTAR thisObject)
{
	RHBOPT_unused(somSelf)
	RHBOPT_unused(ev)
	RHBOPT_unused(thisObject)
}
/* overridden method ::SOMPPersistentStorageMgr::sompRestoreObjectWithoutChildren */
SOM_Scope SOMObject SOMSTAR SOMLINK psma_sompRestoreObjectWithoutChildren(
	SOMPPersistentStorageMgr SOMSTAR somSelf,
	Environment *ev,
	/* in */ SOMPPersistentId SOMSTAR objectID)
{
	SOMObject SOMSTAR __result=NULL;
	RHBOPT_unused(somSelf)
	RHBOPT_unused(ev)
	RHBOPT_unused(objectID)
	return __result;
}
/* overridden method ::SOMPPersistentStorageMgr::sompDeleteObject */
SOM_Scope void SOMLINK psma_sompDeleteObject(
	SOMPPersistentStorageMgr SOMSTAR somSelf,
	Environment *ev,
	/* in */ SOMPPersistentId SOMSTAR objectID)
{
	RHBOPT_unused(somSelf)
	RHBOPT_unused(ev)
	RHBOPT_unused(objectID)
}
/* overridden method ::SOMPPersistentStorageMgr::sompObjectExists */
SOM_Scope boolean SOMLINK psma_sompObjectExists(
	SOMPPersistentStorageMgr SOMSTAR somSelf,
	Environment *ev,
	/* in */ SOMPPersistentId SOMSTAR objectID)
{
	boolean __result=0;
	RHBOPT_unused(somSelf)
	RHBOPT_unused(ev)
	RHBOPT_unused(objectID)
	return __result;
}
/* overridden method ::SOMPPersistentStorageMgr::sompAddObjectToWriteSet */
SOM_Scope void SOMLINK psma_sompAddObjectToWriteSet(
	SOMPPersistentStorageMgr SOMSTAR somSelf,
	Environment *ev,
	/* in */ SOMPPersistentObject SOMSTAR thisObject)
{
	RHBOPT_unused(somSelf)
	RHBOPT_unused(ev)
	RHBOPT_unused(thisObject)
}
/* overridden method ::SOMPPersistentStorageMgr::sompAddIdToReadSet */
SOM_Scope void SOMLINK psma_sompAddIdToReadSet(
	SOMPPersistentStorageMgr SOMSTAR somSelf,
	Environment *ev,
	/* in */ SOMPPersistentId SOMSTAR objectID)
{
	RHBOPT_unused(somSelf)
	RHBOPT_unused(ev)
	RHBOPT_unused(objectID)
}
/* overridden method ::SOMPPersistentStorageMgr::sompRestoreObjectFromIdString */
SOM_Scope SOMObject SOMSTAR SOMLINK psma_sompRestoreObjectFromIdString(
	SOMPPersistentStorageMgr SOMSTAR somSelf,
	Environment *ev,
	/* in */ corbastring idString)
{
	SOMObject SOMSTAR __result=NULL;
	RHBOPT_unused(somSelf)
	RHBOPT_unused(ev)
	RHBOPT_unused(idString)
	return __result;
}
