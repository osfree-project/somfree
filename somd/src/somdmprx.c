#include <rhbopt.h>
#include <rhbsomd.h>

#ifndef SOM_Module_somdmprx_Source
#define SOM_Module_somdmprx_Source
#endif
#define SOMDMetaproxy_Class_Source

#include "somdmprx.ih"

#ifdef SOMDMetaproxy_parent_SOMClass_somInitMIClass
SOM_Scope void  SOMLINK somdmprx_somInitMIClass(SOMDMetaproxy SOMSTAR somSelf, 
                                                unsigned long inherit_vars, 
                                                corbastring className, 
                                                SOMClass_SOMClassSequence* parentClasses, 
                                                long dataSize, 
                                                long dataAlignment, 
                                                long maxStaticMethods, 
                                                long majorVersion, 
                                                long minorVersion)
{
   SOMDMetaproxy_parent_SOMClass_somInitMIClass(somSelf, inherit_vars, 
                                                 className, parentClasses, 
                                                 dataSize, dataAlignment, 
                                                 maxStaticMethods, 
                                                 majorVersion, 
                                                 minorVersion);
}
#endif

