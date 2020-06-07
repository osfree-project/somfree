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

OUTDIR=$(OUTDIR_LIB)
INTDIR=$(BUILDTYPE)

LIBNAME=somobjva
TARGET_LIB=$(OUTDIR)\$(LIBNAME).lib
TARGET_PDB=$(OUTDIR)\$(LIBNAME).pdb

PARTOPTS=	$(STDOPT)						\
			/DWIN32_LEAN_AND_MEAN			\
			/DHAVE_CONFIG_H					\
			/I..							\
			/I..\..\include\$(PLATFORM)		\
			/I..\..\include\$(PLATFORM_DEF)	\
			/I..\..\include					\
			/I..\..\somidl\$(PLATFORM)		\
			/I..\..\somkpub\include			\
			/I..\..\somtk\include			\
			$(CC_OUT_PDB)$(TARGET_PDB)	

OBJS=	$(INTDIR)\clsdisp.obj	\
		$(INTDIR)\objdisp.obj

all: $(TARGET_LIB)

clean:
	$(CLEAN) $(TARGET_LIB) $(OBJS) $(TARGET_PDB)
	
$(TARGET_LIB): $(OBJS) $(OUTDIR) 
	lib /out:$@ $(OBJS)

$(INTDIR)\clsdisp.obj: ..\src\clsdisp.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\clsdisp.c

$(INTDIR)\objdisp.obj: ..\src\objdisp.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\objdisp.c

$(INTDIR):
	mkdir $@

dist:




test:

