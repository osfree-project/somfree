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

if test "$OUTDIR" = ""
then
	echo 1>&2 OUTDIR not set
	exit 1
fi

SHLB_REF_STRONG=$OUTDIR/lib:$OUTDIR/implib
SHLB_REF_WEAK=

if test "$RANLIB" = ""
then
	RANLIB=ranlib
fi

first()
{
	echo "$1"
}

platform_getcflag()
{
	GCF_LAST=

	for gcf in $CFLAGS $PLATFORM_CFLAGS
	do
		if test "$GCF_LAST" = ""
		then
			case "$gcf" in
			-* )
					GCF_LAST="$gcf"
					;;
			* )
					;;
			esac
		else
			if test "$GCF_LAST" = "$1"
			then
				echo $gcf
			fi
			GCF_LAST=
		fi
	done 
}

if test "$PLATFORM_ISYSROOT" = ""
then
	PLATFORM_ISYSROOT=`platform_getcflag -isysroot`
fi

echo PLATFORM_ISYSROOT=$PLATFORM_ISYSROOT 1>&2

platform_not_member()
{
    platform_not_member_1=$1
    shift
    for platform_not_member_i in $@
    do
        if test "$platform_not_member_1" = "$platform_not_member_i"
        then
            return 1
        fi
    done
    return 0
}

if test "$MACOSX_DEPLOYMENT_TARGET" = ""
then
	if test -z "$PLATFORM_ISYSROOT"
	then
		RELEASE=`uname -r | sed y/./\ /`
		RELEASE=`first $RELEASE`
		RELEASE=`echo $RELEASE-4 | bc`
		MACOSX_DEPLOYMENT_TARGET=10.$RELEASE
		echo MACOSX_DEPLOYMENT_TARGET is guessed at "$MACOSX_DEPLOYMENT_TARGET"
	else
		echo MACOSX_DEPLOYMENT_TARGET not defined, "PLATFORM_ISYSROOT=$PLATFORM_ISYSROOT"
	fi
fi

echo MACOSX_DEPLOYMENT_TARGET is $MACOSX_DEPLOYMENT_TARGET
export MACOSX_DEPLOYMENT_TARGET

if platform_not_member MACOSX_DEPLOYMENT_TARGET $MAKEDEFS_EXPORTS
then
	MAKEDEFS_EXPORTS="$MAKEDEFS_EXPORTS MACOSX_DEPLOYMENT_TARGET"
fi

if platform_not_member -D_REENTRANT $CFLAGS $PLATFORM_CFLAGS
then
    PLATFORM_CFLAGS="$PLATFORM_CFLAGS -D_REENTRANT"
fi

if platform_not_member -D_REENTRANT $CXXFLAGS $PLATFORM_CXXFLAGS
then
    PLATFORM_CXXFLAGS="$PLATFORM_CXXFLAGS -D_REENTRANT"
fi

if platform_not_member -D_PLATFORM_DARWIN_ $CFLAGS $PLATFORM_CFLAGS
then
    PLATFORM_CFLAGS="$PLATFORM_CFLAGS -D_PLATFORM_DARWIN_"
fi

if platform_not_member -D_PLATFORM_DARWIN_ $CXXFLAGS $PLATFORM_CXXFLAGS
then
    PLATFORM_CXXFLAGS="$PLATFORM_CXXFLAGS -D_PLATFORM_DARWIN_"
fi

if platform_not_member -D_PLATFORM_UNIX_ $PLATFORM_SCFLAGS
then
	PLATFORM_SCFLAGS="$PLATFORM_SCFLAGS -D_PLATFORM_UNIX_"
fi

if platform_not_member RANLIB $MAKEDEFS_EXPORTS
then
	MAKEDEFS_EXPORTS="$MAKEDEFS_EXPORTS RANLIB"
fi

LIBPREFIX=lib
LIBSUFFIX=.dylib

MAKEDEFS_EXPORTS="$MAKEDEFS_EXPORTS LIBPREFIX LIBSUFFIX SHLB_REF_STRONG SHLB_REF_WEAK"
MAKEDEFS_EXPORTS="$MAKEDEFS_EXPORTS PLATFORM_CFLAGS PLATFORM_CXXFLAGS"

. ../../toolbox/findlibs.sh

if test "$THREADLIBS" != ""
then
	MAKEDEFS_DEFS="$MAKEDEFS_DEFS $THREADLIBS"
fi

if test "$OBJCLIBS" != ""
then
	MAKEDEFS_DEFS="$MAKEDEFS_DEFS OBJCLIBS"
	HAVE_LIBOBJC=true
fi

MAKEDEFS_DEFS="$MAKEDEFS_DEFS PLATFORM_SCFLAGS"

if test "$DLLIBS" != ""
then
	MAKEDEFS_DEFS="$MAKEDEFS_DEFS DLLIBS"
fi

if test "$CFLIBS" != ""
then
	MAKEDEFS_DEFS="$MAKEDEFS_DEFS CFLIBS"
fi

if test "$PLATFORM_ISYSROOT" != ""
then
	MAKEDEFS_DEFS="$MAKEDEFS_DEFS PLATFORM_ISYSROOT"
fi

if test "$HAVE_LIBUUID" = ""
then
	HAVE_LIBUUID=false
fi

if test "$HAVE_LIBOBJC" = ""
then
	HAVE_LIBOBJC=false
fi

FRAMEWORK_VERS=A

echo FRAMEWORK_VERS="$FRAMEWORK_VERS"

export FRAMEWORK_VERS

MAKEDEFS_DEFS="$MAKEDEFS_DEFS HAVE_LIBUUID HAVE_LIBOBJC FRAMEWORK_VERS"
