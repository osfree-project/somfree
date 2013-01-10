#define SOM_Module_somos_Source
#define SOM_Module_somap_Source

#include <rhbsomex.h>
#include <somref.h>

#ifndef SOM_IMPORTEXPORT_somos
	#ifdef SOMDLLEXPORT
		#define SOM_IMPORTEXPORT_somos SOMDLLEXPORT
	#else
		#define SOM_IMPORTEXPORT_somos 
	#endif
#endif /* SOM_IMPORTEXPORT_som */

#ifdef __cplusplus
	#include <somd.xh>
	#include <somos.xh>
	#include <somtdm.xh>
	#include <somap.xh>
	#include <somosutl.xh>
#else
	#include <somd.h>
	#include <somos.h>
	#include <somtdm.h>
	#include <somap.h>
	#include <somosutl.h>
#endif

#ifndef SOMDServer_somDuplicateReference
#define SOMDServer_somDuplicateReference(x)   SOMRefObject_somDuplicateReference(x)
#endif

