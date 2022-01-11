#!/bin/sh -e

INTDIR=$1
SRCDIR=$2
PKGDIR=$3

test -d "$INTDIR"
test -d "$SRCDIR"
test -d "$PKGDIR"

read PKGNAME
read VERSION
read PKGDEP
read PKGROOT
read TITLE

OPSYS=$(uname)
HANDLE=false

trap "rm -rf $INTDIR/meta" 0

mkdir "$INTDIR/meta"

case "$OPSYS" in
	NetBSD )
		PKGROOT=$(dirname $PKGROOT)
		cat > "$INTDIR/meta/BUILD_INFO" <<EOF
HOMEPAGE=https://sourceforge.net/projects/somfree/
MACHINE_ARCH=$(uname -p)
OPSYS=$(uname -s)
OS_VERSION=$(uname -r)
PKGTOOLS_VERSION=$(pkg_info -V)
EOF
		(
			set -e
			echo "@name $PKGNAME-$VERSION"
			cd "$SRCDIR/$PKGROOT"
			DIRLIST=$( for d in *; do if test -d "$d"; then echo "$d"; fi; done )
			find $DIRLIST -type d | while read N
			do
				echo "@pkgdir $N"
			done
			find $DIRLIST -type f | while read N
			do
				echo "$N"
			done	
			find $DIRLIST -type l
		) > "$INTDIR/meta/CONTENTS"
		echo "$TITLE" > "$INTDIR/meta/COMMENT"
		cat > "$INTDIR/meta/DESC"
		if test -n "$PKGDEP"
		then
			pkg_create -v \
				-B "$INTDIR/meta/BUILD_INFO" \
				-c "$INTDIR/meta/COMMENT" \
				-P "$PKGDEP" \
				-g wheel \
				-u root \
				-d "$INTDIR/meta/DESC" \
				-I "/$PKGROOT" \
				-f "$INTDIR/meta/CONTENTS" \
				-p "$SRCDIR/$PKGROOT" \
				-F xz \
				"$PKGDIR/$PKGNAME-$VERSION.tgz"
		else
			pkg_create -v \
				-B "$INTDIR/meta/BUILD_INFO" \
				-c "$INTDIR/meta/COMMENT" \
				-g wheel \
				-u root \
				-d "$INTDIR/meta/DESC" \
				-I "/$PKGROOT" \
				-f "$INTDIR/meta/CONTENTS" \
				-p "$SRCDIR/$PKGROOT" \
				-F xz \
				"$PKGDIR/$PKGNAME-$VERSION.tgz"
		fi
		;;
	FreeBSD )
		if test -z "$MAINTAINER"
		then
			echo MAINTAINER must be provided >&2
			false
		fi
		PKGROOT=$(dirname $PKGROOT)
		(
			cat <<EOF
name $PKGNAME
version $VERSION
comment $TITLE
www https://sourceforge.net/projects/somfree/
origin misc/$PKGNAME
desc: <<EOD
cat
EOD
maintainer $MAINTAINER
prefix /$PKGROOT
licenses: [
    "LGPL2"
]
categories: [
    "misc"
]
EOF
			if test -n "$PKGDEP"
			then
				echo "deps: {"
				COMMA=false
				for d in $PKGDEP
				do
					if $COMMA
					then
						echo "	,"
					fi
					echo "	$d: {origin: misc/$d, version: $VERSION}"
					COMMA=true
				done
				echo "}"
			fi
		) > "$INTDIR/meta/MANIFEST"
		(
			set -e
			cd "$SRCDIR/$PKGROOT"
			DIRLIST=$( for d in *; do if test -d "$d"; then echo "$d"; fi; done )
			find $DIRLIST -type d | while read N
			do
				echo "@dir $N"
			done
			find $DIRLIST -type f | while read N
			do
				echo "$N"
			done	
			find $DIRLIST -type l
		) > "$INTDIR/meta/PLIST"

		pkg create -M "$INTDIR/meta/MANIFEST" -o "$PKGDIR" -r "$SRCDIR" -v -p "$INTDIR/meta/PLIST"
		;;
	OpenBSD )
		if test -z "$MAINTAINER"
		then
			echo MAINTAINER must be provided >&2
			false
		fi
		PKGROOT=$(dirname $PKGROOT)		
		PKGDEPS=
		for d in $PKGDEP
		do
			PKGDEPS="$PKGDEPS -P misc/$d:$d-*:$d-$VERSION"
		done
		(
			set -e
			cd "$SRCDIR/$PKGROOT"
			DIRLIST=$( for d in *; do if test -d "$d"; then echo "$d"; fi; done )
			find $DIRLIST -type d | while read N
			do
				echo "@dir $N"
			done
			find $DIRLIST -type f
			find $DIRLIST -type l			
		) > "$INTDIR/meta/CONTENTS"
		cat > "$INTDIR/meta/DESC"
		set -ex
		pkg_create \
			-A $(uname -p) \
			-d "$INTDIR/meta/DESC" \
			-D "COMMENT=$TITLE" \
			-D "MAINTAINER=$MAINTAINER" \
			-D "FULLPKGPATH=misc/$PKGNAME" \
			-D "FTP=yes" \
			-f "$INTDIR/meta/CONTENTS" \
			-B "$SRCDIR" \
			-p "/$PKGROOT" \
			"$PKGDIR/$PKGNAME-$VERSION.tgz"
		;;
	* )
		;;
esac
