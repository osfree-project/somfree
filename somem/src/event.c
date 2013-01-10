#include <rhbopt.h>

#ifndef SOM_Module_event_Source
#define SOM_Module_event_Source
#endif
#define SOMEEvent_Class_Source

#include <rhbemani.h>
#include <event.ih>

SOM_Scope unsigned long  SOMLINK event_somevGetEventTime(
		SOMEEvent SOMSTAR somSelf, 
		Environment *ev)
{
    SOMEEventData *somThis = SOMEEventGetData(somSelf);

    return somThis->event_time;
}

SOM_Scope unsigned long  SOMLINK event_somevGetEventType(
		SOMEEvent SOMSTAR somSelf, 
		Environment *ev)
{
    SOMEEventData *somThis = SOMEEventGetData(somSelf);

    return somThis->event_type;
}

SOM_Scope void  SOMLINK event_somevSetEventTime(
		SOMEEvent SOMSTAR somSelf, 
		Environment *ev, 
		unsigned long time_val)
{
    SOMEEventData *somThis = SOMEEventGetData(somSelf);

	somThis->event_time=time_val;
}

SOM_Scope void  SOMLINK event_somevSetEventType(
		SOMEEvent SOMSTAR somSelf, 
		Environment *ev, 
		unsigned long type)
{
    SOMEEventData *somThis = SOMEEventGetData(somSelf);

	somThis->event_type=type;
}

SOM_Scope void  SOMLINK event_somInit(SOMEEvent SOMSTAR somSelf)
{
/*    SOMEEventData *somThis = SOMEEventGetData(somSelf);*/
	RHBOPT_unused(somSelf)

#ifdef SOMEEvent_parent_SOMRefObject_somInit
    SOMEEvent_parent_SOMRefObject_somInit(somSelf);
#else
    SOMEEvent_parent_SOMObject_somInit(somSelf);
#endif
}

