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

if test "$CC" = ""
then
	echo $0, CC not set 1>&2
	exit 1
fi

if test "$INTDIR" = ""
then
	echo $0, INTDIR not set 1>&2
	exit 1
fi

expand_cc()
{
    echo echo $@ | sh
}

try_cc()
{
     INTDIR="$INTDIR" ../../toolbox/trycc.sh \
			$CFLAGS $PLATFORM_CFLAGS \
			`expand_cc $CONFIG_OPTS` \
			$@ 
}

arglist()
{
	OUTPUT=
    pref=$1
    shift
    while test "$1" != ""
    do
		if test "$OUTPUT" = ""
		then
       		OUTPUT="${pref}$1"
		else
       		OUTPUT="$OUTPUT ${pref}$1"
		fi
       shift
    done
	if test "$OUTPUT" != ""
	then
		echo "$OUTPUT"
	fi
}

if test "$THREADLIBS" = ""
then
	try_cc <<EOF
#ifdef _REENTRANT
int main(int argc,char **argv) { return argc && argv; }
#else
#error	not _REENTRANT
#endif
EOF
	RC="$?"
	if test "$RC" = "0"
	then
		for e in "" pthread
		do
			try_cc `arglist -l $e` <<EOF
#include <pthread.h>
#ifdef _REENTRANT
static void myclean(void *pv) { if (pv) { } ; }
static void *myfunc(void *pv) { return pv; }
int main(int argc,char **argv) { 
pthread_t self=pthread_self();
void *pv=NULL;
pthread_cleanup_push(myclean,pv);
pthread_cancel(self);
pthread_testcancel();
pthread_cleanup_pop((argc ? 1 : 0));
pthread_join(self,pv);
pthread_create(pv,pv,myfunc,pv);
return argc && argv; }
#else
#error	not _REENTRANT
#endif
EOF
			RC="$?"
			if test "$RC" = "0"
			then
				if test "$e" != ""
				then
					THREADLIBS=`arglist -l $e`
				fi
				break
			fi
		done
	fi
fi

if test "$SOCKLIBS" = ""
then
	for e in "" socket nsl "socket nsl"
	do
    	try_cc `arglist -l $e` <<EOF
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <stdio.h>
int main(int argc,char **argv) { 
return argc && argv && gethostbyname(argv[0]) &&
	socket(AF_UNIX,SOCK_STREAM,0) && getsockname(0,NULL,NULL); }
EOF
	    RC="$?"
    	if test "$RC" = "0"
	    then
			SOCKLIBS=`arglist -l $e`
			SOCKLIBS=`echo $SOCKLIBS`
        	break
	    fi
	done
fi

if test "$DLLIBS" = ""
then
	for e in "" dl
	do
    	try_cc `arglist -l $e` <<EOF
#include <sys/types.h>
#include <dlfcn.h>
int main(int argc,char **argv) { 
return argc && argv && dlopen(argv[0],0); }
EOF
	    RC="$?"
    	if test "$RC" = "0"
	    then
			DLLIBS=`arglist -l $e`
			DLLIBS=`echo $DLLIBS`
        	break
	    fi
	done
fi

for d in " " "-luuid" 
do
	for e in 												\
		"#include <sys/uuid.h>"  							\
		"#include <uuid/uuid.h>" 							\
		"#include <uuid.h>"
	do
		for f in 											\
			"uuid_t a; uint_t s; uuid_create(&a,&s);" 		\
			"uuid_t a; uuid_generate(a); " 					\
			"uuid_t a; uint32_t s; uuid_create(&a,&s);" 
		do
			if test "$UUIDLIBS" != ""
			then
				break
			fi
	   		try_cc $d <<EOF
#include <sys/types.h>
$e
$FINDLIBS_REQUIRED_GLOBALS
int main(int argc,char **argv) {
$f
return argc && argv; }
EOF
			RC="$?"
			if test "$RC" = "0"
			then
				UUIDLIBS="$d"
				break
			fi
		done
	done
done

echo THREADLIBS=\"$THREADLIBS\"\;
echo SOCKLIBS=\"$SOCKLIBS\"\;
echo DLLIBS=\"$DLLIBS\"\;
echo UUIDLIBS=\"$UUIDLIBS\"\;

