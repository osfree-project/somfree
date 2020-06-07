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

!IF "$(BUILDTYPE)" == ""
BUILDTYPE=Debug
!ENDIF

!IF "$(BUILDARCH)" == ""
BUILDARCH=Win32
!ENDIF

!IF "$(PLATFORM)" == ""
PLATFORM=win32
!ENDIF

!IF "$(MAKEDEFS)" == ""
MAKEDEFS=..\..\makedefs\$(PLATFORM)\$(BUILDTYPE)\makedefs.mk
!ENDIF

!INCLUDE $(MAKEDEFS)

!IF "$(PLATFORM_MAKEFILE)" == ""
PLATFORM_MAKEFILE=win32
!ENDIF

!IF "$(CC)" == ""
CC=cl.exe
!ENDIF

XARGS_EXE=$(RHBTOOLS_BIN)\xargs.exe
FIND_EXE=$(RHBTOOLS_BIN)\find.exe
DEPENDS_EXE=$(RHBTOOLS_BIN)\depends.exe

MAKEDEFS_LST=..\$(PLATFORM)\$(BUILDTYPE)\makedefs.lst
MAKEDEFS_CFL=..\$(PLATFORM)\$(BUILDTYPE)\makedefs.cfl

STD_DIRS=$(OUTDIR_BASE)			\
		 $(OUTDIR_BIN)			\
		 $(OUTDIR_SBIN)			\
		 $(OUTDIR_ETC)			\
		 $(OUTDIR_INCLUDE)		\
		 $(OUTDIR_LIB)			\
		 $(OUTDIR_TESTS)		\
		 $(OUTDIR_DIST)			\
		 $(OUTDIR_TOOLS)

all: $(STD_DIRS) $(MAKEDEFS_LST) checkenv allparts

$(STD_DIRS):
	mkdir $@

clean: 
	set MAKE=$(MAKE)
	set PLATFORM=$(PLATFORM)
	set BUILDARCH=$(BUILDARCH)
	set BUILDTYPE=$(BUILDTYPE)
	set MAKEDEFS=$(MAKEDEFS)
	set PLATFORM_HOST=$(PLATFORM_HOST)
	set RHBTOOLS_BIN=$(RHBTOOLS_BIN)
	set SOMTOOLS_BIN=$(SOMTOOLS_BIN)
	cd ..\..\makedefs\win32
	if exist $(MAKEDEFS_LST) if exist "$(XARGS_EXE)" "$(XARGS_EXE)" -n 1 makepart.bat clean <$(MAKEDEFS_LST) 
	$(CLEAN) $(MAKEDEFS_LST)
	$(CLEAN) $(MAKEDEFS_CFL)
	$(CLEAN) $(OUTDIR_BIN)\*.lib
	$(CLEAN) $(OUTDIR_BIN)\*.exp
	if exist $(OUTDIR_ETC) rmdir $(OUTDIR_ETC)
	if exist $(OUTDIR_BIN) rmdir $(OUTDIR_BIN)
	if exist $(OUTDIR_SBIN) rmdir $(OUTDIR_SBIN)
	if exist $(OUTDIR_INCLUDE) rmdir $(OUTDIR_INCLUDE)
	if exist $(OUTDIR_LIB) rmdir $(OUTDIR_LIB)
	if exist $(OUTDIR_TESTS) rmdir $(OUTDIR_TESTS)
	if exist $(OUTDIR_TOOLS) rmdir $(OUTDIR_TOOLS)
	if exist $(OUTDIR_DIST) rmdir $(OUTDIR_DIST)
	if exist $(OUTDIR_BASE) rmdir $(OUTDIR_BASE)
 
allparts: 
	set MAKE=$(MAKE)
	set PLATFORM=$(PLATFORM)
	set BUILDARCH=$(BUILDARCH)
	set BUILDTYPE=$(BUILDTYPE)
	set MAKEDEFS=$(MAKEDEFS)
	set PLATFORM_MAKEFILE=$(PLATFORM_MAKEFILE)
	set PLATFORM_HOST=$(PLATFORM_HOST)
	set RHBTOOLS_BIN=$(RHBTOOLS_BIN)
	set SOMTOOLS_BIN=$(SOMTOOLS_BIN)
	cd ..\..\makedefs\win32
	"$(XARGS_EXE)" -n 1 <$(MAKEDEFS_LST) makepart.bat all

dist test: 
	set MAKE=$(MAKE)
	set PLATFORM=$(PLATFORM)
	set BUILDARCH=$(BUILDARCH)
	set BUILDTYPE=$(BUILDTYPE)
	set MAKEDEFS=$(MAKEDEFS)
	set PLATFORM_MAKEFILE=$(PLATFORM_MAKEFILE)
	set PLATFORM_HOST=$(PLATFORM_HOST)
	set RHBTOOLS_BIN=$(RHBTOOLS_BIN)
	set SOMTOOLS_BIN=$(SOMTOOLS_BIN)
	cd ..\..\makedefs\win32
	"$(XARGS_EXE)" -n 1 <$(MAKEDEFS_LST) makepart.bat $@

makepart:
	set PART=$(PART)
	set ACTION=$(ACTION)
	set MAKE=$(MAKE)
	set CFG="$(PART) - $(BUILDARCH) $(BUILDTYPE)"
	set PLATFORM=$(PLATFORM)
	set PLATFORM_MAKEFILE=$(PLATFORM_MAKEFILE)
	set PLATFORM_HOST=$(PLATFORM_HOST)
	set BUILDARCH=$(BUILDARCH) 
	set BUILDTYPE=$(BUILDTYPE) 
	set MAKEDEFS=$(MAKEDEFS)
	set RHBTOOLS_BIN=$(RHBTOOLS_BIN)
	set SOMTOOLS_BIN=$(SOMTOOLS_BIN)
	set CC=$(CC)
	set CPP=$(CC)
	set INCLUDE=$(INCLUDE)
	set LIB=$(OUTDIR_LIB);$(OUTDIR_DLL);$(LIB)
	call ..\win32\makepart.bat makepart $(PART) $(ACTION)
 
checkenv:
	if "$(OUTDIR_DIST)" == "" exit 1
	if "$(OUTDIR_BASE)" == "" exit 1
	if "$(OUTDIR_BIN)" == "" exit 1
	if "$(OUTDIR_SBIN)" == "" exit 1
	if "$(OUTDIR_LIB)" == "" exit 1
	if "$(OUTDIR_TOOLS)" == "" exit 1
	if "$(OUTDIR_DLL)" == "" exit 1
	if "$(OUTDIR_ETC)" == "" exit 1
	if "$(OUTDIR_TESTS)" == "" exit 1
	if "$(OUTDIR_INCLUDE)" == "" exit 1

$(MAKEDEFS_LST): $(MAKEDEFS_CFL)
	"$(DEPENDS_EXE)" <$(MAKEDEFS_CFL) >$@

$(MAKEDEFS_CFL): "$(FIND_EXE)" "$(DEPENDS_EXE)"
	"$(FIND_EXE)" ..\.. -name makedefs.cf >$@

