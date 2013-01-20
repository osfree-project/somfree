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

#define Company_Class_Source
#include <company.xih>

SOM_Scope long  SOMLINK addEmployee(Company *somSelf,  Environment *ev, 
                                    Employee* entry)
{
    CompanyData *somThis = CompanyGetData(somSelf);
    long rc;
    CompanyMethodDebug("Company","addEmployee");

    if (sequenceLength(somThis->empList) < sequenceMaximum(somThis->empList))
    {
       sequenceElement(somThis->empList, sequenceLength(somThis->empList)) = entry;
       sequenceLength(somThis->empList)++;
       rc = 0L;
    }
    else
       rc = -1L;

    return rc;
}

SOM_Scope void  SOMLINK somInit(Company *somSelf)
{
    CompanyData *somThis = CompanyGetData(somSelf);
    CompanyMethodDebug("Company","somInit");

    Company_parent_SOMObject_somInit(somSelf);

    sequenceMaximum(somThis->empList) = MAXNUM;
    sequenceLength(somThis->empList) = 0;
    somThis->empList._buffer = (Employee **) SOMMalloc(sizeof (Employee *) * MAXNUM);
}

SOM_Scope void  SOMLINK somUninit(Company *somSelf)
{
    CompanyData *somThis = CompanyGetData(somSelf);
    CompanyMethodDebug("Company","somUninit");

    if (somThis->empList._buffer)
    {
       SOMFree(somThis->empList._buffer);
    }
    Company_parent_SOMObject_somUninit(somSelf);
}
