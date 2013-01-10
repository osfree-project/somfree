#ifndef RHBSOMKD_H
#define RHBSOMKD_H

#if defined(USE_THREADS) && !defined(USE_PTHREADS) && defined(_WIN32)
	#include <windows.h>
#endif

#include <rhbmtut.h>

typedef struct RHBSOMUT_KeyDataSetVtbl RHBSOMUT_KeyDataSetVtbl;
typedef struct
{
#ifdef USE_THREADS
	#ifdef USE_PTHREADS
		pthread_mutex_t mutex;
		#ifdef RHBOPT_PTHREAD_MUTEX_INITIALIZER
			#define RHBSOMUT_CriticalSectionInit	{RHBOPT_PTHREAD_MUTEX_INITIALIZER}
		#else
			#define RHBSOMUT_CriticalSectionInit	{{0}}
		#endif
	#else
		CRITICAL_SECTION crit_sect;
		#define RHBSOMUT_CriticalSectionInit	{{0}}
	#endif
#else
	long recurse_count;
	#define RHBSOMUT_CriticalSectionInit	{0}
#endif
} RHBSOMUT_CriticalSection;

#include <rhbsomuk.h>

struct RHBSOMUT_KeyDataSetVtbl
{
	void (*uninit)(RHBSOMUT_KeyDataSet *);
	boolean (*add)(RHBSOMUT_KeyDataSet *,RHBSOMUT_KeyData *);
	boolean (*remove)(RHBSOMUT_KeyDataSet *,RHBSOMUT_KeyData *);
	unsigned long (*count)(RHBSOMUT_KeyDataSet *);
	RHBSOMUT_KeyData *(*find)(RHBSOMUT_KeyDataSet *,RHBSOMUT_Key *);
	RHBSOMUT_KeyData *(*get)(RHBSOMUT_KeyDataSet *,unsigned long);
	boolean (*contains)(RHBSOMUT_KeyDataSet *,RHBSOMUT_KeyData *);
};

#define RHBCDR_kds_is_empty(kds)		 ((!((kds)->lpVtbl))||(!((kds)->dataset._length)))
#define RHBCDR_kds_locked_length(kds)	 ((kds)->dataset._length)
#define RHBCDR_kds_locked_get(kds,i)	 ((kds)->dataset._buffer[(i)])
#define RHBCDR_kds_locked_buffer(kds)	 ((kds)->dataset._buffer)

#ifdef RHBSOMKD_STATIC
static
#else
SOMEXTERN 
#endif
RHBSOMUT_KeyDataSet * SOMLINK RHBCDR_kds_init(RHBSOMUT_KeyDataSet *);

#define RHBCDR_kds_uninit(x)		(x)->lpVtbl->uninit(x)
#define RHBCDR_kds_add(x,y)			(x)->lpVtbl->add(x,y)
#define RHBCDR_kds_remove(x,y)		(x)->lpVtbl->remove(x,y)
#define RHBCDR_kds_count(x)			(x)->lpVtbl->count(x)
#define RHBCDR_kds_find(x,y)		(x)->lpVtbl->find(x,y)
#define RHBCDR_kds_get(x,y)			(x)->lpVtbl->get(x,y)
#define RHBCDR_kds_contains(x,y)	((x)->lpVtbl && (x)->lpVtbl->contains(x,y))

#ifdef PRAGMA_IMPORT_SUPPORTED
	#if PRAGMA_IMPORT_SUPPORTED
		#ifdef BUILD_SOMCDR
			#pragma export list RHBCDR_kds_init
		#else
			#pragma import list RHBCDR_kds_init
		#endif
	#endif /* PRAGMA_IMPORT_SUPPORTED */
#endif /* PRAGMA_IMPORT_SUPPORTED */

#if defined(BUILD_SOM) && defined(_WIN32)
static void rhbsomkd_init(void);
static void rhbsomkd_term(void);
#endif

#endif
