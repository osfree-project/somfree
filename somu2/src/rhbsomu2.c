#include <rhbopt.h>
#include <rhbsomu2.h>

SOMInitModule_begin(somu2)

	SOMInitModule_new(TypecodeDataManipulator);

SOMInitModule_end

#if defined(_PLATFORM_MACINTOSH_) && GENERATINGCFM
void SOMU2_CFM_term(void);
RHBOPT_CFM_init(SOMU2,initBlockPtr)
{
	return 0;
}
void SOMU2_CFM_term(void)
{
}
#endif
