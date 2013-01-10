#include <rhbopt.h>
/* code generater for fsgm.idl */
#define SOM_Module_fsgm_Source
#define SOMPBinary_Class_Source
#include <rhbsomp.h>
#include <fsgm.ih>
/* overridden methods for ::SOMPBinary */
/* overridden method ::SOMPIOGroupMgrAbstract::sompInstantiateMediaInterface */
SOM_Scope SOMPMediaInterfaceAbstract SOMSTAR SOMLINK fsgm_sompInstantiateMediaInterface(
	SOMPBinary SOMSTAR somSelf,
	Environment *ev)
{
	SOMPMediaInterfaceAbstract SOMSTAR __result;
	__result=SOMPBinary_parent_SOMPAscii_sompInstantiateMediaInterface(somSelf,ev);
	return __result;}
/* introduced methods for ::SOMPBinary */
