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

DLLNAME=somp

TARGET_DLL=$(OUTDIR)\$(DLLNAME).dll
TARGET_PDB=$(OUTDIR)\$(DLLNAME).pdb
TARGET_DEF=..\$(PLATFORM_DEF)\$(DLLNAME).def

PARTOPTS=	$(STDOPT)								\
			/DWIN32_LEAN_AND_MEAN 					\
			/DBUILD_SOMP							\
			/DHAVE_CONFIG_H							\
			/I$(INTDIR)								\
			/I..\include							\
			/I..\..\include\$(PLATFORM)				\
			/I..\..\include\$(PLATFORM_DEF)			\
			/I..\..\include							\
			/I..\..\somidl\$(PLATFORM)				\
			/I..\..\somkpub\include					\
			/I..\..\somtk\include					\
			$(CC_OUT_PDB)$(TARGET_PDB)

OBJS=	$(INTDIR)\rhbsomp.obj	\
		$(INTDIR)\defedidl.obj	\
		$(INTDIR)\eda.obj \
		$(INTDIR)\fma.obj \
		$(INTDIR)\fmi.obj \
		$(INTDIR)\fmib.obj \
		$(INTDIR)\fsagm.obj \
		$(INTDIR)\fsgm.obj \
		$(INTDIR)\iogma.obj \
		$(INTDIR)\iogrp.obj \
		$(INTDIR)\mia.obj \
		$(INTDIR)\nsma.obj \
		$(INTDIR)\objset.obj \
		$(INTDIR)\pid.obj \
		$(INTDIR)\po.obj \
		$(INTDIR)\poid.obj \
		$(INTDIR)\poida.obj \
		$(INTDIR)\psma.obj \
		$(INTDIR)\srkset.obj \
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

$(INTDIR)\rhbsomp.obj: ..\src\rhbsomp.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\rhbsomp.c

$(INTDIR)\defedidl.obj: ..\src\defedidl.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\defedidl.c

$(INTDIR)\srkset.obj: ..\src\srkset.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\srkset.c

$(INTDIR)\psma.obj: ..\src\psma.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\psma.c

$(INTDIR)\poida.obj: ..\src\poida.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\poida.c

$(INTDIR)\poid.obj: ..\src\poid.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\poid.c

$(INTDIR)\pid.obj: ..\src\pid.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\pid.c

$(INTDIR)\po.obj: ..\src\po.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\po.c

$(INTDIR)\mia.obj: ..\src\mia.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\mia.c

$(INTDIR)\objset.obj: ..\src\objset.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\objset.c

$(INTDIR)\iogrp.obj: ..\src\iogrp.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\iogrp.c

$(INTDIR)\iogma.obj: ..\src\iogma.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\iogma.c

$(INTDIR)\fsgm.obj: ..\src\fsgm.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\fsgm.c

$(INTDIR)\fsagm.obj: ..\src\fsagm.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\fsagm.c

$(INTDIR)\fmib.obj: ..\src\fmib.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\fmib.c

$(INTDIR)\eda.obj: ..\src\eda.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\eda.c

$(INTDIR)\fma.obj: ..\src\fma.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\fma.c

$(INTDIR)\fmi.obj: ..\src\fmi.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\fmi.c

$(INTDIR)\nsma.obj: ..\src\nsma.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\nsma.c

$(INTDIR)\link386.obj: ..\win32\link386.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\win32\link386.c

$(INTDIR):
	mkdir $@

$(INTDIR)\$(DLLNAME).res: ..\win32\$(DLLNAME).rc
	rc /nologo /r /I.. /I..\..\include\$(PLATFORM) /fo$@ ..\win32\$(DLLNAME).rc

dist:




test:

