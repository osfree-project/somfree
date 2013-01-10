#include <rhbopt.h>
/* code generater for poida.idl */

#define SOM_Module_poida_Source
#define SOMPIdAssignerAbstract_Class_Source
#include <rhbsomp.h>

#include <poida.ih>
/* overridden methods for ::SOMPIdAssignerAbstract */
/* introduced methods for ::SOMPIdAssignerAbstract */
/* introduced method ::SOMPIdAssignerAbstract::sompGetSystemAssignedId */
SOM_Scope void SOMLINK poida_sompGetSystemAssignedId(
	SOMPIdAssignerAbstract SOMSTAR somSelf,
	Environment *ev,
	/* inout */ SOMPPersistentId SOMSTAR *id)
{
	RHBOPT_unused(somSelf)
	RHBOPT_unused(ev)
	RHBOPT_unused(id)
}
