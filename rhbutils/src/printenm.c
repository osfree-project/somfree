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
#include <stdio.h>
#include <ole2.h>
#include <rhbutils.h>


STDAPI rhbutils_print_enum(IEnumString *pEnum)
{
	HRESULT hr=S_OK;

	hr=IEnumString_Reset(pEnum);

	if (!hr)
	{
		LPOLESTR str=0;
		ULONG celt=0;
		long i=0;

		printf("{");

		while (!IEnumString_Next(pEnum,1,&str,&celt))
		{
			if (!celt) break;

			if (str)
			{
				if (i++)
				{
					printf(",");
				}
#ifdef _WIN32
				printf("%S",str);
#else
				printf("%s",str);
#endif
				CoTaskMemFree(str);

				str=0;
			}
		}

		printf("}");

		hr=IEnumString_Reset(pEnum);
	}

	return hr;
}

