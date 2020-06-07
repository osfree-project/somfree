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

all install: optcheck


dist: $(OUTDIR_DIST)
	

$(OUTDIR_DIST):
	mkdir $@

clean:
	for d in $(INTDIR)/makedefs.mk 				\
			 $(INTDIR)/makedefs.sh 				\
			 $(INTDIR)/lib/*; 					\
	do if test -f "$$d"; then rm "$$d"; fi; done
	if test -d "$(INTDIR)/lib"; then rmdir "$(INTDIR)/lib"; fi


optcheck: opt-uuid-$(HAVE_LIBUUID)


opt-uuid-true:


opt-uuid-false:

test:
