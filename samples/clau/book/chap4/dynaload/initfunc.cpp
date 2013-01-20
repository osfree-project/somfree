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

#include "cat.xh"
#include "dog.xh"

#ifdef __IBMC__
  #pragma linkage(SOMInitModule,system)
#endif

SOMEXTERN void SOMLINK SOMInitModule(long majorVersion,
                                     long minorVersion,
                                     string className)
{
   SOM_IgnoreWarning(majorVersion);
   SOM_IgnoreWarning(minorVersion);
   SOM_IgnoreWarning(className);

   CatNewClass(Cat_MajorVersion, Cat_MinorVersion);
   DogNewClass(Dog_MajorVersion, Dog_MinorVersion);

}
