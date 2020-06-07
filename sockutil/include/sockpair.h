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

#if defined(_WIN32) && defined(INVALID_SOCKET)
static int __stdcall socketpair(int family,int type,int protocol,SOCKET *result)
{
	SOCKET a=INVALID_SOCKET,b=INVALID_SOCKET,c=INVALID_SOCKET;
	int rc=-1;

#ifdef _M_IX86
	if (family != AF_UNIX) __asm int 3;
	if (type != SOCK_STREAM) __asm int 3;
#endif

	result[0]=INVALID_SOCKET;
	result[1]=INVALID_SOCKET;

	__try
	{
		a=socket(AF_INET,SOCK_STREAM,0);
		if (a!=INVALID_SOCKET)
		{
			b=socket(AF_INET,SOCK_STREAM,0);
		}

		if ((a!=INVALID_SOCKET) && (b!=INVALID_SOCKET))
		{
			struct sockaddr_in addr;
			memset(&addr,0,sizeof(addr));
			addr.sin_family=AF_INET;
			if (!bind(a,(struct sockaddr *)&addr,sizeof(addr)))
			{
				if (!listen(a,1))
				{
					int j=sizeof(addr);
					if (!getsockname(a,(struct sockaddr *)&addr,&j))
					{
						addr.sin_addr.s_addr=htonl(0x7f000001);

						if (!connect(b,(struct sockaddr *)&addr,j))
						{
							c=accept(a,(struct sockaddr *)&addr,&j);

							if (c!=INVALID_SOCKET) 
							{
								rc=0;

								result[0]=b;
								result[1]=c;
								b=INVALID_SOCKET;
								c=INVALID_SOCKET;
							}
						}
					}
				}
			}
		}
	}
	__finally
	{
		DWORD err=WSAGetLastError();
#if defined(_DEBUG) && defined(_M_IX86)
		if (rc) __asm int 3;
#endif
		if (a!=INVALID_SOCKET) closesocket(a);
		if (b!=INVALID_SOCKET) closesocket(b);
		if (c!=INVALID_SOCKET) closesocket(c);
		if (rc) WSASetLastError(err);
	}

	return rc;
}
#endif
