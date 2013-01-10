#include <rhbopt.h>
#include <rhbsomex.h>
#include <rhbcorba.h>
#include <corba.h>

SOMInitModule_begin(somcorba)

	SOMInitModule_new(CORBA_DataInputStream);
	SOMInitModule_new(CORBA_DataOutputStream);
	SOMInitModule_new(CORBA_Policy);
	SOMInitModule_new(CORBA_Object);
	SOMInitModule_new(CORBA_Current);
	SOMInitModule_new(CORBA_Repository);
	SOMInitModule_new(CORBA_InterfaceDef);
	SOMInitModule_new(CORBA_OperationDef);
	SOMInitModule_new(CORBA_AttributeDef);
	SOMInitModule_new(CORBA_ExceptionDef);
	SOMInitModule_new(CORBA_ModuleDef);

SOMInitModule_end

#if defined(_PLATFORM_MACINTOSH_) && GENERATINGCFM
void SOMCORBA_CFM_term(void);
RHBOPT_CFM_init(SOMCORBA,initBlockPtr)
{
	return 0;
}
void SOMCORBA_CFM_term(void)
{
}
#endif
