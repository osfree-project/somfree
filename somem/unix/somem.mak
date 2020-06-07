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

OBJS=	$(INTDIR)/rhbeman.o \
		$(INTDIR)/clientev.o \
		$(INTDIR)/eman.o \
		$(INTDIR)/sinkev.o \
		$(INTDIR)/timerev.o \
		$(INTDIR)/workprev.o \
		$(INTDIR)/event.o \
		$(INTDIR)/emregdat.o
TARGET=$(OUTDIR_SHLIB)/$(DLLPREFIX)somem$(DLLSUFFIX)
INCL=	-I$(INTDIR) \
		-I../include \
		-I../../somidl/$(PLATFORM) \
		-I../../somkpub/include		\
		-I../../somtk/include		\
		$(STDINCL)

all:  $(TARGET)

clean:
	$(CLEAN) $(OBJS) $(TARGET)

$(TARGET): $(OBJS) 
	$(LINKDLL) $(LINKDLL_HEAD) \
		-o $@ \
		$(OBJS) \
		`$(SHLB_EXP) somem somem` \
		`$(SHLB_REF) somu somu` \
		`$(SHLB_REF) somref somref` \
		`$(SHLB_REF) som som` \
		`$(SHLB_ENT) SOMInitModule` \
		`$(SHLB_MAP) somem somem` \
		 $(SOCKLIBS) $(STDLIB) \
		$(LINKDLL_TAIL)

$(INTDIR)/rhbeman.o: ../src/rhbeman.c
	$(CC_DLL) $(STDOPT) $(INCL)  -DBUILD_SOMEM -c ../src/rhbeman.c -o $@

$(INTDIR)/eman.o: ../src/eman.c 
	$(CC_DLL) $(STDOPT) $(INCL)  -DBUILD_SOMEM -c ../src/eman.c -o $@

$(INTDIR)/sinkev.o: ../src/sinkev.c 
	$(CC_DLL) $(STDOPT) $(INCL)  -DBUILD_SOMEM -c ../src/sinkev.c -o $@

$(INTDIR)/timerev.o: ../src/timerev.c 
	$(CC_DLL) $(STDOPT) $(INCL)  -DBUILD_SOMEM -c ../src/timerev.c -o $@

$(INTDIR)/clientev.o: ../src/clientev.c 
	$(CC_DLL) $(STDOPT) $(INCL)  -DBUILD_SOMEM -c ../src/clientev.c -o $@

$(INTDIR)/event.o: ../src/event.c 
	$(CC_DLL) $(STDOPT) $(INCL)  -DBUILD_SOMEM -c ../src/event.c -o $@

$(INTDIR)/emregdat.o: ../src/emregdat.c 
	$(CC_DLL) $(STDOPT) $(INCL)  -DBUILD_SOMEM -c ../src/emregdat.c -o $@

$(INTDIR)/workprev.o: ../src/workprev.c 
	$(CC_DLL) $(STDOPT) $(INCL)  -DBUILD_SOMEM -c ../src/workprev.c -o $@

dist install test:

