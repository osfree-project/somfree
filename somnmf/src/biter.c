#include <rhbopt.h>

#define Biter_BINDITER_ONE_Class_Source
#define Biter_BINDITER_TWO_Class_Source

#include <rhbsomnm.h>
#include <biter.ih>

SOM_Scope boolean SOMLINK biter_BIT_next_one(
	Biter_BINDITER_TWO SOMSTAR somSelf,
	Environment *ev,
	/* out */ CosNaming_Binding *b)
{
	RHBOPT_unused(somSelf)
	RHBOPT_unused(ev)
	RHBOPT_unused(b)

	return 0;
}

SOM_Scope boolean SOMLINK biter_BIO_next_one(
	Biter_BINDITER_ONE SOMSTAR somSelf,
	Environment *ev,
	/* out */ CosNaming_Binding *b)
{
	RHBOPT_unused(somSelf)
	RHBOPT_unused(ev)
	RHBOPT_unused(b)
	return 0;
}

SOM_Scope void SOMLINK biter_BIT_BI_Init2(
	Biter_BINDITER_TWO SOMSTAR somSelf,
	Environment *ev,
	/* inout */ somToken *ctrl,
	/* in */ CosNaming_BindingList *bl)
{
	RHBOPT_unused(somSelf)
	RHBOPT_unused(ev)
	RHBOPT_unused(ctrl)
	RHBOPT_unused(bl)
}

SOM_Scope void SOMLINK biter_BIT_add_bindings(
	Biter_BINDITER_TWO SOMSTAR somSelf,
	Environment *ev,
	/* in */ CosNaming_BindingList *bl)
{
	RHBOPT_unused(somSelf)
	RHBOPT_unused(ev)
	RHBOPT_unused(bl)
}

SOM_Scope boolean SOMLINK biter_BIT_next_n(
	Biter_BINDITER_TWO SOMSTAR somSelf,
	Environment *ev,
	/* in */ unsigned long how_many,
	/* out */ CosNaming_BindingList *bl)
{
	RHBOPT_unused(somSelf)
	RHBOPT_unused(ev)
	RHBOPT_unused(how_many)
	RHBOPT_unused(bl)
	return 0;
}

SOM_Scope void SOMLINK biter_BIT_destroy(
	Biter_BINDITER_TWO SOMSTAR somSelf,
	Environment *ev)
{
	RHBOPT_unused(somSelf)
	RHBOPT_unused(ev)
}

SOM_Scope void SOMLINK biter_BIO_destroy(
	Biter_BINDITER_ONE SOMSTAR somSelf,
	Environment *ev)
{
	RHBOPT_unused(somSelf)
	RHBOPT_unused(ev)
}

SOM_Scope void SOMLINK biter_BIO_BI_Init1(
	Biter_BINDITER_ONE SOMSTAR somSelf,
	Environment *ev,
	/* inout */ somToken *ctrl,
	/* in */ Biter_BINDITER_ONE_stringSeq *key,
	/* in */ corbastring databaseFile)
{
	RHBOPT_unused(somSelf)
	RHBOPT_unused(ev)
	RHBOPT_unused(ctrl)
	RHBOPT_unused(key)
	RHBOPT_unused(databaseFile)
}

SOM_Scope boolean SOMLINK biter_BIO_next_n(
	Biter_BINDITER_ONE SOMSTAR somSelf,
	Environment *ev,
	/* in */ unsigned long how_many,
	/* out */ CosNaming_BindingList *bl)
{
	RHBOPT_unused(somSelf)
	RHBOPT_unused(ev)
	RHBOPT_unused(how_many)
	RHBOPT_unused(bl)
	return 0;
}




