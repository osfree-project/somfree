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
#include <rhbsomdd.h>
#include <objbase.h>
#include <stdio.h>
#ifndef DONT_USE_SIGNALS
	#include <signal.h>
#endif
#include <somddmsg.h>
#include <regstr.h>
#include <rhbutils.h>

/* need to maintain a list of environment variables modified
	(1) read out of service config
	(2) passed in on command line
	(3) modified by RPC
	*/

static char szServiceName[]="SOMDD";
static const char *SOM_env[]={"SOMDDIR","SOMBASE","SOMIR","SOMDPORT",NULL};
static const char szWindowsClassName[]="SOMDD";
static const char szEnvironment[]="Environment";

struct SOMDD_daemon
{
	SERVICE_STATUS_HANDLE h_service;
	SERVICE_STATUS status;
};

static struct SOMDD_daemon *somdd_daemon;
static HANDLE somdd_eventSource;
static PSID somdd_eventSid;

#if defined(USE_THREADS) && !defined(USE_PTHREADS) 
static struct 
{
	int severity;
	WORD type;
} sevMap[]={
	{SOMDD_LOG_OK,EVENTLOG_SUCCESS},
	{SOMDD_LOG_INFO,EVENTLOG_INFORMATION_TYPE},
	{SOMDD_LOG_WARN,EVENTLOG_WARNING_TYPE},
	{SOMDD_LOG_ERROR,EVENTLOG_ERROR_TYPE}
};
void SOMDD_syslog(struct SOMDD_msg *msg,...)
{
	if (somdd_eventSource)
	{
		va_list ap;
		char *args[32];
		char **h=args;
		WORD c=0;
		int i=0;
		WORD type=SOMDD_LOG_INFO;

		va_start(ap,msg);

		i=sizeof(sevMap)/sizeof(sevMap[0]);
		while (i--)
		{
			if (sevMap[i].severity==msg->type)
			{
				type=sevMap[i].type;
				break;
			}
		}

		while (c < (sizeof(args)/sizeof(args[0])))
		{
			char *p=va_arg(ap,char *);
			*h++=p;
			if (!p) break;
			c++;
		}

		if (msg->id)
		{
			c=ReportEvent(somdd_eventSource,
				type,
				0,
				msg->id,
				somdd_eventSid,
				c,
				0,
				args,
				NULL);
		}
		else
		{
#ifdef _DEBUG
#	ifdef _M_IX86
			__asm int 3
#	endif
#endif
		}

		va_end(ap);
	}
}
#endif

static void WINAPI SOMDD_ServiceCtrlHandler(DWORD dw)
{
	somPrintf("SOMDD_ServiceCtrlHandler(%d)\n",dw);

	switch (dw)
	{
	case SERVICE_CONTROL_STOP:
	case SERVICE_CONTROL_SHUTDOWN:
		if (somdd_daemon)
		{
			if (somdd_daemon->h_service)
			{
				switch (somdd_daemon->status.dwCurrentState)
				{
				case SERVICE_RUNNING:
					somdd_daemon->status.dwCurrentState=SERVICE_STOP_PENDING;
					somdd_daemon->status.dwCheckPoint++;
					SetServiceStatus(somdd_daemon->h_service,&somdd_daemon->status);
					break;
				}
			}
		}
		if (SOMD_SOMOAObject)
		{
			SOMOA SOMSTAR somoa=NULL;
#ifdef USE_THREADS
			somToken mutex=SOMDD_AcquireGlobalMutex();
#endif

			if (SOMD_SOMOAObject)
			{
				somoa=SOMOA_somDuplicateReference(SOMD_SOMOAObject);
			}

#ifdef USE_THREADS
			SOMDD_ReleaseGlobalMutex(mutex);
#endif

			if (somoa)
			{
				Environment ev={NO_EXCEPTION,{NULL,NULL},NULL};
				SOMOA_interrupt_server(somoa,&ev);
				SOMOA_somRelease(somoa);
				SOM_UninitEnvironment(&ev);
			}

		}
		break;
	case SERVICE_CONTROL_INTERROGATE:
		if (somdd_daemon)
		{
			if (somdd_daemon->h_service)
			{
				somdd_daemon->status.dwCheckPoint++;
				SetServiceStatus(somdd_daemon->h_service,&somdd_daemon->status);
			}
		}
		break;
	}
}

static HKEY SOMDD_open_service_key(char *szService,boolean writeAccess)
{
HKEY key=NULL;
char buf[256];

	strncpy(buf,REGSTR_PATH_SERVICES,sizeof(buf));
	strncat(buf,"\\",sizeof(buf));
	strncat(buf,szService,sizeof(buf));

	if (!RegOpenKeyEx(HKEY_LOCAL_MACHINE,buf,0,
		writeAccess ?
		(KEY_CREATE_SUB_KEY|KEY_WRITE) :
	    (KEY_READ),
		&key))
	{
		return key;
	}

	return NULL;
}

void SOMDD_up(struct SOMDD_daemon *daemon)
{
	if (daemon)
	{
		if (daemon->h_service)
		{
			daemon->status.dwCurrentState=SERVICE_RUNNING;
			daemon->status.dwCheckPoint++;

			SetServiceStatus(daemon->h_service,&daemon->status);
		}
	}
}

void SOMDD_down(struct SOMDD_daemon *daemon)
{
	SOMDD_AllocConsole();

	if (daemon)
	{
		if (daemon->h_service)
		{
			daemon->status.dwCurrentState=SERVICE_STOP_PENDING;
			daemon->status.dwCheckPoint++;
			SetServiceStatus(daemon->h_service,&daemon->status);
		}
	}
}

static int SOMDD_printf(const char *fmt,...)
{
	HANDLE h=GetStdHandle(STD_OUTPUT_HANDLE);

	if (h!=INVALID_HANDLE_VALUE)
	{
		char buf[1024];
		int i;
		DWORD dw;
		va_list args;
		va_start(args,fmt);
		i=vsprintf(buf,fmt,args);
		WriteFile(h,buf,i,&dw,NULL);
		va_end(args);
		return i;
	}

	return -1;
}

static void SOMDD_setenv(char *szServiceName)
{
	HKEY key=SOMDD_open_service_key(szServiceName,0);

	if (key)
	{
		HKEY keyenv=NULL;

		if (!RegOpenKeyEx(key,szEnvironment,0,KEY_QUERY_VALUE,&keyenv))
		{
			DWORD index=0;

			while (1)
			{
				char buf[8192];
				char name[256];
				DWORD nameLen=sizeof(name)-1;
				DWORD bufLen=sizeof(buf)-1;
				DWORD type=0;

				if (!RegEnumValue(keyenv,index++,
					name,&nameLen,
					NULL,
					&type,
					buf,
					&bufLen))
				{
					buf[bufLen]=0;
					switch (type)
					{
					case REG_SZ:
						SetEnvironmentVariable(name,buf);
						SOMDD_printf("set %s=%s\n",name,buf);
						break;
					case REG_EXPAND_SZ:
						{
							char exBuf[16384];
							DWORD dw=ExpandEnvironmentStrings(buf,exBuf,sizeof(exBuf)-1);
							exBuf[dw]=0;
							SetEnvironmentVariable(name,exBuf);
							SOMDD_printf("set %s=%s\n",name,exBuf);
						}
						break;
					default:
						break;
					}
				}
				else
				{
					break;
				}
			}

			RegCloseKey(keyenv);
		}

		RegCloseKey(key);
	}
}

static int SOMDD_run_main(struct SOMDD_daemon *daemon,int argc,char **argv)
{
	int ret=1;
	RHBProcessMgrChild childInfo=RHBPROCESSMGRCHILD_INIT;

	RHBProcessMgr executor={
		RHBPROCESSMGR_INIT_COMMON,
#ifdef USE_SELECT_RHBPROCESSMGR
		RHBPROCESSMGR_INIT
#else
		NULL,
		NULL,
		INVALID_HANDLE_VALUE,
		INVALID_HANDLE_VALUE
#endif
	};

	executor.childInfo=&childInfo;

	if (!RHBProcessMgr_init(&executor))
	{
		{
			char username[256];
			DWORD dw=sizeof(username);
			somdd_eventSource=RegisterEventSource(NULL,szServiceName);

			if (GetUserName(username,&dw))
			{
				char sid[256],domain[256]={0};
				SID_NAME_USE use=SidTypeUnknown;
				DWORD dwSid=sizeof(sid),dwDomain=sizeof(domain);
				memset(sid,0,sizeof(sid));

				if (LookupAccountName(NULL,
					username,sid,&dwSid,domain,&dwDomain,&use))
				{
					dwSid=GetLengthSid(sid);
				/*	somPrintf("dwSid=%d\n",dwSid);*/
					somdd_eventSid=malloc(dwSid);
					memcpy(somdd_eventSid,sid,dwSid);
				}
			}
		}

		__try
		{
			ret=SOMDD_main(daemon,&executor,argc,argv);
		}
		__finally
		{
			HANDLE h=somdd_eventSource;
			void *pv=somdd_eventSid;
			somdd_eventSid=NULL;
			somdd_eventSource=NULL;
			if (h)
			{
				DeregisterEventSource(h);
			}
			if (pv)
			{
				free(pv);
			}

			RHBProcessMgr_term(&executor);
		}
	}

	return ret;
}

static void WINAPI SOMDD_ServiceMain(
		DWORD dwArgc,
		LPTSTR *lpszArgv)
{
	struct SOMDD_daemon daemon;
#if defined(USE_PTHREADS) && !defined(DONT_USE_SIGNALS)
	sigset_t sigs;
	sigemptyset(&sigs);
	sigaddset(&sigs,SIGTERM);
	sigaddset(&sigs,SIGINT);
	sigaddset(&sigs,SIGBREAK);
	sigaddset(&sigs,SIGHUP);
#ifdef SIGCHLD
	sigaddset(&sigs,SIGCHLD);
#else
	sigaddset(&sigs,SIGCLD);
#endif
#ifdef SIGIO
	sigaddset(&sigs,SIGIO);
#endif
#ifdef SIGPIPE
	sigaddset(&sigs,SIGPIPE);
#endif
	pthread_sigmask(SIG_BLOCK,&sigs,NULL);
#endif

	memset(&daemon,0,sizeof(daemon));

	daemon.status.dwServiceType=SERVICE_WIN32_OWN_PROCESS;
	daemon.status.dwCurrentState=SERVICE_START_PENDING;
	daemon.status.dwControlsAccepted=SERVICE_ACCEPT_STOP|SERVICE_ACCEPT_SHUTDOWN;

	daemon.status.dwCheckPoint=0;
	daemon.status.dwWaitHint=1000; /* a second */

	__try
	{
		somdd_daemon=&daemon;

		daemon.h_service=RegisterServiceCtrlHandler(szServiceName,SOMDD_ServiceCtrlHandler);

		SOMDD_setenv(szServiceName);

		SetServiceStatus(daemon.h_service,&daemon.status);

		SOMDD_run_main(&daemon,dwArgc,lpszArgv);
	}

	__finally
	{
		somdd_daemon=NULL;
		daemon.status.dwCheckPoint++;
		daemon.status.dwServiceType=SERVICE_WIN32_OWN_PROCESS;
		daemon.status.dwCurrentState=SERVICE_STOPPED;
		daemon.status.dwControlsAccepted=
				SERVICE_ACCEPT_STOP|
				SERVICE_ACCEPT_SHUTDOWN;

		SetServiceStatus(daemon.h_service,&daemon.status);
	}
}

static int SOMDD_WinNT_main(int argc,char **argv,int flags)
{
#ifdef USE_THREADS
BOOL b=0;
SERVICE_TABLE_ENTRY ste[2];

	memset(ste,0,sizeof(ste));

	ste[0].lpServiceName=szServiceName;
	ste[0].lpServiceProc=SOMDD_ServiceMain;

	SetLastError(ERROR_FAILED_SERVICE_CONTROLLER_CONNECT);

	#ifdef _DEBUG
		if (!(flags & SOMDD_FLAGS_DEBUG))
	#endif
		{
			b=StartServiceCtrlDispatcher(ste);
		}

	if (b) 
	{
		return 0;
	}
	else
	{
		DWORD err=GetLastError();

		if (err==ERROR_FAILED_SERVICE_CONTROLLER_CONNECT)
		{
			return SOMDD_run_main(NULL,argc,argv);
		}

		rhbutils_print_Win32Error(err,"StartServiceCtrlDispatcher");
	}

	return 1;
#else
	return SOMDD_run_main(NULL,argc,argv);
#endif
}

static int SOMDD_needs_quotes(const char *p,int len)
{
	while (len--)
	{
		if (isspace(*p)) return 1;
		p++;
	}

	return 0;
}

static int SOMDD_main_any(int argc,char **argv)
{
	int flags=0;

	if (argc > 0)
	{
		int i=1;

		while (i < argc)
		{
			char *p=argv[i];

			if ((*p=='/')||(*p=='-'))
			{
				p++;

				if ((*p=='e')||(*p=='E'))
				{
					char *q=++p;
					while (*q)
					{
						if (*q=='=')
						{
							int namelen=(int)(q-p);
							if (namelen)
							{
								char name[256];
								memcpy(name,p,namelen);
								name[namelen]=0;
								q++;
								if (*q)
								{
									SetEnvironmentVariable(name,q);
								}
								else
								{
									SetEnvironmentVariable(name,NULL);
								}
							}

							break;
						}

						if (*q)	q++;
					}
				}
				else
				{
					if (!strcasecmp(p,"DEBUG"))
					{
						flags|=SOMDD_FLAGS_DEBUG;
						p=NULL;
					}
					else
					{
						p--;
						printf("unknown option, %s\n",p);
						return 1;
					}
				}
			}

			if (p)
			{
				i++;
			}
			else
			{
				int k=i;
				while ((k+1) < argc)
				{
					argv[k]=argv[k+1];
					k++;
				}
				argc--;
			}
		}
	}

#if (defined(USE_SELECT) || defined(USE_PTHREADS) ) && !defined(DONT_USE_SIGNALS)
	{
		sigset_t sigs;
		sigemptyset(&sigs);
		sigaddset(&sigs,SIGTERM);
		sigaddset(&sigs,SIGBREAK);
		sigaddset(&sigs,SIGINT);
		sigaddset(&sigs,SIGHUP);
#ifdef SIGCHLD
		sigaddset(&sigs,SIGCHLD);
#else
		sigaddset(&sigs,SIGCLD);
#endif
#ifdef SIGIO
		sigaddset(&sigs,SIGIO);
#endif
#ifdef SIGPIPE
		sigaddset(&sigs,SIGPIPE);
#endif
#ifdef USE_PTHREADS
		pthread_sigmask(SIG_BLOCK,&sigs,NULL);
#else
		sigprocmask(SIG_BLOCK,&sigs,NULL);
#endif
	}
#endif

	return SOMDD_WinNT_main(argc,argv,flags);
}


static void SOMDD_unreg_env(char *szServiceName)
{
}

#ifdef _CONSOLE
	/* WIN32 console, SOMDD, use for debugging as well */
	int main(int argc,char **argv)
	{
	int rc=1;

		WSADATA wsd;

		SOMDD_AllocConsole();

		if (!WSAStartup(0x101,&wsd))
		{
			rc=SOMDD_main_any(argc,argv);

			WSACleanup();
		}

		return rc;
	}
#else
	/* WIN32 WinMain, SOMDDSVC use as NT service */
	int WINAPI WinMain(HINSTANCE h,HINSTANCE h2,LPSTR lp,int cmd)
	{
		int rc=1;
		WSADATA wsd;
		char buf[MAX_PATH];
		char *argv[32];
		int argc=0;
		int len=strlen(lp)+1;
		char *args=malloc(len);
		char *p=args;
		memcpy(args,lp,len);

		SOMDD_AllocConsole();

		GetModuleFileName(h,buf,sizeof(buf));

		argv[argc++]=buf;

		while (*p)
		{
			while (isspace(*p))
			{
				p++;

				if (!*p) break;
			}

			if (*p)
			{
				char c=*p;
				switch (c)
				{
				case '\"':
				case '\'':
					p++;
					break;
				default:
					c=0;
				}
				argv[argc++]=p;
				while (*p)
				{
					if (*p==c)
					{
						*p++=0;
						break;
					}
					else
					{
						if (isspace(*p) && !c)
						{
							*p++=0;
							break;
						}
						else
						{
							p++;
						}
					}
				}
			}
		}

		argv[argc]=NULL;

		if (argc)
		{
			int i=0;
			while (i < argc)
			{
				SOMDD_printf("<%s>\n",argv[i++]);
			}
		}

		if (!WSAStartup(0x101,&wsd))
		{
			rc=SOMDD_main_any(argc,argv);

			WSACleanup();
		}

		free(args);

		return rc;
	}
#endif

BOOL SOMDD_AllocConsole(void)
{
	return AllocConsole();
}

