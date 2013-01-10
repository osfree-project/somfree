#ifdef _WIN32
/*	#include <windows.h>*/
#endif

#define SOM_Module_defedidl_Source
#define SOM_Module_eda_Source
#define SOM_Module_fma_Source
#define SOM_Module_fmi_Source
#define SOM_Module_fmib_Source
#define SOM_Module_fsagm_Source
#define SOM_Module_fsgm_Source
#define SOM_Module_iogma_Source
#define SOM_Module_iogrp_Source
#define SOM_Module_mia_Source
#define SOM_Module_nsma_Source
#define SOM_Module_objset_Source
#define SOM_Module_psma_Source
#define SOM_Module_pid_Source
#define SOM_Module_po_Source
#define SOM_Module_poid_Source
#define SOM_Module_poida_Source
#define SOM_Module_srkset_Source

#include <rhbsomex.h>
#ifdef USE_APPLE_SOM
#	include <som.h>
#else
#	include <somref.h>
#endif
#include <snglicls.h>
#include <somsid.h>
/* #include <somp.h>*/
#include <sompstad.h>
/*#include <sompstat.h>*/

#include <somir.h>
#include <defedidl.h>
#include <eda.h>
#include <fma.h>
#include <fmi.h>
#include <fmib.h>
#include <fsagm.h>
#include <fsgm.h>
#include <iogma.h>
#include <iogrp.h>
#include <mia.h>
#include <nsma.h>
#include <objset.h>
#include <srkset.h>
#include <po.h>
#include <pid.h>
#include <poid.h>
#include <poida.h>
#include <psma.h>

