#include <sys/types.h>
#include <sys/stat.h>
#include <stdlib.h>
#include <som.h>
#include <somuutil.h>

#define null_if_null(x)    ((x) ? (x) : "(null)")

int main(int argc,char **argv)
{
	SOMClassMgr SOMSTAR mgr=somEnvironmentNew();

	somPrintf("\n");
	somPrintf("            D S O M   E N V I R O N M E N T   E V A L U A T I O N\n");
	somPrintf("\n");

	{
		char *sombase=getenv("SOMBASE");
		somPrintf(" SOMBASE = %s\n",null_if_null(sombase));
		somPrintf("\n");
	}

	{
		char *somenv=getenv("SOMENV");
		somPrintf(" SOMENV = %s\n",null_if_null(somenv));
		somPrintf("\n");
	}

	{
		char buf[1024]={0};

		if (!somutgetpath(buf))
		{
			somPrintf(" SOMDDIR = %s\n",null_if_null(buf));
			somPrintf("\n");
		}
	}

	{
		struct stat s;
		char *somir=somutgetshellenv("SOMIR","[somir]");
		somPrintf(" SOMIR = %s\n",null_if_null(somir));
		if (somir)
		{
			if (!stat(somir,&s))
			{
				somPrintf("  %s was found.\n",null_if_null(somir));
			}
		}
		somPrintf("\n");
	}

	{
		char *host=somutgetshellenv("HOSTNAME","[somd]");
		somPrintf(" HOSTNAME = %s\n",null_if_null(host));
		somPrintf("\n");
	}

	{
		char *proto=somutgetshellenv("SOMDPROTOCOLS","[somd]");
		somPrintf(" SOMDPROTOCOLS = %s\n",null_if_null(proto));
		somPrintf("\n");
	}

	{
		char *proto=somutgetshellenv("HOSTKIND","[somd]");
		somPrintf(" HOSTKIND = %s\n",null_if_null(proto));
		somPrintf("\n");
	}

	{
		char *proto=somutgetshellenv("SOMNMOBJREF","[somd]");
		if (proto && proto[0])
		{
			somPrintf(" SOMNMOBJREF setting was found.\n");
		}
		somPrintf("\n");
	}

	if (mgr)
	{
		somEnvironmentEnd();
	}

	return 0;
}
