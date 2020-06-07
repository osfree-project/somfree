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

#include <windows.h>
#include <stdlib.h>
#include <rhbexewr.h>
#include <rhbfdio.h>

static int has_space(const char *p)
{
	while (*p)
	{
		switch (*p)
		{
		case '\t':
		case ' ':
			return 1;
		}

		p++;
	}

	return 0;
}

int execWriteRead(int argc,char **argv,const void *inData,size_t inLen,void *outData, size_t outMaxLen)
{
	int actLen=0;
	int c=0,i=0;
	char *commandLine;
	char *q;
	BOOL b;
	PROCESS_INFORMATION pinfo;
	STARTUPINFOA startup;
	HANDLE pid=GetCurrentProcess();
	HANDLE hStdinRead=INVALID_HANDLE_VALUE,hStdinWrite=INVALID_HANDLE_VALUE;
	HANDLE hStdoutRead=INVALID_HANDLE_VALUE,hStdoutWrite=INVALID_HANDLE_VALUE;

	memset(&startup,0,sizeof(startup));

	startup.cb=sizeof(startup);

	while (i < argc)
	{
		const char *p=argv[i++];
		c+=(int)strlen(p)+1;
		if (has_space(p)) c+=2;
	}

	commandLine=malloc(c+256);

	memset(commandLine,0,c+256);

	i=0;

	q=commandLine;

	while (i < argc)
	{
		const char *p=argv[i++];
		size_t k=strlen(p);

		if (has_space(p) || !k)
		{
			*q++='\"';
		}

		if (k)
		{
			memcpy(q,p,k);
			q+=k;
		}

		if (has_space(p) || !k)
		{
			*q++='\"';
		}

		if (i < argc)
		{
			*q++=' ';
		}
	}

	*q=0;

	b=CreatePipe(&hStdinRead,&hStdinWrite,NULL,4096);

	b=CreatePipe(&hStdoutRead,&hStdoutWrite,NULL,4096);

	b=DuplicateHandle(pid,hStdinRead,pid,
		&startup.hStdInput,
		0,TRUE,DUPLICATE_SAME_ACCESS|DUPLICATE_CLOSE_SOURCE);

	hStdinRead=INVALID_HANDLE_VALUE;

	b=DuplicateHandle(pid,hStdoutWrite,
		pid,&startup.hStdOutput,
		0,TRUE,DUPLICATE_SAME_ACCESS|DUPLICATE_CLOSE_SOURCE);

	hStdoutWrite=INVALID_HANDLE_VALUE;

	b=DuplicateHandle(pid,GetStdHandle(STD_ERROR_HANDLE),
		pid,&startup.hStdError,
		0,TRUE,DUPLICATE_SAME_ACCESS);

	startup.dwFlags=STARTF_USESTDHANDLES;

	b=CreateProcessA(NULL,commandLine,
		NULL,NULL,TRUE,
		0,
		NULL,
		NULL,
		&startup,
		&pinfo);

	CloseHandle(startup.hStdError);
	CloseHandle(startup.hStdOutput);
	CloseHandle(startup.hStdInput);

	if (b)
	{
		char *p=outData;
		int k=writeExactly(hStdinWrite,inData,inLen);

		CloseHandle(hStdinWrite);

		if (k!=(int)inLen)
		{
			actLen=-1;
		}
		else
		{
			while (outMaxLen)
			{
				DWORD dw=0;
				DWORD gulp=32768;
				if (gulp > outMaxLen)
				{
					gulp=(DWORD)outMaxLen;
				}

				if (ReadFile(hStdoutRead,p+actLen,gulp,&dw,NULL))
				{
					if (!dw) break;

					actLen+=dw;
					outMaxLen-=dw;
				}
				else
				{
					break;
				}
			}
		}

		CloseHandle(hStdoutRead);

		WaitForSingleObject(pinfo.hProcess,INFINITE);

		CloseHandle(pinfo.hThread);
		CloseHandle(pinfo.hProcess);
	}
	else
	{
		CloseHandle(hStdoutRead);
		CloseHandle(hStdinWrite);
	}

	free(commandLine);

	return actLen;
}
