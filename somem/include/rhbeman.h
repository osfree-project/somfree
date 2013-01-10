/* SOMEEMan internals.... */

#include <timerev.h>
#include <sinkev.h>
#include <workprev.h>

#ifdef _PLATFORM_UNIX_
	#include <sys/types.h>
	#include <sys/time.h>
	#include <unistd.h>
	#include <errno.h>
#endif

typedef enum 
{ 
	eman_cb_none, 
	eman_cb_proc,
	eman_cb_event,
	eman_cb_event_ev 
} RHBEMan_callback_type;

typedef struct RHBEMan_Entry
{
	QElem element;
	SOMEEManQueue *queue;

	struct RHBEMan_Entry *next;

	RHBEMan_callback_type eman_callback_type;
	somToken eman_callback_token;

	union
	{
		struct
		{
			EMRegProc *pfn;
		} eman_proc;
		struct 
		{
			SOMObject SOMSTAR target;
			EMMethodProc *pfn;
		} eman_event;
		struct 
		{
			SOMObject SOMSTAR target;
			EMMethodProcEv *pfn;
			Environment *ev;
		} eman_event_ev;
	} eman_callback;

	long token;

	union
	{
		struct 
		{
			SOCKET s_fd;
			long s_mask;
		} sink;

		struct
		{
			long t_interval;
			long t_count;
			long t_when;
		} timer;

		struct
		{
			corbastring ct_type;
		} client_type;

	} specifics;

} RHBEMan_Entry;



