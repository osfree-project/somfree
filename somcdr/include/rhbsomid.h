/* this spec follows the prototype of 'static_foreign_marshaler' */

SOM_IMPORTEXPORT_som SOMEXTERN void SOMLINK 
	somIdMarshal(
		void *latent_param,
		char *foreign_addr,
		SOMD_marshaling_direction_t direction,
		SOMD_marshaling_op_t function,
		CosStream_StreamIO SOMSTAR stream,
		Environment *ev);

