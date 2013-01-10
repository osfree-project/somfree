/*****************************************************************************
 *
 * somddexe
 *
 * the idea is to have a child process that handles all the child process management
 * this solves the problem of inheriting file handles you shouldn't have
 *
 * a pipe, the file descriptor given on the command line, is used to convey
 * exec and kill commands
 * the return path will reply with creation results and obituaries
 * the client generates a unique id to refer to a child, this is finally
 * deleted in the obituary and can be reused there after
 *
 * the owner process never knows the true process id of the child process
 * at termination, this will reap all the children
 *
 */

#ifndef __RHBEXECD_H__
#define __RHBEXECD_H__

/*********************************************************************
 *
 * the protocol goes as follows
 * int32 packet_length
 * int32 command
 * int32 id
 * switch (commmand) {
 *    case LAUNCH:
 *        int32 lenProgram; char program[lenProgram]; 
 *        int32 argc;
 *        struct { int32 len; char str[len]; } argv[argc];
 *		  int32 lenTitle; char title[lenTitle];
 *    case KILL:
 *        int32 signum;
 *    case OBITUARY:
 *        int32 exitcode;
 *    case CLOSE:
 * }
 *
 */

#if defined(_WIN32) && defined(USE_THREADS) && !defined(USE_PTHREADS)
#	define USE_WIN32_IO
#endif

#define RHBEXECD_CLOSE			0		/* close down stream */
#define RHBEXECD_LAUNCH			1		/* fork/exec */
#define RHBEXECD_KILL			2		/* cmd to kill/signal process */
#define RHBEXECD_OBITUARY		3		/* report process has finished */
#define RHBEXECD_RELEASE		4		/* remove entry */

int rhbexecd_run(
#ifdef USE_WIN32_IO
		HANDLE fdInput,HANDLE fdOutput,
#else
		SOCKET fdInput,SOCKET fdOutput,
#endif
#ifdef _WIN32
		HANDLE fdConsole
#else
		SOCKET fdConsole
#endif
		);

#endif /* __RHBEXECD_H__ */

