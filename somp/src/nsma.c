#include <rhbopt.h>
/* code generater for nsma.idl */
#define SOM_Module_nsma_Source
#define SOMPNameSpaceMgr_Class_Source
#include <rhbsomp.h>
#include <nsma.ih>
/* overridden methods for ::SOMPNameSpaceMgr */
/* overridden method ::SOMObject::somInit */
SOM_Scope void SOMLINK nsma_somInit(
	SOMPNameSpaceMgr SOMSTAR somSelf)
{
	RHBOPT_unused(somSelf)
	SOMPNameSpaceMgr_parent_SOMObject_somInit(somSelf);
}
/* overridden method ::SOMObject::somUninit */
SOM_Scope void SOMLINK nsma_somUninit(
	SOMPNameSpaceMgr SOMSTAR somSelf)
{
	RHBOPT_unused(somSelf)
	SOMPNameSpaceMgr_parent_SOMObject_somUninit(somSelf);
}
/* overridden method ::SOMObject::somDumpSelfInt */
SOM_Scope void SOMLINK nsma_somDumpSelfInt(
	SOMPNameSpaceMgr SOMSTAR somSelf,
	/* in */ long level)
{
	SOMPNameSpaceMgr_parent_SOMObject_somDumpSelfInt(somSelf,level);
}
/* introduced methods for ::SOMPNameSpaceMgr */
