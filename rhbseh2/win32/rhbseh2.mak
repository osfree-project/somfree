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

LIBNAME=rhbseh2
TARGET_LIB=$(OUTDIR)\$(LIBNAME).lib
TARGET_PDB=$(OUTDIR)\$(LIBNAME).pdb

PARTOPTS=	$(STDOPT)						\
			/DWIN32_LEAN_AND_MEAN			\
			/DBUILD_RHBSEH2					\
			/I..							\
			/I..\..\include\$(PLATFORM_DEF)	\
			/I..\..\include					\
			$(CC_OUT_PDB)$(TARGET_PDB)	

OBJS=	$(INTDIR)\rhbseh2.obj

all: $(TARGET_LIB)

clean:
	$(CLEAN) $(TARGET_LIB) $(OBJS) $(TARGET_PDB)
	
$(TARGET_LIB): $(OBJS) $(OUTDIR) 
	lib /out:$@ $(OBJS)

$(INTDIR)\rhbseh2.obj: ..\src\rhbseh2.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\rhbseh2.c

$(INTDIR):
	mkdir $@

dist:


test:
