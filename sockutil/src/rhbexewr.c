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

#include <rhbopt.h>

#include <errno.h>
#include <unistd.h>
#include <sys/wait.h>
#include <stdio.h>
#include <stdlib.h>
#include <rhbexewr.h>
#include <rhbfdio.h>

int execWriteRead(int argc,char **argv,const void *inData,size_t inLen,void *outData, size_t outLen)
{
	int retVal=0;

	if (argc>0)
	{
		int fdStdin[2]={-1,-1},fdStdout[2]={-1,-1};
		pid_t pid;
		int s;
		char *p=outData;

		if (pipe(fdStdin)) return -1;

		if (pipe(fdStdout)) return -1;

		pid=fork();

		if (pid==-1) return -1;

		if (!pid)
		{
			dup2(fdStdin[0],0); close(fdStdin[1]);
			dup2(fdStdout[1],1); close(fdStdout[0]);

			execvp(argv[0],argv);

			perror(argv[0]);
		
			_exit(1);
		}

		close(fdStdin[0]);
		close(fdStdout[1]);

		writeExactly(fdStdin[1],inData,inLen);

		close(fdStdin[1]);

		while (outLen)
		{
			s=read(fdStdout[0],p,outLen);

			if (!s) break;

			if (s < 0) break;

			p+=s;
			outLen-=s;
			retVal+=s;
		}

		close(fdStdout[0]);

		waitpid(pid,&s,0);
	}

	return retVal;
}

