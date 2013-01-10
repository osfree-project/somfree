#include <rhbopt.h>
#include <rhbemani.h>

#ifndef SOM_Module_workprev_Source
#define SOM_Module_workprev_Source
#endif
#define SOMEWorkProcEvent_Class_Source

#include "workprev.ih"


SOM_Scope void  SOMLINK workprev_somInit(SOMEWorkProcEvent SOMSTAR somSelf)
{
    /* SOMEWorkProcEventData *somThis = SOMEWorkProcEventGetData(somSelf); */

    SOMEWorkProcEvent_parent_SOMEEvent_somInit(somSelf);
}

