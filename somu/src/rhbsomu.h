#define SOMMProxyForObject_VA_EXTERN

#define SOM_Module_snglicls_Source
#define SOM_Module_somproxy_Source
#define SOM_Module_somida_Source
#define SOM_Module_somsid_Source

#ifdef _WIN32
	void SOMTHRD_init(void);
	void SOMTHRD_term(void);
	void SOMTHRD_thread_dead(void);
#endif

#include <som.h>

#ifdef SOMDLLEXPORT 
	#define SOM_IMPORTEXPORT_somu SOMDLLEXPORT
#else
	#define SOM_IMPORTEXPORT_somu
#endif
