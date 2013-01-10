#include <rhbopt.h>
#include <rhbsomd.h>

#ifndef SOM_Module_om_Source
#define SOM_Module_om_Source
#endif
#define ObjectMgr_Class_Source

#include "om.ih"

SOM_Scope SOMObject SOMSTAR SOMLINK om_somdNewObject(
		ObjectMgr SOMSTAR somSelf, 
		Environment *ev, 
		Identifier objclass, 
		corbastring hints)
{
	RHBOPT_unused(somSelf)
	RHBOPT_unused(ev)
	RHBOPT_unused(objclass)
	RHBOPT_unused(hints)

    return 0;
}

SOM_Scope corbastring  SOMLINK om_somdGetIdFromObject(
		ObjectMgr SOMSTAR somSelf, 
		Environment *ev, 
		SOMObject SOMSTAR obj)
{
	RHBOPT_unused(somSelf)
	RHBOPT_unused(ev)
	RHBOPT_unused(obj)

    return 0;
}

SOM_Scope SOMObject SOMSTAR  SOMLINK om_somdGetObjectFromId(
		ObjectMgr SOMSTAR somSelf, 
		Environment *ev, 
		corbastring id)
{
	RHBOPT_unused(somSelf)
	RHBOPT_unused(ev)
	RHBOPT_unused(id)

    return 0;
}

SOM_Scope void  SOMLINK om_somdReleaseObject(
		ObjectMgr SOMSTAR somSelf, 
		Environment *ev, 
		SOMObject SOMSTAR obj)
{
	RHBOPT_unused(somSelf)
	RHBOPT_unused(ev)
	RHBOPT_unused(obj)
}

SOM_Scope void  SOMLINK om_somdDestroyObject(
		ObjectMgr SOMSTAR somSelf, 
		Environment *ev, 
		SOMObject SOMSTAR obj)
{
	RHBOPT_unused(somSelf)
	RHBOPT_unused(ev)
	RHBOPT_unused(obj)
}

