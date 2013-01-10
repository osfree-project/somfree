#include <rhbopt.h>
#include <som.h>
#include <somtc.h>
#if 0
#include <somtcint.h>
#endif
#include <somd.h>

#ifdef Contained
	#ifndef CORBA_InterfaceDef
		#define CORBA_InterfaceDef   SOMObject
	#endif
	#ifndef CORBA_Contained
		#define CORBA_Contained   	 SOMObject
	#endif
#endif

#include <corba.h>
#include <poa.h>

#define AlignmentHelper(x)  typedef struct x##AlignmentHelper { char q; x z; } x##AlignmentHelper;
#define Alignment(x)        ((int)&(((struct x##AlignmentHelper *)0)->z))

#ifdef _PLATFORM_MACINTOSH_
	typedef char *string;
#endif

/*typedef unsigned short unsigned_short;
typedef unsigned long unsigned_long;*/

#ifndef _IDL_SEQUENCE_octet_defined
	#define _IDL_SEQUENCE_octet_defined
	SOM_SEQUENCE_TYPEDEF(octet);
#endif

#include <unotypes.h>

#define SOMTC_Scope

#include <somddsrv.tc>
