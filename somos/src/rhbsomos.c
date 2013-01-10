#include <rhbopt.h>

#ifdef _PLATFORM_MACINTOSH_
	#include <CodeFragments.h>
#endif

#include <rhbsomos.h>

SOMInitModule_begin(somos)

	SOMInitModule_new(somOS_Server);
	SOMInitModule_new(somOS_ServiceBase);
	SOMInitModule_new(somOS_ServiceBasePRef);
	SOMInitModule_new(somOS_ServiceBaseCORBA);
	SOMInitModule_new(somOS_ServiceBasePRefCORBA);
	SOMInitModule_new(somAttributePersistence_Persist);

SOMInitModule_end

#ifdef _PLATFORM_MACINTOSH_
void SOMOS_CFM_term(void);

RHBOPT_CFM_init(SOMOS,initBlockPtr)
{
	if (initBlockPtr)
	{	
		return 0;
	}

	return -1;
}

void SOMOS_CFM_term(void)
{
}
#endif
