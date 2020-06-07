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

SOMTKLIB=$(OUTDIR_LIB)\somtk.lib

all: $(SOMTKLIB)

SOMLIBS=$(OUTDIR_LIB)\somobjva.lib \
		$(OUTDIR_DLL)\som.lib \
		$(OUTDIR_DLL)\somd.lib \
		$(OUTDIR_DLL)\somdcomm.lib \
		$(OUTDIR_DLL)\somu.lib \
		$(OUTDIR_DLL)\somref.lib \
		$(OUTDIR_DLL)\somtc.lib \
		$(OUTDIR_DLL)\somu2.lib \
		$(OUTDIR_DLL)\somir.lib \
		$(OUTDIR_DLL)\somos.lib \
		$(OUTDIR_DLL)\somabs1.lib \
		$(OUTDIR_DLL)\somestrm.lib \
		$(OUTDIR_DLL)\somem.lib \
		$(OUTDIR_DLL)\somp.lib \
		$(OUTDIR_DLL)\somnmf.lib \
		$(OUTDIR_DLL)\soms.lib 

$(SOMTKLIB): $(SOMLIBS)
	if exist $@ del $@
	lib  $(SOMLIBS) /OUT:$@ 

clean:
	if exist $(SOMTKLIB) del $(SOMTKLIB)


dist:




test:

