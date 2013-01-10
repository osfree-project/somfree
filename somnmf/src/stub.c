#include <rhbopt.h>

#define CosNaming_BindingIterator_Class_Source
#define Biter_BINDITER_ONE_Class_Source
#define Biter_BINDITER_TWO_Class_Source
#define CosNaming_NamingContext_Class_Source
#define CosNaming_NamingContextExt_Class_Source
#define ExtendedNaming_ExtendedNamingContext_Class_Source
#define FileXNaming_FPropertyIterator_Class_Source
#define FileXNaming_FileBindingIterator_Class_Source
#define ExtendedNaming_IndexIterator_Class_Source
#define ExtendedNaming_PropertyBindingIterator_Class_Source
#define ExtendedNaming_PropertyIterator_Class_Source
#define FileXNaming_FPropertyBindingIterator_Class_Source
#define FileXNaming_FileENC_Class_Source
#define FileXNaming_FileIndexIterator_Class_Source
#define LName_Class_Source
#define LNameComponent_Class_Source

#include <rhbsomex.h>

#ifdef SOMDLLEXPORT
	#define SOM_IMPORTEXPORT_somnmf SOMDLLEXPORT
#else
	#define SOM_IMPORTEXPORT_somnmf 
#endif

#include <somstubs.h>
#include <somd.h>
#include <xnamingf.h>
#include <biter.h>
#include <lnamec.h>
#include <lname.h>
#include <somnmext.h>
#include <rhbsomex.h>

SOMSTUB(CosNaming_BindingIterator)
SOMSTUB(Biter_BINDITER_ONE)
SOMSTUB(Biter_BINDITER_TWO)
SOMSTUB(CosNaming_NamingContext)
SOMSTUB(CosNaming_NamingContextExt)
SOMSTUB(ExtendedNaming_ExtendedNamingContext)
SOMSTUB(FileXNaming_FileBindingIterator)
SOMSTUB(FileXNaming_FPropertyIterator)
SOMSTUB(ExtendedNaming_IndexIterator)
SOMSTUB(ExtendedNaming_PropertyBindingIterator)
SOMSTUB(ExtendedNaming_PropertyIterator)
SOMSTUB(FileXNaming_FPropertyBindingIterator)
SOMSTUB(FileXNaming_FileENC)
SOMSTUB(FileXNaming_FileIndexIterator)
SOMSTUB(LName)
SOMSTUB(LNameComponent)


LName SOMSTAR SOMLINK create_lname(void)
{
	return NULL;
}

LNameComponent SOMSTAR SOMLINK create_lname_component(void)
{
	return NULL;
}

SOMInitModule_begin(somnmf)
SOMInitModule_end
