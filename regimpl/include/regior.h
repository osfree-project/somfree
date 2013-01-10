ORBStatus RHB_create_ior(
		_IDL_SEQUENCE_octet *ior,
		Environment *ev,
		char *type_id,
		char *hostname,
		short port,
		_IDL_SEQUENCE_octet *object_key);

char *RHB_ior_string_from_octets(_IDL_SEQUENCE_octet *);
_IDL_SEQUENCE_octet RHB_octets_from_ior_string(char *);
void RHB_print_ior(
		_IDL_SEQUENCE_octet *ior,
		Environment *ev,long level);
