#include <rhbopt.h>

#define SOM_Module_somida_Source
#define SOM_Module_somsid_Source

#define SOMUTStringId_Class_Source

#include <rhbsomex.h>

#include <somida.h>
#include <somsid.h>
#include <somsid.ih>

SOM_Scope unsigned long SOMLINK somsid_somutHashId(
	SOMUTStringId SOMSTAR somSelf,
	Environment *ev)
{
	return SOMUTStringId_parent_SOMUTId_somutHashId(somSelf,ev);
}

SOM_Scope short SOMLINK somsid_somutCompareId(
	SOMUTStringId SOMSTAR somSelf,
	Environment *ev,
	/* in */ SOMUTId SOMSTAR otherId)
{
	return SOMUTStringId_parent_SOMUTId_somutCompareId(somSelf,ev,otherId);
}

SOM_Scope boolean SOMLINK somsid_somutEqualsId(
	SOMUTStringId SOMSTAR somSelf,
	Environment *ev,
	/* in */ SOMUTId SOMSTAR otherId)
{
	return SOMUTStringId_parent_SOMUTId_somutEqualsId(somSelf,ev,otherId);
}

SOM_Scope void SOMLINK somsid_somutSetIdId(
	SOMUTStringId SOMSTAR somSelf,
	Environment *ev,
	/* in */ SOMUTId SOMSTAR otherId)
{
	SOMUTStringId_parent_SOMUTId_somutSetIdId(somSelf,ev,otherId);
}

SOM_Scope boolean SOMLINK somsid_somutEqualsString(
	SOMUTStringId SOMSTAR somSelf,
	Environment *ev,
	/* in */ corbastring IdString)
{
	SOM_IgnoreWarning(somSelf);
	SOM_IgnoreWarning(ev);
	SOM_IgnoreWarning(IdString);

	return 0;
}

SOM_Scope short SOMLINK somsid_somutCompareString(
	SOMUTStringId SOMSTAR somSelf,
	Environment *ev,
	/* in */ corbastring IdString)
{
	SOM_IgnoreWarning(somSelf);
	SOM_IgnoreWarning(ev);
	SOM_IgnoreWarning(IdString);

	return 0;
}

SOM_Scope corbastring SOMLINK somsid_somutGetIdString(
	SOMUTStringId SOMSTAR somSelf,
	Environment *ev,
	/* in */ corbastring toBuffer)
{
	SOM_IgnoreWarning(somSelf);
	SOM_IgnoreWarning(ev);
	SOM_IgnoreWarning(toBuffer);

	return toBuffer;
}

SOM_Scope long SOMLINK somsid_somutGetIdStringLen(
	SOMUTStringId SOMSTAR somSelf,
	Environment *ev)
{
	SOM_IgnoreWarning(somSelf);
	SOM_IgnoreWarning(ev);

	return 0;
}

SOM_Scope long SOMLINK somsid_somutSetIdString(
	SOMUTStringId SOMSTAR somSelf,
	Environment *ev,
	/* in */ corbastring IdString)
{
	SOM_IgnoreWarning(somSelf);
	SOM_IgnoreWarning(ev);
	SOM_IgnoreWarning(IdString);

	return 0;
}

