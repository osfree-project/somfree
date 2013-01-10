#include <rhbopt.h>
#include <rhbsomex.h>
#include <somtc.h>

#if 0
#	include <somtcint.h>
#	define AlignmentHelper(x)  typedef struct x##AlignmentHelper { char q; x z; } x##AlignmentHelper;
#	define Alignment(x)        ((int)&(((struct x##AlignmentHelper *)0)->z))
#endif

#if 0
#ifdef _PLATFORM_MACINTOSH_
	typedef char *string;
#endif
typedef unsigned short unsigned_short;
typedef unsigned long unsigned_long;
#endif

#ifndef _IDL_SEQUENCE_octet_defined
	#define _IDL_SEQUENCE_octet_defined
	SOM_SEQUENCE_TYPEDEF(octet);
#endif

#include <unotypes.h>

#define SOMTC_Scope

#include <regiortc.tc>
