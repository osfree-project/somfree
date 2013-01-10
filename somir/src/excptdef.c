#include <rhbopt.h>

#define ExceptionDef_Class_Source
#define M_ExceptionDef_Class_Source

#include <rhbsomir.h>
#include <excptdef.ih>

#ifdef _type
#undef _type
#endif

SOM_Scope void SOMLINK excptdef_somDumpSelf(
	ExceptionDef SOMSTAR somSelf,
	/* in */ long level)
{
	ExceptionDef_parent_Contained_somDumpSelf(somSelf,level);
}

SOM_Scope void SOMLINK excptdef_somDumpSelfInt(
	ExceptionDef SOMSTAR somSelf,
	/* in */ long level)
{
/*	ExceptionDefData *somThis=ExceptionDefGetData(somSelf);*/
	ExceptionDef_parent_Contained_somDumpSelfInt(somSelf,level);
}
/*
SOM_Scope void SOMLINK excptdef_somInit(
	ExceptionDef SOMSTAR somSelf)
{
	SOM_IgnoreWarning(somSelf);
	ExceptionDef_parent_Contained_somInit(somSelf);
}
*/
SOM_Scope void SOMLINK excptdef__set_type(
	ExceptionDef SOMSTAR somSelf,
	Environment *ev,
	/* in */ TypeCode type)
{
	SOM_IgnoreWarning(somSelf);
	SOM_IgnoreWarning(ev);
	SOM_IgnoreWarning(type);
}

SOM_Scope TypeCode SOMLINK excptdef__get_type(
	ExceptionDef SOMSTAR somSelf,
	Environment *ev)
{
	TypeCode retVal=NULL;
	somir_containedData *cnd=ExceptionDef__get_containedData(somSelf,ev);

	if (cnd)
	{
		retVal=cnd->description.exceptionDesc.type;

		cnd->lpVtbl->Release(cnd);
	}

	return retVal;
}


SOM_Scope void SOMLINK excptdef_somUninit(
	ExceptionDef SOMSTAR somSelf)
{
/*	ExceptionDefData *somThis=ExceptionDefGetData(somSelf);*/
	ExceptionDef_parent_Contained_somUninit(somSelf);
}

SOM_Scope void SOMLINK excptdef_somDestruct(
	ExceptionDef SOMSTAR somSelf,
	boolean doFree,
	somDestructCtrl *ctrl)
{
/*	ExceptionDefData *somThis;*/
	somDestructCtrl globalCtrl;
	somBooleanVector myMask;

	ExceptionDef_BeginDestructor

	excptdef_somUninit(somSelf);

	ExceptionDef_EndDestructor
}

SOM_Scope void SOMLINK m_excptdef_somDestruct(M_ExceptionDef SOMSTAR somSelf,boolean doFree,
											somDestructCtrl *ctrl)
{
	somDestructCtrl globalCtrl;
	somBooleanVector myMask;
/*	M_ExceptionDef *somThis;*/

	M_ExceptionDef_BeginDestructor;

	M_ExceptionDef_EndDestructor;
}

SOM_Scope void SOMLINK m_excptdef_somDefaultInit(M_ExceptionDef SOMSTAR somSelf,
											   somInitCtrl *ctrl)
{
	somInitCtrl globalCtrl;
	somBooleanVector myMask;
/*	M_ExceptionDef *somThis;*/

	M_ExceptionDef_BeginInitializer_somDefaultInit

	M_ExceptionDef_Init_M_Contained_somDefaultInit(somSelf,ctrl)
}


