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

#ifndef __RHBUTILS_H__

#ifdef __cplusplus
extern "C" {
#endif

#ifdef _WIN32
void rhbutils_print_Win32Error(unsigned long err,const char *fmt,...);
#endif

#if defined(STDAPI) && defined(V_VT)
STDAPI rhbutils_print_var(VARIANT *var);
STDAPI rhbutils_cei_printf(LPCOLESTR src,DWORD ctx,const char *fmt,...);
#endif

#if defined(STDAPI) && defined(OLESTR)
STDAPI rhbutils_preload_class(REFCLSID,LPCOLESTR);
STDAPI rhbutils_print_enum(IEnumString *);
#endif

#ifdef __cplusplus
}
#endif

#endif
