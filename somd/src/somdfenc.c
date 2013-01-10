#include <rhbopt.h>
#include <rhbsomd.h>

#ifndef SOM_Module_somdfenc_Source
	#define SOM_Module_somdfenc_Source
#endif

#define FENC_FactoryENC_Class_Source

#include "somdfenc.ih"

SOM_Scope SOMObject SOMSTAR SOMLINK somdfenc_find_any_from_proxy(
		FENC_FactoryENC SOMSTAR somSelf,
		Environment *ev,
		SOMObject SOMSTAR proxy)
{
	return NULL;
}

SOM_Scope SOMObject SOMSTAR SOMLINK somdfenc_resolve_from_proxy(
	FENC_FactoryENC SOMSTAR somSelf,
	Environment *ev,
	/* in */ SOMObject SOMSTAR proxy)
{
	return NULL;
}

SOM_Scope CosNaming_NamingContext SOMSTAR SOMLINK somdfenc_bind_new_context(
	FENC_FactoryENC SOMSTAR somSelf,
	Environment *ev,
	/* in */ CosNaming_Name *n)
{
	return NULL;
}

SOM_Scope void SOMLINK somdfenc_destroy(
	FENC_FactoryENC SOMSTAR somSelf,
	Environment *ev)
{
}

SOM_Scope SOMObject SOMSTAR SOMLINK somdfenc_resolve(
	FENC_FactoryENC SOMSTAR somSelf,
	Environment *ev,
	/* in */ CosNaming_Name *n)
{
	return NULL;
}

SOM_Scope void SOMLINK somdfenc_list(
	FENC_FactoryENC SOMSTAR somSelf,
	Environment *ev,
	/* in */ unsigned long how_many,
	/* out */ CosNaming_BindingList *bl,
	/* out */ CosNaming_BindingIterator SOMSTAR *bi)
{
}

SOM_Scope void SOMLINK somdfenc_rebind(
	FENC_FactoryENC SOMSTAR somSelf,
	Environment *ev,
	/* in */ CosNaming_Name *n,
	/* in */ SOMObject SOMSTAR obj)
{
}

SOM_Scope CosNaming_NamingContext SOMSTAR SOMLINK somdfenc_new_context(
	FENC_FactoryENC SOMSTAR somSelf,
	Environment *ev)
{
	return NULL;
}

SOM_Scope void SOMLINK somdfenc_bind_context(
	FENC_FactoryENC SOMSTAR somSelf,
	Environment *ev,
	/* in */ CosNaming_Name *n,
	/* in */ CosNaming_NamingContext SOMSTAR nc)
{
}

SOM_Scope void SOMLINK somdfenc_bind(
	FENC_FactoryENC SOMSTAR somSelf,
	Environment *ev,
	/* in */ CosNaming_Name *n,
	/* in */ SOMObject SOMSTAR obj)
{
}

SOM_Scope void SOMLINK somdfenc_unbind(
	FENC_FactoryENC SOMSTAR somSelf,
	Environment *ev,
	/* in */ CosNaming_Name *n)
{
}



