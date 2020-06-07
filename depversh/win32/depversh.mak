#
#  Copyright 2011, Roger Brown
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

DEPVERS_INC=..\..\include\$(PLATFORM)
DEPVERS_EXE=$(RHBTOOLS_BIN)\depvers.exe
FIND_EXE=$(RHBTOOLS_BIN)\find.exe
DEPVERS_H=$(DEPVERS_INC)\depvers.h
MAKEDEFS_CFS=..\..\makedefs\$(PLATFORM)\$(BUILDTYPE)\makedefs.cfl

all: $(DEPVERS_H)

clean:
	$(CLEAN) $(DEPVERS_H)
	
$(DEPVERS_H): "$(DEPVERS_EXE)" "$(FIND_EXE)" "$(DEPVERS_INC)" $(MAKEDEFS_CFS)
	"$(DEPVERS_EXE)" --type h >$@ <$(MAKEDEFS_CFS)

dist:

$(DEPVERS_INC):
	mkdir $@

test:
