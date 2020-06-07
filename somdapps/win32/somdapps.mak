#
#  Copyright 2008, Roger Brown
#
#  This file is part of Roger Brown's Toolkit.
#
#  This program is free software: you can redistribute it and/or modify it
#  under the terms of the GNU Lesser General Public License as published by the
#  Free Software Foundation, either version 3 of the License, or (at your
#  option) any later version.
# 
#  This program is distributed in the hope that it will be useful, but WITHOUT
#  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
#  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
#  more details.
#
#  You should have received a copy of the GNU Lesser General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>
#
#  $Id$

!include $(MAKEDEFS)

SC=$(HOSTDIR_BIN)\sc.exe
IDLTOOL=$(RHBTOOLS_BIN)\idltool.exe

SOMIDL_IDL=..\..\somidl
SOMDD_DIR=..\..\somdd
SOMD_DIR=..\..\somd
REGIMPL_DIR=..\..\regimpl
SOMDDMSG_DIR=..\..\somddmsg
SOMDAPPS_DIR=..\..\somdapps
SOMDSVRP_DIR=..\..\somdsvrp

REGIMPL_INTDIR=$(REGIMPL_DIR)\$(PLATFORM)\$(BUILDTYPE)
SOMDD_INTDIR=$(SOMDD_DIR)\$(PLATFORM)\$(BUILDTYPE)
SOMDDMSG_INTDIR=$(SOMDDMSG_DIR)\$(PLATFORM)\$(BUILDTYPE)
SOMDSVRP_INTDIR=$(SOMDSVRP_DIR)\$(PLATFORM)\$(BUILDTYPE)

SOMDDSRV_IDL=$(SOMDD_DIR)\somddsrv.idl
SOMDDSRV_TC=$(SOMDD_INTDIR)\somddsrv.tc
SOMDDMC1_RC=$(SOMDDMSG_INTDIR)\somddmc1.rc
SOMDDMC1_H=$(SOMDDMSG_INTDIR)\somddmc1.h
SOMDDMC1_H=$(SOMDDMSG_INTDIR)\somddmc1.h
SOMDDMC1_RC=$(SOMDDMSG_INTDIR)\somddmc1.rc
SOMDDMC1_BIN=$(SOMDDMSG_INTDIR)\msg00001.bin

REGIORTC_TC=$(REGIMPL_INTDIR)\regiortc.tc
REGIORTC_IDL=$(REGIMPL_DIR)\regiortc.idl

SOMDD_IH=	$(SOMDD_INTDIR)\implreps.ih	\
			$(SOMDD_INTDIR)\implreps.h	\
			$(SOMDD_INTDIR)\somddevm.ih	\
			$(SOMDD_INTDIR)\somddevm.h	\
			$(SOMDD_INTDIR)\somddrep.ih	\
			$(SOMDD_INTDIR)\somddrep.h	\
			$(SOMDD_INTDIR)\somddsrv.ih	\
			$(SOMDD_INTDIR)\somddsrv.h

SOMDSVRP_IH=$(SOMDSVRP_INTDIR)\somdsvrp.ih	\
			$(SOMDSVRP_INTDIR)\somdsvrp.h

DIRS=		$(SOMDD_INTDIR)			\
			$(REGIMPL_INTDIR)		\
			$(SOMDDMSG_INTDIR)		\
			$(SOMDSVRP_INTDIR)

all:	$(DIRS)			\
		$(SOMDD_IH)		\
		$(SOMDDSRV_TC)	\
		$(REGIORTC_TC)	\
		$(SOMDDMC1_RC)	\
		$(SOMDDMC1_H)	\
		$(SOMDSVRP_IH)

clean:
	$(CLEAN) $(SOMDD_IH)
	$(CLEAN) $(SOMDDMC1_H)
	$(CLEAN) $(SOMDDMC1_RC)
	$(CLEAN) $(SOMDDMC1_BIN)
	$(CLEAN) $(SOMDDSRV_TC)
	$(CLEAN) $(SOMDDMC1_RC)
	$(CLEAN) $(SOMDDMC1_H)
	$(CLEAN) $(REGIORTC_TC)
	$(CLEAN) $(SOMDSVRP_IH)

$(SOMDD_IH):
	"$(IDLTOOL)" "$(SC)" $(SOMDD_DIR) -o $@ -p -I$(SOMDD_DIR) -I$(SOMIDL_IDL)

$(SOMDDSRV_TC): $(SC) $(SOMDSRV_IDL)
	"$(IDLTOOL)" "$(SC)" $(SOMDD_DIR) -o $@ -p -D__GENERATE_SOMDD__  -I$(SOMDD_DIR) -I$(SOMIDL_IDL)

$(REGIORTC_TC): $(SC) $(REGIORTC_IDL)
	"$(IDLTOOL)" $(SC) $(REGIMPL_DIR) -o $@ -p -D __GENERATE_REGIMPL__ -I$(REGIMPL_DIR) -I$(SOMD_DIR) -I$(SOMIDL_IDL)

$(SOMDDMC1_RC): $(SOMDDMSG_DIR)\somddmc1.mc
	cd $(SOMDDMSG_DIR)\$(PLATFORM)
	mc -r $(BUILDTYPE) -h $(BUILDTYPE) ..\somddmc1.mc
	cd $(SOMDAPPS_DIR)\$(PLATFORM)

$(SOMDDMC1_H): $(SOMDDMSG_DIR)\somddmc1.mc
	mc -h $(SOMDDMSG_INTDIR) -r $(SOMDDMSG_INTDIR) $(SOMDDMSG_DIR)\somddmc1.mc

$(DIRS):
	mkdir $@

$(SOMDSVRP_IH):
	"$(IDLTOOL)" "$(SC)" $(SOMDSVRP_DIR) -o $@ -p -I$(SOMDSVRP_DIR) -I$(SOMIDL_IDL)

dist:

test:
