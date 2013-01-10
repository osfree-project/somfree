#include <rhbopt.h>
/* code generater for formarsh.idl */
#include <rhbsomex.h>
#include <somd.h>
#define SOM_Module_formarsh_Source
#define SOMDForeignMarshaler_Class_Source
#include <formarsh.ih>
/* overridden methods for ::SOMDForeignMarshaler */
/* introduced methods for ::SOMDForeignMarshaler */
/* introduced method ::SOMDForeignMarshaler::marshal */
SOM_Scope void SOMLINK formarsh_marshal(
	SOMDForeignMarshaler SOMSTAR somSelf,
	Environment *ev,
	/* in */ corbastring latent_param,
	/* in */ somToken dataPtr,
	/* in */ SOMD_marshaling_direction_t direction,
	/* in */ SOMD_marshaling_op_t function,
	/* in */ CosStream_StreamIO SOMSTAR streamio)
{
	RHBOPT_throw_StExcep(ev,NO_IMPLEMENT,NotImplemented,NO);
}
