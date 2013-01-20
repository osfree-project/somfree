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
 *  This file was generated by the SOM Compiler.
 *  Generated using:
 *     SOM incremental update: 2.7
 */

#define Day_Class_Source
#include <day.xih>
#include <workitem.xh>
#include <stdio.h>
#include <eventid.h>

SOM_Scope short  SOMLINK book2(Day *somSelf,  Environment *ev, 
                               string start, string end, string desc)
{
    DayData *somThis = DayGetData(somSelf);
    WorkItem *entry;
    short rc;
    DayMethodDebug("Day","book2");

    somSelf->somrLockNlogOp(ev, "Day", "book2", ev,
                            start, end, desc);
                                                         
    entry = new WorkItem;
    entry->mkEntry(ev, start, end, desc);

    if (sequenceLength(somThis->workList) < sequenceMaximum(somThis->workList))  
    {                                                                            
       sequenceElement(somThis->workList,                                        
                       sequenceLength(somThis->workList)) = entry;               
       sequenceLength(somThis->workList)++;                                      
       rc = 0L;                                                                  
    }                                                                            
    else                                                                         
       rc = -1L;                                                                 

    somSelf->somrReleaseNPropagateOperation(ev);        

    //*******************************************************
    // Notify the different views so that they can refresh 
    // their display
    //*******************************************************
    somSelf->notifyView(ev, WM_REFRESH);
    return rc;                                                                   
}

SOM_Scope short  SOMLINK removeItem(Day *somSelf,  Environment *ev, 
                                    string start, string end, 
                                    string desc)
{
    short    rc, i;
    WorkItem *item;
    DayData *somThis = DayGetData(somSelf);
    DayMethodDebug("Day","removeItem");

    rc = -1;
    somSelf->somrLockNlogOp(ev, "Day", "removeItem", ev,
                            start, end, desc);
                                          
    for (i=0; i < sequenceLength(somThis->workList); i++ )
    {
      item = sequenceElement(somThis->workList,i);
                                                             
      if ( (strcmp(start, item->_get_startTime(ev)) == 0) &&
           (strcmp(end, item->_get_endTime(ev)) == 0) &&
           (strcmp(desc, item->_get_task(ev)) == 0) )
      {
        sequenceLength(somThis->workList)--;
                                                             
        for (i; i < sequenceLength(somThis->workList); i++)
        {
           sequenceElement(somThis->workList,i) =
              sequenceElement(somThis->workList, i+1);
        }
        rc = 0;
      }
    }

    somSelf->somrReleaseNPropagateOperation(ev);

    //*****************************************************
    // Notify the different views so that they can refresh 
    // their display
    //*****************************************************
    somSelf->notifyView(ev, WM_REFRESH);
    return rc;     
}

SOM_Scope void  SOMLINK initReplica(Day *somSelf,  Environment *ev, 
                                    string replicaName)
{
    DayData *somThis = DayGetData(somSelf);
    DayMethodDebug("Day","initReplica");

    somSelf->somrSetObjName(ev, replicaName);
    somSelf->somrRepInit(ev, 'o', 'w');
}

SOM_Scope void  SOMLINK registerView(Day *somSelf,  Environment *ev, 
                                     SOMObject* anyObj, string methodName)
{
    DayData *somThis = DayGetData(somSelf);
    DayMethodDebug("Day","registerView");

    somThis->objectPtr = anyObj;
    somThis->methodName = methodName;
}

SOM_Scope void  SOMLINK notifyView(Day *somSelf,  Environment *ev, 
                                   long eventId)
{
    DayData *somThis = DayGetData(somSelf);
    DayMethodDebug("Day","notifyView");

    if (somThis->objectPtr) 
    {
      (somThis->objectPtr)->somDispatch((somToken*)0,
                         somIdFromString(somThis->methodName),
                         somThis->objectPtr,
                         ev,
                         eventId);
    }
}

SOM_Scope SOMObject*  SOMLINK getViewObject(Day *somSelf,  Environment *ev)
{
    DayData *somThis = DayGetData(somSelf);
    DayMethodDebug("Day","getViewObject");

    return (somThis->objectPtr);
}

SOM_Scope void  SOMLINK somInit(Day *somSelf)
{
    DayData *somThis = DayGetData(somSelf);
    DayMethodDebug("Day","somInit");

    Day_parent_SOMRReplicbl_somInit(somSelf);

    sequenceMaximum(somThis->workList) = MAXITEM;
    sequenceLength(somThis->workList) = 0;
    somThis->workList._buffer =
       (WorkItem**) SOMMalloc(sizeof (WorkItem *) * MAXITEM);                                                     

}

SOM_Scope void  SOMLINK somUninit(Day *somSelf)
{
    DayData *somThis = DayGetData(somSelf);
    DayMethodDebug("Day","somUninit");

    if (somThis->workList._buffer)
       SOMFree(somThis->workList._buffer);

    Day_parent_SOMRReplicbl_somUninit(somSelf);
}

SOM_Scope void  SOMLINK somrGetState(Day *somSelf,  Environment *ev, 
                                     string* buf)
{
    long bufsize;
    long seqsize;
    short i, len;
    long infoLen;
    char *start;
    WorkItem *item;
    DayData *somThis = DayGetData(somSelf);
    DayMethodDebug("Day","somrGetState");

    bufsize = sizeof(long) + sizeof(unsigned long);
 
    for (i=0; i < sequenceLength(somThis->workList); i++ )
    {
       item = sequenceElement(somThis->workList,i);
       bufsize += strlen(item->_get_startTime(ev)) + 1 + sizeof(long) +
                  strlen(item->_get_endTime(ev)) + 1 + sizeof(long) +
                  strlen(item->_get_task(ev)) + 1 + sizeof(long);
    }

    *buf = (char *) SOMMalloc(bufsize);

    //**************************************************
    // Store total length
    //**************************************************
    memcpy(*buf, &bufsize, sizeof(long));
    len = sizeof(long);

    //**************************************************
    // Store sequence Length
    //**************************************************
    memcpy((*buf+len),
           &sequenceLength(somThis->workList),
           sizeof(unsigned long));
    len += sizeof(unsigned long);

    //************************************************** 
    // Store sequence Elements
    //************************************************** 
    for (i=0; i < sequenceLength(somThis->workList); i++ )
    {
      item = sequenceElement(somThis->workList,i);

      //*********************************************** 
      // Store length of startTime and startTime
      //***********************************************
      infoLen = strlen(item->_get_startTime(ev)) + 1;

      memcpy((*buf+len), &infoLen, sizeof(long));
      len += sizeof(long);

      strcpy( (char*)(*buf+len), item->_get_startTime(ev));
      len += infoLen;

      //***********************************************  
      // Store length of endTime and endTime
      //*********************************************** 
      infoLen = strlen(item->_get_endTime(ev)) + 1;
      memcpy((*buf+len), &infoLen, sizeof(long));
      len += sizeof(long);

      strcpy((char*)(*buf+len), item->_get_endTime(ev));
      len += infoLen;
 
      //***********************************************  
      // Store length of task and task
      //*********************************************** 
      infoLen = strlen(item->_get_task(ev)) + 1;
      memcpy((*buf+len), &infoLen, sizeof(long));
      len += sizeof(long);

      strcpy((char*)(*buf+len), item->_get_task(ev));
      len += infoLen;
    }
}

SOM_Scope void  SOMLINK somrSetState(Day *somSelf,  Environment *ev, 
                                     string buf)
{
    long totlen, seqlen;
    short len;
    long infoLen;
    WorkItem *entry;
    short i;
    char *start, *end, *task;
    DayData *somThis = DayGetData(somSelf);
    DayMethodDebug("Day","somrSetState");

    totlen = *(long *) buf;
    len = sizeof(long);

    seqlen = *( (unsigned long *)(buf + len) );
    len += sizeof(unsigned long);

    for (i=0; i < seqlen; i++) 
    {
       //***********************************************
       // Get startTime
       //***********************************************
       infoLen = *( (long *)(buf+len) );
       len += sizeof(long);

       start = (char *)SOMMalloc(infoLen);
       memcpy(start, (buf + len), infoLen);
       len += infoLen;

       //***********************************************      
       // Get endTime
       //***********************************************
       infoLen = *( (long *)(buf+len) );
       len += sizeof(long);
                                                       
       end = (char *)SOMMalloc(infoLen);
       memcpy(end, (buf + len), infoLen);
       len += infoLen;
                                                       
       //***********************************************
       // Get task
       //***********************************************
       infoLen = *( (long *)(buf+len) );
       len += sizeof(long);
                                                       
       task = (char *)SOMMalloc(infoLen);
       memcpy(task, (buf + len), infoLen);
       len += infoLen;
                                                       
       //********************************************** 
       // Create WorkItem
       //**********************************************
       entry = new WorkItem;         
       entry->mkEntry(ev, start, end, task);
                                                               
       sequenceElement(somThis->workList,i) = entry;
       SOMFree(start);
       SOMFree(end);
       SOMFree(task);
    } 

    sequenceLength(somThis->workList) = seqlen;
}

SOM_Scope void  SOMLINK somrDoDirective(Day *somSelf,  Environment *ev, 
                                        string str)
{
   DayData *somThis = DayGetData(somSelf);
   DayMethodDebug("Day","somrDoDirective");

   if (strcmp(str, "BECOME_STAND_ALONE") == 0)
   {
       somSelf->notifyView(ev, WM_STAND_ALONE);

   } 
   else
   {
      if (strcmp(str, "CONNECTION_LOST") == 0)
      {
          somSelf->notifyView(ev, WM_CONNECTION_LOST);
      }
      else
      {
         if (strcmp(str, "CONNECTION_REESTABLISHED") == 0)
         {
             somSelf->notifyView(ev, WM_CONNECTION_REESTABLISH);
         }
         else
         {
            if (strcmp(str, "LOST_RECOVERABLILTY") == 0)
            {
                somSelf->notifyView(ev, WM_LOST_RECOVER);
            }
         }
      }
   }

   Day_parent_SOMRReplicbl_somrDoDirective(somSelf, ev, str);
}
