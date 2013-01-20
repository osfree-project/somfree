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

#include "car.xh"
#include "leftcar.xh"
#include "rightcar.xh"
#include <stdio.h>

Environment *ev = somGetGlobalEnvironment();

//****************************************
// Using offset resolution
//****************************************
offset_res()
{
  MetaCar *mcar;
  Car     *car;

  printf("Use offset resolution\n");

  mcar = CarNewClass(0,0);
  car = mcar->createCar(ev, "Honda", "Prelude", 20000);
  car->printCarSpec(ev);

}

//**************************************************************
// Generic procedure to invoke a generic method "printCarSpec"
// that is defined in subclasses
//**************************************************************
generic(Car *target)
{
   somTD_Car_printCarSpec carMethodPtr;

   //*******************************************************
   //  Show how to invoke printCarSpec assuming namelookup
   //  modifier is not set.
   //*******************************************************
   carMethodPtr = (somTD_Car_printCarSpec)
         somResolveByName( target, "printCarSpec");

   carMethodPtr(target,ev);

   //*****************************************************
   //  Since printCarSpec has a namelookup modifier, one
   //  can use the following macro to invoke the method
   //*****************************************************
   lookup_printCarSpec(target,ev);
}


//*****************************************************************
// Create a LeftSteeringCar and a RightSteeringCar object and
// invoke the corresponding printCarSpec using a generic procedure
//*****************************************************************
callgeneric()
{
   LeftSteeringCar  *lscar;
   RightSteeringCar *rscar;
   MetaCar          *lmcar, *rmcar;
   MetaCar          *rcar;

   lmcar = (MetaCar *) LeftSteeringCarNewClass(0,0);
   rmcar = (MetaCar *) RightSteeringCarNewClass(0,0);

   lscar = (LeftSteeringCar *) lmcar->createCar(ev, "Honda", "Prelude1", 20000);
   rscar = (RightSteeringCar *) rmcar->createCar(ev,"Honda", "Prelude2", 25000);

   generic(lscar);
   generic(rscar);
}

//***************************************** 
// Using namelookup resolution
//******************************************
namelookup_res()
{
   Car                     *car;
   MetaCar                 *mcar;
   somTD_MetaCar_createCar metaCarMethodPtr;
   somTD_Car_printCarSpec  carMethodPtr;

   printf("Use namelookup resolution\n");

   mcar = CarNewClass(0,0);
   //
   // Invoke class method
   //
   metaCarMethodPtr = (somTD_MetaCar_createCar)
        _MetaCar->somLookupMethod( somIdFromString("createCar"));

   car = metaCarMethodPtr(mcar, ev, "Honda", "Prelude", 20000);

   //
   // Invoke instance method
   //
   carMethodPtr = (somTD_Car_printCarSpec)
        _Car->somLookupMethod( somIdFromString("printCarSpec"));
   carMethodPtr(car,ev);
}

//************************************************
// Using Dispatch function resolution
//************************************************
dispatch_res()
{
  MetaCar *mcar;
  Car     *car;
  va_list startArg, arg, arg2;
  long    total;

  printf("Use dispatch-function resolution\n");

  mcar = CarNewClass(0,0);
  total = strlen("Honda")+1 + strlen("Prelude")+1 +
          sizeof(long) + sizeof(MetaCar*) + sizeof(Environment*);

  arg = (char*) SOMMalloc(total);
  startArg = arg;

  va_arg(arg, MetaCar*)     = mcar;
  va_arg(arg, Environment*) = ev;
  va_arg(arg, string)      = "Honda";
  va_arg(arg, string)      = "Prelude";
  va_arg(arg, long)        = 20000;

  mcar->SOMObject_somDispatch((somToken*)&car,
                               somIdFromString("createCar"),
                               startArg);

  arg2 = (char*) SOMMalloc(8);
  startArg = arg2;
  va_arg(arg2, Car*)         = car;
  va_arg(arg2, Environment*) = ev;
  car->SOMObject_somDispatch((somToken*)0,
                             somIdFromString("printCarSpec"),
                             startArg);
}

main(int argc, char *argv[], char *envp[])
{
   offset_res();        // offset resolution
   namelookup_res();    // name lookup resolution
   dispatch_res();      // dispatch function resolution

   callgeneric();       // shows generic procedure
}
