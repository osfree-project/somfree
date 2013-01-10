#include <rhbopt.h>

#define SOM_Module_clientev_Source
#define SOM_Module_emregdat_Source
#define SOMEClientEvent_Class_Source

#include <rhbemani.h>
#include <emregdat.h>
#include "clientev.ih"

SOM_Scope void*  SOMLINK clientev_somevGetEventClientData(
		SOMEClientEvent SOMSTAR somSelf, 
		Environment *ev)
{
    SOMEClientEventData *somThis = SOMEClientEventGetData(somSelf);

    return somThis->element.client_data;
}

SOM_Scope corbastring  SOMLINK clientev_somevGetEventClientType(
		SOMEClientEvent SOMSTAR somSelf, 
		Environment *ev)
{
    SOMEClientEventData *somThis = SOMEClientEventGetData(somSelf);

    return somThis->element.client_type;
}

SOM_Scope void  SOMLINK clientev_somevSetEventClientData(
		SOMEClientEvent SOMSTAR somSelf, 
		Environment *ev, 
		void* clientData)
{
    SOMEClientEventData *somThis = SOMEClientEventGetData(somSelf);

	somThis->element.client_data=clientData;
}

SOM_Scope void  SOMLINK clientev_somevSetEventClientType(
		SOMEClientEvent SOMSTAR somSelf, 
		Environment *ev, 
		corbastring clientType)
{
    SOMEClientEventData *somThis = SOMEClientEventGetData(somSelf);

	if (somThis->element.client_type)
	{
		SOMFree(somThis->element.client_type);
	}

	somThis->element.client_type=SOMEEMRegisterData_dupl_string(ev,clientType);
}

SOM_Scope void  SOMLINK clientev_somInit(
	SOMEClientEvent SOMSTAR somSelf)
{
    SOMEClientEventData *somThis = SOMEClientEventGetData(somSelf);

	somThis->element.qElem.qLink=NULL;
	somThis->element.qElem.qType=0;
	somThis->element.header=NULL;
	somThis->element.event=somSelf;
	somThis->element.client_data=NULL;
	somThis->element.client_type=NULL;

    SOMEClientEvent_parent_SOMEEvent_somInit(somSelf);
}

SOM_Scope void  SOMLINK clientev_somUninit(
	SOMEClientEvent SOMSTAR somSelf)
{
    SOMEClientEventData *somThis = SOMEClientEventGetData(somSelf);

	if (somThis->element.header)
	{
#ifdef _DEBUG
		somPrintf("SOMEClientEvent(%s) still queued\n",somThis->element.client_type);
#endif
/*		rhbeman_Dequeue(&somThis->element.qElem,somThis->element.header);*/

		somThis->element.dequeue(&somThis->element);
	}

	if (somThis->element.client_type)
	{
		SOMFree(somThis->element.client_type);
		somThis->element.client_type=NULL;
	}

    SOMEClientEvent_parent_SOMEEvent_somUninit(somSelf);
}

SOM_Scope void SOMLINK clientev_somDumpSelfInt(SOMEClientEvent SOMSTAR somSelf,long level)
{
    SOMEClientEventData *somThis = SOMEClientEventGetData(somSelf);
	somPrefixLevel(level);
	somPrintf("client_type : %s\n",somThis->element.client_type);
	somPrefixLevel(level);
	somPrintf("client_data : %p\n",somThis->element.client_data);
}

SOM_Scope SOMEClientEventQL * SOMLINK clientev_somevGetClientEventQL(
			SOMEClientEvent SOMSTAR somSelf,
			Environment *ev)
{
    SOMEClientEventData *somThis = SOMEClientEventGetData(somSelf);
	return &somThis->element;
}
