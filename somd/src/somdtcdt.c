#define somtcnst_h		/* so we dont get TC constants */

#include <rhbopt.h>

typedef unsigned short unsigned_short;
typedef unsigned long unsigned_long;
#ifdef _PLATFORM_MACINTOSH_
	typedef char *string;	/* mac som uses 'corbastring' */
#endif

#define SOMD_TypeCodes

#include <rhbsomd.h>

#if 0
	/* these bits are from ir.idl but with Apple SOM you
		can't have two IDL files with the same module */
	/* use any type of enum type */
	typedef SOMD_marshaling_op_t CORBA_DefinitionKind;
	typedef SOMObject CORBA_InterfaceDef;

	#ifdef _PLATFORM_MACINTOSH_
		#if powerc
			#pragma options align=mac68k
		#endif /* powerc */
	#endif /* _PLATFORM_MACINTOSH_ */

	typedef struct CORBA_Contained_Description
	{
		CORBA_DefinitionKind kind;
		any value;
	} CORBA_Contained_Description;

	#ifdef _PLATFORM_MACINTOSH_
		#if powerc
			#pragma options align=reset
		#endif  /* powerc */
	#endif /* _PLATFORM_MACINTOSH_ */
#endif

#include <somtcint.h>

#define AlignmentHelper(x)  typedef struct x##AlignmentHelper { char q; x z; } x##AlignmentHelper;
#define Alignment(x)        ((int)(size_t)&(((struct x##AlignmentHelper *)0)->z))

#define TC__string				somdTC__string
#define TC__octet				somdTC__octet
#define TC__short				somdTC__short
#define TC__ushort				somdTC__ushort
#define TC__long				somdTC__long
#define TC__boolean				somdTC__boolean
#define TC__IOP_TaggedComponent	somdTC__IOP_TaggedComponent
#define TC__IOP_TaggedProfile	somdTC__IOP_TaggedProfile

/* dont want the somdTC__XXXX exported... */

#define SOMTC_Scope    

#ifdef PRAGMA_IMPORT_SUPPORTED
	#undef PRAGMA_IMPORT_SUPPORTED
#endif

#include <somdtcdt.tc>

/* 
	this exception definition is special
	because 
	(a) zero origin enum
	(b) enum is actually an enum, not an unsignd long
  */


AlignmentHelper(completion_status)
AlignmentHelper(unsigned_long)
AlignmentHelper(StExcep)

static struct TypeCode_base TC__unsigned_long=
{
	tk_ulong,
	Alignment(unsigned_long),
	SOMTC_VERSION_1,
	0
};

static char * _buffer_somdTC__completion_status[]={"YES","NO","MAYBE"};

static struct TypeCode_enum somdTC__completion_status={
	tk_enum,
	Alignment(completion_status),
	SOMTC_VERSION_1,
	SOMTC_FLAGS_ZENUM,
	sizeof(_buffer_somdTC__completion_status)/
		sizeof(_buffer_somdTC__completion_status[0]),
	"completion_status",
	_buffer_somdTC__completion_status};

static struct TypeCode_struct_member _buffer_somdTC_StExcep[]={
	{"minor",(TypeCode)&TC__unsigned_long},
	{"completed",(TypeCode)&somdTC__completion_status}
};

struct TypeCode_struct somdTC__StExcep={
	tk_struct,
	Alignment(StExcep),
	SOMTC_VERSION_1,
	0,
	sizeof(_buffer_somdTC_StExcep)/
		sizeof(_buffer_somdTC_StExcep[0]),
	"StExcep",
	_buffer_somdTC_StExcep};
