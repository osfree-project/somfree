#define SOMObject_VA_EXTERN
#define SOM_Module_somobj_Source
#define SOMDLLEXPORT

#include <rhbopt.h>
#include <som.h>

boolean SOMLINK somva_SOMObject_somDispatch(SOMObject SOMSTAR somSelf,
		somToken *retValue,
		somId methodId,
		...)
{
	boolean __result;
	va_list ap;
	va_start(ap,methodId);
	__result=SOMObject_somDispatch(somSelf,retValue,methodId,ap);
	va_end(ap);
	return __result;
}
