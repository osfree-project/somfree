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

#ifdef _WIN32
#	ifdef HAVE_WINSOCK2_H
#		include <winsock2.h>
#		ifdef HAVE_WS2IP6_H
#			include <ws2ip6.h>
#		endif
#		ifdef HAVE_WS2TCPIP_H
#			include <ws2tcpip.h>
#		endif
#		pragma comment(lib,"ws2_32")
#	else
#		include <windows.h>
#		include <winsock.h>
#		pragma comment(lib,"wsock32")
#	endif
#	include <sockpair.h>
#else
#	include <sys/types.h>
#	include <sys/time.h>
#	include <sys/socket.h>
#	include <sys/ioctl.h>
#	ifdef HAVE_SYS_SELECT_H
#		include <sys/select.h>
#	endif
#	include <netinet/in.h>
#	include <arpa/inet.h>
#	include <netdb.h>
#	include <errno.h>
#	include <unistd.h>
#	include <fcntl.h>
#	ifndef INVALID_SOCKET
#		define INVALID_SOCKET   -1
		typedef int SOCKET;
#	endif
#endif

#include <stdio.h>
#include <stdlib.h>
#include <pipeexec.h>

#ifndef SD_SEND
#	define SD_SEND		1
#endif

#ifdef _WIN32
struct child_process
{
	LONG usage;
	HANDLE hEvent;
	HANDLE pipe_stdin,pipe_stdout;
	SOCKET fd_stdin,fd_stdout;
	int wait_count;
	struct
	{
		HANDLE handle;
		DWORD tid;
	} wait_list[4];
};

static void child_process_release(struct child_process *proc)
{
	if (!InterlockedDecrement(&proc->usage))
	{
		if (!SetEvent(proc->hEvent))
		{
#if defined(_WIN32) && defined(_M_IX86)
			__asm int 3
#endif
		}
	}
}

static DWORD CALLBACK child_reaper(void *pv)
{
struct child_process *proc=pv;
DWORD tid=GetCurrentThreadId();
DWORD rcExit=(DWORD)-1;

	WaitForSingleObject(proc->hEvent,INFINITE);

	while (proc->wait_count--)
	{
		int i=proc->wait_count;

		if (proc->wait_list[i].tid!=tid)
		{
			WaitForSingleObject(proc->wait_list[i].handle,INFINITE);
		}

		if (!proc->wait_list[i].tid)
		{
			if (!GetExitCodeProcess(proc->wait_list[i].handle,&rcExit))
			{
#if defined(_WIN32) && defined(_M_IX86)
				__asm int 3
#endif
			}
		}

		if (!CloseHandle(proc->wait_list[i].handle))
		{
#if defined(_WIN32) && defined(_M_IX86)
			__asm int 3
#endif
		}
	}

	LocalFree(proc);

	return rcExit;
}

static DWORD CALLBACK do_stdin(void *pv)
{
struct child_process *data=pv;
	
	while (pv)
	{
		char buf[256];
		int i=recv(data->fd_stdin,buf,sizeof(buf),0);

		if (!i) 
		{
			break;
		}

		if (i > 0)
		{
			const char *p=buf;

			while (i)
			{
				DWORD dw=i;

				if (WriteFile(data->pipe_stdin,p,i,&dw,NULL))
				{
					p+=dw;
					i-=dw;

#if defined(_WIN32) && defined(_M_IX86)
					if (!dw) __asm int 3
#endif
				}
				else
				{
					pv=0;
					break;
				}
			}
		}
		else
		{
			i=WSAGetLastError();

			if (i==WSAEWOULDBLOCK)
			{
				fd_set fds;
				struct timeval tv;
				tv.tv_sec=10;
				tv.tv_usec=0;

				FD_ZERO(&fds);
				FD_SET(data->fd_stdin,&fds);

				i=select((int)(data->fd_stdin+1),&fds,NULL,NULL,NULL);
			}
			else
			{
				break;
			}
		}
	}

	CloseHandle(data->pipe_stdin);

	child_process_release(data);

	return 0;
}

static DWORD CALLBACK do_stdout(void *pv)
{
struct child_process *data=pv;
	
	while (pv)
	{
		char buf[1];
		DWORD dw=sizeof(buf);
		if (ReadFile(data->pipe_stdout,buf,sizeof(buf),&dw,NULL))
		{
			if (!dw) break;

			while (dw)
			{
				int i=send(data->fd_stdout,buf,dw,0);

				if (i < 0)
				{
					DWORD err=GetLastError();

					if (err==WSAEWOULDBLOCK)
					{
						fd_set fds;
						FD_ZERO(&fds);
						FD_SET(data->fd_stdout,&fds);
						select((int)(data->fd_stdout+1),NULL,&fds,NULL,NULL);
					}
					else
					{
						pv=0;
						break;
					}
				}
				else
				{
					dw-=i;
					if (dw) 
					{
						pv=0;
						break;
					}
				}
			}
		}
		else
		{
			break;
		}
	}

	shutdown(data->fd_stdout,SD_SEND);

	CloseHandle(data->pipe_stdout);

	child_process_release(data);

	return 0;
}
#endif

static int sockopts(SOCKET fd)
{
#ifdef _WIN32
	BOOL ul=1;
	int i=ioctlsocket(fd,FIONBIO,(unsigned long *)&ul);
#else
#	ifdef HAVE_FCNTL_F_SETFL_O_NDELAY
	int i=fcntl(fd,F_SETFL,O_NDELAY);
	if (i < 0)
	{
		perror("F_SETFL");
	}
#	else
	int ul=1;
	int i=ioctl(fd,FIONBIO,(void *)&ul);
	if (i)
	{
		perror("FIONBIO");
	}
#	endif
#endif

	return i;
}

#ifdef _WIN32
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
#endif

SOCKET pipeexec(int argc,char **argv,
#ifdef _WIN32
				HANDLE *hProcess
#else
				pid_t *ppid
#endif
				)
{
SOCKET fd[2]={INVALID_SOCKET,INVALID_SOCKET};

	if (!socketpair(AF_UNIX,SOCK_STREAM,0,fd))
	{
#ifdef _WIN32
		int c=0,i=0;
		char *commandLine;
		char *q;
		BOOL b;
		PROCESS_INFORMATION pinfo;
		STARTUPINFO startup;
		HANDLE pid=GetCurrentProcess();
		HANDLE hStdinRead=INVALID_HANDLE_VALUE,hStdinWrite=INVALID_HANDLE_VALUE;
		HANDLE hStdoutRead=INVALID_HANDLE_VALUE,hStdoutWrite=INVALID_HANDLE_VALUE;

		sockopts(fd[1]);

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

#if defined(_WIN32) && defined(_M_IX86)
		if (!b) __asm int 3
#endif

		b=CreatePipe(&hStdoutRead,&hStdoutWrite,NULL,4096);

#if defined(_WIN32) && defined(_M_IX86)
		if (!b) __asm int 3
#endif
		b=DuplicateHandle(pid,hStdinRead,pid,
			&startup.hStdInput,
			0,TRUE,DUPLICATE_SAME_ACCESS|DUPLICATE_CLOSE_SOURCE);

#if defined(_WIN32) && defined(_M_IX86)
		if (!b) __asm int 3
#endif

		hStdinRead=INVALID_HANDLE_VALUE;

		b=DuplicateHandle(pid,hStdoutWrite,
			pid,&startup.hStdOutput,
			0,TRUE,DUPLICATE_SAME_ACCESS|DUPLICATE_CLOSE_SOURCE);

#if defined(_WIN32) && defined(_M_IX86)
		if (!b) __asm int 3
#endif

		hStdoutWrite=INVALID_HANDLE_VALUE;
	
		b=DuplicateHandle(pid,GetStdHandle(STD_ERROR_HANDLE),
			pid,&startup.hStdError,
			0,TRUE,DUPLICATE_SAME_ACCESS);

#if defined(_WIN32) && defined(_M_IX86)
		if (!b) __asm int 3
#endif

		startup.dwFlags=STARTF_USESTDHANDLES;

		b=CreateProcess(NULL,commandLine,
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
			struct child_process *child=LocalAlloc(LMEM_FIXED|LMEM_ZEROINIT,sizeof(child[0]));

			child->usage=2;
			child->hEvent=CreateEvent(NULL,FALSE,FALSE,NULL);

			child->fd_stdin=fd[1];
			child->pipe_stdin=hStdinWrite;

			child->fd_stdout=fd[1];
			child->pipe_stdout=hStdoutRead;

			child->wait_list[child->wait_count].handle=
				CreateThread(NULL,0,do_stdin,child,0,
						&child->wait_list[child->wait_count].tid);

			if (child->wait_list[child->wait_count].handle)
			{
				child->wait_count++;
			}

			child->wait_list[child->wait_count].handle=
				CreateThread(NULL,0,do_stdout,child,0,
						&child->wait_list[child->wait_count].tid);

			if (child->wait_list[child->wait_count].handle)
			{
				child->wait_count++;
			}

			child->wait_list[child->wait_count].handle=pinfo.hThread;

			if (child->wait_list[child->wait_count].handle)
			{
				child->wait_list[child->wait_count].tid=pinfo.dwThreadId;
				child->wait_count++;
			}

			child->wait_list[child->wait_count].handle=pinfo.hProcess;

			if (child->wait_list[child->wait_count].handle)
			{
				child->wait_count++;
			}

			pinfo.hThread=CreateThread(NULL,0,child_reaper,child,0,&pinfo.dwThreadId);

			if (hProcess)
			{
				*hProcess=pinfo.hThread;
			}
			else
			{
				CloseHandle(pinfo.hThread);
			}
		}
		else
		{
			CloseHandle(hStdoutRead);
			CloseHandle(hStdinWrite);

			closesocket(fd[0]);
			closesocket(fd[1]);

			fd[0]=INVALID_SOCKET;
			fd[1]=INVALID_SOCKET;
		}
#else
		pid_t pid=fork();

		if (pid)
		{
			if (pid < 0)
			{
				perror("fork");
				close(fd[0]);
				close(fd[1]);
				fd[0]=INVALID_SOCKET;
			}
			else
			{
				sockopts(fd[0]);

				close(fd[1]);

				if (ppid)
				{
					*ppid=pid;
				}
			}
		}
		else
		{
			int i;

			close(fd[0]);

			i=dup2(fd[1],0);

			if (i!=0)
			{
				perror("dup2 stdin"); 
				exit(1);
			}

			i=dup2(fd[1],1);

			if (i!=1)
			{
				perror("dup2 stdout"); 
				exit(1);
			}

			i=close(fd[1]);

			if (i<0)
			{
				perror("close pipe"); 
				exit(1);
			}

			execvp(argv[0],argv);

			if (argv[0])
			{
				perror(argv[0]);
			}
			else
			{
				perror("exec");
			}

			exit(1);
		}
#endif
	}

	return fd[0];
}
