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

COMMONOPTS=/W3 /MD /DNDEBUG /DWIN32 /D_WIN32_DCOM /D_WIN32_WINNT=0x600 /D_CRT_SECURE_NO_DEPRECATE /Zp8 /D_PLATFORM_LITTLE_ENDIAN_ /D_PLATFORM_WIN32_ /D_CRT_NONSTDC_NO_DEPRECATE /D_WINSOCK_DEPRECATED_NO_WARNINGS
STDOPT=$(COMMONOPTS) /WX
STDOPTXX=$(COMMONOPTS)  /EHa
CC=cl.exe /nologo
CXX=$(CC) 
MKTYPLIB=midl.exe /mktyplib203
MKTYPLIB_FLAGS=/env x64
MIDL_FLAGS=/ms_ext /c_ext /env x64
CONFIG_OPTS=/WX $(COMMONOPTS) ws2_32.lib
LDFLAGS=/MACHINE:X64 /INCREMENTAL:NO /NOLOGO
RCFLAGS=/DNDEBUG
PLATFORM_DEF=win32
POSTLINK_EXE=..\..\makedefs\$(PLATFORM)\postlink.bat 1
POSTLINK_DLL=..\..\makedefs\$(PLATFORM)\postlink.bat 2

!INCLUDE ..\..\makedefs\$(PLATFORM_DEF)\makedefs.mk
