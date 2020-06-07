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

OUTDIR_DSOM=$(OUTDIR_ETC)\dsom
SOMENV_INI=$(OUTDIR_ETC)\somenv.ini
SOMENV_CMD=$(OUTDIR_BIN)\somenv.cmd
IMPL_DB=$(OUTDIR_DSOM)\impl.db

all: $(OUTDIR_DSOM) $(SOMENV_INI)  $(SOMENV_CMD)

clean:
	$(CLEAN) "$(IMPL_DB)"
	$(CLEAN) "$(SOMENV_INI)"
	$(CLEAN) "$(SOMENV_CMD)"
	if exist "$(OUTDIR_DSOM)" rmdir "$(OUTDIR_DSOM)"

$(OUTDIR_DSOM):
	mkdir $@

dist:

$(SOMENV_INI): ..\win32\somenv.ini
	copy ..\win32\somenv.ini $@

$(SOMENV_CMD): ..\win32\somenv.cmd
	copy ..\win32\somenv.cmd $@

test:

