#include <rhbopt.h>

#define LNameComponent_Class_Source

#include <rhbsomnm.h>

#include <lnamec.ih>


SOM_Scope void SOMLINK lnamec_destroy(
	LNameComponent SOMSTAR somSelf,
	Environment *ev)
{
	RHBOPT_unused(somSelf)
	RHBOPT_unused(ev)
}

SOM_Scope void SOMLINK lnamec_set_kind(
	LNameComponent SOMSTAR somSelf,
	Environment *ev,
	/* in */ corbastring k)
{
	RHBOPT_unused(somSelf)
	RHBOPT_unused(ev)
	RHBOPT_unused(k)
}

SOM_Scope corbastring SOMLINK lnamec_get_kind(
	LNameComponent SOMSTAR somSelf,
	Environment *ev)
{
	RHBOPT_unused(somSelf)
	RHBOPT_unused(ev)
	return 0;
}

SOM_Scope corbastring SOMLINK lnamec_get_id(
	LNameComponent SOMSTAR somSelf,
	Environment *ev)
{
	RHBOPT_unused(somSelf)
	RHBOPT_unused(ev)
	return 0;
}

SOM_Scope void SOMLINK lnamec_set_id(
	LNameComponent SOMSTAR somSelf,
	Environment *ev,
	/* in */ corbastring i)
{
	RHBOPT_unused(somSelf)
	RHBOPT_unused(ev)
	RHBOPT_unused(i)
}



