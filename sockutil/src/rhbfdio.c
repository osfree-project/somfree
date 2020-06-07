/**************************************************************************
 *
 *  Copyright 2011, Roger Brown
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
#else
#	include <unistd.h>
#	include <errno.h>
#endif

#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include <rhbfdio.h>

#ifdef _WIN32
int readExactly(HANDLE fd,void *pv,size_t len)
{
	int actual=0;
	unsigned char *op=pv;

	while (len)
	{
		DWORD dw=0;

		if (ReadFile(fd,op+actual,(DWORD)len,&dw,NULL))
		{
			if (dw)
			{
				actual+=dw;
				len-=dw;
			}
			else
			{
				return -1;
			}
		}
		else
		{
			return -1;
		}
	}

	return actual;
}

int writeExactly(HANDLE fd,const void *pv,size_t len)
{
	int actual=0;
	const unsigned char *op=pv;

	while (len)
	{
		DWORD dw=0;

		if (WriteFile(fd,op+actual,(DWORD)len,&dw,NULL))
		{
			if (dw)
			{
				actual+=dw;
				len-=dw;
			}
			else
			{
				return -1;
			}
		}
		else
		{
			return -1;
		}
	}

	return actual;
}
#else
int readExactly(int fd,void *pv,size_t len)
{
	int act=0;
	char *p=pv;

	while (len)
	{
		int i=read(fd,p,len);

		if (i==0) return -1;

		if (i==-1)
		{
			int e=errno;

			if (e!=EAGAIN)
			{
				return -1;
			}
		}
		else
		{
			len-=i;
			act+=i;
			p+=i;
		}
	}

	return act;
}

int writeExactly(int fd,const void *pv,size_t len)
{
	int act=0;
	const char *p=pv;

	while (len)
	{
		int i=write(fd,p,len);

		if (i==0) return -1;

		if (i==-1)
		{
			int e=errno;

			if (e!=EAGAIN)
			{
				return -1;
			}
		}
		else
		{
			len-=i;
			act+=i;
			p+=i;
		}
	}

	return act;
}
#endif

