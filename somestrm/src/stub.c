#include <rhbopt.h>

#define somStream_StreamIO_Class_Source
#define somStream_MemoryStreamIO_Class_Source
#define somStream_Streamable_Class_Source
#define CosStream_StreamIO_Class_Source
#define CosStream_StreamableFactory_Class_Source
#define CosStream_Streamable_Class_Source

#include <rhbsomex.h>
#include <somd.h>
#include <somstubs.h>
#include <omgestio.h>
#include <somestio.h>
#include <rhbsomex.h>

SOMSTUB(CosStream_StreamIO)
SOMSTUB(CosStream_Streamable)
SOMSTUB(CosStream_StreamableFactory)
SOMSTUB(somStream_MemoryStreamIO)
SOMSTUB(somStream_StreamIO)
SOMSTUB(somStream_Streamable)

SOMInitModule_begin(somestrm)
SOMInitModule_end
