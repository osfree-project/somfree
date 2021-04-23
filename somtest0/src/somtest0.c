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

/* $Id$ */

#include <rhbopt.h>
#ifdef HAVE_SYS_TYPES_H
#	include <sys/types.h>
#endif
#include <time.h>
#include <rhbsomex.h>
#include <somtc.h>
#include <somtcnst.h>
#include <somir.h>
#include <containd.h>
#include <containr.h>
#include <repostry.h>
#include <stdio.h>
#include <stdlib.h>

#ifdef _WIN32
	#include <winsock.h>
#else
	#include <signal.h>
	#include <unistd.h>
	#include <sys/types.h>
	#include <sys/wait.h>
#endif

#if defined(USE_PTHREADS) && defined(HAVE_PTHREAD_CANCEL)
static int thread_waiting;
static pthread_cond_t thread_waiting_cond
#ifdef RHBOPT_PTHREAD_COND_INITIALIZER
	=RHBOPT_PTHREAD_COND_INITIALIZER
#endif
	;
#endif

#ifdef _WIN32
	int gethostid(void);
/*	int getdomainname(char *,int);*/
	#define sleep(x)    Sleep(x * 1000)
#endif

static int test_tc(char *name,Environment *ev,TypeCode tc)
{
	somPrintf("TC_%s size=%d, alignment %d\n",name,(int)tcSize(tc,ev),(int)tcAlignment(tc,ev));
	TypeCode_print(tc,ev);
	return 0;
}

#define do_tc(x)   if (test_tc(#x,ev,TC_##x)) return 1;

static int test_tcs(Environment *ev)
{
	do_tc(null);
	do_tc(void);
	do_tc(short);
	do_tc(ushort);
	do_tc(long);
	do_tc(ulong);
	do_tc(char);
	do_tc(boolean);
	do_tc(octet);
	do_tc(string);
	do_tc(float);
	do_tc(double);
	do_tc(any);
	do_tc(TypeCode);
	do_tc(Object);
	do_tc(Principal);
	do_tc(NamedValue);

	return 0;
}

static char test_pointer_base[11];

static void printVa(char *s,va_list ap)
{
#if defined(HAVE_VA_LIST_SCALAR) || defined(__ia64)
	somPrintf("{%s=%p}\n",s,ap);
#else
	#if defined(HAVE_VA_LIST_OVERFLOW_ARG_AREA) || defined(HAVE_VA_LIST___VA_OVERFLOW_ARG_AREA)
		#ifdef HAVE_VA_LIST___VA_OVERFLOW_ARG_AREA
			somPrintf("{%s=%p}\n",s,ap[0].__va_overflow_arg_area);
		#else
			somPrintf("{%s=%p}\n",s,ap[0].overflow_arg_area);
		#endif
	#else
		#if defined(HAVE_VA_LIST__A0) && defined(HAVE_VA_LIST__OFFSET)
			somPrintf("{%s=%p,%d}\n",ap._a0,ap._offset);
		#else
			#if defined(HAVE_VA_LIST___AP)
				somPrintf("%s=%p\n",s,ap.__ap);
			#else
				#if defined(HAVE_VA_LIST___GR_OFFS) && defined(HAVE_VA_LIST___GR_TOP)
					somPrintf("{%s=%p,%p,%p,%x,%x}\n",s,ap.__stack,ap.__gr_top,ap.__vr_top,ap.__gr_offs,ap.__vr_offs);
				#else
					somPrintf("{%s=%p,%d}\n",ap.__base,ap.__offset);
				#endif
			#endif
		#endif
	#endif
#endif
}

static int my_va_func2(TCKind kind,va_list args)
{
long i=0;

	somPrintf("va(");

	while (i < 11)
	{
		printVa("!",args);

		switch (kind)
		{
		case tk_long:
		case tk_ulong:
			{
				long l=va_arg(args,long);

				if (l != i)
				{
					fprintf(stderr,"vargs build wrong, %ld != %ld\n",l,i);
					fflush(stderr);

					return 1;
				}
			}
			break;
		case tk_short:
		case tk_ushort:
			{
				long l=(short)va_arg(args,int);

				if (l != i)
				{
					fprintf(stderr,"vargs build wrong, %ld != %ld\n",l,i);
					fflush(stderr);

					return 1;
				}
			}
			break;
		case tk_char:
		case tk_octet:
		case tk_boolean:
			{
				long l=(octet)va_arg(args,int);

				if (l != i)
				{
					fprintf(stderr,"vargs build wrong, %ld != %ld\n",l,i);
					fflush(stderr);

					return 1;
				}
			}
			break;
		case tk_float:
		case tk_double:
			{
				double l=va_arg(args,double);

				if (l != (double)i)
				{
					fprintf(stderr,"vargs build wrong, %f != %f\n",l,(double)i);
					fflush(stderr);

					return 1;
				}
			}
			break;
		case tk_pointer:
			{
				char *l=va_arg(args,char *);

				if (l != (test_pointer_base+i))
				{
					fprintf(stderr,"vargs build wrong, %p != %p\n",l,test_pointer_base+i);
					fflush(stderr);

					return 1;
				}
			}
			break;
		default:
			fprintf(stderr,"vargs bad TCKind %ld",(long)kind);
			fflush(stderr);

			return 1;
		}

		somPrintf("%ld",i);

		i++;

		if (i < 11) somPrintf(",");
	}

	somPrintf(")\n");

	return 0;
}

static int my_va_func(TCKind kind,...)
{
	int i=1;
	va_list args;
	
	va_start(args,kind);

	i=my_va_func2(kind,args);

	va_end(args);

	return i;
}

static int my_va_obj_func2(SOMObject SOMSTAR obj,va_list ap)
{
	SOMObject SOMSTAR tgt,SOMSTAR other=NULL;
	int err=1;

	printVa("my_va_obj_func2.1",ap);

	tgt=somvalistGetTarget(ap);

	printVa("my_va_obj_func2.2",ap);
	if (tgt != obj) 
	{
		somPrintf("target not right 1, %p!=%p\n",tgt,obj);

		return 1;
	}

	printVa("my_va_obj_func2.3",ap);
	tgt=somvalistGetTarget(ap);

	printVa("my_va_obj_func2.4",ap);
	if (tgt != obj) 
	{
		somPrintf("target not right 2, %p!=%p\n",tgt,obj);

		return 1;
	}

	printVa("my_va_obj_func2.5",ap);
	tgt=somvalistGetTarget(ap);
	printVa("my_va_obj_func2.6",ap);

	if (tgt != obj) 
	{
		somPrintf("target not right 3, %p!=%p\n",tgt,obj);

		return 1;
	}
	printVa("my_va_obj_func2.7",ap);

	other=SOMObjectNew();

	somvalistSetTarget(ap,other);

	printVa("my_va_obj_func2.8",ap);
	tgt=somvalistGetTarget(ap);
	printVa("my_va_obj_func2.9",ap);

	if (tgt == other)
	{
		somPrintf("object is current target\n");
		err=0;
	}
	else
	{
		somPrintf("target not right 4, %p!=%p\n",tgt,other);
		err=1;
	}

	SOMObject_somFree(other);

	return err;
}

static int my_va_obj_func(SOMObject SOMSTAR obj,...)
{
	int err=0;
	va_list ap;
	va_start(ap,obj);
	err=my_va_obj_func2(obj,ap);
	va_end(ap);
	return err;
}

static int diff_va(TCKind kind,...)
{
va_list ap;
void *p1;
void *p2;
#if defined(HAVE_VA_LIST___GR_OFFS) && defined(HAVE_VA_LIST___GR_TOP)
void *v1;
void *v2;
#endif
int k;

	va_start(ap,kind);

	printVa("begin",ap);

#if defined(HAVE_VA_LIST_SCALAR) || defined(__ia64)
	p1=ap;
#else
	#if defined(HAVE_VA_LIST_OVERFLOW_ARG_AREA) || defined(HAVE_VA_LIST___VA_OVERFLOW_ARG_AREA)
		#ifdef HAVE_VA_LIST___VA_OVERFLOW_ARG_AREA
			p1=ap[0].__va_overflow_arg_area;
		#else
			p1=ap[0].overflow_arg_area;
		#endif
	#else
		#if defined(HAVE_VA_LIST__A0) && defined(HAVE_VA_LIST__OFFSET)
			p1=(void *)(((char *)ap._a0)+ap._offset);
		#else
			#if defined(HAVE_VA_LIST___AP)
				p1=ap.__ap;
			#else
				#if defined(HAVE_VA_LIST___GR_OFFS) && defined(HAVE_VA_LIST___GR_TOP)
					p1=(void *)(((char *)ap.__gr_top)+ap.__gr_offs);
					v1=(void *)(((char *)ap.__vr_top)+ap.__vr_offs);
				#else
					p1=(void *)(((char *)ap.__base)+ap.__offset);
				#endif
			#endif
		#endif
	#endif
#endif

	switch (kind)
	{
	case tk_short:
		{
			short i=(short)va_arg(ap,int);

			if (!i)
			{
				return -1;
			}
		}
		break;
	case tk_long:
		{
			long i=va_arg(ap,long);
			if (!i)
			{
				k=-1;
			}
		}
		break;
	case tk_double:
		{
			double i=va_arg(ap,double);
			if (!i)
			{
				k=-1;
			}
		}
		break;
	case tk_pointer:
		{
			char * i=va_arg(ap,char *);
			if (!i)
			{
				k=-1;
			}
		}
		break;
	}

	printVa("end  ",ap);

#if defined(HAVE_VA_LIST_SCALAR) || defined(__ia64)
	p2=ap;
#else
	#if defined(HAVE_VA_LIST_OVERFLOW_ARG_AREA) || defined(HAVE_VA_LIST___VA_OVERFLOW_ARG_AREA)
		#ifdef HAVE_VA_LIST___VA_OVERFLOW_ARG_AREA
			p2=ap[0].__va_overflow_arg_area;
		#else
			p2=ap[0].overflow_arg_area;
		#endif
	#else
		#if defined(HAVE_VA_LIST__A0) && defined(HAVE_VA_LIST__OFFSET)
			p2=(void *)(((char *)ap._a0)+ap._offset);
		#else
			#if defined(HAVE_VA_LIST___AP)
				p2=ap.__ap;
			#else
				#if defined(HAVE_VA_LIST___GR_OFFS) && defined(HAVE_VA_LIST___GR_TOP)
					p2=(void *)(((char *)ap.__gr_top)+ap.__gr_offs);
					v2=(void *)(((char *)ap.__vr_top)+ap.__vr_offs);
				#else
					p2=(void *)(((char *)ap.__base)+ap.__offset);
				#endif
			#endif
		#endif
	#endif
#endif

	va_end(ap);

	{
		char *c1=p1;
		char *c2=p2;

		k=(int)(c2-c1);

		somPrintf("p.diff=%d\n",k);
	
		if (k > 0)
		{
			int i=(k << 1);
			octet *p=(void *)c1;
			while (i--)
			{
				somPrintf("%02X ",*p);
				p++;
			}
			somPrintf("\n");
		}	
	}

#if defined(HAVE_VA_LIST___GR_OFFS) && defined(HAVE_VA_LIST___GR_TOP)
	if (!k) {
		char *c1=v1;
		char *c2=v2;

		k=(int)(c2-c1);

		somPrintf("v.diff=%d\n",k);
	
		if (k > 0)
		{
			int i=(k << 1);
			octet *p=(void *)c1;
			while (i--)
			{
				somPrintf("%02X ",*p);
				p++;
			}
			somPrintf("\n");
		}	
	}
#endif

	return k;
}

static int test_vargs(void)
{
	int err=0;

	somPrintf("va_list difference ... int\n");
	diff_va(tk_short,0x12121212,0x34343434);
	somPrintf("va_list difference ... long\n");
	diff_va(tk_long,0x12121212L,0x34343434L);
	somPrintf("va_list difference ... pointer\n");
	diff_va(tk_pointer,"1","2");
	somPrintf("va_list difference ... double\n");
	diff_va(tk_double,1.0,2.0);

	{
		{
			somVaBuf buf;
			long l=0;
			TCKind kind=tk_long;
			va_list args;

			somPrintf("testing long vargs by calling...\n");
			err=my_va_func(kind,0L,1L,2L,3L,4L,5L,6L,7L,8L,9L,10L);

			if (err) return err;

			somPrintf("testing long vargs by construction...\n");
			buf=somVaBuf_create(0,0);

			while (l < 11)
			{
				somVaBuf_add(buf,&l,kind);
				l++;
			}

			somPrintf("calling somVaBuf_get_valist\n");

			somVaBuf_get_valist(buf,&args);

			printVa("call ",args);

			err=my_va_func2(kind,args);

			printVa("done ",args);

			somVaBuf_destroy(buf);
		}

		if (!err)
		{
			somVaBuf buf;
			short s=0;
			TCKind kind=tk_short;
			va_list args;

			somPrintf("testing short vargs by calling...\n");
			err=my_va_func(kind,0,1,2,3,4,5,6,7,8,9,10);

			if (err) return err;

			somPrintf("testing short vargs by construction...\n");
			buf=somVaBuf_create(0,0);

			while (s < 11)
			{
				somVaBuf_add(buf,&s,kind);
				s++;
			}

			somVaBuf_get_valist(buf,&args);
			err=my_va_func2(kind,args);

			somVaBuf_destroy(buf);
		}

		if (!err)
		{
			somVaBuf buf;
			octet o=0;
			TCKind kind=tk_octet;
			va_list args;

			somPrintf("testing octet vargs by calling...\n");
			err=my_va_func(kind,0,1,2,3,4,5,6,7,8,9,10);

			if (err) return err;

			somPrintf("testing octet vargs by construction...\n");
			buf=somVaBuf_create(0,0);

			while (o < 11)
			{
				somVaBuf_add(buf,&o,kind);
				o++;
			}

			somVaBuf_get_valist(buf,&args);
			err=my_va_func2(kind,args);

			somVaBuf_destroy(buf);
		}

		if (!err)
		{	/* this may not work.... */

			somVaBuf buf;
			float f=(float)0.0;
			TCKind kind=tk_float;
			va_list args;

			somPrintf("testing float vargs by calling...\n");
			err=my_va_func(kind,
				(float)0.0,
				(float)1.0,
				(float)2.0,
				(float)3.0,
				(float)4.0,
				(float)5.0,
				(float)6.0,
				(float)7.0,
				(float)8.0,
				(float)9.0,
				(float)10.0);

			if (err) return err;

			somPrintf("testing float vargs by construction...\n");
			buf=somVaBuf_create(0,0);

			while (f < (float)11.0)
			{
				somVaBuf_add(buf,&f,kind);
				f++;
			}

			somVaBuf_get_valist(buf,&args);
			err=my_va_func2(kind,args);

			somVaBuf_destroy(buf);
		}

		if (!err)
		{
			somVaBuf buf;
			double d=0.0;
			TCKind kind=tk_double;
			va_list args;

			somPrintf("testing double vargs by calling...\n");
			err=my_va_func(kind,0.0,1.0,2.0,3.0,4.0,5.0,6.0,7.0,8.0,9.0,10.0);

			if (err) return err;

			somPrintf("testing double vargs by construction...\n");
			buf=somVaBuf_create(0,0);

			while (d < 11.0)
			{
				somVaBuf_add(buf,&d,kind);
				d++;
			}

			somVaBuf_get_valist(buf,&args);
			err=my_va_func2(kind,args);

			somVaBuf_destroy(buf);
		}

		if (!err)
		{
			somVaBuf buf;
			char *p=test_pointer_base;
			TCKind kind=tk_pointer;
			va_list args;

			somPrintf("testing pointer vargs by calling...\n");
			err=my_va_func(kind,
				test_pointer_base,
				test_pointer_base+1,
				test_pointer_base+2,
				test_pointer_base+3,
				test_pointer_base+4,
				test_pointer_base+5,
				test_pointer_base+6,
				test_pointer_base+7,
				test_pointer_base+8,
				test_pointer_base+9,
				test_pointer_base+10
				);

			if (err) return err;

			somPrintf("testing pointer vargs by construction...\n");
			buf=somVaBuf_create(0,0);

			while (p < (test_pointer_base+11))
			{
				somVaBuf_add(buf,&p,kind);
				p++;
			}

			somVaBuf_get_valist(buf,&args);
			err=my_va_func2(kind,args);

			somVaBuf_destroy(buf);
		}

		if (!err)
		{
			SOMObject SOMSTAR obj=SOMObjectNew();
			err=my_va_obj_func(obj,obj,NULL);
			SOMObject_somFree(obj);
		}

		if (!err)
		{
			SOMObject SOMSTAR obj=SOMObjectNew();
			somVaBuf buf;
			TCKind kind=tk_pointer;
			void *nullPtr=NULL;
			va_list args;

			somPrintf("testing target vargs by construction...\n");
			buf=somVaBuf_create(0,0);

			somVaBuf_add(buf,&obj,kind);
			somVaBuf_add(buf,&obj,kind);
			somVaBuf_add(buf,&nullPtr,kind);

			somVaBuf_get_valist(buf,&args);
			err=my_va_obj_func2(obj,args);

			somVaBuf_destroy(buf);
			SOMObject_somFree(obj);
		}

	}

	return err;
}

#if defined(USE_PTHREADS)
static pthread_cond_t cond_1,cond_2,cond_3,cond_4;
static pthread_mutex_t mutex;

#if defined( HAVE_PTHREAD_CANCEL)
static pthread_key_t thread_tls;
static int was_TLS_cleanup,was_local_cleanup;
static void cleanup_tls(void *x)
{
	somPrintf("Cleanup TLS\n");
	pthread_mutex_lock(&mutex);
	somPrintf("Cleanup TLS locked\n");
	was_TLS_cleanup++;
	pthread_cond_signal(&cond_4);
	somPrintf("Cleanup TLS signalled\n");
	pthread_mutex_unlock(&mutex);
	somPrintf("Cleanup TLS unlocked\n");
}
static void * somtest0_thread_wait(void *);
#endif
static void * thread_run(void *);

int test_threads(Environment *ev)
{
	pthread_t thr;
	void *pv;
	int i;

	somPrintf("thread testing\n");

	pthread_cond_init(&cond_1,RHBOPT_pthread_condattr_default);
	pthread_cond_init(&cond_2,RHBOPT_pthread_condattr_default);
	pthread_cond_init(&cond_3,RHBOPT_pthread_condattr_default);
	pthread_cond_init(&cond_4,RHBOPT_pthread_condattr_default);
	pthread_mutex_init(&mutex,RHBOPT_pthread_mutexattr_default);

	pthread_mutex_lock(&mutex);

	pthread_create(&thr,RHBOPT_pthread_attr_default,thread_run,0);

	somPrintf("waiting for 1\n");
	pthread_cond_wait(&cond_1,&mutex);

	pthread_cond_signal(&cond_2);

	pthread_mutex_unlock(&mutex);

	somPrintf("calling 'pthread_join()'\n");

	i=pthread_join(thr,&pv);

	somPrintf("pthread_join() returned %d\n",i);

	if (i != 0)
	{
		fprintf(stderr,"pthread_join not working correctly\n");
		fflush(stderr);
#ifdef __AIX__
		/* we know that the AIX fails on this,
			let's catch other architectures with same problem */
#else
		return 1;
#endif
	}

	somPrintf("testing pthread_equal\n");

	i=pthread_equal(pthread_self(),thr);

	somPrintf("pthread_equal returned %d (should be zero)\n",i);

	somPrintf("clearing up bits\n");

#ifdef HAVE_PTHREAD_CANCEL
	#ifdef HAVE_PTHREAD_KEY_CREATE
		pthread_key_create(&thread_tls,cleanup_tls);
	#else
		pthread_keycreate(&thread_tls,cleanup_tls);
	#endif


	#if !defined(RHBOPT_PTHREAD_COND_INITIALIZER)
	pthread_cond_init(&thread_waiting_cond,RHBOPT_pthread_condattr_default);
	#endif

	somPrintf("Trying to get mutex\n");

	pthread_mutex_lock(&mutex);

	pthread_create(&thr,RHBOPT_pthread_attr_default,somtest0_thread_wait,0);

	while (!thread_waiting)
	{
		somPrintf("thread is not waiting...\n");

		pthread_cond_wait(&thread_waiting_cond,&mutex);
	}

	pthread_mutex_unlock(&mutex);

	somPrintf("canceling thread....\n");

	pthread_cancel(thr);

	somPrintf("Have cancelled thread....\n");

	pthread_mutex_lock(&mutex);

	somPrintf("Relocked for reaping....\n");

	while (!was_local_cleanup)
	{
		time_t now;
		struct timespec ts;
		time(&now);
		ts.tv_sec=now+5;
		ts.tv_nsec=0;

		somPrintf("waiting for local cleanup\n");

		pthread_cond_timedwait(&cond_3,&mutex,&ts);
	}

	while (!was_TLS_cleanup)
	{
		time_t now;
		struct timespec ts;
		time(&now);
		ts.tv_sec=now+5;
		ts.tv_nsec=0;

		somPrintf("waiting for TLS cleanup\n");

		pthread_cond_timedwait(&cond_4,&mutex,&ts);
	}

	somPrintf("thread is cancelled\n");

	pthread_mutex_unlock(&mutex);

	somPrintf("Waiting for thread....\n");

	i=pthread_join(thr,&pv);

	somPrintf("pthread_join() returned %d\n",i);

	#if !defined(RHBOPT_PTHREAD_COND_INITIALIZER)
	pthread_cond_destroy(&thread_waiting_cond);
	#endif
#endif

	pthread_mutex_lock(&mutex);
	pthread_cond_destroy(&cond_1);
	pthread_cond_destroy(&cond_2);
	pthread_cond_destroy(&cond_3);
	pthread_cond_destroy(&cond_4);
	pthread_mutex_unlock(&mutex);
	pthread_mutex_destroy(&mutex);

	somPrintf("thread test done\n");

	return i;
}

static void * thread_run(void *pv)
{
	Environment ev;

	SOM_InitEnvironment(&ev);

	somPrintf("thread started\n");
	pthread_mutex_lock(&mutex);
	pthread_cond_signal(&cond_1);
	somPrintf("waiting for 2\n");
	pthread_cond_wait(&cond_2,&mutex);
	pthread_mutex_unlock(&mutex);

	somPrintf("setting SOM exception\n");
	somSetException(&ev,SYSTEM_EXCEPTION,"::Hello::World",0);
	somPrintf("thread ending\n");

	SOM_UninitEnvironment(&ev);

	return 0;
}
#endif

#if defined(USE_PTHREADS)
#ifdef HAVE_PTHREAD_CANCEL
static void thread_cleanup(void *pv)
{
	somPrintf("thread cleanup called\n");
	was_local_cleanup++;
	pthread_cond_signal(&cond_3);
	pthread_mutex_unlock(&mutex);
	somPrintf("mutex unlocked in cleanup\n");
}
static void *somtest0_thread_wait(void *pv)
{
#ifdef HAVE_PTHREAD_ADDR_T
	pthread_setspecific(thread_tls,(pthread_addr_t)(void *)"Hello World");
#else
	pthread_setspecific(thread_tls,"Hello World");
#endif
	somPrintf("thread started\n");

	pthread_cleanup_push(thread_cleanup,&mutex);
	pthread_mutex_lock(&mutex);
	somPrintf("telling parent...\n");
	thread_waiting=1;
	pthread_cond_signal(&thread_waiting_cond);
	somPrintf("thread going to sleep....\n");
	while (1)
	{
		time_t now;
		struct timespec ts;
		time(&now);
		ts.tv_sec=now+5;
		ts.tv_nsec=0;
		if (!pthread_cond_timedwait(&cond_1,&mutex,&ts))
		{
			break;
		}
		somPrintf("now calling test cancel(1)....\n");
		pthread_testcancel();
	}
	somPrintf("now calling test cancel(2)....\n");
	pthread_testcancel();
	pthread_cleanup_pop(1);
	somPrintf("thread returned normally after cleanup\n");
	return 0;
}
#endif
#endif

void test_callstyle(SOMClassMgr SOMSTAR mgr)
{
somTD_SOMClassMgr_somFindClass td;
int i;
SOMClass SOMSTAR f;

	i=10;

	while (i--)
	{
		td=(somTD_SOMClassMgr_somFindClass)somResolve(mgr,SOMClassMgrClassData.somFindClass);

		if (td)
		{
			f=td(mgr,0,1,2);

#ifdef SOMClass_somRelease
			if (f) somReleaseClassReference(f);
#else
			RHBOPT_unused(f);
#endif
		}
	}

#ifdef SOM_METHOD_THUNKS
	{
		somId id;

		somPrintf("_WIN32 is %d\n",(int)_WIN32);
		somPrintf("_M_IX86 is %d\n",(int)_M_IX86);
		somPrintf("_MSC_VER is %d\n",(int)_MSC_VER);

		id=somIdFromString("SOMObject");
		td=(somTD_SOMClassMgr_somFindClass)SOMClassMgrClassData.somFindClass;
		f=td(mgr,id,1,2);
		if (f) 
		{
			SOMObject SOMSTAR o;
			somTD_SOMClass_somNew td;
			char *p;
			somTD_SOMObject_somGetClassName td2;

			td=(somTD_SOMClass_somNew)SOMClassClassData.somNew;
			o=td(f);
			td2=(somTD_SOMObject_somGetClassName)SOMObjectClassData.somGetClassName;
			p=td2(o);

			SOM_Resolve(o,SOMObject,somFree)(o);
	
			somReleaseClassReference(f);
		}
		SOMFree(id);
	}
#endif
}

int test_lookup(SOMClassMgr SOMSTAR mgr)
{
char *p;
char *id="somGetClassName";
somTD_SOMObject_somGetClassName td;

	td=(somTD_SOMObject_somGetClassName)SOMClass_somLookupMethod(mgr->mtab->classObject,&id);

	p=td(mgr);	

	RHBOPT_unused(p);

	return 0;
}


int test_types(void)
{
	Environment ev;

	SOM_InitEnvironment(&ev);

#ifdef _WIN32
	{
		__int64 l;
		l=0;
		somPrintf("length of __int64 is %d\n",sizeof(l));
	}

	{
		long double x;
		x=0;
		somPrintf("length of long double is %d\n",sizeof(x));
	}
#endif

	tcPrint(TC_void,&ev);
	tcPrint(TC_long,&ev);
	tcPrint(TC_float,&ev);
	tcPrint(TC_double,&ev);
	tcPrint(TC_string,&ev);
	tcPrint(TC_any,&ev);
	tcPrint(TC_NamedValue,&ev);

	SOM_UninitEnvironment(&ev);

	return 0;
}

static int main_somtest0(SOMClassMgr SOMSTAR clsMgr,int argc,char **argv)
{
	Environment ev;

	if (!clsMgr) return 1;

#ifdef _WIN32	
	somPrintf("_WIN32 is %d\n",(int)_WIN32);
#endif
#ifdef _WIN64	
	somPrintf("_WIN64 is %d\n",(int)_WIN64);
#endif
#ifdef _M_IX86
	somPrintf("_M_IX86 is %d\n",(int)_M_IX86);
#endif
#ifdef _MSC_VER
	somPrintf("_MSC_VER is %d\n",(int)_MSC_VER);
#endif
#ifdef __AIX__
	somPrintf("#define __AIX__\n");
#endif
#ifdef __DEC__
	somPrintf("#define __DEC__\n");
#endif
#ifdef __GNUC__
	somPrintf("#define __GNUC__ %d\n",(int)__GNUC__);
#endif
#ifdef __IBMC__
	somPrintf("#define __IBMC__\n");
#endif
#ifdef _DEBUG
	somPrintf("#define _DEBUG\n");
#endif
#ifdef _REENTRANT
	somPrintf("#define _REENTRANT\n");
#endif
/*#ifdef unix
	somPrintf("unix==%d\n",(int)unix);
#endif*/
#ifdef BSD
	somPrintf("#define BSD %d\n",(int)BSD);
#endif
#ifdef power
	somPrintf("#define power %d\n",(int)power);
#endif
#ifdef __power
	somPrintf("#define __power %d\n",(int)__power);
#endif
#ifdef __mips__
	somPrintf("#define __mips__ %d\n",(int)__mips__);
#endif
#ifdef __VA_REGBYTES
	somPrintf("#define __VA_REGBYTES %d\n",(int)__VA_REGBYTES);
#endif

	somPrintf("sizeof(TCKind)=%ld\n",(long)sizeof(TCKind));
	somPrintf("sizeof(completion_status)=%ld\n",(long)sizeof(completion_status));

	if (sizeof(TCKind)!=sizeof(completion_status))
	{
		somPrintf("TCKind!=completion_status,%ld,%ld\n",
				sizeof(TCKind),sizeof(completion_status));

		return 1;
	}

	SOMClassMgr_somDumpSelf(clsMgr,0);

	test_callstyle(clsMgr);

	test_lookup(clsMgr); 

	test_types();

	SOM_InitEnvironment(&ev);

	if (test_tcs(&ev))
	{
		if (ev._major)
		{
			somPrintf("%s\n",somExceptionId(&ev));
			SOM_UninitEnvironment(&ev);
			return 1;
		}
	}
		
	{
		long i;
		char *p;
		i=1;
		p=(char *)(void *)&i;
		if (*p) 
		{
			somPrintf("little-endian\n");
		}
		else
		{
			somPrintf("big-endian\n");
		}
	}

	if (test_vargs())
	{
		somPrintf("test_vargs failed\n");

		return 1;
	}


#ifdef USE_PTHREADS
	test_threads(&ev);
#endif

	if (argc > 0)
	{
		somPrintf("%s tests completed\n",argv[0]);
	}
	else
	{
		somPrintf("tests completed\n");
	}
	
	SOM_UninitEnvironment(&ev);

	return 0;
}

int main(int argc,char **argv)
{
	int i=-1;
	SOMClassMgr SOMSTAR mgr=somEnvironmentNew();

	if (mgr)
	{
		i=main_somtest0(mgr,argc,argv);

		somEnvironmentEnd();
	}

	return i;
}

