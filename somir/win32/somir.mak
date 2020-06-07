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

DLLNAME=somir

TARGET_DLL=$(OUTDIR)\$(DLLNAME).dll
TARGET_PDB=$(OUTDIR)\$(DLLNAME).pdb
TARGET_DEF=..\$(PLATFORM_DEF)\$(DLLNAME).def

PARTOPTS=	$(STDOPT)								\
			/DWIN32_LEAN_AND_MEAN 					\
			/DBUILD_SOMIR							\
			/DHAVE_CONFIG_H							\
			/I$(INTDIR)								\
			/I..\include							\
			/I..\..\include\$(PLATFORM)				\
			/I..\..\include\$(PLATFORM_DEF)			\
			/I..\..\include							\
			/I..\..\somidl\$(PLATFORM)				\
			/I..\..\somirfmt\include				\
			/I..\..\rhbiniut\include				\
			/I..\..\somtc\include					\
			/I..\..\rhbmtut\include					\
			/I..\..\somkpub\include					\
			/I..\..\somtk\include					\
			$(CC_OUT_PDB)$(TARGET_PDB)
		
OBJS=	$(INTDIR)\rhbsomir.obj	\
		$(INTDIR)\repostry.obj	\
		$(INTDIR)\containd.obj	\
		$(INTDIR)\containr.obj	\
		$(INTDIR)\constdef.obj	\
		$(INTDIR)\excptdef.obj	\
		$(INTDIR)\paramdef.obj	\
		$(INTDIR)\typedef.obj	\
		$(INTDIR)\operatdf.obj	\
		$(INTDIR)\attribdf.obj	\
		$(INTDIR)\intfacdf.obj	\
		$(INTDIR)\moduledf.obj	\
		$(INTDIR)\somirfmt.obj	\
		$(INTDIR)\link386.obj

all: $(TARGET_DLL)

clean:
	$(CLEAN)	$(TARGET_DLL)				\
				$(TARGET_PDB)				\
				$(OBJS)						\
				$(OUTDIR)\$(DLLNAME).exp	\
				$(OUTDIR)\$(DLLNAME).lib	\
				$(INTDIR)\$(DLLNAME).res
	
$(TARGET_DLL): $(OBJS) $(OUTDIR) $(TARGET_DEF) $(INTDIR)\$(DLLNAME).res
	$(CC) $(CC_OUT_DLL)$@ $(OBJS)		\
			$(CC_OUT_PDB)$(TARGET_PDB)	\
			$(CC_LINK)					\
			$(LDFLAGS)					\
			$(LD_DEF)$(TARGET_DEF)		\
			$(INTDIR)\$(DLLNAME).res
	$(POSTLINK_DLL) $@

$(INTDIR)\rhbsomir.obj: ..\src\rhbsomir.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\rhbsomir.c

$(INTDIR)\repostry.obj: ..\src\repostry.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\repostry.c

$(INTDIR)\containd.obj: ..\src\containd.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\containd.c

$(INTDIR)\containr.obj: ..\src\containr.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\containr.c

$(INTDIR)\constdef.obj: ..\src\constdef.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\constdef.c

$(INTDIR)\typedef.obj: ..\src\typedef.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\typedef.c

$(INTDIR)\paramdef.obj: ..\src\paramdef.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\paramdef.c

$(INTDIR)\excptdef.obj: ..\src\excptdef.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\excptdef.c

$(INTDIR)\operatdf.obj: ..\src\operatdf.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\operatdf.c

$(INTDIR)\attribdf.obj: ..\src\attribdf.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\attribdf.c

$(INTDIR)\intfacdf.obj: ..\src\intfacdf.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\intfacdf.c

$(INTDIR)\moduledf.obj: ..\src\moduledf.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\moduledf.c

$(INTDIR)\somirfmt.obj: ..\..\somirfmt\src\somirfmt.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\..\somirfmt\src\somirfmt.c

$(INTDIR)\rhbiniut.obj: ..\..\rhbiniut\src\rhbiniut.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\..\rhbiniut\src\rhbiniut.c

$(INTDIR)\link386.obj: ..\win32\link386.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\win32\link386.c

$(INTDIR):
	mkdir $@

$(INTDIR)\$(DLLNAME).res: ..\win32\$(DLLNAME).rc
	rc /nologo /r /I.. /I..\..\include\$(PLATFORM) /fo$@ ..\win32\$(DLLNAME).rc

dist:




test:

