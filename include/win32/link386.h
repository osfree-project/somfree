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

/* generalised pragmas for linking */

/* _MSC_VER

		1200 = MSVC6
		1400 = MSVC8

  */

#if defined(_MSC_VER) && defined(_DEBUG)
#	if (_MSC_VER < 1200)
#		define USE_RHBOLE
#	else
#	endif
#endif

#ifdef LINK386_SOMTK
#	pragma comment(lib,"somtk.lib")
#endif

#ifdef LINK386_OPENDOC
#	pragma comment(lib,"opendoc.lib")
#endif

#ifdef LINK386_SOMOBJVA
#	pragma comment(lib,"somobjva.lib")
#endif

#ifdef LINK386_SOMOS
#	pragma comment(lib,"somos.lib")
#endif

#ifdef LINK386_SOM
#	pragma comment(lib,"som.lib")
#endif

#ifdef LINK386_SOMREF
#	pragma comment(lib,"somref.lib")
#endif

#ifdef LINK386_SOMABS1
#	pragma comment(lib,"somabs1.lib")
#endif

#ifdef LINK386_SOMCORBA
#	pragma comment(lib,"somcorba.lib")
#endif

#ifdef LINK386_SOMANY
#	pragma comment(lib,"somany.lib")
#endif

#ifdef LINK386_SOMTC
#	pragma comment(lib,"somtc.lib")
#endif

#ifdef LINK386_SOMDCOMM
#	pragma comment(lib,"somdcomm.lib")
#endif

#ifdef LINK386_SOMD
#	pragma comment(lib,"somd.lib")
#endif

#ifdef LINK386_SOMIR
#	pragma comment(lib,"somir.lib")
#endif

#ifdef LINK386_SOMP
#	pragma comment(lib,"somp.lib")
#endif

#ifdef LINK386_SOMS
#	pragma comment(lib,"soms.lib")
#endif

#ifdef LINK386_SOMU
#	pragma comment(lib,"somu.lib")
#endif

#if defined(LINK386_SOMULINK) && !defined(_WIN64)
#	pragma comment(lib,"somulink.lib")
#endif

#ifdef LINK386_SOMU2
#	pragma comment(lib,"somu2.lib")
#endif

#ifdef LINK386_SOMNMF
#	pragma comment(lib,"somnmf.lib")
#endif

#ifdef LINK386_SOMESTRM
#	pragma comment(lib,"somestrm.lib")
#endif

#ifdef LINK386_SOMEM
#	pragma comment(lib,"somem.lib")
#endif

#ifdef LINK386_SOMCDR
#	pragma comment(lib,"somcdr.lib")
#endif

#ifdef LINK386_SOMCORBA
#	pragma comment(lib,"somcorba.lib")
#endif

#ifdef LINK386_SOMANY
#	pragma comment(lib,"somany.lib")
#endif

#ifdef LINK386_SOMDOM
#	pragma comment(lib,"somdom.lib")
#endif

#ifdef LINK386_WSOCK32
#	if (_MSC_VER < 1200)
#		pragma comment(lib,"wsock32.lib")
#	else
#		ifdef _WIN32_WCE
#			pragma comment(lib,"ws2.lib")
#		else
#			pragma comment(lib,"ws2_32.lib")
#		endif
#	endif
#endif

#ifdef LINK386_WININET
#	if (_MSC_VER < 1200)
#	else
#		pragma comment(lib,"wininet.lib")
#	endif
#endif

#ifdef LINK386_KERNEL32
#	pragma comment(lib,"kernel32.lib")
#endif

#ifdef LINK386_USER32
#	ifndef _WIN32_WCE
#		pragma comment(lib,"user32.lib")
#	endif
#endif

#ifdef LINK386_ADVAPI32
#	ifndef _WIN32_WCE
#		pragma comment(lib,"advapi32.lib")
#	endif
#endif

#ifdef LINK386_GDI32
#	ifndef _WIN32_WCE
#		pragma comment(lib,"gdi32.lib")
#	endif
#endif

#ifdef LINK386_OLE32
#	pragma comment(lib,"ole32.lib")
#endif

#ifdef LINK386_OLEAUT32
#	pragma comment(lib,"oleaut32.lib")
#endif

#ifdef LINK386_UUID
#	pragma comment(lib,"uuid.lib")
#endif

#ifdef LINK386_RHBMTUT
#	pragma comment(lib,"rhbmtut.lib")
#endif

#ifdef LINK386_RPCRT4
#	pragma comment(lib,"rpcrt4.lib")
#endif

#if defined(LINK386_WINSCARD) && (_MSC_VER >= 1200)
#	pragma comment(lib,"winscard.lib")
#endif

#ifdef LINK386_SHELL32
#	ifndef _WIN32_WCE
#		pragma comment(lib,"shell32.lib")
#	endif
#endif

#ifdef LINK386_RHBCDRIO
#	pragma comment(lib,"rhbcdrio.lib")
#endif
