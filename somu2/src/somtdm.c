#include <rhbopt.h>

#define SOM_Module_somtdm_Source

#define TypecodeDataManipulator_Class_Source

#include <rhbsomu2.h>
#include <somtdm.ih>

SOM_Scope void SOMLINK somtdm_somUninit(
	TypecodeDataManipulator SOMSTAR somSelf)
{
	TypecodeDataManipulator_parent_SOMObject_somUninit(somSelf);
}

SOM_Scope void SOMLINK somtdm_somInit(
	TypecodeDataManipulator SOMSTAR somSelf)
{
	TypecodeDataManipulator_parent_SOMObject_somInit(somSelf);
}
