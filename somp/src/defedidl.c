#include <rhbopt.h>
/* code generater for defedidl.idl */
#define SOMPAttrEncoderDecoder_Class_Source
#include <rhbsomp.h>
#include <defedidl.ih>
/* overridden methods for ::SOMPAttrEncoderDecoder */
/* overridden method ::SOMPEncoderDecoderAbstract::sompEDWrite */
SOM_Scope void SOMLINK defedidl_sompEDWrite(
	SOMPAttrEncoderDecoder SOMSTAR somSelf,
	Environment *ev,
	/* in */ SOMPMediaInterfaceAbstract SOMSTAR thisMedia,
	/* in */ SOMPPersistentObject SOMSTAR thisObject)
{
	SOMPAttrEncoderDecoder_parent_SOMPEncoderDecoderAbstract_sompEDWrite(somSelf,ev,thisMedia,thisObject);
}
/* overridden method ::SOMPEncoderDecoderAbstract::sompEDRead */
SOM_Scope void SOMLINK defedidl_sompEDRead(
	SOMPAttrEncoderDecoder SOMSTAR somSelf,
	Environment *ev,
	/* in */ SOMPMediaInterfaceAbstract SOMSTAR thisMedia,
	/* in */ SOMPPersistentObject SOMSTAR thisObject)
{
	SOMPAttrEncoderDecoder_parent_SOMPEncoderDecoderAbstract_sompEDRead(somSelf,ev,thisMedia,thisObject);
}
/* overridden method ::SOMObject::somInit */
SOM_Scope void SOMLINK defedidl_somInit(
	SOMPAttrEncoderDecoder SOMSTAR somSelf)
{
	RHBOPT_unused(somSelf)

	SOMPAttrEncoderDecoder_parent_SOMPEncoderDecoderAbstract_somInit(somSelf);
}
/* introduced methods for ::SOMPAttrEncoderDecoder */
