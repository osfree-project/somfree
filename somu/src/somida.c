#include <rhbopt.h>


#define SOMUTId_Class_Source

#include <somida.h>
#include <somida.ih>

SOM_Scope unsigned long SOMLINK somida_somutHashId(
	SOMUTId SOMSTAR somSelf,
	Environment *ev)
{
	SOM_IgnoreWarning(somSelf);
	SOM_IgnoreWarning(ev);

	return 0;
}

SOM_Scope short SOMLINK somida_somutCompareId(
	SOMUTId SOMSTAR somSelf,
	Environment *ev,
	/* in */ SOMUTId SOMSTAR otherId)
{
	SOM_IgnoreWarning(somSelf);
	SOM_IgnoreWarning(ev);
	SOM_IgnoreWarning(otherId);

	return 0;
}

SOM_Scope boolean SOMLINK somida_somutEqualsId(
	SOMUTId SOMSTAR somSelf,
	Environment *ev,
	/* in */ SOMUTId SOMSTAR otherId)
{
	SOM_IgnoreWarning(somSelf);
	SOM_IgnoreWarning(ev);
	SOM_IgnoreWarning(otherId);

	return 0;
}

SOM_Scope void SOMLINK somida_somutSetIdId(
	SOMUTId SOMSTAR somSelf,
	Environment *ev,
	/* in */ SOMUTId SOMSTAR otherId)
{
	SOM_IgnoreWarning(somSelf);
	SOM_IgnoreWarning(ev);
	SOM_IgnoreWarning(otherId);
}
