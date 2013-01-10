/* #define SOM_Scope  static */

#ifndef SOM_IMPORTEXPORT_somnmf
	#ifdef SOMDLLEXPORT
		#define SOM_IMPORTEXPORT_somnmf SOMDLLEXPORT
	#else
		#define SOM_IMPORTEXPORT_somnmf 
	#endif
#endif /* SOM_IMPORTEXPORT_som */


#include <rhbsomex.h>

#define SOM_Module_naming_Source
#define SOM_Module_xnaming_Source
#define SOM_Module_xnamingf_Source
#define SOM_Module_biter_Source
#define SOM_Module_lname_Source
#define SOM_Module_lnamec_Source

#include <rhbsomkd.h>
/*#include <naming.h>
#include <lnamec.h>
#include <lname.h>
#include <biter.h>
#include <xnaming.h>
*/
#include <somnm.h>
#include <somir.h>
#include <somd.h>
#include <somos.h>
#include <xnamingf.h>
