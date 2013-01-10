#include <rhbopt.h>

#define ModuleDef_Class_Source
#define M_ModuleDef_Class_Source

#include <rhbsomir.h>
#include <moduledf.ih>

SOM_Scope void SOMLINK moduledf_somDumpSelf(
	ModuleDef SOMSTAR somSelf,
	/* in */ long level)
{
	ModuleDef_parent_Contained_somDumpSelf(somSelf,level);
}

SOM_Scope void SOMLINK moduledf_somDumpSelfInt(
	ModuleDef SOMSTAR somSelf,
	/* in */ long level)
{
	ModuleDef_parent_Contained_somDumpSelfInt(somSelf,level);
	ModuleDef_parent_Container_somDumpSelfInt(somSelf,level);
}

/*
SOM_Scope void SOMLINK moduledf_somInit(
	ModuleDef SOMSTAR somSelf)
{
	ModuleDef_parent_Container_somInit(somSelf);
	ModuleDef_parent_Contained_somInit(somSelf);
	SOM_IgnoreWarning(somSelf);
}
*/
/*
SOM_Scope void SOMLINK moduledf_somUninit(
	ModuleDef SOMSTAR somSelf)
{
	SOM_IgnoreWarning(somSelf);
	ModuleDef_parent_Container_somUninit(somSelf);
	ModuleDef_parent_Contained_somUninit(somSelf);
}
*/

SOM_Scope void SOMLINK moduledf_somDestruct(
		ModuleDef SOMSTAR somSelf,
		boolean doFree,
		somDestructCtrl *ctrl)
{
	somDestructCtrl globalCtrl;
	somBooleanVector myMask;

	ModuleDef_BeginDestructor

	ModuleDef_EndDestructor
}

SOM_Scope void SOMLINK m_moduledf_somDestruct(M_ModuleDef SOMSTAR somSelf,boolean doFree,
											somDestructCtrl *ctrl)
{
	somDestructCtrl globalCtrl;
	somBooleanVector myMask;
/*	M_ModuleDef *somThis;*/

	M_ModuleDef_BeginDestructor;

	M_ModuleDef_EndDestructor;
}

SOM_Scope void SOMLINK m_moduledf_somDefaultInit(M_ModuleDef SOMSTAR somSelf,
											   somInitCtrl *ctrl)
{
	somInitCtrl globalCtrl;
	somBooleanVector myMask;
/*	M_ModuleDef *somThis;*/

	M_ModuleDef_BeginInitializer_somDefaultInit

	M_ModuleDef_Init_M_Contained_somDefaultInit(somSelf,ctrl)
}
