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

## ROOT MAKEFILE ##

MAKEDEFS_SH=makedefs.sh
MAKEDEFS_DIR=makedefs/unix

default: all

all clean config install dist test: nosuch $(MAKEDEFS_DIR)/$(MAKEDEFS_SH)
	chmod +x $(MAKEDEFS_DIR)/$(MAKEDEFS_SH)
	cd $(MAKEDEFS_DIR); \
	MAKE="$(MAKE)" \
	CXX="$(CXX)" \
	CC="$(CC)" \
	CFLAGS="$(CFLAGS)" \
	CXXFLAGS="$(CXXFLAGS)" \
	RANLIB="$(RANLIB)" \
	AR="$(AR)" \
	ARFLAGS="$(ARFLAGS)" \
	LD="$(LD)" \
	LDFLAGS="$(LDFLAGS)" \
	BUILDARCH="$(BUILDARCH)" \
	BUILDTYPE="$(BUILDTYPE)" \
	BUILDTYPE_HOST="$(BUILDTYPE_HOST)" \
	PLATFORM="$(PLATFORM)" \
	PLATFORM_HOST="$(PLATFORM_HOST)" \
	OUTDIR="$(OUTDIR)" \
	./$(MAKEDEFS_SH) $@

generic:
	PLATFORM=generic PLATFORM_HOST=generic $(MAKE)

nosuch:


## EOF ##
