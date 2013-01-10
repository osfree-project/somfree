#include <rhbopt.h>

#define ServerRequest_Class_Source

#include <rhbsomd.h>
#include <servreq.ih>

SOM_Scope Context SOMSTAR SOMLINK servreq_ctx(ServerRequest SOMSTAR somSelf,Environment *ev)
{
ServerRequestData *somThis=ServerRequestGetData(somSelf);

	if (somThis->c_request)
	{
		return RHBServerRequest_ctx(somThis->c_request,ev);
	}

	return NULL;
}

struct servreq_set_result
{
	any ex_value;
	Environment ev;
};

RHBOPT_cleanup_begin(servreq_set_result_cleanup,pv)

struct servreq_set_result *data=pv;

	somdExceptionFree(&(data->ev));

	SOMD_FreeType(&(data->ev),&data->ex_value,TC_any);

	somdExceptionFree(&(data->ev));

RHBOPT_cleanup_end

SOM_Scope void SOMLINK servreq_set_result(ServerRequest SOMSTAR somSelf,Environment *ev,any *val)
{
ServerRequestData *somThis=ServerRequestGetData(somSelf);

	if (somThis->c_request)
	{
		if (ev->_major)
		{
			struct servreq_set_result data={{NULL,NULL}};
			RHBORB *orb=ORB__get_c_orb(SOMD_ORBObject,NULL);

			SOM_InitEnvironment(&data.ev);

			RHBOPT_cleanup_push(servreq_set_result_cleanup,&data);

			data.ex_value._type=RHBORB_get_exception_tc(orb,
						ev->_major,
						somExceptionId(ev));

			if (!data.ex_value._type)
			{
				somExceptionFree(ev);
				RHBOPT_throw_StExcep(ev,UNKNOWN,UnknownReposId,MAYBE);
				data.ex_value._type=somdTC_StExcep;
			}

			data.ex_value._value=ev->exception._params;
			ev->exception._params=NULL;
						
			RHBServerRequest_set_result(somThis->c_request,ev,&data.ex_value);

			RHBOPT_cleanup_pop();
		}
		else
		{
			RHBServerRequest_set_result(somThis->c_request,ev,val);
		}
	}
}

SOM_Scope void SOMLINK servreq_arguments(ServerRequest SOMSTAR somSelf,Environment *ev,NVList SOMSTAR *nv)
{
ServerRequestData *somThis=ServerRequestGetData(somSelf);

	if (somThis->c_request)
	{
		RHBServerRequest_params(somThis->c_request,ev,nv);
	}
}

SOM_Scope void SOMLINK servreq_set_exception(ServerRequest SOMSTAR somSelf,Environment *ev,any *val)
{
ServerRequestData *somThis=ServerRequestGetData(somSelf);

	if (somThis->c_request)
	{
		struct servreq_set_result data={{NULL,NULL}};

		SOM_InitEnvironment(&data.ev);

		RHBOPT_cleanup_push(servreq_set_result_cleanup,&data);

		if (ev->_major)
		{
			if (val->_value)
			{
				RHBOPT_ASSERT(val->_value != ev->exception._params)
			}
			else
			{
				val->_value=ev->exception._params;
				ev->exception._params=NULL;
			}

			RHBServerRequest_set_result(somThis->c_request,ev,val);
		}
		else
		{
			RHBOPT_throw_StExcep(&data.ev,INTERNAL,UnexpectedNULL,MAYBE);
			
			data.ex_value._type=somdTC_StExcep;
			data.ex_value._value=data.ev.exception._params;
			data.ev.exception._params=NULL;

			RHBServerRequest_set_result(somThis->c_request,
					&data.ev,
					&data.ex_value);
		}

		RHBOPT_cleanup_pop();
	}
}

SOM_Scope char * SOMLINK servreq__get_operation(ServerRequest SOMSTAR somSelf,Environment *ev)
{
ServerRequestData *somThis=ServerRequestGetData(somSelf);
RHBServerRequest *c_request=somThis->c_request;

	if (c_request)
	{
		return c_request->header.operation;
	}

	return NULL;
}

SOM_Scope RHBServerRequest * SOMLINK servreq__get_c_request(
		ServerRequest SOMSTAR somSelf,
		Environment *ev)
{
ServerRequestData *somThis=ServerRequestGetData(somSelf);
RHBServerRequest *c_request=somThis->c_request;

	if (c_request) 
	{
		RHBServerRequest_AddRef(c_request);
	}

	return c_request;
}

SOM_Scope void SOMLINK servreq__set_c_request(
		ServerRequest SOMSTAR somSelf,
		Environment *ev,
		RHBServerRequest *c_request)
{
ServerRequestData *somThis=ServerRequestGetData(somSelf);

	if (c_request != somThis->c_request)
	{
		RHBServerRequest *old=somThis->c_request;

		if (c_request) RHBServerRequest_AddRef(c_request);
		somThis->c_request=c_request;
		if (old) RHBServerRequest_Release(old);
	}
}

SOM_Scope void SOMLINK servreq_somUninit(
		ServerRequest SOMSTAR somSelf)
{
ServerRequestData *somThis=ServerRequestGetData(somSelf);
RHBServerRequest *c_request=somThis->c_request;

	somThis->c_request=NULL;

#ifdef ServerRequest_parent_SOMRefObject_somUninit
	ServerRequest_parent_SOMRefObject_somUninit(somSelf);
#else
	ServerRequest_parent_SOMObject_somUninit(somSelf);
#endif
	if (c_request) 
	{
		if (!(c_request->finished))
		{
			Environment ev;
			any a={NULL,NULL};

			SOM_InitEnvironment(&ev);

			RHBOPT_throw_StExcep(&ev,INTERNAL,DispatchError,MAYBE);

			a._type=somdTC_StExcep;
			a._value=ev.exception._params;
			ev.exception._params=NULL;

			RHBServerRequest_set_result(c_request,&ev,&a);

			SOM_UninitEnvironment(&ev);
		}

		RHBServerRequest_Release(c_request);
	}
}
