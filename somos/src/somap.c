#include <rhbopt.h>

#define somAttributePersistence_Persist_Class_Source

#include <rhbsomos.h>
#include <somap.ih>

SOM_Scope SOMObject SOMSTAR SOMLINK somap_init_for_object_creation(
	somAttributePersistence_Persist SOMSTAR somSelf,
	Environment *ev)
{
	RHBOPT_unused(somSelf)
	RHBOPT_unused(ev)
	return 0;
}

SOM_Scope void SOMLINK somap_reinit(
	somAttributePersistence_Persist SOMSTAR somSelf,
	Environment *ev,
	/* in */ somOS_ServiceBase_metastate_t *meta_data)
{
	RHBOPT_unused(somSelf)
	RHBOPT_unused(ev)
	RHBOPT_unused(meta_data)
}

SOM_Scope SOMObject SOMSTAR SOMLINK somap_init_for_object_copy(
	somAttributePersistence_Persist SOMSTAR somSelf,
	Environment *ev)
{
	RHBOPT_unused(somSelf)
	RHBOPT_unused(ev)
	return 0;
}

SOM_Scope SOMObject SOMSTAR SOMLINK somap_init_for_object_reactivation(
	somAttributePersistence_Persist SOMSTAR somSelf,
	Environment *ev)
{
	RHBOPT_unused(somSelf)
	RHBOPT_unused(ev)
	return 0;
}

SOM_Scope void SOMLINK somap_capture(
	somAttributePersistence_Persist SOMSTAR somSelf,
	Environment *ev,
	/* inout */ somOS_ServiceBase_metastate_t *meta_data)
{
	RHBOPT_unused(somSelf)
	RHBOPT_unused(ev)
	RHBOPT_unused(meta_data)
}

SOM_Scope void SOMLINK somap_load_attribute(
	somAttributePersistence_Persist SOMSTAR somSelf,
	Environment *ev,
	/* in */ corbastring attribute_name,
	/* out */ void **buffer,
	/* in */ TypeCode attribute_tc)
{
	RHBOPT_unused(somSelf)
	RHBOPT_unused(ev)
	RHBOPT_unused(buffer)
	RHBOPT_unused(attribute_name)
	RHBOPT_unused(attribute_tc)
}

SOM_Scope void SOMLINK somap_store_attribute(
	somAttributePersistence_Persist SOMSTAR somSelf,
	Environment *ev,
	/* in */ corbastring attribute_name,
	/* in */ void *buffer,
	/* in */ TypeCode attribute_tc)
{
	RHBOPT_unused(somSelf)
	RHBOPT_unused(ev)
	RHBOPT_unused(buffer)
	RHBOPT_unused(attribute_name)
	RHBOPT_unused(attribute_tc)
}

SOM_Scope void SOMLINK somap_uninit_for_object_move(
	somAttributePersistence_Persist SOMSTAR somSelf,
	Environment *ev)
{
	RHBOPT_unused(somSelf)
	RHBOPT_unused(ev)
}

SOM_Scope void SOMLINK somap_uninit_for_object_passivation(
	somAttributePersistence_Persist SOMSTAR somSelf,
	Environment *ev)
{
	RHBOPT_unused(somSelf)
	RHBOPT_unused(ev)
}

SOM_Scope void SOMLINK somap_uninit_for_object_destruction(
	somAttributePersistence_Persist SOMSTAR somSelf,
	Environment *ev)
{
	RHBOPT_unused(somSelf)
	RHBOPT_unused(ev)
}










