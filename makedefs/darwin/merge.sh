#!/bin/sh -e
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

thinfile()
{
	RC=1

	if lipo -info "$1"
	then
		OUTPUT=`lipo -info "$1"`
		case "$OUTPUT" in
		Non-fat* )
			RC=0
			;;
		* )
			;;
		esac
	fi

	return $RC
}

mergedirs()
{
	ARCHLIST=$@

	echo ARCHLIST=$ARCHLIST

	for d in $ARCHLIST
	do
		(
			if test -d "$d"
			then
				cd "$d"
			
				find . -type f | while read M
				do
					if thinfile "$M" >/dev/null
					then
						echo "$M"
					fi
				done
			fi		
		) | (
			while read N
			do
				echo XXXX  handle file "$N"
				FILELIST=
				for e in $ARCHLIST
				do
					if test -f "$e/$N"
					then
						FILELIST="$FILELIST $e/$N"
					fi
				done

				if lipo $FILELIST -create -output lipo.tmp
				then
					lipo -info lipo.tmp

					for e in $FILELIST
					do
						rm "$e"
						ln lipo.tmp "$e"
					done

					rm lipo.tmp
				fi
			done
		)
	done
}

for group in products 
do
	if test -d "$group"
	then
		(
			cd "$group"

			for platform in *
			do
				if test -d "$platform"
				then
					(
						cd "$platform"
					
						ARCHLIST=`echo *`

						if test `echo $ARCHLIST | wc -w` -gt 1
						then
							mergedirs $ARCHLIST
						fi
					)
				fi
			done
		)
	fi
done
