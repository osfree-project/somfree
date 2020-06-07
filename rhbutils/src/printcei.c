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

#include <rhbopt.h>
#include <stdarg.h>
#include <stdio.h>
#include <ole2.h>
#include <rhbutils.h>
#include <rhbcomex.h>

STDAPI rhbutils_cei_printf(LPCOLESTR src,DWORD ctx,const char *fmt,...)
{
	ICreateErrorInfo *pCreate=NULL;
	va_list ap;
	HRESULT hr=CreateErrorInfo(&pCreate);
	va_start(ap,fmt);
	if (hr)
	{
		fprintf(stderr,"CreateErrorInfo failed with %0lx\n",(long)hr);
	}
	else
	{
		IErrorInfo *pInfo=NULL;
		char buf[512];
		OLECHAR buf_w[sizeof(buf)+1];
		int i=vsprintf(buf,fmt,ap);
#ifdef _WIN32
		int k=MultiByteToWideChar(CP_ACP,0,buf,i,
				buf_w,sizeof(buf_w)/sizeof(buf_w[0]));
#else
		int k=i;
		while (k--)
		{
			buf_w[k]=buf[k];
		}
#endif
		buf_w[k]=0;

		ICreateErrorInfo_SetSource(pCreate,(LPOLESTR)src);
		ICreateErrorInfo_SetHelpContext(pCreate,ctx);
		ICreateErrorInfo_SetDescription(pCreate,buf_w);

		hr=ICreateErrorInfo_QueryInterface(pCreate,RHBCOM_REFIID(IErrorInfo),(void **)(void *)&pInfo);

		if (hr)
		{
			fprintf(stderr,"ICreateErrorInfo_QueryInterface failed with %0lx\n",(long)hr);
		}
		else
		{
			hr=SetErrorInfo(0,pInfo);

			IErrorInfo_Release(pInfo);
		}

		ICreateErrorInfo_Release(pCreate);
	}
	va_end(ap);

	return hr;
}

