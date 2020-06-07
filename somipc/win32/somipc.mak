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

APPNAME=somipc

OBJS=	$(INTDIR)\rhbidl.obj		\
		$(INTDIR)\rhbsc.obj	\
		$(INTDIR)\rhbscapi.obj	\
		$(INTDIR)\rhbscemt.obj	\
		$(INTDIR)\rhbschdr.obj	\
		$(INTDIR)\rhbscir.obj	\
		$(INTDIR)\rhbsckih.obj	\
		$(INTDIR)\rhbscpp.obj	\
		$(INTDIR)\rhbsctc.obj	\
		$(INTDIR)\rhbsctyp.obj

TARGET_EXE=$(OUTDIR)\$(APPNAME).exe
TARGET_PDB=$(OUTDIR)\$(APPNAME).pdb

PARTOPTS=	$(STDOPTXX)					\
			/DHAVE_CONFIG_HPP			\
			/D_CONSOLE					\
			/DWIN32_LEAN_AND_MEAN		\
			/I..\..\include\$(PLATFORM)	\
			/I..\..\include\$(PLATFORM_DEF)	\
			/I..\..\include				\
			/I..\include				\
			/I..\..\somirfmt\include	\
			$(CC_OUT_PDB)$(TARGET_PDB)

all: $(TARGET_EXE)

clean:
	$(CLEAN) $(TARGET_EXE)				\
			 $(TARGET_PDB)				\
			 $(OBJS)					\
			 $(INTDIR)\$(APPNAME).res	\
			 $(OUTDIR)\$(APPNAME).lib	\
			 $(OUTDIR)\$(APPNAME).exp
	
$(TARGET_EXE): $(OBJS) $(OUTDIR) $(INTDIR)\$(APPNAME).res
	$(CC) $(CC_OUT_EXE)$@ $(OBJS)		\
		  $(CC_OUT_PDB)$(TARGET_PDB)	\
		  $(CC_LINK)					\
		  $(LD_SUBSYSTEM_CONSOLE)		\
		  $(LD_ENTRY_MAIN) \
		  $(LDFLAGS) $(INTDIR)\$(APPNAME).res
	$(POSTLINK_EXE) $@

$(INTDIR)\rhbidl.obj: ..\src\rhbidl.cpp $(INTDIR)
	$(CXX) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\rhbidl.cpp

$(INTDIR)\rhbsc.obj: ..\src\rhbsc.cpp $(INTDIR)
	$(CXX) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\rhbsc.cpp

$(INTDIR)\rhbscapi.obj: ..\src\rhbscapi.cpp $(INTDIR)
	$(CXX) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\rhbscapi.cpp

$(INTDIR)\rhbscemt.obj: ..\src\rhbscemt.cpp $(INTDIR)
	$(CXX) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\rhbscemt.cpp

$(INTDIR)\rhbschdr.obj: ..\src\rhbschdr.cpp $(INTDIR)
	$(CXX) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\rhbschdr.cpp

$(INTDIR)\rhbscir.obj: ..\src\rhbscir.cpp $(INTDIR)
	$(CXX) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\rhbscir.cpp

$(INTDIR)\rhbsckih.obj: ..\src\rhbsckih.cpp $(INTDIR)
	$(CXX) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\rhbsckih.cpp

$(INTDIR)\rhbscpp.obj: ..\src\rhbscpp.cpp $(INTDIR)
	$(CXX) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\rhbscpp.cpp

$(INTDIR)\rhbsctc.obj: ..\src\rhbsctc.cpp $(INTDIR)
	$(CXX) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\rhbsctc.cpp

$(INTDIR)\rhbsctyp.obj: ..\src\rhbsctyp.cpp $(INTDIR)
	$(CXX) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\rhbsctyp.cpp

$(INTDIR):
	mkdir $@

$(INTDIR)\$(APPNAME).res: ..\win32\$(APPNAME).rc
	rc /nologo /r /I.. /I..\..\include\$(PLATFORM) /fo$@ ..\win32\$(APPNAME).rc

dist:


test:
