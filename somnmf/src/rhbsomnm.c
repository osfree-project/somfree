#include <rhbopt.h>
#include <rhbsomnm.h>
#include <rhbsomex.h>

SOMInitModule_begin(somnmf)

	SOMInitModule_new(CosNaming_NamingContext);
	SOMInitModule_new(CosNaming_NamingContextExt);
	SOMInitModule_new(CosNaming_BindingIterator);
	SOMInitModule_new(ExtendedNaming_ExtendedNamingContext);
	SOMInitModule_new(FileXNaming_FileENC);
	SOMInitModule_new(Biter_BINDITER_ONE);
	SOMInitModule_new(Biter_BINDITER_TWO);
	SOMInitModule_new(ExtendedNaming_PropertyBindingIterator);
	SOMInitModule_new(ExtendedNaming_PropertyIterator);
	SOMInitModule_new(ExtendedNaming_IndexIterator);
	SOMInitModule_new(FileXNaming_FileBindingIterator);
	SOMInitModule_new(FileXNaming_FPropertyBindingIterator);
	SOMInitModule_new(FileXNaming_FPropertyIterator);
	SOMInitModule_new(FileXNaming_FileIndexIterator);
	SOMInitModule_new(LName);
	SOMInitModule_new(LNameComponent);

SOMInitModule_end

#if defined(_PLATFORM_MACINTOSH_) && GENERATINGCFM
void SOMNMF_CFM_term(void);

RHBOPT_CFM_init(SOMNMF,initBlockPtr)
{
	if (initBlockPtr)
	{	
		return 0;
	}

	return -1;
}

void SOMNMF_CFM_term(void)
{
}
#endif

SOMEXTERN LName SOMSTAR SOMLINK  create_lname(void)
{
	return LNameNew();
}

SOMEXTERN LNameComponent SOMSTAR SOMLINK create_lname_component(void)
{
	return LNameComponentNew();
}

