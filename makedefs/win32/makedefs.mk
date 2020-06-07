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

!IF "$(PLATFORM_DEF)" == ""
PLATFORM_DEF=win32
!ENDIF

!IF "$(CC)" == ""
CC=cl.exe /nologo
!ENDIF

!IF "$(CXX)" == ""
CXX=$(CC)
!ENDIF

!IF "$(CC_OUT_OBJ)" == ""
CC_OUT_OBJ=/Fo
!ENDIF

!IF "$(CC_OUT_EXE)" == ""
CC_OUT_EXE=/Fe
!ENDIF

!IF "$(CC_OUT_DLL)" == ""
CC_OUT_DLL=/LD /Fe
!ENDIF

!IF "$(CC_OUT_PDB)" == ""
CC_OUT_PDB=/Fd
!ENDIF

!IF "$(CC_OUT_MAP)" == ""
CC_OUT_MAP=/Fm
!ENDIF

!IF "$(CC_LINK)" == ""
CC_LINK=/link
!ENDIF

!IF "$(LD_DEF)" == ""
LD_DEF=/DEF:
!ENDIF

!IF "$(LD_SUBSYSTEM_CONSOLE)" == ""
LD_SUBSYSTEM_CONSOLE=/SUBSYSTEM:CONSOLE
!ENDIF

!IF "$(LDFLAGS)" == ""
LDFLAGS=/MACHINE:IX86 /INCREMENTAL:NO
!ENDIF

!IF "$(LD_PDB)" == ""
LD_PDB=/PDB:
!ENDIF

!IF "$(LD_DEF)" == ""
LD_DEF=/DEF:
!ENDIF

!IF "$(LD_PDB_NONE)" == ""
LD_PDB_NONE=$(LD_PDB)NONE
!ENDIF

!IF "$(LD_SUBSYSTEM_WINDOWS)" == ""
LD_SUBSYSTEM_WINDOWS=/SUBSYSTEM:WINDOWS
!ENDIF

!IF "$(PLATFORM_HOST)" == ""
PLATFORM_HOST=$(PLATFORM)
!ENDIF

!IF "$(BUILDTYPE_HOST)" == ""
BUILDTYPE_HOST=$(BUILDTYPE)
!ENDIF

!IF "$(RHBTOOLS_BIN)" == ""
RHBTOOLS_BIN=$(ProgramFiles)\rhubarb.geek.nz\RHBtools\bin
!ENDIF

!IF "$(OUTDIR_BASE)" == ""
OUTDIR_BASE=..\..\products\$(PLATFORM)\$(BUILDTYPE)
!ENDIF

!IF "$(HOSTDIR_BASE)" == ""
HOSTDIR_BASE=..\..\products\$(PLATFORM_HOST)\$(BUILDTYPE_HOST)
!ENDIF

OUTDIR_ETC=$(OUTDIR_BASE)\etc
OUTDIR_BIN=$(OUTDIR_BASE)\bin
OUTDIR_SBIN=$(OUTDIR_BASE)\sbin
OUTDIR_DLL=$(OUTDIR_BASE)\bin
OUTDIR_TOOLS=$(OUTDIR_BASE)\tools
OUTDIR_LIB=$(OUTDIR_BASE)\lib
OUTDIR_TESTS=$(OUTDIR_BASE)\tests
OUTDIR_DIST=$(OUTDIR_BASE)\dist
OUTDIR_INCLUDE=$(OUTDIR_BASE)\include
OUTDIR=c:\null
OUTDIR_SHLIB=c:\null

HOSTDIR_TESTS=$(HOSTDIR_BASE)\tests
HOSTDIR_TOOLS=$(HOSTDIR_BASE)\tools
HOSTDIR_BIN=$(HOSTDIR_BASE)\bin
HOSTDIR_DLL=$(HOSTDIR_BASE)\bin

!IF "$(SOMTOOLS_BIN)" == ""
SOMTOOLS_BIN=$(OUTDIR_BASE)\bin
!ENDIF

!IF "$(MIDL)" == ""
MIDL=midl.exe
!ENDIF

!IF "$(MIDL_FLAGS)" == ""
MIDL_FLAGS=/ms_ext /c_ext
!ENDIF

!IF "$(CLEAN)" == ""
CLEAN=..\..\makedefs\$(PLATFORM)\clean.bat
!ENDIF

!IF "$(POSTLINK_EXE)" == ""
POSTLINK_EXE=..\..\makedefs\$(PLATFORM_DEF)\postlink.bat
!ENDIF

!IF "$(POSTLINK_DLL)" == ""
POSTLINK_DLL=..\..\makedefs\$(PLATFORM_DEF)\postlink.bat
!ENDIF
