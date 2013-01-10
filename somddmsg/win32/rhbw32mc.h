#ifdef RC_INVOKED
#else
	#include <somddmsg.h>
	#define IDM_DISPLAY_NAME		SOMDDMSG_DisplayName
	#define RHBW32MC_OpenLog        SOMDDMSG_OpenLog
	#define RHBW32MC_WriteLogA      SOMDDMSG_WriteLogA
	#define RHBW32MC_WriteLogW      SOMDDMSG_WriteLogW
	#define RHBW32MC_CloseLog       SOMDDMSG_CloseLog
#endif

#define IDS_APPLICATION		1
