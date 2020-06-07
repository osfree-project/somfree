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

DLLNAME=som

TARGET_DLL=$(OUTDIR)\$(DLLNAME).dll
TARGET_PDB=$(OUTDIR)\$(DLLNAME).pdb
TARGET_MAP=$(INTDIR)\$(DLLNAME).map
TARGET_DEF=..\$(PLATFORM_DEF)\$(DLLNAME).def

PARTOPTS=	$(STDOPT)								\
			/DWIN32_LEAN_AND_MEAN 					\
			/DBUILD_SOM								\
			/DHAVE_CONFIG_H							\
			/I$(INTDIR)								\
			/I..\win32								\
			/I..\include							\
			/I..\src								\
			/I..\..\include\$(PLATFORM)				\
			/I..\..\include\$(PLATFORM_DEF)			\
			/I..\..\include							\
			/I..\..\somidl\$(PLATFORM)				\
			/I..\..\somcdr\$(PLATFORM)\$(BUILDTYPE)	\
			/I..\..\somcdr\include					\
			/I..\..\somcdr\src						\
			/I..\..\rhbmtut\include					\
			/I..\..\somkpub\include					\
			/I..\..\somtk\include					\
			$(CC_OUT_PDB)$(TARGET_PDB)	

OBJS=	$(INTDIR)\somkern.obj	\
		$(INTDIR)\somthunk.obj	\
		$(INTDIR)\somalloc.obj	\
		$(INTDIR)\somobjva.obj	\
		$(INTDIR)\somshlb.obj	\
		$(INTDIR)\somkpath.obj	\
		$(INTDIR)\sommutex.obj	\
		$(INTDIR)\somapi.obj	\
		$(INTDIR)\rhbsomid.obj	\
		$(INTDIR)\link386.obj

all: $(TARGET_DLL)

clean:
	$(CLEAN) $(TARGET_DLL) $(TARGET_PDB) $(TARGET_MAP) $(OBJS) $(INTDIR)\$(DLLNAME).res $(OUTDIR)\$(DLLNAME).exp $(OUTDIR)\$(DLLNAME).lib
	
$(TARGET_DLL): $(OBJS) $(OUTDIR) $(TARGET_DEF) $(INTDIR)\$(DLLNAME).res
	$(CC) $(CC_OUT_DLL)$@ $(OBJS)		\
			$(INTDIR)\$(DLLNAME).res	\
			$(CC_OUT_PDB)$(TARGET_PDB)	\
			$(CC_LINK)					\
			$(LDFLAGS)					\
			$(LD_DEF)$(TARGET_DEF)
	$(POSTLINK_DLL) $@

$(INTDIR)\somkern.obj: ..\src\somkern.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\somkern.c

$(INTDIR)\somobjva.obj: ..\src\somobjva.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\somobjva.c

$(INTDIR)\somalloc.obj: ..\src\somalloc.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\somalloc.c

$(INTDIR)\sommutex.obj: ..\src\sommutex.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\sommutex.c

$(INTDIR)\somapi.obj: ..\src\somapi.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\somapi.c

$(INTDIR)\somshlb.obj: ..\src\somshlb.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\somshlb.c

$(INTDIR)\somkpath.obj: ..\src\somkpath.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\somkpath.c

$(INTDIR)\somthunk.obj: ..\win32\somthunk.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\win32\somthunk.c

$(INTDIR)\rhbsomid.obj: ..\..\somid\src\rhbsomid.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\..\somid\src\rhbsomid.c

$(INTDIR)\link386.obj: ..\win32\link386.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\win32\link386.c

$(INTDIR):
	mkdir $@

$(INTDIR)\$(DLLNAME).res: ..\win32\$(DLLNAME).rc
	rc /nologo /r /I.. /I..\..\include\$(PLATFORM) /fo$@ ..\win32\$(DLLNAME).rc

dist:




test:

