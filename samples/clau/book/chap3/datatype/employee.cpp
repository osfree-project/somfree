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

#define Employee_Class_Source
#include <employee.xih>

/*
 *Method from the IDL attribute statement:
 *"attribute string name"
 */

SOM_Scope void  SOMLINK _set_name(Employee *somSelf,  Environment *ev, 
                                  string name)
{
    EmployeeData *somThis = EmployeeGetData(somSelf);
    EmployeeMethodDebug("Employee","_set_name");

    if (somThis->name)             
    {
      SOMFree(somThis->name);
    }

    somThis->name = (string) SOMMalloc(strlen(name)+1);   
    strcpy(somThis->name, name);
}

SOM_Scope void  SOMLINK somInit(Employee *somSelf)
{
    EmployeeData *somThis = EmployeeGetData(somSelf);
    EmployeeMethodDebug("Employee","somInit");

    Employee_parent_SOMObject_somInit(somSelf);
    somThis->name = NULL;
}

SOM_Scope void  SOMLINK somUninit(Employee *somSelf)
{
    EmployeeData *somThis = EmployeeGetData(somSelf);
    EmployeeMethodDebug("Employee","somUninit");

    if (somThis->name) 
    {
       SOMFree(somThis->name);
    } 
    Employee_parent_SOMObject_somUninit(somSelf);
}

