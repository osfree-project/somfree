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

#define CalendarDir_Class_Source
#include <caldir.xih>

SOM_Scope long  SOMLINK addDay(CalendarDir *somSelf,  Environment *ev, 
                               short daynum, Day* entry)
{
    CalendarDirData *somThis = CalendarDirGetData(somSelf);
    long            rc;
    CalendarDirMethodDebug("CalendarDir","addDay");

    if (sequenceLength(somThis->weekList) < sequenceMaximum(somThis->weekList))
    {
      sequenceElement(somThis->weekList, 
                      sequenceLength(somThis->weekList)) = entry;
      sequenceLength(somThis->weekList)++;
      rc = 0L;
    }
    else
      rc = -1L;
                                                                                   
    return rc;
}

SOM_Scope Day*  SOMLINK getDay(CalendarDir *somSelf,  Environment *ev, 
                               short daynum)
{
    CalendarDirData *somThis = CalendarDirGetData(somSelf);
    CalendarDirMethodDebug("CalendarDir","getDay");

    return ( sequenceElement(somThis->weekList, daynum) );
}

SOM_Scope void  SOMLINK somInit(CalendarDir *somSelf)
{
    CalendarDirData *somThis = CalendarDirGetData(somSelf);
    CalendarDirMethodDebug("CalendarDir","somInit");

    CalendarDir_parent_SOMObject_somInit(somSelf);

    sequenceMaximum(somThis->weekList) = MAXDAY;
    sequenceLength(somThis->weekList) = 0;
    somThis->weekList._buffer = 
        (Day**) SOMMalloc(sizeof (Day *) * MAXDAY);

}

SOM_Scope void  SOMLINK somUninit(CalendarDir *somSelf)
{
    CalendarDirData *somThis = CalendarDirGetData(somSelf);
    CalendarDirMethodDebug("CalendarDir","somUninit");

    if (somThis->weekList._buffer)
      SOMFree(somThis->weekList._buffer);

    CalendarDir_parent_SOMObject_somUninit(somSelf);
}

