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

COMMONOPTS=/W3 /MDd /Zp8 /Zi /D_DEBUG /DWIN32 /D_WIN32_DCOM /D_WIN32_WINNT=0x600 /D_CRT_SECURE_NO_DEPRECATE /D_CRT_NONSTDC_NO_DEPRECATE /D_PLATFORM_LITTLE_ENDIAN_ /D_PLATFORM_WIN32_ 
STDOPT=$(COMMONOPTS) /WX 
STDOPTXX=$(COMMONOPTS)  /EHa
CC=cl.exe /nologo
CXX=$(CC)  
CC_OUT_EXE=/Zi /Fe
CC_OUT_DLL=/Zi /LDd /Fe
LDFLAGS=/MACHINE:IX86 /INCREMENTAL:NO /NOLOGO /DEBUG
MKTYPLIB=midl.exe /mktyplib203
MKTYPLIB_FLAGS=
CONFIG_OPTS=/WX $(COMMONOPTS) ws2_32.lib
RCFLAGS=/D_DEBUG
PLATFORM_DEF=win32
POSTLINK_EXE=..\..\makedefs\$(PLATFORM)\postlink.bat 1
POSTLINK_DLL=..\..\makedefs\$(PLATFORM)\postlink.bat 2

!INCLUDE ..\..\makedefs\$(PLATFORM_DEF)\makedefs.mk
