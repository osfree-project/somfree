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
SOMIDL_IDL=..\..\somidl
SOMIDL_HEADERS=..\..\somidl\$(PLATFORM)

SOMTC_PART=..\..\somtc
SOMREF_PART=..\..\somref
SOMIR_PART=..\..\somir
SOM_PART=..\..\somkpub\som

SOMTC_INTDIR=$(SOMTC_PART)\$(PLATFORM)\$(BUILDTYPE)
SOMREF_INTDIR=$(SOMREF_PART)\$(PLATFORM)\$(BUILDTYPE)
SOMIR_INTDIR=$(SOMIR_PART)\$(PLATFORM)\$(BUILDTYPE)

SOMTCDAT_TC=$(SOMTC_INTDIR)\somtcdat.tc

SOMREF_PDL=	$(SOMIDL_IDL)\somref.idl

SOMREF_H=	$(SOMIDL_HEADERS)\somref.h	\
			$(SOMIDL_HEADERS)\somref.xh

SOMREF_IH=	$(SOMREF_INTDIR)\somref.h	\
			$(SOMREF_INTDIR)\somref.ih

SOMIR_IH=	$(SOMIR_INTDIR)\containd.ih	\
			$(SOMIR_INTDIR)\containd.h	\
			$(SOMIR_INTDIR)\containr.ih	\
			$(SOMIR_INTDIR)\containr.h	\
			$(SOMIR_INTDIR)\typedef.ih	\
			$(SOMIR_INTDIR)\typedef.h	\
			$(SOMIR_INTDIR)\repostry.ih	\
			$(SOMIR_INTDIR)\repostry.h	\
			$(SOMIR_INTDIR)\excptdef.ih	\
			$(SOMIR_INTDIR)\excptdef.h	\
			$(SOMIR_INTDIR)\constdef.ih	\
			$(SOMIR_INTDIR)\constdef.h	\
			$(SOMIR_INTDIR)\operatdf.ih	\
			$(SOMIR_INTDIR)\operatdf.h	\
			$(SOMIR_INTDIR)\intfacdf.ih	\
			$(SOMIR_INTDIR)\intfacdf.h	\
			$(SOMIR_INTDIR)\moduledf.ih	\
			$(SOMIR_INTDIR)\moduledf.h	\
			$(SOMIR_INTDIR)\paramdef.ih	\
			$(SOMIR_INTDIR)\paramdef.h	\
			$(SOMIR_INTDIR)\attribdf.ih	\
			$(SOMIR_INTDIR)\attribdf.h

all: $(SOMTCDAT_TC) $(SOMREF_H) $(SOMREF_IH) $(SOMREF_PDL) $(SOMIR_IH)


clean:
	$(CLEAN) $(SOMTCDAT_TC) 
	$(CLEAN) $(SOMREF_H) 
	$(CLEAN) $(SOMREF_IH) 
	$(CLEAN) $(SOMREF_PDL)
	$(CLEAN) $(SOMIR_IH)


$(SOMTCDAT_TC): $(SOMTC_PART)\somtcdat.idl $(SOMTC_INTDIR)
	$(IDLTOOL) $(SC) $(SOMTC_PART) -o $@ -p -D __GENERATE_SOMTC__ -I$(SOMIDL_IDL)

$(SOMREF_PDL): $(SOMREF_PART)\somref.idl
	$(IDLTOOL) $(PDL) $(SOMREF_PART) -o $@ 	

$(SOMREF_H): $(SOMREF_PDL)
	$(IDLTOOL) $(SC) $(SOMIDL_IDL) -o $@ -I$(SOMIDL_IDL)

$(SOMREF_IH): $(SOMREF_PDL) $(SOMREF_INTDIR)
	$(IDLTOOL) $(SC) $(SOMREF_PART) -o $@ -p -I$(SOM_PART) -I$(SOMIDL_IDL)

$(SOMIR_IH): $(SOMREF_PDL) $(SOMIR_INTDIR)
	$(IDLTOOL) $(SC) $(SOMIR_PART) -o $@ -p -I$(SOMIR_PART) -I$(SOMIDL_IDL)

$(SOMTC_INTDIR) $(SOMREF_INTDIR) $(SOMIR_INTDIR):
	mkdir $@

dist:

test:
