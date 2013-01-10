#include <rhbopt.h>
#include <rhbsomex.h>

#ifdef SOMDLLEXPORT
	#define SOM_IMPORTEXPORT_somtc  SOMDLLEXPORT
#else
	#define SOM_IMPORTEXPORT_somtc  
#endif

#include <somtc.h>

SOMEXTERN GENERIC_SEQUENCE * SOMLINK tcSequenceNew(TypeCode t,
						    unsigned long max)
{
	GENERIC_SEQUENCE *s=(GENERIC_SEQUENCE *)SOMMalloc(sizeof(GENERIC_SEQUENCE));

	if (s)
	{
		s->_length=0;
		s->_maximum=max;

		if (max)
		{
			Environment ev;
			SOM_InitEnvironment(&ev);
			s->_buffer=SOMCalloc(max,tcSize(t,&ev));
			SOM_UninitEnvironment(&ev);
		}
		else
		{
			s->_buffer=NULL;
		}
	}

	return s;
}

SOMEXTERN _IDL_SEQUENCE_string SOMLINK tcSeqFromListString(const char *str)
{
	_IDL_SEQUENCE_string seq={0,0,NULL};

	if (str)
	{
		unsigned long num=1,len=1;
		unsigned long ptrs;
		const char *p=str;

		while (*p)
		{
			if (*p==',')
			{
				num++;
			}

			p++;
		}

		len+=(int)(p-str);
			
		ptrs=num*sizeof(char *);

		seq._buffer=SOMMalloc(ptrs+len);

		if (seq._buffer)
		{
			char *q=((char *)seq._buffer)+ptrs;
			char **h=seq._buffer;

			seq._length=seq._maximum=num;

			memcpy(q,str,len);

			*h++=q;

			while (*q)
			{
				if (*q++==',')
				{
					*h++=q;
					q[-1]=0;
				}
			}
		}
	}

	return seq;
}



