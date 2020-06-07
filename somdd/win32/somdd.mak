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

APPNAME=somdd

OBJS=	$(INTDIR)\rhbsomdd.obj	\
		$(INTDIR)\implreps.obj	\
		$(INTDIR)\rhbexecd.obj	\
		$(INTDIR)\rhbexec.obj	\
		$(INTDIR)\winerror.obj	\
		$(INTDIR)\somddevm.obj	\
		$(INTDIR)\somddior.obj	\
		$(INTDIR)\somddrep.obj	\
		$(INTDIR)\somddsrv.obj	\
		$(INTDIR)\somddtc.obj	\
		$(INTDIR)\somddw32.obj	\
		$(INTDIR)\link386.obj 

TARGET_EXE=$(OUTDIR)\$(APPNAME).exe
TARGET_PDB=$(OUTDIR)\$(APPNAME).pdb
TARGET_MAP=$(INTDIR)\$(APPNAME).map

PARTOPTS=	$(STDOPT)					\
			/DHAVE_CONFIG_H				\
			/D_CONSOLE					\
			/DWIN32_LEAN_AND_MEAN		\
			/I..\include				\
			/I..\win32					\
			/I$(INTDIR)					\
			/I..\..\include\$(PLATFORM)	\
			/I..\..\include\$(PLATFORM_DEF)	\
			/I..\..\include				\
			/I..\..\somidl\$(PLATFORM)	\
			/I..\..\somddmsg\include	\
			/I..\..\somcdr\include		\
			/I..\..\somcdr\$(PLATFORM)\$(BUILDTYPE)	\
			/I..\..\somddmsg\$(PLATFORM)\$(BUILDTYPE) \
			/I..\..\somtc				\
			/I..\..\rhbexecd\include	\
			/I..\..\rhbutils\include	\
			/I..\..\rhbmtut\include		\
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
			 $(OUTDIR)\$(APPNAME).lib
	
$(TARGET_EXE): $(OBJS) $(OUTDIR) $(INTDIR)\$(APPNAME).res
	$(CC) $(CC_OUT_EXE)$@ $(OBJS)	\
		$(CC_OUT_PDB)$(TARGET_PDB)	\
		$(CC_LINK)					\
		$(LD_SUBSYSTEM_CONSOLE)		\
		$(INTDIR)\$(APPNAME).res	\
		$(LDFLAGS) 
	$(POSTLINK_EXE) $@

$(INTDIR)\rhbsomdd.obj: ..\src\rhbsomdd.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\rhbsomdd.c

$(INTDIR)\implreps.obj: ..\src\implreps.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\implreps.c

$(INTDIR)\somddevm.obj: ..\src\somddevm.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\somddevm.c

$(INTDIR)\somddior.obj: ..\src\somddior.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\somddior.c

$(INTDIR)\somddrep.obj: ..\src\somddrep.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\somddrep.c

$(INTDIR)\somddsrv.obj: ..\src\somddsrv.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\somddsrv.c

$(INTDIR)\somddtc.obj: ..\src\somddtc.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\somddtc.c

$(INTDIR)\somddw32.obj: ..\src\somddw32.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\somddw32.c

$(INTDIR)\rhbexecd.obj: ..\..\rhbexecd\src\rhbexecd.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\..\rhbexecd\src\rhbexecd.c

$(INTDIR)\rhbexec.obj: ..\src\rhbexec.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\rhbexec.c

$(INTDIR)\winerror.obj: ..\..\rhbutils\src\winerror.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\..\rhbutils\src\winerror.c

$(INTDIR)\link386.obj: ..\win32\link386.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\win32\link386.c

$(INTDIR):
	mkdir $@

$(INTDIR)\$(APPNAME).res: ..\win32\$(APPNAME).rc
	rc /nologo $(RCFLAGS) /r /I.. /I..\..\include\$(PLATFORM) /fo$@ ..\win32\$(APPNAME).rc

dist:




test:

