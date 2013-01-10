#include <rhbopt.h>
#include <rhbemani.h>

#ifndef SOM_Module_timerev_Source
#define SOM_Module_timerev_Source
#endif
#define SOMETimerEvent_Class_Source

#include "timerev.ih"

SOM_Scope long  SOMLINK timerev_somevGetEventInterval(
		SOMETimerEvent SOMSTAR somSelf, 
		Environment *ev)
{
    SOMETimerEventData *somThis = SOMETimerEventGetData(somSelf);

    return somThis->timer_interval;
}

SOM_Scope void  SOMLINK timerev_somevSetEventInterval(
		SOMETimerEvent SOMSTAR somSelf, 
		Environment *ev, 
		long interval)
{
    SOMETimerEventData *somThis = SOMETimerEventGetData(somSelf);

	somThis->timer_interval=interval;
}

SOM_Scope void  SOMLINK timerev_somInit(
		SOMETimerEvent SOMSTAR somSelf)
{
    SOMETimerEventData *somThis = SOMETimerEventGetData(somSelf);

	somThis->timer_interval=0;

    SOMETimerEvent_parent_SOMEEvent_somInit(somSelf);
}


SOM_Scope void SOMLINK timerev_somDumpSelfInt(SOMETimerEvent SOMSTAR somSelf,long level)
{
    SOMETimerEventData *somThis = SOMETimerEventGetData(somSelf);
	somPrefixLevel(level);
	somPrintf("timer_interval : %ld\n",(long)somThis->timer_interval);
}

