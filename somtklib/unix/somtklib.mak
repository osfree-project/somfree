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

TARGET=$(OUTDIR_LIB)/libsomtk.a
TMPLIB=$(INTDIR)/libsomtk.a
STRIP=

all: $(TARGET)

dist:
	if test -f ../$(PLATFORM_PROTO)/dist.mak; then $(MAKE) -f ../$(PLATFORM_PROTO)/dist.mak BUILDTYPE=$(BUILDTYPE) PLATFORM=$(PLATFORM); fi

install test:

clean:
	$(CLEAN) $(TARGET) $(TMPLIB) $(INTDIR)/lib*.so
	if test -f ../$(PLATFORM_PROTO)/dist.mak; then $(MAKE) -f ../$(PLATFORM_PROTO)/dist.mak clean BUILDTYPE=$(BUILDTYPE) PLATFORM=$(PLATFORM); fi

$(TARGET): $(TMPLIB)
	if test -f "$(TMPLIB)"; then mv "$(TMPLIB)" $@;	fi

$(TMPLIB):
	for d in som somref somtc somd somir somut somu somu2 somabs1 somnmf somos somdcomm somany somcorba somabs1 somcslib somem somuc somst soms somp; \
	do \
		for e in so dylib; \
		do \
			if test -f "$(OUTDIR_LIB)/lib$$d.$$e"; \
			then \
				cp "$(OUTDIR_LIB)/lib$$d.$$e" "$(INTDIR)/lib$$d.$$e"; \
				if test "$(STRIP)" != ""; then $(STRIP) "$(INTDIR)/lib$$d.$$e"; fi; \
			fi; \
		done; \
	done
	cd $(INTDIR); \
	FOUND=; for d in lib*.so lib*.dylib; do if test -f "$$d"; then FOUND="$$FOUND $$d"; fi; done; \
	if test "$$FOUND" != ""; \
	then \
		$(AR) $(ARFLAGS) `basename $@` $$FOUND; \
		rm $$FOUND; \
		if test "$(RANLIB)" != ""; then $(RANLIB) `basename $@`; fi; \
	fi

