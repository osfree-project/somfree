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
#ifdef HAVE_DLFCN_H
#	include <dlfcn.h>
#endif
#include <ole2.h>
#include <rhbutils.h>
#include <rhbcomex.h>

static const char szDllGetClassObject[]="DllGetClassObject";

STDAPI rhbutils_preload_class(REFCLSID rclsid,LPCOLESTR dllname)
{
	HRESULT hr=(HRESULT)E_FAIL;
	HINSTANCE pv=CoLoadLibrary((LPOLESTR)dllname,FALSE);

	if (pv)
	{
#ifdef _WIN32
		LPFNGETCLASSOBJECT pfn=(LPFNGETCLASSOBJECT)GetProcAddress(pv,szDllGetClassObject);
#else
		LPFNGETCLASSOBJECT pfn=(LPFNGETCLASSOBJECT)dlsym(pv,szDllGetClassObject);
#endif

		if (pfn)
		{
			IUnknown *punk=0;

			hr=pfn(rclsid,RHBCOM_REFIID(IUnknown),(void **)&punk);

			if (!hr)
			{
				DWORD dw=0;

				hr=CoRegisterClassObject(rclsid,punk,CLSCTX_INPROC_SERVER,REGCLS_MULTIPLEUSE,&dw);
			}
		}
	}
	
	return hr;
}

