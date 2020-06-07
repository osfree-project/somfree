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

SC=$(SOMTOOLS_BIN)\sc.exe
SOMIR=$(OUTDIR_ETC)\som.ir
SOMIDL_IDL=..\..\somidl
SOMDD_DIR=..\..\somdd

SOMD_INTDIR=..\..\somd\$(PLATFORM)\$(BUILDTYPE)
IPV6TEST_H=$(SOMD_INTDIR)\ipv6test.h

$(IPV6TEST_H): ..\..\ipv6test\$(PLATFORM)\ipv6test.h
	copy /Y ..\..\ipv6test\$(PLATFORM)\ipv6test.h $@

DIRS=	$(SOMD_INTDIR)			 \

clean:
	$(CLEAN) $(IPV6TEST_H)
	$(CLEAN) $(SOMIR)

all: 	$(DIRS)			\
	$(IPV6TEST_H)		\
	$(SOMIR)

SOMIR_1=	$(SOMIDL_IDL)\somobj.idl		\
			$(SOMIDL_IDL)\somcls.idl		\
			$(SOMIDL_IDL)\somcm.idl

SOMIR_2=	$(SOMIDL_IDL)\somref.idl		\
			$(SOMIDL_IDL)\corba.idl			\
			$(SOMIDL_IDL)\dynany.idl		\
			$(SOMIDL_IDL)\poa.idl			\
			$(SOMDD_DIR)\somddsrv.idl

SOMIR_3=	$(SOMIDL_IDL)\intfacdf.idl		\
			$(SOMIDL_IDL)\repostry.idl		\

SOMIR_4=	$(SOMIDL_IDL)\stexcep.idl		\
			$(SOMIDL_IDL)\somdserv.idl		\
			$(SOMIDL_IDL)\somdcprx.idl		\
			$(SOMIDL_IDL)\somoa.idl			\
			$(SOMIDL_IDL)\implrep.idl		\
			$(SOMIDL_IDL)\orb.idl			\
			$(SOMIDL_IDL)\somestio.idl		\
			$(SOMIDL_IDL)\tcpsock.idl

$(SOMIR): $(SOMIR_1) $(SOMIR_2) $(SOMIR_3) $(SOMIR_4)
	set SOMIR=$(SOMIR)
	for %e in ( $(SOMIR_1) ) do "$(SC)" -sir -u -I $(SOMIDL_IDL) %e
	for %e in ( $(SOMIR_2) ) do "$(SC)" -sir -u -I $(SOMIDL_IDL) %e
	for %e in ( $(SOMIR_3) ) do "$(SC)" -sir -u -I $(SOMIDL_IDL) %e
	for %e in ( $(SOMIR_4) ) do "$(SC)" -sir -u -I $(SOMIDL_IDL) %e

$(SOMD_INTDIR):
	mkdir $@

dist:

test:

