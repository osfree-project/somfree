#include <rhbopt.h>
/* code generater for fsagm.idl */
#define SOM_Module_fsagm_Source
#define SOMPAscii_Class_Source
#include <rhbsomp.h>
#include <fsagm.ih>
/* overridden methods for ::SOMPAscii */
/* overridden method ::SOMPIOGroupMgrAbstract::sompNewMediaInterface */
SOM_Scope void SOMLINK fsagm_sompNewMediaInterface(
	SOMPAscii SOMSTAR somSelf,
	Environment *ev,
	/* in */ corbastring IOInfo)
{
	SOMPAscii_parent_SOMPIOGroupMgrAbstract_sompNewMediaInterface(somSelf,ev,IOInfo);
}
/* overridden method ::SOMPIOGroupMgrAbstract::sompGetMediaInterface */
SOM_Scope SOMPMediaInterfaceAbstract SOMSTAR SOMLINK fsagm_sompGetMediaInterface(
	SOMPAscii SOMSTAR somSelf,
	Environment *ev)
{
	SOMPMediaInterfaceAbstract SOMSTAR __result;
	__result=SOMPAscii_parent_SOMPIOGroupMgrAbstract_sompGetMediaInterface(somSelf,ev);
	return __result;}
/* overridden method ::SOMPIOGroupMgrAbstract::sompFreeMediaInterface */
SOM_Scope void SOMLINK fsagm_sompFreeMediaInterface(
	SOMPAscii SOMSTAR somSelf,
	Environment *ev)
{
	SOMPAscii_parent_SOMPIOGroupMgrAbstract_sompFreeMediaInterface(somSelf,ev);
}
/* overridden method ::SOMPIOGroupMgrAbstract::sompInstantiateMediaInterface */
SOM_Scope SOMPMediaInterfaceAbstract SOMSTAR SOMLINK fsagm_sompInstantiateMediaInterface(
	SOMPAscii SOMSTAR somSelf,
	Environment *ev)
{
	SOMPMediaInterfaceAbstract SOMSTAR __result;
	__result=SOMPAscii_parent_SOMPIOGroupMgrAbstract_sompInstantiateMediaInterface(somSelf,ev);
	return __result;}
/* overridden method ::SOMPIOGroupMgrAbstract::sompWriteGroup */
SOM_Scope boolean SOMLINK fsagm_sompWriteGroup(
	SOMPAscii SOMSTAR somSelf,
	Environment *ev,
	/* in */ SOMPPersistentObject SOMSTAR thisPo)
{
	boolean __result;
	__result=SOMPAscii_parent_SOMPIOGroupMgrAbstract_sompWriteGroup(somSelf,ev,thisPo);
	return __result;}
/* overridden method ::SOMPIOGroupMgrAbstract::sompReadGroup */
SOM_Scope SOMPPersistentObject SOMSTAR SOMLINK fsagm_sompReadGroup(
	SOMPAscii SOMSTAR somSelf,
	Environment *ev,
	/* in */ SOMPPersistentId SOMSTAR objectID)
{
	SOMPPersistentObject SOMSTAR __result;
	__result=SOMPAscii_parent_SOMPIOGroupMgrAbstract_sompReadGroup(somSelf,ev,objectID);
	return __result;}
/* overridden method ::SOMPIOGroupMgrAbstract::sompReadObjectData */
SOM_Scope void SOMLINK fsagm_sompReadObjectData(
	SOMPAscii SOMSTAR somSelf,
	Environment *ev,
	/* in */ SOMPPersistentObject SOMSTAR thisPo)
{
	SOMPAscii_parent_SOMPIOGroupMgrAbstract_sompReadObjectData(somSelf,ev,thisPo);
}
/* overridden method ::SOMPIOGroupMgrAbstract::sompGroupExists */
SOM_Scope boolean SOMLINK fsagm_sompGroupExists(
	SOMPAscii SOMSTAR somSelf,
	Environment *ev,
	/* in */ corbastring IOInfo)
{
	boolean __result;
	__result=SOMPAscii_parent_SOMPIOGroupMgrAbstract_sompGroupExists(somSelf,ev,IOInfo);
	return __result;}
/* overridden method ::SOMPIOGroupMgrAbstract::sompObjectInGroup */
SOM_Scope boolean SOMLINK fsagm_sompObjectInGroup(
	SOMPAscii SOMSTAR somSelf,
	Environment *ev,
	/* in */ SOMPPersistentId SOMSTAR objectID)
{
	boolean __result;
	__result=SOMPAscii_parent_SOMPIOGroupMgrAbstract_sompObjectInGroup(somSelf,ev,objectID);
	return __result;}
/* overridden method ::SOMPIOGroupMgrAbstract::sompMediaFormatOk */
SOM_Scope boolean SOMLINK fsagm_sompMediaFormatOk(
	SOMPAscii SOMSTAR somSelf,
	Environment *ev,
	/* in */ corbastring mediaFormatName)
{
	boolean __result;
	__result=SOMPAscii_parent_SOMPIOGroupMgrAbstract_sompMediaFormatOk(somSelf,ev,mediaFormatName);
	return __result;}
/* overridden method ::SOMPIOGroupMgrAbstract::sompDeleteObjectFromGroup */
SOM_Scope void SOMLINK fsagm_sompDeleteObjectFromGroup(
	SOMPAscii SOMSTAR somSelf,
	Environment *ev,
	/* in */ SOMPPersistentId SOMSTAR objectID)
{
	SOMPAscii_parent_SOMPIOGroupMgrAbstract_sompDeleteObjectFromGroup(somSelf,ev,objectID);
}
/* overridden method ::SOMObject::somInit */
SOM_Scope void SOMLINK fsagm_somInit(
	SOMPAscii SOMSTAR somSelf)
{
	RHBOPT_unused(somSelf)
	SOMPAscii_parent_SOMPIOGroupMgrAbstract_somInit(somSelf);
}
/* overridden method ::SOMObject::somUninit */
SOM_Scope void SOMLINK fsagm_somUninit(
	SOMPAscii SOMSTAR somSelf)
{
	RHBOPT_unused(somSelf)
	SOMPAscii_parent_SOMPIOGroupMgrAbstract_somUninit(somSelf);
}
/* introduced methods for ::SOMPAscii */
