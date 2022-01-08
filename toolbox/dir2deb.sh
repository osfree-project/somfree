#!/bin/sh -e

if test "$GTAR" = ""
then
	if ../../toolbox/pkgtool.sh gtar
	then
		GTAR=`../../toolbox/pkgtool.sh gtar`
	fi

	if test "$GTAR" = ""
	then
		exit 0
	fi
fi

getField()
{
	while read N M
	do
		if test "$N" = "$2"
		then
			echo "$M"
			break
		fi	
	done <"$1"
}

INTDIR=$1
BASEDIR=$2
DEBDIR=$3

test -d "$INTDIR"
test -d "$BASEDIR"
test -d "$DEBDIR"

case "$BASEDIR" in
/* )
	;;
* )
	BASEDIR=`pwd`/"$BASEDIR"
	;;
esac

CONTROLFILE="$INTDIR/control"

trap "rm -rf CONTROLFILE" 0

cat >"$CONTROLFILE"

APPNAME=`getField "$CONTROLFILE" Package:`
VERSION=`getField "$CONTROLFILE" Version:`
ARCH=`getField "$CONTROLFILE" Architecture:`
MAINTAINER=`getField "$CONTROLFILE" Maintainer:`
PACKAGE_NAME="$APPNAME"_"$VERSION"_"$ARCH".deb

if dpkg --print-architecture
then
	if test "$ARCH" != "$(dpkg --print-architecture)"
	then
		echo Wrong architecture, $ARCH is not "$(dpkg --print-architecture)"
		exit 0
	fi
else
	exit 0
fi

if test -z "$MAINTAINER"
then
	echo MAINTAINER must be provided >&2
	false
fi

(
	cd "$BASEDIR"

	if test -n "$PKGROOT"
	then
		$GTAR --owner=0 --group=0 --create --file - "$PKGROOT"
	else
		$GTAR --owner=0 --group=0 --create --file - ./*
	fi
) | gzip >"$INTDIR/data.tar.gz"

(
	cd "$INTDIR"
	rm -rf "$PACKAGE_NAME"
	$GTAR --owner=0 --group=0 --create --file control.tar control	
	echo "2.0" >debian-binary
	gzip control.tar
	ar r "$PACKAGE_NAME" debian-binary control.tar.gz data.tar.gz
	rm -rf data.tar.gz control.tar.gz debian-binary
)

mv "$INTDIR/$PACKAGE_NAME" "$DEBDIR"
