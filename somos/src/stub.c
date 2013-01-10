#include <rhbopt.h>

#define somAttributePersistence_Persist_Class_Source
#define somOS_Server_Class_Source
#define somOS_ServiceBase_Class_Source
#define somOS_ServiceBaseCORBA_Class_Source
#define somOS_ServiceBasePRef_Class_Source
#define somOS_ServiceBasePRefCORBA_Class_Source

#include <rhbsomex.h>

#ifdef SOMDLLEXPORT
	#define SOM_IMPORTEXPORT_somos SOMDLLEXPORT
#else
	#define SOM_IMPORTEXPORT_somos 
#endif

#include <somstubs.h>
#include <somd.h>

#include <somap.h>
#include <somos.h>
#include <somosutl.h>
#include <rhbsomex.h>

SOMSTUB(somAttributePersistence_Persist)
SOMSTUB(somOS_Server)
SOMSTUB(somOS_ServiceBase)
SOMSTUB(somOS_ServiceBaseCORBA)
SOMSTUB(somOS_ServiceBasePRef)
SOMSTUB(somOS_ServiceBasePRefCORBA)

int SOMLINK somos_init_persist_dbs(char *impl_alias, Environment *ev)
{
	return 0;
}
void SOMLINK somos_uninit_persist_dbs(char *impl_alias, Environment *ev)
{
}
int SOMLINK somos_getopt(int argc, char **argv, char *opts)
{
	return 0;
}

void SOMLINK somos_exit(int exit_code)
{
}

void SOMLINK somos_setup(void)
{
}

void SOMLINK somos_init_services(boolean initialize_mode)
{
}

void SOMLINK somos_init_services_afterimpl(boolean initialize_mode)
{
}

void SOMLINK somos_register_exit_callback(somOS_service_id_e somos_service_id, 
						    somosExitCallbackProc *proc,
						    void *client_data)
{
}

void SOMLINK somos_init_logging(void)
{
}

SOMInitModule_begin(somos)
SOMInitModule_end
