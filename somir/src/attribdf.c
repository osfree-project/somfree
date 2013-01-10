#include <rhbopt.h>

#define AttributeDef_Class_Source
#define M_AttributeDef_Class_Source

#include <rhbsomir.h>
#include <attribdf.ih>

#ifdef _type
#undef _type
#endif

SOM_Scope void SOMLINK attribdf_somDumpSelf(
	AttributeDef SOMSTAR somSelf,
	/* in */ long level)
{
	AttributeDef_parent_Contained_somDumpSelf(somSelf,level);
}

SOM_Scope void SOMLINK attribdf_somDumpSelfInt(
	AttributeDef SOMSTAR somSelf,
	/* in */ long level)
{
	AttributeDef_parent_Contained_somDumpSelfInt(somSelf,level);
}

/*SOM_Scope void SOMLINK attribdf_somInit(
	AttributeDef SOMSTAR somSelf)
{
	AttributeDef_parent_Contained_somInit(somSelf);
	SOM_IgnoreWarning(somSelf);
}*/

SOM_Scope void SOMLINK attribdf_somUninit(
	AttributeDef SOMSTAR somSelf)
{
	AttributeDef_parent_Contained_somUninit(somSelf);
}

SOM_Scope TypeCode SOMLINK attribdf__get_type(
	AttributeDef SOMSTAR somSelf,
	Environment *ev)
{
	TypeCode retVal=NULL;
	somir_containedData *cnd=AttributeDef__get_containedData(somSelf,ev);

	if (cnd)
	{
		retVal=cnd->description.attributeDesc.type;
		cnd->lpVtbl->Release(cnd);
	}

	return retVal;
}

SOM_Scope void SOMLINK attribdf__set_type(
	AttributeDef SOMSTAR somSelf,
	Environment *ev,
	/* in */ TypeCode type)
{
	SOM_IgnoreWarning(somSelf);
	SOM_IgnoreWarning(ev);
	SOM_IgnoreWarning(type);
}

SOM_Scope AttributeDef_AttributeMode SOMLINK attribdf__get_mode(
	AttributeDef SOMSTAR somSelf,
	Environment *ev)
{
	AttributeDef_AttributeMode retVal=0;
	somir_containedData *cnd=AttributeDef__get_containedData(somSelf,ev);

	if (cnd)
	{
		retVal=cnd->description.attributeDesc.mode;
		cnd->lpVtbl->Release(cnd);
	}

	return retVal;
}

SOM_Scope void SOMLINK attribdf__set_mode(
	AttributeDef SOMSTAR somSelf,
	Environment *ev,
	/* in */ AttributeDef_AttributeMode mode)
{
	SOM_IgnoreWarning(somSelf);
	SOM_IgnoreWarning(ev);
	SOM_IgnoreWarning(mode);
}

SOM_Scope void SOMLINK attribdf_somDestruct(
	AttributeDef SOMSTAR somSelf,
	boolean doFree,
	somDestructCtrl *ctrl)
{
/*	AttributeDefData *somThis; */
	somDestructCtrl globalCtrl;
	somBooleanVector myMask;

	AttributeDef_BeginDestructor

	attribdf_somUninit(somSelf);

	AttributeDef_EndDestructor
}

SOM_Scope void SOMLINK m_attribdf_somDestruct(
	M_AttributeDef SOMSTAR somSelf,
	boolean doFree,
	somDestructCtrl *ctrl)
{
/*	M_AttributeDefData *somThis;*/
	somDestructCtrl globalCtrl;
	somBooleanVector myMask;

	M_AttributeDef_BeginDestructor

	M_AttributeDef_EndDestructor
}

SOM_Scope void SOMLINK m_attribdf_somDefaultInit(M_AttributeDef SOMSTAR somSelf,
											   somInitCtrl *ctrl)
{
	somInitCtrl globalCtrl;
	somBooleanVector myMask;
/*	M_AttributeDefData *somThis;*/

	M_AttributeDef_BeginInitializer_somDefaultInit

	M_AttributeDef_Init_M_Contained_somDefaultInit(somSelf,ctrl)
}


