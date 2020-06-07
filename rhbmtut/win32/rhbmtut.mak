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

DLLNAME=rhbmtut

TARGET_LIB=$(OUTDIR)\$(DLLNAME).lib
TARGET_PDB=$(OUTDIR)\$(DLLNAME).pdb

PARTOPTS=	$(STDOPT)					\
			/DWIN32_LEAN_AND_MEAN 		\
			/DBUILD_RHBMTUT				\
			/DHAVE_CONFIG_H				\
			/I..\include				\
			/I..\..\include\$(PLATFORM) \
			/I..\..\include\$(PLATFORM_DEF)	\
			/I..\..\include				\
			$(CC_OUT_PDB)$(TARGET_PDB)
		

OBJS=$(INTDIR)\$(DLLNAME).obj	\
	 $(INTDIR)\rhbmtutp.obj		\
	 $(INTDIR)\rhbmtutx.obj		


all: $(TARGET_LIB)

clean:
	$(CLEAN) $(TARGET_LIB) $(OBJS) $(TARGET_PDB) 
	
$(TARGET_LIB): $(OBJS) $(OUTDIR)
	if exist $@ del $@
	lib  $(OBJS) /OUT:$@ 

$(INTDIR)\$(DLLNAME).obj: ..\src\$(DLLNAME).c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\$(DLLNAME).c

$(INTDIR)\rhbmtutp.obj: ..\src\rhbmtutp.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\rhbmtutp.c

$(INTDIR)\rhbmtutx.obj: ..\src\rhbmtutx.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\rhbmtutx.c

$(INTDIR):
	mkdir $@

dist:




test:

