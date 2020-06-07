/**************************************************************************
 *
 *  Copyright 2012, Roger Brown
 *
 *  This file is part of Roger Brown's Toolkit.
 *
 *  This program is free software: you can redistribute it and/or modify it
 *  under the terms of the GNU Lesser General Public License as published by the
 *  Free Software Foundation, either version 3 of the License, or (at your
 *  option) any later version.
 * 
 *  This program is distributed in the hope that it will be useful, but WITHOUT
 *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
 *  more details.
 *
 *  You should have received a copy of the GNU Lesser General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>
 *
 */

/*
 * $Id$
 */

#ifdef HAVE_CONFIG_H
#	include <config.h>
#endif

#ifdef _WIN32
#	include <windows.h>
#	include <winsock.h>
#else
#	include <sys/types.h>
#	include <sys/time.h>
#	include <sys/socket.h>
#	include <sys/ioctl.h>
#	ifdef HAVE_SYS_SELECT_H
#		include <sys/select.h>
#	endif
#	include <netinet/in.h>
#	include <arpa/inet.h>
#	include <netdb.h>
#	include <errno.h>
#	include <unistd.h>
#	include <fcntl.h>
#	ifndef INVALID_SOCKET
#		define INVALID_SOCKET   -1
		typedef int SOCKET;
#	endif
#	define closesocket(x)		close((x))
#endif

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <rhbsokio.h>

#ifdef _WIN32
#	define SELECT_COUNT(x)		0
#else
#	define SELECT_COUNT(x)		(x)
#endif

int readExactlySocket(SOCKET fd,void *pv,size_t len)
{
	int act=0;
	char *p=pv;

	while (len)
	{
		int i=recv(fd,p+act,(int)len,0);

		if (i==0) return -1;

		if (i==-1)
		{
#ifdef _WIN32
			return -1;
#else
			int e=errno;

			if (e!=EAGAIN)
			{
				return -1;
			}
#endif
		}
		else
		{
			len-=i;
			act+=i;
		}
	}

	return act;
}

int writeExactlySocket(SOCKET fd,const void *pv,size_t len)
{
	int act=0;
	const char *p=pv;

	while (len)
	{
		int i=send(fd,p+act,(int)len,0);

		if (i==0) return -1;

		if (i==-1)
		{
#ifdef _WIN32
			return -1;
#else
			int e=errno;

			if (e!=EAGAIN)
			{
				return -1;
			}
#endif
		}
		else
		{
			len-=i;
			act+=i;
		}
	}

	return act;
}

