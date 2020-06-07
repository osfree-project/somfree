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

OUTDIR=$(OUTDIR_BIN)
INTDIR=$(BUILDTYPE)

APPNAME=regimpl

OBJS=	$(INTDIR)\$(APPNAME).obj	\
		$(INTDIR)\link386.obj		\
		$(INTDIR)\regior.obj		\
		$(INTDIR)\regiortc.obj

TARGET_EXE=$(OUTDIR)\$(APPNAME).exe
TARGET_PDB=$(OUTDIR)\$(APPNAME).pdb
TARGET_MAP=$(INTDIR)\$(APPNAME).map

PARTOPTS=	$(STDOPT)					\
			/DHAVE_CONFIG_H				\
			/D_CONSOLE	\
			/DWIN32_LEAN_AND_MEAN		\
			/I..\include				\
			/I$(INTDIR)					\
			/I..\..\include\$(PLATFORM)	\
			/I..\..\include\$(PLATFORM_DEF) \
			/I..\..\include				\
			/I..\..\somidl\$(PLATFORM)	\
			/I..\..\somtc\include		\
			/I..\..\somkpub\include		\
			/I..\..\somtk\include		\
			$(CC_OUT_PDB)$(TARGET_PDB)

all: $(TARGET_EXE)

clean:
	$(CLEAN) $(TARGET_EXE)				\
			 $(TARGET_PDB)				\
			 $(TARGET_MAP)				\
			 $(OBJS)					\
			 $(INTDIR)\$(APPNAME).res	\
			 $(OUTDIR)\$(APPNAME).lib	\
			 $(INTDIR)\$(APPNAME).res
	
$(TARGET_EXE): $(OBJS) $(OUTDIR) $(INTDIR)\$(APPNAME).res
	$(CC) $(CC_OUT_EXE)$@ $(OBJS) \
		$(CC_OUT_PDB)$(TARGET_PDB)	\
		$(CC_LINK) \
		$(LD_SUBSYSTEM_CONSOLE) \
		$(LDFLAGS)				\
		$(INTDIR)\$(APPNAME).res
	$(POSTLINK_EXE) $@

$(INTDIR)\$(APPNAME).obj: ..\src\$(APPNAME).c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\$(APPNAME).c

$(INTDIR)\regior.obj: ..\src\regior.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\regior.c

$(INTDIR)\regiortc.obj: ..\src\regiortc.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\regiortc.c

$(INTDIR)\link386.obj: ..\win32\link386.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\win32\link386.c

$(INTDIR):
	mkdir $@

$(INTDIR)\$(APPNAME).res: ..\win32\$(APPNAME).rc
	rc /nologo /r /I.. /I..\..\include\$(PLATFORM) /fo$@ ..\win32\$(APPNAME).rc

dist:




test:

