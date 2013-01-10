#include <rhbopt.h>
/* code generater for poid.idl */
#define SOM_Module_poid_Source
#define SOMPIdAssigner_Class_Source

#include <rhbsomp.h>

#include <poida.h>
#include <poid.ih>
/* overridden methods for ::SOMPIdAssigner */
/* overridden method ::SOMPIdAssignerAbstract::sompGetSystemAssignedId */
SOM_Scope void SOMLINK poid_sompGetSystemAssignedId(
	SOMPIdAssigner SOMSTAR somSelf,
	Environment *ev,
	/* inout */ SOMPPersistentId SOMSTAR *id)
{
	SOMPIdAssigner_parent_SOMPIdAssignerAbstract_sompGetSystemAssignedId(somSelf,ev,id);
}
/* introduced methods for ::SOMPIdAssigner */
