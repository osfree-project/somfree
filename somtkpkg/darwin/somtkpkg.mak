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

include $(MAKEDEFS)

INTDIR=$(BUILDTYPE)

BUILD=../..
FRAMEWORKS=$(OUTDIR_FRAMEWORKS)
SUBFRAMEWORKS=$(FRAMEWORKS)/SOMTK.framework/Versions/$(FRAMEWORK_VERS)/Frameworks
PLUGINS=$(FRAMEWORKS)/SOMTK.framework/Versions/$(FRAMEWORK_VERS)/PlugIns
IMPLIBS=$(INTDIR)/implibs
FWIMPLIBS=$(INTDIR)/fwimplibs
SHARED=-dynamiclib -Wl,-single_module
BUNDLE=-bundle
OBJDIR=$(INTDIR)/obj
SRCDIR=../src
BINDIR=$(FRAMEWORKS)/SOMTK.framework/Versions/$(FRAMEWORK_VERS)/bin
STDLIB=-lpthread -lc -L$(BUILD)/products/$(PLATFORM)/$(BUILDTYPE)/lib -lrhbmtuta $(DLLIBS)

all: SOMTK \
	$(BINDIR) \
	$(PLUGINS) \
	$(BINDIR)/pdl \
	$(BINDIR)/irdump \
	$(PLUGINS)/somir.dll \
	$(PLUGINS)/somref.dll \
	$(PLUGINS)/somcslib.dll \
	$(PLUGINS)/somu.dll \
	$(PLUGINS)/somu2.dll \
	$(PLUGINS)/somestrm.dll \
	$(PLUGINS)/somnmf.dll \
	$(PLUGINS)/somdcomm.dll \
	$(PLUGINS)/somcorba.dll \
	$(PLUGINS)/somany.dll \
	$(PLUGINS)/somcdr.dll \
	$(PLUGINS)/somd.dll \
	$(PLUGINS)/somabs1.dll \
	$(PLUGINS)/somos.dll \
	$(BINDIR)/somdd \
	$(BINDIR)/regimpl \
	$(BINDIR)/somdsvr \
	$(BINDIR)/dsom \
	$(BINDIR)/somossvr \
	$(BINDIR)/somipc \
	$(BINDIR)/somdchk \
	$(FRAMEWORKS)/SOM.framework/SOM \
	$(FRAMEWORKS)/SOMTC.framework/SOMTC \
	$(FRAMEWORKS)/SOMREF.framework/SOMREF \
	$(FRAMEWORKS)/SOMIR.framework/SOMIR \
	$(FRAMEWORKS)/SOMU.framework/SOMU \
	$(FRAMEWORKS)/SOMU2.framework/SOMU2 \
	$(FRAMEWORKS)/SOMABS1.framework/SOMABS1 \
	$(FRAMEWORKS)/SOMANY.framework/SOMANY \
	$(FRAMEWORKS)/SOMCORBA.framework/SOMCORBA \
	fwimplibs \
	$(FRAMEWORKS)/SOMCDR.framework/SOMCDR \
	$(FRAMEWORKS)/SOMNMF.framework/SOMNMF \
	$(FRAMEWORKS)/SOMESTRM.framework/SOMESTRM \
	$(FRAMEWORKS)/SOMDCOMM.framework/SOMDCOMM \
	$(FRAMEWORKS)/SOMD.framework/SOMD \
	$(FRAMEWORKS)/SOMOS.framework/SOMOS \
	$(FRAMEWORKS)/SOMCSLIB.framework/SOMCSLIB \
	$(FRAMEWORKS)/somir.dll \
	$(FRAMEWORKS)/somref.dll \
	$(FRAMEWORKS)/somcslib.dll \
	$(FRAMEWORKS)/somu.dll \
	$(FRAMEWORKS)/somu2.dll \
	$(FRAMEWORKS)/somestrm.dll \
	$(FRAMEWORKS)/somnmf.dll \
	$(FRAMEWORKS)/somdcomm.dll \
	$(FRAMEWORKS)/somcorba.dll \
	$(FRAMEWORKS)/somany.dll \
	$(FRAMEWORKS)/somcdr.dll \
	$(FRAMEWORKS)/somd.dll \
	$(FRAMEWORKS)/somabs1.dll \
	$(FRAMEWORKS)/somos.dll

clean:
	rm -rf $(BINDIR) $(IMPLIBS) $(FWIMPLIBS) \
	$(FRAMEWORKS)/SOMTK.framework \
	$(OBJDIR) \
	$(FRAMEWORKS)/SOM.framework \
	$(FRAMEWORKS)/SOMTC.framework \
	$(FRAMEWORKS)/SOMREF.framework \
	$(FRAMEWORKS)/SOMIR.framework \
	$(FRAMEWORKS)/SOMU.framework \
	$(FRAMEWORKS)/SOMU2.framework \
	$(FRAMEWORKS)/SOMCSLIB.framework \
	$(FRAMEWORKS)/SOMABS1.framework \
	$(FRAMEWORKS)/SOMANY.framework \
	$(FRAMEWORKS)/SOMD.framework \
	$(FRAMEWORKS)/SOMDCOMM.framework \
	$(FRAMEWORKS)/SOMOS.framework \
	$(FRAMEWORKS)/SOMCDR.framework \
	$(FRAMEWORKS)/SOMESTRM.framework \
	$(FRAMEWORKS)/SOMNMF.framework \
	$(FRAMEWORKS)/SOMCORBA.framework \
	$(FRAMEWORKS)/somir.dll \
	$(FRAMEWORKS)/somref.dll \
	$(FRAMEWORKS)/somcslib.dll \
	$(FRAMEWORKS)/somabs1.dll \
	$(FRAMEWORKS)/somu.dll \
	$(FRAMEWORKS)/somu2.dll \
	$(FRAMEWORKS)/somestrm.dll \
	$(FRAMEWORKS)/somnmf.dll \
	$(FRAMEWORKS)/somdcomm.dll \
	$(FRAMEWORKS)/somcorba.dll \
	$(FRAMEWORKS)/somany.dll \
	$(FRAMEWORKS)/somcdr.dll \
	$(FRAMEWORKS)/somd.dll \
	$(FRAMEWORKS)/somos.dll

$(SUBFRAMEWORKS)/SOM.framework/Versions/$(FRAMEWORK_VERS) \
$(SUBFRAMEWORKS)/SOMREF.framework/Versions/$(FRAMEWORK_VERS) \
$(SUBFRAMEWORKS)/SOMTC.framework/Versions/$(FRAMEWORK_VERS) \
$(SUBFRAMEWORKS)/SOMIR.framework/Versions/$(FRAMEWORK_VERS) \
$(SUBFRAMEWORKS)/SOMD.framework/Versions/$(FRAMEWORK_VERS) \
$(SUBFRAMEWORKS)/SOMU.framework/Versions/$(FRAMEWORK_VERS) \
$(SUBFRAMEWORKS)/SOMU2.framework/Versions/$(FRAMEWORK_VERS) \
$(SUBFRAMEWORKS)/SOMABS1.framework/Versions/$(FRAMEWORK_VERS) \
$(SUBFRAMEWORKS)/SOMESTRM.framework/Versions/$(FRAMEWORK_VERS) \
$(SUBFRAMEWORKS)/SOMOS.framework/Versions/$(FRAMEWORK_VERS) \
$(SUBFRAMEWORKS)/SOMNMF.framework/Versions/$(FRAMEWORK_VERS) \
$(SUBFRAMEWORKS)/SOMDCOMM.framework/Versions/$(FRAMEWORK_VERS) \
$(SUBFRAMEWORKS)/SOMANY.framework/Versions/$(FRAMEWORK_VERS) \
$(SUBFRAMEWORKS)/SOMCORBA.framework/Versions/$(FRAMEWORK_VERS) \
$(SUBFRAMEWORKS)/SOMCDR.framework/Versions/$(FRAMEWORK_VERS) \
$(SUBFRAMEWORKS)/SOMCSLIB.framework/Versions/$(FRAMEWORK_VERS) \
$(IMPLIBS)/SOMESTRM.framework/Versions/$(FRAMEWORK_VERS) \
$(IMPLIBS)/SOMOS.framework/Versions/$(FRAMEWORK_VERS) \
$(IMPLIBS)/SOMNMF.framework/Versions/$(FRAMEWORK_VERS) \
$(BINDIR) $(OBJDIR) $(PLUGINS) \
$(FWIMPLIBS)/SOMESTRM.framework/Versions/$(FRAMEWORK_VERS) \
$(FWIMPLIBS)/SOMOS.framework/Versions/$(FRAMEWORK_VERS) \
$(FWIMPLIBS)/SOMNMF.framework/Versions/$(FRAMEWORK_VERS) \
$(FRAMEWORKS)/SOMIR.framework/Versions/$(FRAMEWORK_VERS) \
$(FRAMEWORKS)/SOMTC.framework/Versions/$(FRAMEWORK_VERS) \
$(FRAMEWORKS)/SOM.framework/Versions/$(FRAMEWORK_VERS) \
$(FRAMEWORKS)/SOMCDR.framework/Versions/$(FRAMEWORK_VERS) \
$(FRAMEWORKS)/SOMCSLIB.framework/Versions/$(FRAMEWORK_VERS) \
$(FRAMEWORKS)/SOMU.framework/Versions/$(FRAMEWORK_VERS) \
$(FRAMEWORKS)/SOMU2.framework/Versions/$(FRAMEWORK_VERS) \
$(FRAMEWORKS)/SOMABS1.framework/Versions/$(FRAMEWORK_VERS) \
$(FRAMEWORKS)/SOMANY.framework/Versions/$(FRAMEWORK_VERS) \
$(FRAMEWORKS)/SOMCORBA.framework/Versions/$(FRAMEWORK_VERS) \
$(FRAMEWORKS)/SOMNMF.framework/Versions/$(FRAMEWORK_VERS) \
$(FRAMEWORKS)/SOMOS.framework/Versions/$(FRAMEWORK_VERS) \
$(FRAMEWORKS)/SOMDCOMM.framework/Versions/$(FRAMEWORK_VERS) \
$(FRAMEWORKS)/SOMD.framework/Versions/$(FRAMEWORK_VERS) \
$(FRAMEWORKS)/SOMESTRM.framework/Versions/$(FRAMEWORK_VERS) \
$(FRAMEWORKS)/SOMREF.framework/Versions/$(FRAMEWORK_VERS):
	mkdir -p $@

SOMTK: $(FRAMEWORKS)/SOMTK.framework/Versions/$(FRAMEWORK_VERS)/SOMTK $(FRAMEWORKS)/SOMTK.framework/SOMTK

SOM: $(SUBFRAMEWORKS)/SOM.framework/Versions/$(FRAMEWORK_VERS)/SOM $(SUBFRAMEWORKS)/SOM.framework/SOM

SOMCSLIB: $(SUBFRAMEWORKS)/SOMCSLIB.framework/Versions/$(FRAMEWORK_VERS)/SOMCSLIB $(SUBFRAMEWORKS)/SOMCSLIB.framework/SOMCSLIB

SOMTC: $(SUBFRAMEWORKS)/SOMTC.framework/Versions/$(FRAMEWORK_VERS)/SOMTC $(SUBFRAMEWORKS)/SOMTC.framework/SOMTC

SOMIR: $(SUBFRAMEWORKS)/SOMIR.framework/Versions/$(FRAMEWORK_VERS)/SOMIR $(SUBFRAMEWORKS)/SOMIR.framework/SOMIR

SOMREF: $(SUBFRAMEWORKS)/SOMREF.framework/Versions/$(FRAMEWORK_VERS)/SOMREF $(SUBFRAMEWORKS)/SOMREF.framework/SOMREF

SOMANY: $(SUBFRAMEWORKS)/SOMANY.framework/Versions/$(FRAMEWORK_VERS)/SOMANY $(SUBFRAMEWORKS)/SOMANY.framework/SOMANY

SOMCORBA: $(SUBFRAMEWORKS)/SOMCORBA.framework/Versions/$(FRAMEWORK_VERS)/SOMCORBA $(SUBFRAMEWORKS)/SOMCORBA.framework/SOMCORBA

SOMOS: $(SUBFRAMEWORKS)/SOMOS.framework/Versions/$(FRAMEWORK_VERS)/SOMOS $(SUBFRAMEWORKS)/SOMOS.framework/SOMOS

SOMCDR: $(SUBFRAMEWORKS)/SOMCDR.framework/Versions/$(FRAMEWORK_VERS)/SOMCDR $(SUBFRAMEWORKS)/SOMCDR.framework/SOMCDR

SOMNMF: $(SUBFRAMEWORKS)/SOMNMF.framework/Versions/$(FRAMEWORK_VERS)/SOMNMF $(SUBFRAMEWORKS)/SOMNMF.framework/SOMNMF

SOMESTRM: $(SUBFRAMEWORKS)/SOMESTRM.framework/Versions/$(FRAMEWORK_VERS)/SOMESTRM $(SUBFRAMEWORKS)/SOMESTRM.framework/SOMESTRM

SOMDCOMM: $(SUBFRAMEWORKS)/SOMDCOMM.framework/Versions/$(FRAMEWORK_VERS)/SOMDCOMM $(SUBFRAMEWORKS)/SOMDCOMM.framework/SOMDCOMM

SOMD: $(SUBFRAMEWORKS)/SOMD.framework/Versions/$(FRAMEWORK_VERS)/SOMD $(SUBFRAMEWORKS)/SOMD.framework/SOMD

SOMABS1: $(SUBFRAMEWORKS)/SOMABS1.framework/Versions/$(FRAMEWORK_VERS)/SOMABS1 $(SUBFRAMEWORKS)/SOMABS1.framework/SOMABS1

SOMU: $(SUBFRAMEWORKS)/SOMU.framework/Versions/$(FRAMEWORK_VERS)/SOMU $(SUBFRAMEWORKS)/SOMU.framework/SOMU

SOMU2: $(SUBFRAMEWORKS)/SOMU2.framework/Versions/$(FRAMEWORK_VERS)/SOMU2 $(SUBFRAMEWORKS)/SOMU2.framework/SOMU2

implibs: $(IMPLIBS)/SOMESTRM.framework/SOMESTRM $(IMPLIBS)/SOMOS.framework/SOMOS $(IMPLIBS)/SOMNMF.framework/SOMNMF

fwimplibs: $(FWIMPLIBS)/SOMESTRM.framework/SOMESTRM $(FWIMPLIBS)/SOMOS.framework/SOMOS $(FWIMPLIBS)/SOMNMF.framework/SOMNMF

$(FRAMEWORKS)/SOMTK.framework/Versions/$(FRAMEWORK_VERS)/SOMTK: SOM SOMREF SOMTC SOMIR SOMU SOMU2 SOMABS1 SOMANY SOMCORBA implibs SOMCDR SOMNMF SOMESTRM SOMDCOMM SOMD SOMOS SOMCSLIB
	rm -rf $@.*
	for d in `../../toolbox/lipoarch.sh $(SUBFRAMEWORKS)/SOM.framework/SOM`; do \
	echo "const char somtk_arch[]=\"$$d\";" >$(INTDIR)/SOMTK.arch.c; \
	$(CC) -arch $$d 			\
		$(INTDIR)/SOMTK.arch.c \
		`if test "$(PLATFORM_ISYSROOT)" != ""; then echo -isysroot "$(PLATFORM_ISYSROOT)" ; fi` \
		-dynamiclib -o $@.$$d 	\
		-Wl,-install_name,/Library/Frameworks/SOMTK.framework/Versions/$(FRAMEWORK_VERS)/SOMTK \
		-sub_umbrella SOM 		\
		-sub_umbrella SOMTC 	\
		-sub_umbrella SOMIR 	\
		-sub_umbrella SOMREF 	\
		-sub_umbrella SOMU 	\
		-sub_umbrella SOMU2 	\
		-sub_umbrella SOMABS1 	\
		-sub_umbrella SOMNMF 	\
		-sub_umbrella SOMESTRM \
		-sub_umbrella SOMCORBA \
		-sub_umbrella SOMDCOMM	\
		-sub_umbrella SOMANY	\
		-sub_umbrella SOMOS	\
		-sub_umbrella SOMD		\
		-sub_umbrella SOMCDR 	\
		-sub_umbrella SOMCSLIB	\
		-F$(SUBFRAMEWORKS)		\
		-framework SOM			\
		-framework SOMREF		\
		-framework SOMIR		\
		-framework SOMU			\
		-framework SOMU2		\
		-framework SOMABS1		\
		-framework SOMNMF		\
		-framework SOMESTRM		\
		-framework SOMDCOMM		\
		-framework SOMOS		\
		-framework SOMD			\
		-framework SOMCDR		\
		-framework SOMCORBA		\
		-framework SOMANY		\
		-framework SOMCSLIB		\
		$(UUIDLIBS)				\
		-framework SOMTC;		\
		rm $(INTDIR)/SOMTK.arch.c; \
	done
	ls -ld $@.*
	if test `ls $@.* | wc -l` -gt 1; then lipo -create -output $@ $@.*; rm $@.*; lipo -info $@; else mv $@.* $@; fi
	file $@
	lipo -info $@

SOM_OBJS=$(BUILD)/som/$(PLATFORM)/$(BUILDTYPE)/somalloc.o	\
		$(BUILD)/som/$(PLATFORM)/$(BUILDTYPE)/somkern.o		\
		$(BUILD)/som/$(PLATFORM)/$(BUILDTYPE)/sommutex.o	\
		$(BUILD)/som/$(PLATFORM)/$(BUILDTYPE)/somobjva.o	\
		$(BUILD)/som/$(PLATFORM)/$(BUILDTYPE)/somapi.o		\
		$(BUILD)/som/$(PLATFORM)/$(BUILDTYPE)/rhbsomid.o	\
		$(BUILD)/som/$(PLATFORM)/$(BUILDTYPE)/somshlb.o		\
		$(OBJDIR)/somkpath.o

SOMREF_OBJS=$(BUILD)/somref/$(PLATFORM)/$(BUILDTYPE)/somref.o		

SOMCSLIB_OBJS=$(BUILD)/somcslib/$(PLATFORM)/$(BUILDTYPE)/xmscssae.o		

SOMTC_OBJS=$(BUILD)/somtc/$(PLATFORM)/$(BUILDTYPE)/rhbsomtc.o	\
			$(BUILD)/somtc/$(PLATFORM)/$(BUILDTYPE)/rhbsomva.o 	\
			$(BUILD)/somtc/$(PLATFORM)/$(BUILDTYPE)/rhbsomts.o 

SOMOS_OBJS=$(BUILD)/somos/$(PLATFORM)/$(BUILDTYPE)/rhbsomos.o	\
			$(BUILD)/somos/$(PLATFORM)/$(BUILDTYPE)/somos.o 	\
			$(BUILD)/somos/$(PLATFORM)/$(BUILDTYPE)/somosutl.o 	\
			$(BUILD)/somos/$(PLATFORM)/$(BUILDTYPE)/somap.o 

SOMCORBA_OBJS=$(BUILD)/somcorba/$(PLATFORM)/$(BUILDTYPE)/rhbcorba.o	\
			$(BUILD)/somcorba/$(PLATFORM)/$(BUILDTYPE)/corba.o 

SOMDCOMM_OBJS=$(BUILD)/somdcomm/$(PLATFORM)/$(BUILDTYPE)/formarsh.o	\
			$(BUILD)/somdcomm/$(PLATFORM)/$(BUILDTYPE)/rhbsomus.o \
			$(BUILD)/somdcomm/$(PLATFORM)/$(BUILDTYPE)/somdcomm.o 

SOMANY_OBJS=$(BUILD)/somany/$(PLATFORM)/$(BUILDTYPE)/rhbdynam.o	\
			$(BUILD)/somany/$(PLATFORM)/$(BUILDTYPE)/dynany.o 

SOMCDR_OBJS=$(BUILD)/somcdr/$(PLATFORM)/$(BUILDTYPE)/somcdr.o	\
			$(BUILD)/somcdr/$(PLATFORM)/$(BUILDTYPE)/rhbsomkd.o \
			$(BUILD)/somcdr/$(PLATFORM)/$(BUILDTYPE)/rhbsomue.o \
			$(BUILD)/somcdr/$(PLATFORM)/$(BUILDTYPE)/rhbsomut.o 

SOMESTRM_OBJS=$(BUILD)/somestrm/$(PLATFORM)/$(BUILDTYPE)/rhbestrm.o	\
			$(BUILD)/somestrm/$(PLATFORM)/$(BUILDTYPE)/omgestio.o 	\
			$(BUILD)/somestrm/$(PLATFORM)/$(BUILDTYPE)/somestio.o 

SOMNMF_OBJS=$(BUILD)/somnmf/$(PLATFORM)/$(BUILDTYPE)/biter.o	\
			$(BUILD)/somnmf/$(PLATFORM)/$(BUILDTYPE)/lname.o 	\
			$(BUILD)/somnmf/$(PLATFORM)/$(BUILDTYPE)/naming.o 	\
			$(BUILD)/somnmf/$(PLATFORM)/$(BUILDTYPE)/rhbsomnm.o 	\
			$(BUILD)/somnmf/$(PLATFORM)/$(BUILDTYPE)/xnaming.o 	\
			$(BUILD)/somnmf/$(PLATFORM)/$(BUILDTYPE)/xnamingf.o 	\
			$(BUILD)/somnmf/$(PLATFORM)/$(BUILDTYPE)/lnamec.o 

SOMD_OBJS=$(BUILD)/somd/$(PLATFORM)/$(BUILDTYPE)/rhbgiop1.o	\
			$(BUILD)/somd/$(PLATFORM)/$(BUILDTYPE)/rhbgiop2.o 	\
			$(BUILD)/somd/$(PLATFORM)/$(BUILDTYPE)/rhbgiop3.o 	\
			$(BUILD)/somd/$(PLATFORM)/$(BUILDTYPE)/rhbgiop4.o 	\
			$(BUILD)/somd/$(PLATFORM)/$(BUILDTYPE)/rhbgiop5.o 	\
			$(BUILD)/somd/$(PLATFORM)/$(BUILDTYPE)/rhbgiop6.o 	\
			$(BUILD)/somd/$(PLATFORM)/$(BUILDTYPE)/rhbgiop7.o 	\
			$(BUILD)/somd/$(PLATFORM)/$(BUILDTYPE)/rhbgiop8.o 	\
			$(BUILD)/somd/$(PLATFORM)/$(BUILDTYPE)/rhbgiop9.o 	\
			$(BUILD)/somd/$(PLATFORM)/$(BUILDTYPE)/rhbgiops.o 	\
			$(BUILD)/somd/$(PLATFORM)/$(BUILDTYPE)/rhborbst.o 	\
			$(BUILD)/somd/$(PLATFORM)/$(BUILDTYPE)/request.o 	\
			$(BUILD)/somd/$(PLATFORM)/$(BUILDTYPE)/om.o 		\
			$(BUILD)/somd/$(PLATFORM)/$(BUILDTYPE)/nvlist.o 	\
			$(BUILD)/somd/$(PLATFORM)/$(BUILDTYPE)/orb.o	 	\
			$(BUILD)/somd/$(PLATFORM)/$(BUILDTYPE)/poa.o 		\
			$(BUILD)/somd/$(PLATFORM)/$(BUILDTYPE)/principl.o 	\
			$(BUILD)/somd/$(PLATFORM)/$(BUILDTYPE)/impldef.o 	\
			$(BUILD)/somd/$(PLATFORM)/$(BUILDTYPE)/implrep.o 	\
			$(BUILD)/somd/$(PLATFORM)/$(BUILDTYPE)/boa.o 		\
			$(BUILD)/somd/$(PLATFORM)/$(BUILDTYPE)/cntxt.o 		\
			$(BUILD)/somd/$(PLATFORM)/$(BUILDTYPE)/unotypes.o 	\
			$(BUILD)/somd/$(PLATFORM)/$(BUILDTYPE)/servmgr.o 	\
			$(BUILD)/somd/$(PLATFORM)/$(BUILDTYPE)/servreq.o 	\
			$(BUILD)/somd/$(PLATFORM)/$(BUILDTYPE)/somdobj.o 	\
			$(BUILD)/somd/$(PLATFORM)/$(BUILDTYPE)/somdcprx.o 	\
			$(BUILD)/somd/$(PLATFORM)/$(BUILDTYPE)/somdmprx.o 	\
			$(BUILD)/somd/$(PLATFORM)/$(BUILDTYPE)/somdfenc.o 	\
			$(BUILD)/somd/$(PLATFORM)/$(BUILDTYPE)/somdom.o 	\
			$(BUILD)/somd/$(PLATFORM)/$(BUILDTYPE)/somoa.o 		\
			$(BUILD)/somd/$(PLATFORM)/$(BUILDTYPE)/somdstub.o 	\
			$(BUILD)/somd/$(PLATFORM)/$(BUILDTYPE)/somdserv.o 	\
			$(BUILD)/somd/$(PLATFORM)/$(BUILDTYPE)/somdtcdt.o 	\
			$(BUILD)/somd/$(PLATFORM)/$(BUILDTYPE)/rhbsomd.o 

SOMIR_OBJS=$(BUILD)/somir/$(PLATFORM)/$(BUILDTYPE)/rhbsomir.o	\
			$(BUILD)/somir/$(PLATFORM)/$(BUILDTYPE)/repostry.o 	\
			$(BUILD)/somir/$(PLATFORM)/$(BUILDTYPE)/containr.o 	\
			$(BUILD)/somir/$(PLATFORM)/$(BUILDTYPE)/typedef.o 	\
			$(BUILD)/somir/$(PLATFORM)/$(BUILDTYPE)/paramdef.o 	\
			$(BUILD)/somir/$(PLATFORM)/$(BUILDTYPE)/excptdef.o 	\
			$(BUILD)/somir/$(PLATFORM)/$(BUILDTYPE)/intfacdf.o 	\
			$(BUILD)/somir/$(PLATFORM)/$(BUILDTYPE)/operatdf.o 	\
			$(BUILD)/somir/$(PLATFORM)/$(BUILDTYPE)/attribdf.o 	\
			$(BUILD)/somir/$(PLATFORM)/$(BUILDTYPE)/constdef.o 	\
			$(BUILD)/somir/$(PLATFORM)/$(BUILDTYPE)/moduledf.o 	\
			$(BUILD)/somir/$(PLATFORM)/$(BUILDTYPE)/somirfmt.o 	\
			$(BUILD)/somir/$(PLATFORM)/$(BUILDTYPE)/containd.o 

SOMU_OBJS=$(BUILD)/somu/$(PLATFORM)/$(BUILDTYPE)/rhbsomu.o	\
			$(BUILD)/somu/$(PLATFORM)/$(BUILDTYPE)/snglicls.o 	\
			$(BUILD)/somu/$(PLATFORM)/$(BUILDTYPE)/sombacls.o 	\
			$(BUILD)/somu/$(PLATFORM)/$(BUILDTYPE)/somproxy.o 	\
			$(BUILD)/somu/$(PLATFORM)/$(BUILDTYPE)/somida.o 	\
			$(BUILD)/somu/$(PLATFORM)/$(BUILDTYPE)/somsid.o 	\
			$(BUILD)/somu/$(PLATFORM)/$(BUILDTYPE)/rhbiniut.o 	\
			$(BUILD)/somu/$(PLATFORM)/$(BUILDTYPE)/somthrd.o 

SOMU2_OBJS=$(BUILD)/somu2/$(PLATFORM)/$(BUILDTYPE)/rhbsomu2.o	\
			$(BUILD)/somu2/$(PLATFORM)/$(BUILDTYPE)/somtdm.o 

SOMABS1_OBJS=$(BUILD)/somabs1/$(PLATFORM)/$(BUILDTYPE)/somabs1.o	\
			$(BUILD)/somabs1/$(PLATFORM)/$(BUILDTYPE)/omgidobj.o

IRDUMP_OBJS=$(BUILD)/irdump/$(PLATFORM)/$(BUILDTYPE)/irdump.o		

DSOM_OBJS=$(BUILD)/dsom/$(PLATFORM)/$(BUILDTYPE)/dsom.o		

PDL_OBJS=$(BUILD)/pdl/$(PLATFORM)/$(BUILDTYPE)/pdl.o		

REGIMPL_OBJS=$(BUILD)/regimpl/$(PLATFORM)/$(BUILDTYPE)/regimpl.o \
		$(BUILD)/regimpl/$(PLATFORM)/$(BUILDTYPE)/regior.o \
		$(BUILD)/regimpl/$(PLATFORM)/$(BUILDTYPE)/regiortc.o

SOMDSVR_OBJS=$(BUILD)/somdsvr/$(PLATFORM)/$(BUILDTYPE)/somdsvr-cpp.o 

SOMDCHK_OBJS=$(BUILD)/somdchk/$(PLATFORM)/$(BUILDTYPE)/somdchk.o 

SOMOSSVR_OBJS=$(BUILD)/somossvr/$(PLATFORM)/$(BUILDTYPE)/somossvr-cpp.o \
		$(BUILD)/somossvr/$(PLATFORM)/$(BUILDTYPE)/somosrun.o

SOMDD_OBJS=$(BUILD)/somdd/$(PLATFORM)/$(BUILDTYPE)/rhbsomdd.o \
		$(BUILD)/somdd/$(PLATFORM)/$(BUILDTYPE)/implreps.o \
		$(BUILD)/somdd/$(PLATFORM)/$(BUILDTYPE)/rhbexecd.o \
		$(BUILD)/somdd/$(PLATFORM)/$(BUILDTYPE)/somddior.o \
		$(BUILD)/somdd/$(PLATFORM)/$(BUILDTYPE)/somddrep.o \
		$(BUILD)/somdd/$(PLATFORM)/$(BUILDTYPE)/somddsrv.o \
		$(BUILD)/somdd/$(PLATFORM)/$(BUILDTYPE)/somddtc.o \
		$(BUILD)/somdd/$(PLATFORM)/$(BUILDTYPE)/rhbexec.o

$(FRAMEWORKS)/SOMTK.framework/SOMTK: $(FRAMEWORKS)/SOMTK.framework/Versions/$(FRAMEWORK_VERS)/SOMTK
	cd $(FRAMEWORKS)/SOMTK.framework; if test ! -L SOMTK; then ln -s Versions/$(FRAMEWORK_VERS)/SOMTK SOMTK; fi

$(SUBFRAMEWORKS)/SOM.framework/SOM: $(SUBFRAMEWORKS)/SOM.framework/Versions/$(FRAMEWORK_VERS)/SOM
	cd $(SUBFRAMEWORKS)/SOM.framework; if test ! -L SOM; then ln -s Versions/$(FRAMEWORK_VERS)/SOM SOM; fi

$(SUBFRAMEWORKS)/SOMREF.framework/SOMREF: $(SUBFRAMEWORKS)/SOMREF.framework/Versions/$(FRAMEWORK_VERS)/SOMREF
	cd $(SUBFRAMEWORKS)/SOMREF.framework; if test ! -L SOMREF; then ln -s Versions/$(FRAMEWORK_VERS)/SOMREF SOMREF; fi

$(SUBFRAMEWORKS)/SOMCSLIB.framework/SOMCSLIB: $(SUBFRAMEWORKS)/SOMCSLIB.framework/Versions/$(FRAMEWORK_VERS)/SOMCSLIB
	cd $(SUBFRAMEWORKS)/SOMCSLIB.framework; if test ! -L SOMCSLIB; then ln -s Versions/$(FRAMEWORK_VERS)/SOMCSLIB SOMCSLIB; fi

$(SUBFRAMEWORKS)/SOMTC.framework/SOMTC: $(SUBFRAMEWORKS)/SOMTC.framework/Versions/$(FRAMEWORK_VERS)/SOMTC
	cd $(SUBFRAMEWORKS)/SOMTC.framework; if test ! -L SOMTC; then ln -s Versions/$(FRAMEWORK_VERS)/SOMTC SOMTC; fi

$(SUBFRAMEWORKS)/SOMIR.framework/SOMIR: $(SUBFRAMEWORKS)/SOMIR.framework/Versions/$(FRAMEWORK_VERS)/SOMIR
	cd $(SUBFRAMEWORKS)/SOMIR.framework; if test ! -L SOMIR; then ln -s Versions/$(FRAMEWORK_VERS)/SOMIR SOMIR; fi

$(SUBFRAMEWORKS)/SOMU.framework/SOMU: $(SUBFRAMEWORKS)/SOMU.framework/Versions/$(FRAMEWORK_VERS)/SOMU
	cd $(SUBFRAMEWORKS)/SOMU.framework; if test ! -L SOMU; then ln -s Versions/$(FRAMEWORK_VERS)/SOMU SOMU; fi

$(SUBFRAMEWORKS)/SOMU2.framework/SOMU2: $(SUBFRAMEWORKS)/SOMU2.framework/Versions/$(FRAMEWORK_VERS)/SOMU2
	cd $(SUBFRAMEWORKS)/SOMU2.framework; if test ! -L SOMU2; then ln -s Versions/$(FRAMEWORK_VERS)/SOMU2 SOMU2; fi

$(SUBFRAMEWORKS)/SOMABS1.framework/SOMABS1: $(SUBFRAMEWORKS)/SOMABS1.framework/Versions/$(FRAMEWORK_VERS)/SOMABS1
	cd $(SUBFRAMEWORKS)/SOMABS1.framework; if test ! -L SOMABS1; then ln -s Versions/$(FRAMEWORK_VERS)/SOMABS1 SOMABS1; fi

$(SUBFRAMEWORKS)/SOMDCOMM.framework/SOMDCOMM: $(SUBFRAMEWORKS)/SOMDCOMM.framework/Versions/$(FRAMEWORK_VERS)/SOMDCOMM
	cd $(SUBFRAMEWORKS)/SOMDCOMM.framework; if test ! -L SOMDCOMM; then ln -s Versions/$(FRAMEWORK_VERS)/SOMDCOMM SOMDCOMM; fi

$(SUBFRAMEWORKS)/SOMD.framework/SOMD: $(SUBFRAMEWORKS)/SOMD.framework/Versions/$(FRAMEWORK_VERS)/SOMD
	cd $(SUBFRAMEWORKS)/SOMD.framework; if test ! -L SOMD; then ln -s Versions/$(FRAMEWORK_VERS)/SOMD SOMD; fi

$(SUBFRAMEWORKS)/SOMNMF.framework/SOMNMF: $(SUBFRAMEWORKS)/SOMNMF.framework/Versions/$(FRAMEWORK_VERS)/SOMNMF
	cd $(SUBFRAMEWORKS)/SOMNMF.framework; if test ! -L SOMNMF; then ln -s Versions/$(FRAMEWORK_VERS)/SOMNMF SOMNMF; fi

$(SUBFRAMEWORKS)/SOMOS.framework/SOMOS: $(SUBFRAMEWORKS)/SOMOS.framework/Versions/$(FRAMEWORK_VERS)/SOMOS
	cd $(SUBFRAMEWORKS)/SOMOS.framework; if test ! -L SOMOS; then ln -s Versions/$(FRAMEWORK_VERS)/SOMOS SOMOS; fi

$(SUBFRAMEWORKS)/SOMESTRM.framework/SOMESTRM: $(SUBFRAMEWORKS)/SOMESTRM.framework/Versions/$(FRAMEWORK_VERS)/SOMESTRM
	cd $(SUBFRAMEWORKS)/SOMESTRM.framework; if test ! -L SOMESTRM; then ln -s Versions/$(FRAMEWORK_VERS)/SOMESTRM SOMESTRM; fi

$(SUBFRAMEWORKS)/SOMANY.framework/SOMANY: $(SUBFRAMEWORKS)/SOMANY.framework/Versions/$(FRAMEWORK_VERS)/SOMANY
	cd $(SUBFRAMEWORKS)/SOMANY.framework; if test ! -L SOMANY; then ln -s Versions/$(FRAMEWORK_VERS)/SOMANY SOMANY; fi

$(SUBFRAMEWORKS)/SOMCORBA.framework/SOMCORBA: $(SUBFRAMEWORKS)/SOMCORBA.framework/Versions/$(FRAMEWORK_VERS)/SOMCORBA
	cd $(SUBFRAMEWORKS)/SOMCORBA.framework; if test ! -L SOMCORBA; then ln -s Versions/$(FRAMEWORK_VERS)/SOMCORBA SOMCORBA; fi

$(SUBFRAMEWORKS)/SOMCDR.framework/SOMCDR: $(SUBFRAMEWORKS)/SOMCDR.framework/Versions/$(FRAMEWORK_VERS)/SOMCDR
	cd $(SUBFRAMEWORKS)/SOMCDR.framework; if test ! -L SOMCDR; then ln -s Versions/$(FRAMEWORK_VERS)/SOMCDR SOMCDR; fi

$(SUBFRAMEWORKS)/SOM.framework/Versions/$(FRAMEWORK_VERS)/SOM: $(SOM_OBJS) $(SUBFRAMEWORKS)/SOM.framework/Versions/$(FRAMEWORK_VERS)
	$(CC) $(CFLAGS) $(SHARED) -o $@ \
		$(SOM_OBJS) \
		-umbrella SOMTK \
		-Wl,-exported_symbols_list,$(BUILD)/som/$(PLATFORM)/$(BUILDTYPE)/som.exp.def \
		-Wl,-install_name,/Library/Frameworks/SOMTK.framework/Versions/$(FRAMEWORK_VERS)/Frameworks/SOM.framework/Versions/$(FRAMEWORK_VERS)/SOM \
		$(STDLIB)

$(IMPLIBS)/SOMESTRM.framework/SOMESTRM \
$(IMPLIBS)/SOMOS.framework/SOMOS \
$(IMPLIBS)/SOMNMF.framework/SOMNMF: \
	$(IMPLIBS)/SOMESTRM.framework/Versions/$(FRAMEWORK_VERS)/SOMESTRM \
	$(IMPLIBS)/SOMNMF.framework/Versions/$(FRAMEWORK_VERS)/SOMNMF \
	$(IMPLIBS)/SOMOS.framework/Versions/$(FRAMEWORK_VERS)/SOMOS
	cd `dirname $@`; if test ! -f `basename $@`; then ln -s Versions/$(FRAMEWORK_VERS)/`basename $@`; fi

$(SUBFRAMEWORKS)/SOMREF.framework/Versions/$(FRAMEWORK_VERS)/SOMREF: $(SOMREF_OBJS) $(SUBFRAMEWORKS)/SOMREF.framework/Versions/$(FRAMEWORK_VERS)
	$(CC) $(CFLAGS) $(SHARED) -o $@ \
		$(SOMREF_OBJS) \
		-umbrella SOMTK \
		-Wl,-exported_symbols_list,$(BUILD)/somref/$(PLATFORM)/$(BUILDTYPE)/somref.exp.def \
		-Wl,-install_name,/Library/Frameworks/SOMTK.framework/Versions/$(FRAMEWORK_VERS)/Frameworks/SOMREF.framework/Versions/$(FRAMEWORK_VERS)/SOMREF \
		$(STDLIB) -F$(SUBFRAMEWORKS) -framework SOM

$(SUBFRAMEWORKS)/SOMCSLIB.framework/Versions/$(FRAMEWORK_VERS)/SOMCSLIB: $(SOMCSLIB_OBJS) $(SUBFRAMEWORKS)/SOMCSLIB.framework/Versions/$(FRAMEWORK_VERS)
	$(CC) $(CFLAGS) $(SHARED) -o $@ \
		$(SOMCSLIB_OBJS) \
		-umbrella SOMTK \
		-Wl,-exported_symbols_list,$(BUILD)/somcslib/$(PLATFORM)/$(BUILDTYPE)/somcslib.exp.def \
		-Wl,-install_name,/Library/Frameworks/SOMTK.framework/Versions/$(FRAMEWORK_VERS)/Frameworks/SOMCSLIB.framework/Versions/$(FRAMEWORK_VERS)/SOMCSLIB \
		$(STDLIB) -F$(SUBFRAMEWORKS) -framework SOM -framework SOMREF

$(SUBFRAMEWORKS)/SOMANY.framework/Versions/$(FRAMEWORK_VERS)/SOMANY: $(SOMANY_OBJS) $(SUBFRAMEWORKS)/SOMANY.framework/Versions/$(FRAMEWORK_VERS)
	$(CC) $(CFLAGS) $(SHARED) -o $@ \
		$(SOMANY_OBJS) \
		-umbrella SOMTK \
		-Wl,-exported_symbols_list,$(BUILD)/somany/$(PLATFORM)/$(BUILDTYPE)/somany.exp.def \
		-Wl,-install_name,/Library/Frameworks/SOMTK.framework/Versions/$(FRAMEWORK_VERS)/Frameworks/SOMANY.framework/Versions/$(FRAMEWORK_VERS)/SOMANY \
		$(STDLIB) -F$(SUBFRAMEWORKS) -framework SOM -framework SOMTC

$(SUBFRAMEWORKS)/SOMD.framework/Versions/$(FRAMEWORK_VERS)/SOMD: $(SOMD_OBJS) $(SUBFRAMEWORKS)/SOMD.framework/Versions/$(FRAMEWORK_VERS)
	$(CC) $(CFLAGS) $(SHARED) -o $@ \
		$(SOMD_OBJS) \
		-umbrella SOMTK \
		-Wl,-exported_symbols_list,$(BUILD)/somd/$(PLATFORM)/$(BUILDTYPE)/somd.exp.def \
		-Wl,-install_name,/Library/Frameworks/SOMTK.framework/Versions/$(FRAMEWORK_VERS)/Frameworks/SOMD.framework/Versions/$(FRAMEWORK_VERS)/SOMD \
		$(STDLIB) -F$(SUBFRAMEWORKS) -framework SOM -framework SOMREF -framework SOMTC -framework SOMDCOMM -framework SOMCDR \
			-framework SOMANY -framework SOMCORBA -framework SOMESTRM -framework SOMU -framework SOMNMF -framework SOMABS1 \
			-F$(IMPLIBS) -framework SOMOS $(UUIDLIBS)

$(SUBFRAMEWORKS)/SOMTC.framework/Versions/$(FRAMEWORK_VERS)/SOMTC: $(SOMTC_OBJS) $(SUBFRAMEWORKS)/SOMTC.framework/Versions/$(FRAMEWORK_VERS)
	$(CC) $(CFLAGS) $(SHARED) -o $@ \
		$(SOMTC_OBJS) \
		-umbrella SOMTK \
		-Wl,-exported_symbols_list,$(BUILD)/somtc/$(PLATFORM)/$(BUILDTYPE)/somtc.exp.def \
		-Wl,-install_name,/Library/Frameworks/SOMTK.framework/Versions/$(FRAMEWORK_VERS)/Frameworks/SOMTC.framework/Versions/$(FRAMEWORK_VERS)/SOMTC \
		$(STDLIB) -F$(SUBFRAMEWORKS) -framework SOM

$(SUBFRAMEWORKS)/SOMOS.framework/Versions/$(FRAMEWORK_VERS)/SOMOS: $(SOMOS_OBJS) $(SUBFRAMEWORKS)/SOMOS.framework/Versions/$(FRAMEWORK_VERS)
	$(CC) $(CFLAGS) $(SHARED) -o $@ \
		$(SOMOS_OBJS) \
		-umbrella SOMTK \
		-Wl,-exported_symbols_list,$(BUILD)/somos/$(PLATFORM)/$(BUILDTYPE)/somos.exp.def \
		-Wl,-install_name,/Library/Frameworks/SOMTK.framework/Versions/$(FRAMEWORK_VERS)/Frameworks/SOMOS.framework/Versions/$(FRAMEWORK_VERS)/SOMOS \
		$(STDLIB) -F$(IMPLIBS) -F$(SUBFRAMEWORKS) -framework SOM -framework SOMTC -framework SOMREF -framework SOMD -framework SOMABS1 \
			-framework SOMU -framework SOMCDR -framework SOMCORBA -framework SOMANY -framework SOMDCOMM \
			-framework SOMU2 -framework SOMNMF -framework SOMESTRM $(UUIDLIBS)

$(SUBFRAMEWORKS)/SOMNMF.framework/Versions/$(FRAMEWORK_VERS)/SOMNMF: $(SOMNMF_OBJS) $(SUBFRAMEWORKS)/SOMNMF.framework/Versions/$(FRAMEWORK_VERS)
	$(CC) $(CFLAGS) $(SHARED) -o $@ \
		$(SOMNMF_OBJS) \
		-umbrella SOMTK \
		-Wl,-exported_symbols_list,$(BUILD)/somnmf/$(PLATFORM)/$(BUILDTYPE)/somnmf.exp.def \
		-Wl,-install_name,/Library/Frameworks/SOMTK.framework/Versions/$(FRAMEWORK_VERS)/Frameworks/SOMNMF.framework/Versions/$(FRAMEWORK_VERS)/SOMNMF \
		$(STDLIB) -F$(SUBFRAMEWORKS) -framework SOM -framework SOMREF -F$(IMPLIBS) -framework SOMOS

$(SUBFRAMEWORKS)/SOMESTRM.framework/Versions/$(FRAMEWORK_VERS)/SOMESTRM: $(SOMESTRM_OBJS) $(SUBFRAMEWORKS)/SOMESTRM.framework/Versions/$(FRAMEWORK_VERS)
	$(CC) $(CFLAGS) $(SHARED) -o $@ \
		$(SOMESTRM_OBJS) \
		-umbrella SOMTK \
		-Wl,-exported_symbols_list,$(BUILD)/somestrm/$(PLATFORM)/$(BUILDTYPE)/somestrm.exp.def \
		-Wl,-install_name,/Library/Frameworks/SOMTK.framework/Versions/$(FRAMEWORK_VERS)/Frameworks/SOMESTRM.framework/Versions/$(FRAMEWORK_VERS)/SOMESTRM \
		$(STDLIB) -F$(SUBFRAMEWORKS) -framework SOM -framework SOMREF -framework SOMABS1 -F$(IMPLIBS) -framework SOMOS

$(SUBFRAMEWORKS)/SOMIR.framework/Versions/$(FRAMEWORK_VERS)/SOMIR: $(SOMIR_OBJS) $(SUBFRAMEWORKS)/SOMIR.framework/Versions/$(FRAMEWORK_VERS)
	$(CC) $(CFLAGS) $(SHARED) -o $@ \
		$(SOMIR_OBJS) \
		-umbrella SOMTK \
		-Wl,-exported_symbols_list,$(BUILD)/somir/$(PLATFORM)/$(BUILDTYPE)/somir.exp.def \
		-Wl,-install_name,/Library/Frameworks/SOMTK.framework/Versions/$(FRAMEWORK_VERS)/Frameworks/SOMIR.framework/Versions/$(FRAMEWORK_VERS)/SOMIR \
		$(STDLIB) -F$(SUBFRAMEWORKS) -framework SOM -framework SOMTC -framework SOMREF

$(SUBFRAMEWORKS)/SOMU.framework/Versions/$(FRAMEWORK_VERS)/SOMU: $(SOMU_OBJS) $(SUBFRAMEWORKS)/SOMU.framework/Versions/$(FRAMEWORK_VERS)
	$(CC) $(CFLAGS) $(SHARED) -o $@ \
		$(SOMU_OBJS) \
		-umbrella SOMTK \
		-Wl,-exported_symbols_list,$(BUILD)/somu/$(PLATFORM)/$(BUILDTYPE)/somu.exp.def \
		-Wl,-install_name,/Library/Frameworks/SOMTK.framework/Versions/$(FRAMEWORK_VERS)/Frameworks/SOMU.framework/Versions/$(FRAMEWORK_VERS)/SOMU \
		$(STDLIB) -F$(SUBFRAMEWORKS) -framework SOM -framework SOMREF $(UUIDLIBS)

$(SUBFRAMEWORKS)/SOMU2.framework/Versions/$(FRAMEWORK_VERS)/SOMU2: $(SOMU2_OBJS) $(SUBFRAMEWORKS)/SOMU2.framework/Versions/$(FRAMEWORK_VERS)
	$(CC) $(CFLAGS) $(SHARED) -o $@ \
		$(SOMU2_OBJS) \
		-umbrella SOMTK \
		-Wl,-exported_symbols_list,$(BUILD)/somu2/$(PLATFORM)/$(BUILDTYPE)/somu2.exp.def \
		-Wl,-install_name,/Library/Frameworks/SOMTK.framework/Versions/$(FRAMEWORK_VERS)/Frameworks/SOMU2.framework/Versions/$(FRAMEWORK_VERS)/SOMU2 \
		$(STDLIB) -F$(SUBFRAMEWORKS) -framework SOM -framework SOMREF

$(SUBFRAMEWORKS)/SOMABS1.framework/Versions/$(FRAMEWORK_VERS)/SOMABS1: $(SOMABS1_OBJS) $(SUBFRAMEWORKS)/SOMABS1.framework/Versions/$(FRAMEWORK_VERS)
	$(CC) $(CFLAGS) $(SHARED) -o $@ \
		$(SOMABS1_OBJS) \
		-umbrella SOMTK \
		-Wl,-exported_symbols_list,$(BUILD)/somabs1/$(PLATFORM)/$(BUILDTYPE)/somabs1.exp.def \
		-Wl,-install_name,/Library/Frameworks/SOMTK.framework/Versions/$(FRAMEWORK_VERS)/Frameworks/SOMABS1.framework/Versions/$(FRAMEWORK_VERS)/SOMABS1 \
		$(STDLIB) -F$(SUBFRAMEWORKS) -framework SOM -framework SOMREF

$(SUBFRAMEWORKS)/SOMCORBA.framework/Versions/$(FRAMEWORK_VERS)/SOMCORBA: $(SOMCORBA_OBJS) $(SUBFRAMEWORKS)/SOMCORBA.framework/Versions/$(FRAMEWORK_VERS)
	$(CC) $(CFLAGS) $(SHARED) -o $@ \
		$(SOMCORBA_OBJS) \
		-umbrella SOMTK \
		-Wl,-exported_symbols_list,$(BUILD)/somcorba/$(PLATFORM)/$(BUILDTYPE)/somcorba.exp.def \
		-Wl,-install_name,/Library/Frameworks/SOMTK.framework/Versions/$(FRAMEWORK_VERS)/Frameworks/SOMCORBA.framework/Versions/$(FRAMEWORK_VERS)/SOMCORBA \
		$(STDLIB) -F$(SUBFRAMEWORKS) -framework SOM -framework SOMREF

$(SUBFRAMEWORKS)/SOMDCOMM.framework/Versions/$(FRAMEWORK_VERS)/SOMDCOMM: $(SOMDCOMM_OBJS) $(SUBFRAMEWORKS)/SOMDCOMM.framework/Versions/$(FRAMEWORK_VERS)
	$(CC) $(CFLAGS) $(SHARED) -o $@ \
		$(SOMDCOMM_OBJS) \
		-umbrella SOMTK \
		-Wl,-exported_symbols_list,$(BUILD)/somdcomm/$(PLATFORM)/$(BUILDTYPE)/somdcomm.exp.def \
		-Wl,-install_name,/Library/Frameworks/SOMTK.framework/Versions/$(FRAMEWORK_VERS)/Frameworks/SOMDCOMM.framework/Versions/$(FRAMEWORK_VERS)/SOMDCOMM \
		$(STDLIB) -F$(SUBFRAMEWORKS) -framework SOM -framework SOMREF -framework SOMCDR \
			-framework SOMTC -framework SOMCORBA -framework SOMESTRM \
			-framework SOMABS1 -F$(IMPLIBS) -framework SOMOS

$(SUBFRAMEWORKS)/SOMCDR.framework/Versions/$(FRAMEWORK_VERS)/SOMCDR: $(SOMCDR_OBJS) $(SUBFRAMEWORKS)/SOMCDR.framework/Versions/$(FRAMEWORK_VERS)
	$(CC) $(CFLAGS) $(SHARED) -o $@ \
		$(SOMCDR_OBJS) \
		-umbrella SOMTK \
		-Wl,-exported_symbols_list,$(BUILD)/somcdr/$(PLATFORM)/$(BUILDTYPE)/somcdr.exp.def \
		-Wl,-install_name,/Library/Frameworks/SOMTK.framework/Versions/$(FRAMEWORK_VERS)/Frameworks/SOMCDR.framework/Versions/$(FRAMEWORK_VERS)/SOMCDR \
		$(STDLIB) \
		-F$(SUBFRAMEWORKS) -framework SOM -framework SOMREF -framework SOMTC -framework SOMCORBA 

$(IMPLIBS)/SOMESTRM.framework/Versions/$(FRAMEWORK_VERS)/SOMESTRM: $(BUILD)/somdstub/$(PLATFORM)/$(BUILDTYPE)/somestrm.o $(IMPLIBS)/SOMESTRM.framework/Versions/$(FRAMEWORK_VERS)
	$(CC) $(CFLAGS) $(SHARED) -o $@ \
		$(BUILD)/somdstub/$(PLATFORM)/$(BUILDTYPE)/somestrm.o \
		-umbrella SOMTK \
		-Wl,-exported_symbols_list,$(BUILD)/somdstub/$(PLATFORM)/$(BUILDTYPE)/somestrm.exp.def \
		-Wl,-install_name,/Library/Frameworks/SOMTK.framework/Versions/$(FRAMEWORK_VERS)/Frameworks/SOMESTRM.framework/Versions/$(FRAMEWORK_VERS)/SOMESTRM \
		$(STDLIB)

$(IMPLIBS)/SOMNMF.framework/Versions/$(FRAMEWORK_VERS)/SOMNMF: $(BUILD)/somdstub/$(PLATFORM)/$(BUILDTYPE)/somnmf.o $(IMPLIBS)/SOMNMF.framework/Versions/$(FRAMEWORK_VERS)
	$(CC) $(CFLAGS) $(SHARED) -o $@ \
		$(BUILD)/somdstub/$(PLATFORM)/$(BUILDTYPE)/somnmf.o \
		-umbrella SOMTK \
		-Wl,-exported_symbols_list,$(BUILD)/somdstub/$(PLATFORM)/$(BUILDTYPE)/somnmf.exp.def \
		-Wl,-install_name,/Library/Frameworks/SOMTK.framework/Versions/$(FRAMEWORK_VERS)/Frameworks/SOMNMF.framework/Versions/$(FRAMEWORK_VERS)/SOMNMF \
		$(STDLIB)

$(IMPLIBS)/SOMOS.framework/Versions/$(FRAMEWORK_VERS)/SOMOS: $(BUILD)/somdstub/$(PLATFORM)/$(BUILDTYPE)/somos.o $(IMPLIBS)/SOMOS.framework/Versions/$(FRAMEWORK_VERS)
	$(CC) $(CFLAGS) $(SHARED) -o $@ \
		$(BUILD)/somdstub/$(PLATFORM)/$(BUILDTYPE)/somos.o \
		-umbrella SOMTK \
		-Wl,-exported_symbols_list,$(BUILD)/somdstub/$(PLATFORM)/$(BUILDTYPE)/somos.exp.def \
		-Wl,-install_name,/Library/Frameworks/SOMTK.framework/Versions/$(FRAMEWORK_VERS)/Frameworks/SOMOS.framework/Versions/$(FRAMEWORK_VERS)/SOMOS \
		$(STDLIB)

$(BINDIR)/pdl: $(PDL_OBJS)
	$(CC) $(PDL_OBJS) $(CFLAGS) -o $@ $(STDLIB)

$(BINDIR)/irdump: $(IRDUMP_OBJS)
	$(CC) $(IRDUMP_OBJS) $(CFLAGS) -o $@ $(STDLIB) -F$(FRAMEWORKS) -F$(SUBFRAMEWORKS) -framework SOMTK 

$(BINDIR)/somdd: $(SOMDD_OBJS)
	$(CC) $(SOMDD_OBJS) $(CFLAGS) -o $@ $(STDLIB) -F$(FRAMEWORKS) -F$(SUBFRAMEWORKS) -framework SOMTK $(UUIDLIBS)

$(BINDIR)/somossvr: $(SOMOSSVR_OBJS)
	$(CXX) $(SOMOSSVR_OBJS) $(CXXFLAGS) -o $@ $(STDLIB) -F$(FRAMEWORKS) -F$(SUBFRAMEWORKS) -framework SOMTK $(UUIDLIBS)

$(BINDIR)/somdsvr: $(SOMDSVR_OBJS)
	$(CXX) $(SOMDSVR_OBJS) $(CXXFLAGS) -o $@ $(STDLIB) -F$(FRAMEWORKS) -F$(SUBFRAMEWORKS) -framework SOMTK $(UUIDLIBS)

$(BINDIR)/somdchk: $(SOMDCHK_OBJS)
	$(CXX) $(SOMDCHK_OBJS) $(CFLAGS) -o $@ $(STDLIB) -F$(FRAMEWORKS) -F$(SUBFRAMEWORKS) -framework SOMTK $(UUIDLIBS)

$(BINDIR)/regimpl: $(REGIMPL_OBJS)
	$(CC) $(REGIMPL_OBJS) $(CFLAGS) -o $@ $(STDLIB) -F$(FRAMEWORKS) -F$(SUBFRAMEWORKS) -framework SOMTK $(UUIDLIBS)

$(BINDIR)/dsom: $(DSOM_OBJS)
	$(CC) $(DSOM_OBJS) $(CFLAGS) -o $@ $(STDLIB) -F$(FRAMEWORKS) -F$(SUBFRAMEWORKS) -framework SOMTK $(UUIDLIBS)

$(PLUGINS)/somref.dll: SOMTK
	$(CC) $(CFLAGS) $(BUNDLE) -o $@ \
		$(BUILD)/somref/$(PLATFORM)/$(BUILDTYPE)/bundle.somref.SOMInitModule.c \
		-Wl,-exported_symbols_list,$(BUILD)/somref/$(PLATFORM)/$(BUILDTYPE)/bundle.somref.def \
		-F$(FRAMEWORKS) -F$(SUBFRAMEWORKS) -framework SOMTK

$(PLUGINS)/somcslib.dll: SOMTK
	$(CC) $(CFLAGS) $(BUNDLE) -o $@ \
		$(BUILD)/somcslib/$(PLATFORM)/$(BUILDTYPE)/bundle.somcslib.SOMInitModule.c \
		-Wl,-exported_symbols_list,$(BUILD)/somcslib/$(PLATFORM)/$(BUILDTYPE)/bundle.somcslib.def \
		-F$(FRAMEWORKS) -F$(SUBFRAMEWORKS) -framework SOMTK

$(PLUGINS)/somir.dll: SOMTK
	$(CC) $(CFLAGS) $(BUNDLE) -o $@ \
		$(BUILD)/somir/$(PLATFORM)/$(BUILDTYPE)/bundle.somir.SOMInitModule.c \
		-Wl,-exported_symbols_list,$(BUILD)/somir/$(PLATFORM)/$(BUILDTYPE)/bundle.somir.def \
		-F$(FRAMEWORKS) -F$(SUBFRAMEWORKS) -framework SOMTK 

$(PLUGINS)/somu.dll: SOMTK
	$(CC) $(CFLAGS) $(BUNDLE) -o $@ \
		$(BUILD)/somu/$(PLATFORM)/$(BUILDTYPE)/bundle.somu.SOMInitModule.c \
		-Wl,-exported_symbols_list,$(BUILD)/somu/$(PLATFORM)/$(BUILDTYPE)/bundle.somu.def \
		-F$(FRAMEWORKS) -F$(SUBFRAMEWORKS) -framework SOMTK $(UUIDLIBS)

$(PLUGINS)/somu2.dll: SOMTK
	$(CC) $(CFLAGS) $(BUNDLE) -o $@ \
		$(BUILD)/somu2/$(PLATFORM)/$(BUILDTYPE)/bundle.somu2.SOMInitModule.c \
		-Wl,-exported_symbols_list,$(BUILD)/somu2/$(PLATFORM)/$(BUILDTYPE)/bundle.somu2.def \
		-F$(FRAMEWORKS) -F$(SUBFRAMEWORKS) -framework SOMTK

$(PLUGINS)/somcorba.dll: SOMTK
	$(CC) $(CFLAGS) $(BUNDLE) -o $@ \
		$(BUILD)/somcorba/$(PLATFORM)/$(BUILDTYPE)/bundle.somcorba.SOMInitModule.c \
		-Wl,-exported_symbols_list,$(BUILD)/somcorba/$(PLATFORM)/$(BUILDTYPE)/bundle.somcorba.def \
		-F$(FRAMEWORKS) -F$(SUBFRAMEWORKS) -framework SOMTK

$(PLUGINS)/somdcomm.dll: SOMTK
	$(CC) $(CFLAGS) $(BUNDLE) -o $@ \
		$(BUILD)/somdcomm/$(PLATFORM)/$(BUILDTYPE)/bundle.somdcomm.SOMInitModule.c \
		-Wl,-exported_symbols_list,$(BUILD)/somdcomm/$(PLATFORM)/$(BUILDTYPE)/bundle.somdcomm.def \
		-F$(FRAMEWORKS) -F$(SUBFRAMEWORKS) -framework SOMTK $(UUIDLIBS)

$(PLUGINS)/somcdr.dll: SOMTK
	$(CC) $(CFLAGS) $(BUNDLE) -o $@ \
		$(BUILD)/somcdr/$(PLATFORM)/$(BUILDTYPE)/bundle.somcdr.SOMInitModule.c \
		-Wl,-exported_symbols_list,$(BUILD)/somcdr/$(PLATFORM)/$(BUILDTYPE)/bundle.somcdr.def \
		-F$(FRAMEWORKS) -F$(SUBFRAMEWORKS) -framework SOMTK

$(PLUGINS)/somd.dll: SOMTK
	$(CC) $(CFLAGS) $(BUNDLE) -o $@ \
		$(BUILD)/somd/$(PLATFORM)/$(BUILDTYPE)/bundle.somd.SOMInitModule.c \
		-Wl,-exported_symbols_list,$(BUILD)/somd/$(PLATFORM)/$(BUILDTYPE)/bundle.somd.def \
		-F$(FRAMEWORKS) -F$(SUBFRAMEWORKS) -framework SOMTK $(UUIDLIBS)

$(PLUGINS)/somabs1.dll: SOMTK
	$(CC) $(CFLAGS) $(BUNDLE) -o $@ \
		$(BUILD)/somabs1/$(PLATFORM)/$(BUILDTYPE)/bundle.somabs1.SOMInitModule.c \
		-Wl,-exported_symbols_list,$(BUILD)/somabs1/$(PLATFORM)/$(BUILDTYPE)/bundle.somabs1.def \
		-F$(FRAMEWORKS) -F$(SUBFRAMEWORKS) -framework SOMTK

$(PLUGINS)/somestrm.dll: SOMTK
	$(CC) $(CFLAGS) $(BUNDLE) -o $@ \
		$(BUILD)/somestrm/$(PLATFORM)/$(BUILDTYPE)/bundle.somestrm.SOMInitModule.c \
		-Wl,-exported_symbols_list,$(BUILD)/somestrm/$(PLATFORM)/$(BUILDTYPE)/bundle.somestrm.def \
		-F$(FRAMEWORKS) -F$(SUBFRAMEWORKS) -framework SOMTK $(UUIDLIBS)

$(PLUGINS)/somnmf.dll: SOMTK
	$(CC) $(CFLAGS) $(BUNDLE) -o $@ \
		$(BUILD)/somnmf/$(PLATFORM)/$(BUILDTYPE)/bundle.somnmf.SOMInitModule.c \
		-Wl,-exported_symbols_list,$(BUILD)/somnmf/$(PLATFORM)/$(BUILDTYPE)/bundle.somnmf.def \
		-F$(FRAMEWORKS) -F$(SUBFRAMEWORKS) -framework SOMTK $(UUIDLIBS)

$(PLUGINS)/somos.dll: SOMTK
	$(CC) $(CFLAGS) $(BUNDLE) -o $@ \
		$(BUILD)/somos/$(PLATFORM)/$(BUILDTYPE)/bundle.somos.SOMInitModule.c \
		-Wl,-exported_symbols_list,$(BUILD)/somos/$(PLATFORM)/$(BUILDTYPE)/bundle.somos.def \
		-F$(FRAMEWORKS) -F$(SUBFRAMEWORKS) -framework SOMTK $(UUIDLIBS)

$(PLUGINS)/somany.dll: SOMTK
	$(CC) $(CFLAGS) $(BUNDLE) -o $@ \
		$(BUILD)/somany/$(PLATFORM)/$(BUILDTYPE)/bundle.somany.SOMInitModule.c \
		-Wl,-exported_symbols_list,$(BUILD)/somany/$(PLATFORM)/$(BUILDTYPE)/bundle.somany.def \
		-F$(FRAMEWORKS) -F$(SUBFRAMEWORKS) -framework SOMTK

$(OBJDIR)/somkpath.o: $(SRCDIR)/somkpath.c $(OBJDIR)
	$(CC) $(CFLAGS) -c $(SRCDIR)/somkpath.c -o $@ -I$(BUILD)/som/include

$(BINDIR)/somipc: $(OUTDIR_BIN)/somipc
	cp $(OUTDIR_BIN)/somipc $@

$(FRAMEWORKS)/SOM.framework/Versions/$(FRAMEWORK_VERS):
	mkdir -p $@

$(FRAMEWORKS)/SOM.framework/SOM: $(FRAMEWORKS)/SOM.framework/Versions/$(FRAMEWORK_VERS)/SOM
	cd $(FRAMEWORKS)/SOM.framework; if test ! -L SOM; then ln -s Versions/$(FRAMEWORK_VERS)/SOM SOM; fi

$(FRAMEWORKS)/SOM.framework/Versions/$(FRAMEWORK_VERS)/SOM: $(FRAMEWORKS)/SOM.framework/Versions/$(FRAMEWORK_VERS) $(SOM_OBJS)
	$(CC) $(CFLAGS) $(SHARED) -o $@ \
		$(SOM_OBJS) \
		-Wl,-exported_symbols_list,$(BUILD)/som/$(PLATFORM)/$(BUILDTYPE)/som.exp.def \
		-Wl,-install_name,"@rpath/SOM.framework/Versions/$(FRAMEWORK_VERS)/SOM" \
		$(STDLIB)

$(FRAMEWORKS)/SOMTC.framework/SOMTC: $(FRAMEWORKS)/SOMTC.framework/Versions/$(FRAMEWORK_VERS)/SOMTC
	cd $(FRAMEWORKS)/SOMTC.framework; if test ! -L SOMTC; then ln -s Versions/$(FRAMEWORK_VERS)/SOMTC SOMTC; fi

$(FRAMEWORKS)/SOMREF.framework/SOMREF: $(FRAMEWORKS)/SOMREF.framework/Versions/$(FRAMEWORK_VERS)/SOMREF
	cd $(FRAMEWORKS)/SOMREF.framework; if test ! -L SOMREF; then ln -s Versions/$(FRAMEWORK_VERS)/SOMREF SOMREF; fi

$(FRAMEWORKS)/SOMIR.framework/SOMIR: $(FRAMEWORKS)/SOMIR.framework/Versions/$(FRAMEWORK_VERS)/SOMIR
	cd $(FRAMEWORKS)/SOMIR.framework; if test ! -L SOMIR; then ln -s Versions/$(FRAMEWORK_VERS)/SOMIR SOMIR; fi

$(FRAMEWORKS)/SOMCSLIB.framework/SOMCSLIB: $(FRAMEWORKS)/SOMCSLIB.framework/Versions/$(FRAMEWORK_VERS)/SOMCSLIB
	cd $(FRAMEWORKS)/SOMCSLIB.framework; if test ! -L SOMCSLIB; then ln -s Versions/$(FRAMEWORK_VERS)/SOMCSLIB SOMCSLIB; fi

$(FRAMEWORKS)/SOMU.framework/SOMU: $(FRAMEWORKS)/SOMU.framework/Versions/$(FRAMEWORK_VERS)/SOMU
	cd $(FRAMEWORKS)/SOMU.framework; if test ! -L SOMU; then ln -s Versions/$(FRAMEWORK_VERS)/SOMU SOMU; fi

$(FRAMEWORKS)/SOMU2.framework/SOMU2: $(FRAMEWORKS)/SOMU2.framework/Versions/$(FRAMEWORK_VERS)/SOMU2
	cd $(FRAMEWORKS)/SOMU2.framework; if test ! -L SOMU2; then ln -s Versions/$(FRAMEWORK_VERS)/SOMU2 SOMU2; fi

$(FRAMEWORKS)/SOMABS1.framework/SOMABS1: $(FRAMEWORKS)/SOMABS1.framework/Versions/$(FRAMEWORK_VERS)/SOMABS1
	cd $(FRAMEWORKS)/SOMABS1.framework; if test ! -L SOMABS1; then ln -s Versions/$(FRAMEWORK_VERS)/SOMABS1 SOMABS1; fi

$(FRAMEWORKS)/SOMANY.framework/SOMANY: $(FRAMEWORKS)/SOMANY.framework/Versions/$(FRAMEWORK_VERS)/SOMANY
	cd $(FRAMEWORKS)/SOMANY.framework; if test ! -L SOMANY; then ln -s Versions/$(FRAMEWORK_VERS)/SOMANY SOMANY; fi

$(FRAMEWORKS)/SOMCORBA.framework/SOMCORBA: $(FRAMEWORKS)/SOMCORBA.framework/Versions/$(FRAMEWORK_VERS)/SOMCORBA
	cd $(FRAMEWORKS)/SOMCORBA.framework; if test ! -L SOMCORBA; then ln -s Versions/$(FRAMEWORK_VERS)/SOMCORBA SOMCORBA; fi

$(FRAMEWORKS)/SOMCDR.framework/SOMCDR: $(FRAMEWORKS)/SOMCDR.framework/Versions/$(FRAMEWORK_VERS)/SOMCDR
	cd $(FRAMEWORKS)/SOMCDR.framework; if test ! -L SOMCDR; then ln -s Versions/$(FRAMEWORK_VERS)/SOMCDR SOMCDR; fi

$(FRAMEWORKS)/SOMNMF.framework/SOMNMF: $(FRAMEWORKS)/SOMNMF.framework/Versions/$(FRAMEWORK_VERS)/SOMNMF
	cd $(FRAMEWORKS)/SOMNMF.framework; if test ! -L SOMNMF; then ln -s Versions/$(FRAMEWORK_VERS)/SOMNMF SOMNMF; fi

$(FRAMEWORKS)/SOMESTRM.framework/SOMESTRM: $(FRAMEWORKS)/SOMESTRM.framework/Versions/$(FRAMEWORK_VERS)/SOMESTRM
	cd $(FRAMEWORKS)/SOMESTRM.framework; if test ! -L SOMESTRM; then ln -s Versions/$(FRAMEWORK_VERS)/SOMESTRM SOMESTRM; fi

$(FRAMEWORKS)/SOMDCOMM.framework/SOMDCOMM: $(FRAMEWORKS)/SOMDCOMM.framework/Versions/$(FRAMEWORK_VERS)/SOMDCOMM
	cd $(FRAMEWORKS)/SOMDCOMM.framework; if test ! -L SOMREF; then ln -s Versions/$(FRAMEWORK_VERS)/SOMDCOMM SOMDCOMM; fi

$(FRAMEWORKS)/SOMD.framework/SOMD: $(FRAMEWORKS)/SOMD.framework/Versions/$(FRAMEWORK_VERS)/SOMD
	cd $(FRAMEWORKS)/SOMD.framework; if test ! -L SOMD; then ln -s Versions/$(FRAMEWORK_VERS)/SOMD SOMD; fi

$(FRAMEWORKS)/SOMOS.framework/SOMOS: $(FRAMEWORKS)/SOMOS.framework/Versions/$(FRAMEWORK_VERS)/SOMOS
	cd $(FRAMEWORKS)/SOMOS.framework; if test ! -L SOMOS; then ln -s Versions/$(FRAMEWORK_VERS)/SOMOS SOMOS; fi

$(FRAMEWORKS)/SOMTC.framework/Versions/$(FRAMEWORK_VERS)/SOMTC: $(FRAMEWORKS)/SOMTC.framework/Versions/$(FRAMEWORK_VERS) $(SOMTC_OBJS)
	$(CC) $(CFLAGS) $(SHARED) -o $@ \
		$(SOMTC_OBJS) \
		-Wl,-exported_symbols_list,$(BUILD)/somtc/$(PLATFORM)/$(BUILDTYPE)/somtc.exp.def \
		-Wl,-install_name,"@rpath/SOMTC.framework/Versions/$(FRAMEWORK_VERS)/SOMTC" \
		-F$(FRAMEWORKS)		\
		-framework SOM \
		$(STDLIB)

$(FRAMEWORKS)/SOMREF.framework/Versions/$(FRAMEWORK_VERS)/SOMREF: $(FRAMEWORKS)/SOMREF.framework/Versions/$(FRAMEWORK_VERS) $(SOMREF_OBJS)
	$(CC) $(CFLAGS) $(SHARED) -o $@ \
		$(SOMREF_OBJS) \
		-Wl,-exported_symbols_list,$(BUILD)/somref/$(PLATFORM)/$(BUILDTYPE)/somref.exp.def \
		-Wl,-install_name,"@rpath/SOMREF.framework/Versions/$(FRAMEWORK_VERS)/SOMREF" \
		-F$(FRAMEWORKS)		\
		-framework SOM \
		$(STDLIB)

$(FRAMEWORKS)/SOMIR.framework/Versions/$(FRAMEWORK_VERS)/SOMIR: $(FRAMEWORKS)/SOMIR.framework/Versions/$(FRAMEWORK_VERS) $(SOMIR_OBJS)
	$(CC) $(CFLAGS) $(SHARED) -o $@ \
		$(SOMIR_OBJS) \
		-Wl,-exported_symbols_list,$(BUILD)/somir/$(PLATFORM)/$(BUILDTYPE)/somir.exp.def \
		-Wl,-install_name,"@rpath/SOMIR.framework/Versions/$(FRAMEWORK_VERS)/SOMIR" \
		-F$(FRAMEWORKS)		\
		-framework SOM \
		-framework SOMREF \
		-framework SOMTC \
		$(STDLIB)

$(FRAMEWORKS)/SOMCSLIB.framework/Versions/$(FRAMEWORK_VERS)/SOMCSLIB: $(FRAMEWORKS)/SOMCSLIB.framework/Versions/$(FRAMEWORK_VERS) $(SOMCSLIB_OBJS)
	$(CC) $(CFLAGS) $(SHARED) -o $@ \
		$(SOMCSLIB_OBJS) \
		-Wl,-exported_symbols_list,$(BUILD)/somcslib/$(PLATFORM)/$(BUILDTYPE)/somcslib.exp.def \
		-Wl,-install_name,"@rpath/SOMCSLIB.framework/Versions/$(FRAMEWORK_VERS)/SOMCSLIB" \
		-F$(FRAMEWORKS)		\
		-framework SOM \
		-framework SOMREF \
		$(STDLIB)

$(FRAMEWORKS)/SOMU.framework/Versions/$(FRAMEWORK_VERS)/SOMU: $(FRAMEWORKS)/SOMU.framework/Versions/$(FRAMEWORK_VERS) $(SOMU_OBJS)
	$(CC) $(CFLAGS) $(SHARED) -o $@ \
		$(SOMU_OBJS) \
		-Wl,-exported_symbols_list,$(BUILD)/somu/$(PLATFORM)/$(BUILDTYPE)/somu.exp.def \
		-Wl,-install_name,"@rpath/SOMU.framework/Versions/$(FRAMEWORK_VERS)/SOMU" \
		-F$(FRAMEWORKS)		\
		-framework SOM \
		-framework SOMREF \
		$(STDLIB)

$(FRAMEWORKS)/SOMU2.framework/Versions/$(FRAMEWORK_VERS)/SOMU2: $(FRAMEWORKS)/SOMU2.framework/Versions/$(FRAMEWORK_VERS) $(SOMU2_OBJS)
	$(CC) $(CFLAGS) $(SHARED) -o $@ \
		$(SOMU2_OBJS) \
		-Wl,-exported_symbols_list,$(BUILD)/somu2/$(PLATFORM)/$(BUILDTYPE)/somu2.exp.def \
		-Wl,-install_name,"@rpath/SOMU2.framework/Versions/$(FRAMEWORK_VERS)/SOMU2" \
		-F$(FRAMEWORKS)		\
		-framework SOM \
		-framework SOMREF \
		$(STDLIB)

$(FRAMEWORKS)/SOMANY.framework/Versions/$(FRAMEWORK_VERS)/SOMANY: $(FRAMEWORKS)/SOMANY.framework/Versions/$(FRAMEWORK_VERS) $(SOMANY_OBJS)
	$(CC) $(CFLAGS) $(SHARED) -o $@ \
		$(SOMANY_OBJS) \
		-Wl,-exported_symbols_list,$(BUILD)/somany/$(PLATFORM)/$(BUILDTYPE)/somany.exp.def \
		-Wl,-install_name,"@rpath/SOMANY.framework/Versions/$(FRAMEWORK_VERS)/SOMANY" \
		-F$(FRAMEWORKS)		\
		-framework SOM \
		-framework SOMREF \
		-framework SOMTC \
		$(STDLIB)

$(FRAMEWORKS)/SOMCORBA.framework/Versions/$(FRAMEWORK_VERS)/SOMCORBA: $(FRAMEWORKS)/SOMCORBA.framework/Versions/$(FRAMEWORK_VERS) $(SOMCORBA_OBJS)
	$(CC) $(CFLAGS) $(SHARED) -o $@ \
		$(SOMCORBA_OBJS) \
		-Wl,-exported_symbols_list,$(BUILD)/somcorba/$(PLATFORM)/$(BUILDTYPE)/somcorba.exp.def \
		-Wl,-install_name,"@rpath/SOMCORBA.framework/Versions/$(FRAMEWORK_VERS)/SOMCORBA" \
		-F$(FRAMEWORKS)		\
		-framework SOM \
		-framework SOMREF \
		$(STDLIB)

$(FRAMEWORKS)/SOMABS1.framework/Versions/$(FRAMEWORK_VERS)/SOMABS1: $(FRAMEWORKS)/SOMABS1.framework/Versions/$(FRAMEWORK_VERS) $(SOMABS1_OBJS)
	$(CC) $(CFLAGS) $(SHARED) -o $@ \
		$(SOMABS1_OBJS) \
		-Wl,-exported_symbols_list,$(BUILD)/somabs1/$(PLATFORM)/$(BUILDTYPE)/somabs1.exp.def \
		-Wl,-install_name,"@rpath/SOMABS1.framework/Versions/$(FRAMEWORK_VERS)/SOMABS1" \
		-F$(FRAMEWORKS)		\
		-framework SOM \
		-framework SOMREF \
		$(STDLIB)

$(FWIMPLIBS)/SOMESTRM.framework/SOMESTRM \
$(FWIMPLIBS)/SOMOS.framework/SOMOS \
$(FWIMPLIBS)/SOMNMF.framework/SOMNMF: \
	$(FWIMPLIBS)/SOMESTRM.framework/Versions/$(FRAMEWORK_VERS)/SOMESTRM \
	$(FWIMPLIBS)/SOMNMF.framework/Versions/$(FRAMEWORK_VERS)/SOMNMF \
	$(FWIMPLIBS)/SOMOS.framework/Versions/$(FRAMEWORK_VERS)/SOMOS
	cd `dirname $@`; if test ! -f `basename $@`; then ln -s Versions/$(FRAMEWORK_VERS)/`basename $@`; fi

$(FWIMPLIBS)/SOMESTRM.framework/Versions/$(FRAMEWORK_VERS)/SOMESTRM: $(BUILD)/somdstub/$(PLATFORM)/$(BUILDTYPE)/somestrm.o $(FWIMPLIBS)/SOMESTRM.framework/Versions/$(FRAMEWORK_VERS)
	$(CC) $(CFLAGS) $(SHARED) -o $@ \
		$(BUILD)/somdstub/$(PLATFORM)/$(BUILDTYPE)/somestrm.o \
		-Wl,-exported_symbols_list,$(BUILD)/somdstub/$(PLATFORM)/$(BUILDTYPE)/somestrm.exp.def \
		-Wl,-install_name,"@rpath/SOMESTRM.framework/Versions/$(FRAMEWORK_VERS)/SOMESTRM" \
		$(STDLIB)

$(FWIMPLIBS)/SOMNMF.framework/Versions/$(FRAMEWORK_VERS)/SOMNMF: $(BUILD)/somdstub/$(PLATFORM)/$(BUILDTYPE)/somnmf.o $(FWIMPLIBS)/SOMNMF.framework/Versions/$(FRAMEWORK_VERS)
	$(CC) $(CFLAGS) $(SHARED) -o $@ \
		$(BUILD)/somdstub/$(PLATFORM)/$(BUILDTYPE)/somnmf.o \
		-Wl,-exported_symbols_list,$(BUILD)/somdstub/$(PLATFORM)/$(BUILDTYPE)/somnmf.exp.def \
		-Wl,-install_name,"@rpath/SOMNMF.framework/Versions/$(FRAMEWORK_VERS)/SOMNMF" \
		$(STDLIB)

$(FWIMPLIBS)/SOMOS.framework/Versions/$(FRAMEWORK_VERS)/SOMOS: $(BUILD)/somdstub/$(PLATFORM)/$(BUILDTYPE)/somos.o $(FWIMPLIBS)/SOMOS.framework/Versions/$(FRAMEWORK_VERS)
	$(CC) $(CFLAGS) $(SHARED) -o $@ \
		$(BUILD)/somdstub/$(PLATFORM)/$(BUILDTYPE)/somos.o \
		-Wl,-exported_symbols_list,$(BUILD)/somdstub/$(PLATFORM)/$(BUILDTYPE)/somos.exp.def \
		-Wl,-install_name,"@rpath/SOMOS.framework/Versions/$(FRAMEWORK_VERS)/SOMOS" \
		$(STDLIB)

$(FRAMEWORKS)/SOMCDR.framework/Versions/$(FRAMEWORK_VERS)/SOMCDR: $(SOMCDR_OBJS) $(FRAMEWORKS)/SOMCDR.framework/Versions/$(FRAMEWORK_VERS)
	$(CC) $(CFLAGS) $(SHARED) -o $@ \
		$(SOMCDR_OBJS) \
		-Wl,-exported_symbols_list,$(BUILD)/somcdr/$(PLATFORM)/$(BUILDTYPE)/somcdr.exp.def \
		-Wl,-install_name,"@rpath/SOMCDR.framework/Versions/$(FRAMEWORK_VERS)/SOMCDR" \
		$(STDLIB) \
		-F$(FRAMEWORKS) -framework SOM -framework SOMREF -framework SOMTC -framework SOMCORBA 

$(FRAMEWORKS)/SOMNMF.framework/Versions/$(FRAMEWORK_VERS)/SOMNMF: $(SOMNMF_OBJS) $(FRAMEWORKS)/SOMNMF.framework/Versions/$(FRAMEWORK_VERS)
	$(CC) $(CFLAGS) $(SHARED) -o $@ \
		$(SOMNMF_OBJS) \
		-Wl,-exported_symbols_list,$(BUILD)/somnmf/$(PLATFORM)/$(BUILDTYPE)/somnmf.exp.def \
		-Wl,-install_name,"@rpath/SOMNMF.framework/Versions/$(FRAMEWORK_VERS)/SOMNMF" \
		$(STDLIB) \
		-F$(FRAMEWORKS) -framework SOM -framework SOMREF -framework SOMTC -framework SOMCORBA \
		-F$(FWIMPLIBS) -framework SOMOS

$(FRAMEWORKS)/SOMESTRM.framework/Versions/$(FRAMEWORK_VERS)/SOMESTRM: $(SOMESTRM_OBJS) $(FRAMEWORKS)/SOMESTRM.framework/Versions/$(FRAMEWORK_VERS)
	$(CC) $(CFLAGS) $(SHARED) -o $@ \
		$(SOMESTRM_OBJS) \
		-Wl,-exported_symbols_list,$(BUILD)/somestrm/$(PLATFORM)/$(BUILDTYPE)/somestrm.exp.def \
		-Wl,-install_name,"@rpath/SOMESTRM.framework/Versions/$(FRAMEWORK_VERS)/SOMESTRM" \
		$(STDLIB) \
		-F$(FRAMEWORKS) -framework SOM -framework SOMREF -framework SOMTC -framework SOMABS1  \
		-F$(FWIMPLIBS) -framework SOMOS

$(FRAMEWORKS)/SOMDCOMM.framework/Versions/$(FRAMEWORK_VERS)/SOMDCOMM: $(SOMDCOMM_OBJS) $(FRAMEWORKS)/SOMDCOMM.framework/Versions/$(FRAMEWORK_VERS)
	$(CC) $(CFLAGS) $(SHARED) -o $@ \
		$(SOMDCOMM_OBJS) \
		-Wl,-exported_symbols_list,$(BUILD)/somdcomm/$(PLATFORM)/$(BUILDTYPE)/somdcomm.exp.def \
		-Wl,-install_name,"@rpath/SOMDCOMM.framework/Versions/$(FRAMEWORK_VERS)/SOMDCOMM" \
		$(STDLIB) \
		-F$(FRAMEWORKS) -framework SOM -framework SOMREF -framework SOMTC -framework SOMCDR -framework SOMABS1 \
		-framework SOMCORBA -framework SOMESTRM -F$(FWIMPLIBS) -framework SOMOS

$(FRAMEWORKS)/SOMD.framework/Versions/$(FRAMEWORK_VERS)/SOMD: $(SOMD_OBJS) $(FRAMEWORKS)/SOMD.framework/Versions/$(FRAMEWORK_VERS)
	$(CC) $(CFLAGS) $(SHARED) -o $@ \
		$(SOMD_OBJS) \
		-Wl,-exported_symbols_list,$(BUILD)/somd/$(PLATFORM)/$(BUILDTYPE)/somd.exp.def \
		-Wl,-install_name,"@rpath/SOMD.framework/Versions/$(FRAMEWORK_VERS)/SOMD" \
		$(STDLIB) \
		-F$(FRAMEWORKS) -framework SOM -framework SOMREF -framework SOMTC -framework SOMCDR -framework SOMABS1 \
		-framework SOMCORBA -framework SOMESTRM -framework SOMNMF -framework SOMDCOMM -framework SOMU \
		-framework SOMANY -F$(FWIMPLIBS) -framework SOMOS

$(FRAMEWORKS)/SOMOS.framework/Versions/$(FRAMEWORK_VERS)/SOMOS: $(SOMOS_OBJS) $(FRAMEWORKS)/SOMOS.framework/Versions/$(FRAMEWORK_VERS)
	$(CC) $(CFLAGS) $(SHARED) -o $@ \
		$(SOMOS_OBJS) \
		-Wl,-exported_symbols_list,$(BUILD)/somos/$(PLATFORM)/$(BUILDTYPE)/somos.exp.def \
		-Wl,-install_name,"@rpath/SOMOS.framework/Versions/$(FRAMEWORK_VERS)/SOMOS" \
		$(STDLIB) \
		-F$(FRAMEWORKS) -framework SOM -framework SOMREF -framework SOMTC -framework SOMCDR -framework SOMABS1 \
		-framework SOMCORBA -framework SOMESTRM -framework SOMNMF -framework SOMDCOMM -framework SOMU \
		-framework SOMANY -framework SOMD -framework SOMU2

$(FRAMEWORKS)/somir.dll: $(FRAMEWORKS)/SOMIR.framework/Versions/$(FRAMEWORK_VERS)/SOMIR
	$(CC) $(CFLAGS) $(BUNDLE) -o $@ \
		$(BUILD)/somir/$(PLATFORM)/$(BUILDTYPE)/bundle.somir.SOMInitModule.c \
		-Wl,-exported_symbols_list,$(BUILD)/somir/$(PLATFORM)/$(BUILDTYPE)/bundle.somir.def \
		-F$(FRAMEWORKS) -framework SOMIR 

$(FRAMEWORKS)/somref.dll: $(FRAMEWORKS)/SOMREF.framework/Versions/$(FRAMEWORK_VERS)/SOMREF
	$(CC) $(CFLAGS) $(BUNDLE) -o $@ \
		$(BUILD)/somref/$(PLATFORM)/$(BUILDTYPE)/bundle.somref.SOMInitModule.c \
		-Wl,-exported_symbols_list,$(BUILD)/somref/$(PLATFORM)/$(BUILDTYPE)/bundle.somref.def \
		-F$(FRAMEWORKS) -framework SOMREF 

$(FRAMEWORKS)/somcslib.dll: $(FRAMEWORKS)/SOMCSLIB.framework/Versions/$(FRAMEWORK_VERS)/SOMCSLIB
	$(CC) $(CFLAGS) $(BUNDLE) -o $@ \
		$(BUILD)/somcslib/$(PLATFORM)/$(BUILDTYPE)/bundle.somcslib.SOMInitModule.c \
		-Wl,-exported_symbols_list,$(BUILD)/somcslib/$(PLATFORM)/$(BUILDTYPE)/bundle.somcslib.def \
		-F$(FRAMEWORKS) -framework SOMCSLIB 

$(FRAMEWORKS)/somu.dll: $(FRAMEWORKS)/SOMU.framework/Versions/$(FRAMEWORK_VERS)/SOMU
	$(CC) $(CFLAGS) $(BUNDLE) -o $@ \
		$(BUILD)/somu/$(PLATFORM)/$(BUILDTYPE)/bundle.somu.SOMInitModule.c \
		-Wl,-exported_symbols_list,$(BUILD)/somu/$(PLATFORM)/$(BUILDTYPE)/bundle.somu.def \
		-F$(FRAMEWORKS) -framework SOMU 

$(FRAMEWORKS)/somu2.dll: $(FRAMEWORKS)/SOMU2.framework/Versions/$(FRAMEWORK_VERS)/SOMU2
	$(CC) $(CFLAGS) $(BUNDLE) -o $@ \
		$(BUILD)/somu2/$(PLATFORM)/$(BUILDTYPE)/bundle.somu2.SOMInitModule.c \
		-Wl,-exported_symbols_list,$(BUILD)/somu2/$(PLATFORM)/$(BUILDTYPE)/bundle.somu2.def \
		-F$(FRAMEWORKS) -framework SOMU2 

$(FRAMEWORKS)/somestrm.dll: $(FRAMEWORKS)/SOMESTRM.framework/Versions/$(FRAMEWORK_VERS)/SOMESTRM
	$(CC) $(CFLAGS) $(BUNDLE) -o $@ \
		$(BUILD)/somestrm/$(PLATFORM)/$(BUILDTYPE)/bundle.somestrm.SOMInitModule.c \
		-Wl,-exported_symbols_list,$(BUILD)/somestrm/$(PLATFORM)/$(BUILDTYPE)/bundle.somestrm.def \
		-F$(FRAMEWORKS) -framework SOMESTRM 

$(FRAMEWORKS)/somnmf.dll: $(FRAMEWORKS)/SOMNMF.framework/Versions/$(FRAMEWORK_VERS)/SOMNMF
	$(CC) $(CFLAGS) $(BUNDLE) -o $@ \
		$(BUILD)/somnmf/$(PLATFORM)/$(BUILDTYPE)/bundle.somnmf.SOMInitModule.c \
		-Wl,-exported_symbols_list,$(BUILD)/somnmf/$(PLATFORM)/$(BUILDTYPE)/bundle.somnmf.def \
		-F$(FRAMEWORKS) -framework SOMNMF 

$(FRAMEWORKS)/somdcomm.dll: $(FRAMEWORKS)/SOMDCOMM.framework/Versions/$(FRAMEWORK_VERS)/SOMDCOMM
	$(CC) $(CFLAGS) $(BUNDLE) -o $@ \
		$(BUILD)/somdcomm/$(PLATFORM)/$(BUILDTYPE)/bundle.somdcomm.SOMInitModule.c \
		-Wl,-exported_symbols_list,$(BUILD)/somdcomm/$(PLATFORM)/$(BUILDTYPE)/bundle.somdcomm.def \
		-F$(FRAMEWORKS) -framework SOMDCOMM 

$(FRAMEWORKS)/somcorba.dll: $(FRAMEWORKS)/SOMCORBA.framework/Versions/$(FRAMEWORK_VERS)/SOMCORBA
	$(CC) $(CFLAGS) $(BUNDLE) -o $@ \
		$(BUILD)/somcorba/$(PLATFORM)/$(BUILDTYPE)/bundle.somcorba.SOMInitModule.c \
		-Wl,-exported_symbols_list,$(BUILD)/somcorba/$(PLATFORM)/$(BUILDTYPE)/bundle.somcorba.def \
		-F$(FRAMEWORKS) -framework SOMCORBA 

$(FRAMEWORKS)/somany.dll: $(FRAMEWORKS)/SOMANY.framework/Versions/$(FRAMEWORK_VERS)/SOMANY
	$(CC) $(CFLAGS) $(BUNDLE) -o $@ \
		$(BUILD)/somany/$(PLATFORM)/$(BUILDTYPE)/bundle.somany.SOMInitModule.c \
		-Wl,-exported_symbols_list,$(BUILD)/somany/$(PLATFORM)/$(BUILDTYPE)/bundle.somany.def \
		-F$(FRAMEWORKS) -framework SOMANY 

$(FRAMEWORKS)/somcdr.dll: $(FRAMEWORKS)/SOMCDR.framework/Versions/$(FRAMEWORK_VERS)/SOMCDR
	$(CC) $(CFLAGS) $(BUNDLE) -o $@ \
		$(BUILD)/somcdr/$(PLATFORM)/$(BUILDTYPE)/bundle.somcdr.SOMInitModule.c \
		-Wl,-exported_symbols_list,$(BUILD)/somcdr/$(PLATFORM)/$(BUILDTYPE)/bundle.somcdr.def \
		-F$(FRAMEWORKS) -framework SOMCDR 

$(FRAMEWORKS)/somd.dll: $(FRAMEWORKS)/SOMD.framework/Versions/$(FRAMEWORK_VERS)/SOMD
	$(CC) $(CFLAGS) $(BUNDLE) -o $@ \
		$(BUILD)/somd/$(PLATFORM)/$(BUILDTYPE)/bundle.somd.SOMInitModule.c \
		-Wl,-exported_symbols_list,$(BUILD)/somd/$(PLATFORM)/$(BUILDTYPE)/bundle.somd.def \
		-F$(FRAMEWORKS) -framework SOMD 

$(FRAMEWORKS)/somos.dll: $(FRAMEWORKS)/SOMOS.framework/Versions/$(FRAMEWORK_VERS)/SOMOS
	$(CC) $(CFLAGS) $(BUNDLE) -o $@ \
		$(BUILD)/somos/$(PLATFORM)/$(BUILDTYPE)/bundle.somos.SOMInitModule.c \
		-Wl,-exported_symbols_list,$(BUILD)/somos/$(PLATFORM)/$(BUILDTYPE)/bundle.somos.def \
		-F$(FRAMEWORKS) -framework SOMOS 

$(FRAMEWORKS)/somabs1.dll: $(FRAMEWORKS)/SOMABS1.framework/Versions/$(FRAMEWORK_VERS)/SOMABS1
	$(CC) $(CFLAGS) $(BUNDLE) -o $@ \
		$(BUILD)/somabs1/$(PLATFORM)/$(BUILDTYPE)/bundle.somabs1.SOMInitModule.c \
		-Wl,-exported_symbols_list,$(BUILD)/somabs1/$(PLATFORM)/$(BUILDTYPE)/bundle.somabs1.def \
		-F$(FRAMEWORKS) -framework SOMABS1 
