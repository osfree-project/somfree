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

#include <stdio.h>
#include <ole2.h>
#include <rhbutils.h>

void recurse_print_array(VARTYPE vt,LPSAFEARRAY pa,LONG *dims,int dim)
{
/*	int cDims=SafeArrayGetDim(pa); */
	LONG lBound=-1,uBound=-1;
	SafeArrayGetLBound(pa,dim,&lBound);
	SafeArrayGetUBound(pa,dim,&uBound);

	printf("{");

	while (lBound <= uBound)
	{
		dims[dim-1]=lBound;

		if (dim > 1)
		{
			recurse_print_array(vt,pa,dims,dim-1);
		}
		else
		{
			void *pv=NULL;
			SafeArrayPtrOfIndex(pa,dims,&pv);

			if (pv)
			{
				switch (vt)
				{
				case VT_BSTR:
					{
						BSTR b=((BSTR *)pv)[0];
						if (b)
						{
#ifdef _WIN32
							printf("\"%S\"",b);
#else
							printf("\"%s\"",b);
#endif
						}
					}
					break;
				case VT_UI1:
					printf("%02X",((BYTE *)pv)[0]);
					break;
				}
			}
		}

		if (lBound < uBound)
		{
			printf(",");
		}

		lBound++;
	}

	printf("}");
}


STDAPI rhbutils_print_var(VARIANT *var)
{
	HRESULT hr=S_OK;

	if (V_ISARRAY(var))
	{
		LPSAFEARRAY pa=V_ARRAY(var);
		LONG dims[32];

		hr=SafeArrayLock(pa);

		if (!hr)
		{
			int cDims=SafeArrayGetDim(pa);
/*
			int i=SafeArrayGetDim(pa);
*/
#if 0
			int k=0;
			while (k++ < i)
			{
				LONG lBound=-1,uBound=-1;
				SafeArrayGetLBound(pa,k,&lBound);
				SafeArrayGetUBound(pa,k,&uBound);
				printf("[%ld,%ld]\n",(long)lBound,(long)uBound);
			}
#endif

			recurse_print_array((VARTYPE)(V_VT(var) & 0xff),pa,dims,cDims);

			SafeArrayUnlock(pa);
		}
	}

	return hr;
}

