#!/bin/sh
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
# $Id$
#

SHLB_REF_STRONG=$OUTDIR/lib:$OUTDIR/implib
SHLB_REF_WEAK=

PLATFORM_SCFLAGS="-D_PLATFORM_UNIX_"

X11CONTENDERS="/usr/X11R6 /opt/X11R6"

. ../../toolbox/findlibs.sh

if test "$THREADLIBS" != ""
then
	CONFIG_LIBS="$THREADLIBS $CONFIG_LIBS"
	MAKEDEFS_DEFS="$MAKEDEFS_DEFS CONFIG_LIBS"
fi

if test "$UUIDLIBS" != ""
then
	HAVE_LIBUUID=true
	MAKEDEFS_DEFS="$MAKEDEFS_DEFS UUIDLIBS"
fi

if test "$HAVE_LIBUUID" = ""
then
	HAVE_LIBUUID=false
fi

MAKEDEFS_DEFS="$MAKEDEFS_DEFS HAVE_LIBUUID"

MAKEDEFS_EXPORTS="$MAKEDEFS_EXPORTS SHLB_REF_STRONG"
MAKEDEFS_EXPORTS="$MAKEDEFS_EXPORTS SHLB_REF_WEAK"
MAKEDEFS_DEFS="$MAKEDEFS_DEFS PLATFORM_SCFLAGS"
MAKEDEFS_DEFS="$MAKEDEFS_DEFS PLATFORM_CFLAGS PLATFORM_CXXFLAGS"
