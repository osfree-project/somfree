#include <rhbopt.h>
#include <rhbsomex.h>
#include <rhbdynam.h>
#include <dynany.h>

SOMInitModule_begin(somany)

	SOMInitModule_new(DynamicAny_DynAny);
	SOMInitModule_new(DynamicAny_DynFixed);
	SOMInitModule_new(DynamicAny_DynUnion);
	SOMInitModule_new(DynamicAny_DynStruct);
	SOMInitModule_new(DynamicAny_DynArray);
	SOMInitModule_new(DynamicAny_DynSequence);
	SOMInitModule_new(DynamicAny_DynValue);
	SOMInitModule_new(DynamicAny_DynEnum);
	SOMInitModule_new(DynamicAny_DynAnyFactory);

SOMInitModule_end

#if defined(_PLATFORM_MACINTOSH_) && GENERATINGCFM
void SOMANY_CFM_term(void);
RHBOPT_CFM_init(SOMANY,initBlockPtr)
{
	return 0;
}
void SOMANY_CFM_term(void)
{
}
#endif
