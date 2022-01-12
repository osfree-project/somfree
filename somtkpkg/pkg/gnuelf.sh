#!/bin/sh -e
#
#  Copyright 2011, Roger Brown
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

. ../version.sh

if test "$VERSION" = ""
then
	VERSION=0.0.0.1
fi

test -n "$PKGROOT"

FLAG=

INTDIR=.

for d in $@
do
	if test "$FLAG" = ""
	then
		FLAG="$d"
	else
		case "$FLAG" in
		-d )
			OUTDIR_DIST="$d"
			;;
		-r )
			OUTDIR="$d"
			;;
		-t )
			INTDIR="$d"
			;;
		* )
			unknown option $d
			exit 1
		esac
		FLAG=
	fi
done

../pkg/mkfs.sh -d "$OUTDIR_DIST" -t "$INTDIR" -r "$OUTDIR" -h "../../somidl/$PLATFORM"

find "$INTDIR" -print | xargs ls -ld

../../toolbox/dir2rpm.sh "$INTDIR" "$INTDIR/somtk.ir" "$OUTDIR_DIST" <<EOF
Summary: SOMTK Interface Repository
Name: somtk-ir
Version: $VERSION
Release: 1
Group: Applications/System
License: GPL
Prefix: /$PKGROOT

%description
Interface Repository for SOMTK

EOF

../../toolbox/dir2rpm.sh "$INTDIR" "$INTDIR/somtk.rte" "$OUTDIR_DIST" <<EOF
Summary: SOMTK RTE
Name: somtk-rte
Version: $VERSION
Release: 1
Group: Applications/System
License: GPL
Prefix: /$PKGROOT

%description
Runtime Environment for SOMTK

EOF

../../toolbox/dir2rpm.sh "$INTDIR" "$INTDIR/somtk.dsom" "$OUTDIR_DIST" <<EOF
Summary: SOMTK DSOM
Name: somtk-dsom
Version: $VERSION
Release: 1
Group: Applications/System
License: GPL
Prefix: /$PKGROOT

%description
CORBA ORB for SOMTK

EOF

../../toolbox/dir2rpm.sh "$INTDIR" "$INTDIR/somtk.util" "$OUTDIR_DIST" <<EOF
Summary: SOMTK Utils
Name: somtk-util
Version: $VERSION
Release: 1
Group: Applications/System
License: GPL
Prefix: /$PKGROOT

%description
Utilities for SOMTK

EOF

../../toolbox/dir2rpm.sh "$INTDIR" "$INTDIR/somtk.comp" "$OUTDIR_DIST" <<EOF
Summary: SOMTK Compiler
Name: somtk-comp
Version: $VERSION
Release: 1
Group: Applications/System
License: GPL
Prefix: /$PKGROOT

%description
IDL Compiler for SOMTK

EOF

../../toolbox/dir2rpm.sh "$INTDIR" "$INTDIR/somtk.dev" "$OUTDIR_DIST" <<EOF
Summary: SOMTK Development Library
Name: somtk-dev
Version: $VERSION
Release: 1
Group: Applications/System
License: GPL
Prefix: /$PKGROOT

%description
Developer library for SOMTK

EOF

DPKGARCH=`../../toolbox/pkgtool.sh dpkg-arch "$OUTDIR/bin/somipc"`

../../toolbox/dir2deb.sh "$INTDIR" "$INTDIR/somtk.comp" "$OUTDIR_DIST" <<EOF
Package: somtk-comp
Version: $VERSION
Architecture: $DPKGARCH
Maintainer: $MAINTAINER
Provides: somtk-comp
Section: misc
Priority: extra
Description: SOMTK compiler
 IDL compiler for SOMTK
 .
EOF

../../toolbox/dir2deb.sh "$INTDIR" "$INTDIR/somtk.rte" "$OUTDIR_DIST" <<EOF
Package: somtk-rte
Version: $VERSION
Architecture: $DPKGARCH
Maintainer: $MAINTAINER
Provides: somtk-rte
Section: misc
Priority: extra
Description: SOMTK RTE
 Run Time Environment for SOMTK
 .
EOF

../../toolbox/dir2deb.sh "$INTDIR" "$INTDIR/somtk.ir" "$OUTDIR_DIST" <<EOF
Package: somtk-ir
Version: $VERSION
Architecture: $DPKGARCH
Maintainer: $MAINTAINER
Depends: somtk-rte
Provides: somtk-ir
Section: misc
Priority: extra
Description: SOMTK Utilities
 Utility classes for SOMTK
 .
EOF

../../toolbox/dir2deb.sh "$INTDIR" "$INTDIR/somtk.util" "$OUTDIR_DIST" <<EOF
Package: somtk-util
Version: $VERSION
Architecture: $DPKGARCH
Maintainer: $MAINTAINER
Depends: somtk-ir
Provides: somtk-util
Section: misc
Priority: extra
Description: SOMTK Utilities
 Utility classes for SOMTK
 .
EOF

../../toolbox/dir2deb.sh "$INTDIR" "$INTDIR/somtk.dsom" "$OUTDIR_DIST" <<EOF
Package: somtk-dsom
Version: $VERSION
Architecture: $DPKGARCH
Maintainer: $MAINTAINER
Depends: somtk-util
Provides: somtk-dsom
Section: misc
Priority: extra
Description: SOMTK DSOM
 CORBA ORB for SOMTK
 .
EOF

../../toolbox/dir2deb.sh "$INTDIR" "$INTDIR/somtk.dev" "$OUTDIR_DIST" <<EOF
Package: somtk-dev
Version: $VERSION
Architecture: $DPKGARCH
Maintainer: $MAINTAINER
Depends: somtk-comp
Provides: somtk-dev
Section: misc
Priority: extra
Description: SOMTK Development Library
 Library and headers for SOMTK
 .
EOF

../../toolbox/dir2bsd.sh "$INTDIR" "$INTDIR/somtk.rte" "$OUTDIR_DIST" <<EOF
somtk-rte
$VERSION

$PKGROOT
SOMTK Runtime Environment
Runtime Environment for SOMTK
EOF

../../toolbox/dir2bsd.sh "$INTDIR" "$INTDIR/somtk.comp" "$OUTDIR_DIST" <<EOF
somtk-comp
$VERSION

$PKGROOT
SOMTK IDL Compiler
IDL Compiler for SOMTK
EOF

../../toolbox/dir2bsd.sh "$INTDIR" "$INTDIR/somtk.ir" "$OUTDIR_DIST" <<EOF
somtk-ir
$VERSION
somtk-rte
$PKGROOT
SOMTK Interface Repository
Interface Repository for SOMTK
EOF

../../toolbox/dir2bsd.sh "$INTDIR" "$INTDIR/somtk.util" "$OUTDIR_DIST" <<EOF
somtk-util
$VERSION
somtk-ir somtk-rte
$PKGROOT
SOMTK Utilities
Utilities for SOMTK
EOF

../../toolbox/dir2bsd.sh "$INTDIR" "$INTDIR/somtk.dsom" "$OUTDIR_DIST" <<EOF
somtk-dsom
$VERSION
somtk-util somtk-ir somtk-rte
$PKGROOT
SOMTK DSOM
CORBA ORB for SOMTK
EOF

../../toolbox/dir2bsd.sh "$INTDIR" "$INTDIR/somtk.dev" "$OUTDIR_DIST" <<EOF
somtk-dev
$VERSION
somtk-comp
$PKGROOT
SOMTK Development Library
Library and headers for SOMTK
EOF


while read BASEDIR PKGNAME
do
	../../toolbox/slackpkg.sh "$INTDIR" "$BASEDIR" "$OUTDIR_DIST" << EOF
$PKGNAME
$VERSION
$PKGROOT
$PKGNAME: somFree - Portable implementation of SOM
$PKGNAME:
$PKGNAME: A portable clean-room implementation of IBM's SOM. Includes DSOM
$PKGNAME: capabilities with CORBA IDL and IIOP.
$PKGNAME: 
$PKGNAME: 
$PKGNAME: 
$PKGNAME: 
$PKGNAME: 
$PKGNAME: 
$PKGNAME: 
EOF
done << EOF2
$INTDIR/somtk.dev	somtk-dev
$INTDIR/somtk.comp	somtk-comp
$INTDIR/somtk.rte	somtk-rte
$INTDIR/somtk.dsom	somtk-dsom
$INTDIR/somtk.ir	somtk-ir
$INTDIR/somtk.util	somtk-util
EOF2
