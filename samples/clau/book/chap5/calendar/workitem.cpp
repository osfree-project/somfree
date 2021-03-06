/**************************************************************************
 *
 *  Copyright 1994, Christina Lau
 *
 *  This file is part of Object-Orientated Programming using SOM and DSOM.
 *
 *  This program is free software: you can redistribute it and/or modify it
 *  under the terms of the GNU Lesser General Public License as published by the
 *  Free Software Foundation, either version 3 of the License, or (at your
 *  option) any later version.
 * 
 *  This program is distributed in the hope that it will be useful, but WITHOUT
 *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
 *  more details.
 *
 *  You should have received a copy of the GNU Lesser General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>
 *
 */

/*
 *  This file was generated by the SOM Compiler and Emitter Framework.
 *  Generated using: 
 *      SOM Emitter emitxtm: somc/smmain.c
 */

#define WorkItem_Class_Source
#include <workitem.xih>

SOM_Scope void  SOMLINK mkEntry(WorkItem *somSelf,  Environment *ev, 
                                string sTime, string eTime, string taskDesc)
{
    WorkItemData *somThis = WorkItemGetData(somSelf);
    WorkItemMethodDebug("WorkItem","mkEntry");

    if (somThis->startTime) SOMFree(somThis->startTime);
    somThis->startTime = (string)SOMMalloc(strlen(sTime)+1);
    strcpy (somThis->startTime, sTime);
                                                             
    if (somThis->endTime) SOMFree(somThis->endTime);
    somThis->endTime = (string)SOMMalloc(strlen(eTime)+1);
    strcpy (somThis->endTime, eTime);
                                                             
    if (somThis->task) SOMFree(somThis->task);
    somThis->task = (string)SOMMalloc(strlen(taskDesc)+1);
    strcpy (somThis->task, taskDesc);
}

SOM_Scope void  SOMLINK somInit(WorkItem *somSelf)
{
    WorkItemData *somThis = WorkItemGetData(somSelf);
    WorkItemMethodDebug("WorkItem","somInit");

    WorkItem_parent_SOMObject_somInit(somSelf);

    somThis->startTime = NULL;            
    somThis->endTime   = NULL;
    somThis->task      = NULL;
}

SOM_Scope void  SOMLINK somUninit(WorkItem *somSelf)
{
    WorkItemData *somThis = WorkItemGetData(somSelf);
    WorkItemMethodDebug("WorkItem","somUninit");

    if (somThis->startTime) SOMFree(somThis->startTime);     
    if (somThis->endTime) SOMFree(somThis->endTime);
    if (somThis->task) SOMFree(somThis->task);

    WorkItem_parent_SOMObject_somUninit(somSelf);
}

