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

STDINCL=-I. -I..  -I../../include/$(PLATFORM)/$(BUILDTYPE) -I../../include
CC_EXE=$(CC) $(CFLAGS)
CC_DLL=$(CC) $(CFLAGS) $(CC_FLAG_FPIC)
CXX_EXE=$(CXX) $(CXXFLAGS)
CXX_DLL=$(CXX) $(CXXFLAGS) $(CXX_FLAG_FPIC)
STDLIB=-lpthread -lc
STDLIBXX=-lpthread -lc
DLLPREFIX=$(SHLIBPREFIX)
DLLSUFFIX=$(SHLIBSUFFIX)
STDCONFIGOPTS=-D_PLATFORM_UNIX_ -D_XOPEN_SOURCE_EXTENDED
STDOPT=$(PLATFORM_CFLAGS) $(MAKEDEFS_CFLAGS) $(STDCONFIGOPTS)
STDOPTXX=$(PLATFORM_CXXFLAGS) $(MAKEDEFS_CXXFLAGS) $(STDCONFIGOPTS)
LINKDLL=MAKE=$(MAKE) CFLAGS="$(CFLAGS)" INTDIR="$(INTDIR)" ../../makedefs/$(PLATFORM_PROTO)/linktool.sh 
LINKDLLXX=MAKE=$(MAKE) CFLAGS="$(CFLAGS)" CXXFLAGS="$(CXXFLAGS)" INTDIR="$(INTDIR)" ../../makedefs/$(PLATFORM_PROTO)/linktool.sh -cxx 
#LINKAPP=../../toolbox/asneeded.sh ../../toolbox/ldhppa.sh $(CC) $(CFLAGS)
#LINKAPPXX=../../toolbox/asneeded.sh ../../toolbox/ldhppa.sh $(CXX) $(CXXFLAGS)
LINKAPP=MAKE="$(MAKE)" INTDIR="$(INTDIR)" ../../makedefs/$(PLATFORM_PROTO)/linktool.sh
LINKAPPXX=MAKE="$(MAKE)" INTDIR="$(INTDIR)" ../../makedefs/$(PLATFORM_PROTO)/linktool.sh -cxx
LINKDLL_HEAD=-shared
LINKDLL_TAIL=-L$(OUTDIR_IMPLIB)
AR=ar
