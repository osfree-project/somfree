#include <rhbopt.h>
/* code generater for iogrp.idl */
#define SOM_Module_iogrp_Source
#define SOMPIOGroup_Class_Source
#include <rhbsomp.h>
#include <iogrp.ih>
/* overridden methods for ::SOMPIOGroup */
/* overridden method ::SOMObject::somInit */
SOM_Scope void SOMLINK iogrp_somInit(
	SOMPIOGroup SOMSTAR somSelf)
{
	RHBOPT_unused(somSelf)
	SOMPIOGroup_parent_SOMPKeyedSet_somInit(somSelf);
}
/* overridden method ::SOMObject::somUninit */
SOM_Scope void SOMLINK iogrp_somUninit(
	SOMPIOGroup SOMSTAR somSelf)
{
	RHBOPT_unused(somSelf)
	SOMPIOGroup_parent_SOMPKeyedSet_somUninit(somSelf);
}
/* overridden method ::SOMObject::somDumpSelfInt */
SOM_Scope void SOMLINK iogrp_somDumpSelfInt(
	SOMPIOGroup SOMSTAR somSelf,
	/* in */ long level)
{
	SOMPIOGroup_parent_SOMPKeyedSet_somDumpSelfInt(somSelf,level);
}
/* introduced methods for ::SOMPIOGroup */
/* introduced method ::SOMPIOGroup::sompCount */
SOM_Scope long SOMLINK iogrp_sompCount(
	SOMPIOGroup SOMSTAR somSelf,
	Environment *ev)
{
	long __result=0;
	RHBOPT_unused(somSelf)
	RHBOPT_unused(ev)
	return __result;
}
/* introduced method ::SOMPIOGroup::sompFirst */
SOM_Scope SOMObject SOMSTAR SOMLINK iogrp_sompFirst(
	SOMPIOGroup SOMSTAR somSelf,
	Environment *ev)
{
	SOMObject SOMSTAR __result=NULL;
	RHBOPT_unused(somSelf)
	RHBOPT_unused(ev)
	return __result;
}
/* introduced method ::SOMPIOGroup::sompNewIterator */
SOM_Scope SOMPIteratorHandle SOMSTAR SOMLINK iogrp_sompNewIterator(
	SOMPIOGroup SOMSTAR somSelf,
	Environment *ev)
{
	SOMPIteratorHandle SOMSTAR __result=NULL;
	RHBOPT_unused(somSelf)
	RHBOPT_unused(ev)
	return __result;
}
/* introduced method ::SOMPIOGroup::sompNextObjectInGroup */
SOM_Scope SOMObject SOMSTAR SOMLINK iogrp_sompNextObjectInGroup(
	SOMPIOGroup SOMSTAR somSelf,
	Environment *ev,
	/* in */ SOMPIteratorHandle SOMSTAR iteratorHandle)
{
	SOMObject SOMSTAR __result=NULL;
	RHBOPT_unused(somSelf)
	RHBOPT_unused(ev)
	RHBOPT_unused(iteratorHandle)
	return __result;
}
/* introduced method ::SOMPIOGroup::sompFreeIterator */
SOM_Scope void SOMLINK iogrp_sompFreeIterator(
	SOMPIOGroup SOMSTAR somSelf,
	Environment *ev,
	/* in */ SOMPIteratorHandle SOMSTAR iteratorHandle)
{
	RHBOPT_unused(somSelf)
	RHBOPT_unused(ev)
	RHBOPT_unused(iteratorHandle)
}
/* introduced method ::SOMPIOGroup::sompAddToGroup */
SOM_Scope void SOMLINK iogrp_sompAddToGroup(
	SOMPIOGroup SOMSTAR somSelf,
	Environment *ev,
	/* in */ SOMObject SOMSTAR newObject,
	/* in */ SOMPIOGroup_SOMPIOGroupKey key)
{
	RHBOPT_unused(somSelf)
	RHBOPT_unused(ev)
	RHBOPT_unused(newObject)
	RHBOPT_unused(key)
}
/* introduced method ::SOMPIOGroup::sompRemoveFromGroup */
SOM_Scope SOMObject SOMSTAR SOMLINK iogrp_sompRemoveFromGroup(
	SOMPIOGroup SOMSTAR somSelf,
	Environment *ev,
	/* in */ SOMPIOGroup_SOMPIOGroupKey key)
{
	SOMObject SOMSTAR __result=NULL;
	RHBOPT_unused(somSelf)
	RHBOPT_unused(ev)
	RHBOPT_unused(key)
	return __result;
}
/* introduced method ::SOMPIOGroup::sompFindByKey */
SOM_Scope SOMObject SOMSTAR SOMLINK iogrp_sompFindByKey(
	SOMPIOGroup SOMSTAR somSelf,
	Environment *ev,
	/* in */ SOMPIOGroup_SOMPIOGroupKey key)
{
	SOMObject SOMSTAR __result=NULL;
	RHBOPT_unused(somSelf)
	RHBOPT_unused(ev)
	RHBOPT_unused(key)
	return __result;
}
