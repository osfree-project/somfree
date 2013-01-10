#include <rhbopt.h>

#include <rhbemani.h>

#ifndef SOM_Module_sinkev_Source
#define SOM_Module_sinkev_Source
#endif
#define SOMESinkEvent_Class_Source

#include "sinkev.ih"

SOM_Scope long  SOMLINK sinkev_somevGetEventSink(
		SOMESinkEvent SOMSTAR somSelf, 
		Environment *ev)
{
    SOMESinkEventData *somThis = SOMESinkEventGetData(somSelf);

    return somThis->sink_fd;
}

SOM_Scope void  SOMLINK sinkev_somevSetEventSink(
		SOMESinkEvent SOMSTAR somSelf, 
		Environment *ev, 
		long sink)
{
    SOMESinkEventData *somThis = SOMESinkEventGetData(somSelf);

	somThis->sink_fd=sink;
}

SOM_Scope void  SOMLINK sinkev_somInit(SOMESinkEvent SOMSTAR somSelf)
{
    SOMESinkEventData *somThis = SOMESinkEventGetData(somSelf);

	somThis->sink_fd=-1;

    SOMESinkEvent_parent_SOMEEvent_somInit(somSelf);
}

SOM_Scope void SOMLINK sinkev_somDumpSelfInt(SOMESinkEvent SOMSTAR somSelf,long level)
{
    SOMESinkEventData *somThis = SOMESinkEventGetData(somSelf);
	somPrefixLevel(level);
	somPrintf("sink_fd : %d\n",(int)somThis->sink_fd);
}
