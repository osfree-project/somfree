/**************************************************************************
 *
 *  Copyright 2008, Roger Brown
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

#include <windows.h>
#include <stdarg.h>
#include <stdio.h>
#include <rhbutils.h>

void rhbutils_print_Win32Error(unsigned long err,const char *fmt,...)
{
	TCHAR buf[1024];
	va_list ap;
#ifdef STD_ERROR_HANDLE
	HANDLE h=GetStdHandle(STD_ERROR_HANDLE);
#else
	HANDLE h=INVALID_HANDLE_VALUE;
#endif
	DWORD dw=FormatMessage(
		FORMAT_MESSAGE_IGNORE_INSERTS|FORMAT_MESSAGE_FROM_SYSTEM,
		NULL,
		err,
		0,
		buf,
		(sizeof(buf)/sizeof(buf[0]))-2,
		NULL);

	va_start(ap,fmt);

	if (h==INVALID_HANDLE_VALUE)
	{
#ifdef _CONSOLE
		if (fmt)
		{
			char buf2[256];
			int i=_vsnprintf(buf2,sizeof(buf2)-1,fmt,ap);

			if (i > 0)
			{
				buf2[i++]='\n';
				fwrite(buf2,1,i,stderr);
			}
		}
		buf[dw++]='\n';
		fwrite(buf,1,dw,stderr);
		fflush(stderr);
#else
		TCHAR titleBuf[256];
		TCHAR *title=titleBuf;

		if (fmt)
		{
#ifdef UNICODE
			char title2[4096];
			int i=_vsnprintf(title2,sizeof(title2),fmt,ap);
			i=MultiByteToWideChar(CP_ACP,0,title2,i,titleBuf,(sizeof(titleBuf)/sizeof(titleBuf[0]))-1);
			titleBuf[0]=i;
#else
			_vsnprintf(titleBuf,sizeof(titleBuf),fmt,ap);
#endif
		}
		else
		{
			int i=GetModuleFileName(NULL,titleBuf,sizeof(titleBuf));
			title=titleBuf+i;
			while (title > titleBuf)
			{
				title--;
				if (*title=='\\')
				{
					title++;
					break;
				}
			}
		}
		buf[dw]=0;
		MessageBox(NULL,buf,title,MB_OK|MB_ICONERROR);
#endif
	}
	else
	{
		if (fmt)
		{
			char buf2[256];
			int i=_vsnprintf(buf2,sizeof(buf2)-2,fmt,ap);

			if (i > 0)
			{
				DWORD dw2;
				buf2[i++]='\r';
				buf2[i++]='\n';
				WriteFile(h,buf2,i,&dw2,NULL);
			}
		}

		buf[dw++]='\r';
		buf[dw++]='\n';
		WriteFile(h,buf,dw,&dw,NULL);
	}

	va_end(ap);
}
