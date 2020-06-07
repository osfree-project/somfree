#
#  Copyright 2008, Roger Brown
#
#  This file is part of Roger Brown's Toolkit.
#
#  This program is free software: you can redistribute it and/or modify it
#  under the terms of the GNU Lesser General Public License as published by the
#  Free Software Foundation, either version 3 of the License, or (at your
#  option) any later version.
# 
#  This program is distributed in the hope that it will be useful, but WITHOUT
#  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
#  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
#  more details.
#
#  You should have received a copy of the GNU Lesser General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>
#
#  $Id$

!include $(MAKEDEFS)

SC=$(HOSTDIR_BIN)\sc.exe
PDL=$(HOSTDIR_BIN)\pdl.exe
IDLTOOL=$(HOSTDIR_TOOLS)\idltool.exe

SOM_IDL=..\som\somobj.idl ..\som\somcls.idl ..\som\somcm.idl
SOMIDL_IDL=..\..\somidl
SOMIDL_HEADERS=..\..\somidl\$(PLATFORM)

PRODUCTS_SC=	$(SOMIDL_HEADERS)\somobj.h	\
				$(SOMIDL_HEADERS)\somobj.xh	\
				$(SOMIDL_HEADERS)\somcls.h	\
				$(SOMIDL_HEADERS)\somcls.xh	\
				$(SOMIDL_HEADERS)\somcm.h	\
				$(SOMIDL_HEADERS)\somcm.xh	\
				$(SOMIDL_HEADERS)\somcls.api

PRODUCTS_PDL=	$(SOMIDL_IDL)\somobj.idl	\
				$(SOMIDL_IDL)\somcls.idl	\
				$(SOMIDL_IDL)\somcm.idl

all:		$(PRODUCTS_PDL) $(PRODUCTS_SC) 



clean:
	$(CLEAN) $(PRODUCTS_SC) $(PRODUCTS_PDL)

$(SOMIDL_HEADERS) $(SOMIDL_IDL):
	mkdir $@

$(PRODUCTS_PDL): $(SOMIDL_IDL) $(SOM_IDL)
	$(IDLTOOL) $(PDL) ..\som -o $@

$(PRODUCTS_SC): $(SOMIDL_HEADERS) $(SOM_IDL)
	$(IDLTOOL) $(SC) $(SOMIDL_IDL) -o $@ -I$(SOMIDL_IDL)


dist:


test:

