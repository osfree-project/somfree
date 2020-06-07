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

OUTDIR=$(OUTDIR_BIN)
INTDIR=$(BUILDTYPE)

DLLNAME=somddmsg

TARGET_DLL=$(OUTDIR)\$(DLLNAME).dll

all: $(TARGET_DLL)

clean:
	$(CLEAN) $(TARGET_DLL) $(INTDIR)\$(DLLNAME).res $(OUTDIR)\$(DLLNAME).pdb

	
$(TARGET_DLL): $(OUTDIR) $(INTDIR)\$(DLLNAME).res 
	LINK $(LDFLAGS) /OUT:$@ /DLL /NOENTRY $(INTDIR)\$(DLLNAME).res /VERSION:1.0
	$(POSTLINK_DLL) $@

$(INTDIR)\somddmsg.obj: ..\src\somddmsg.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\somddmsg.c

$(INTDIR):
	mkdir $@

$(INTDIR)\$(DLLNAME).res: ..\win32\$(DLLNAME).rc
	rc /nologo $(RCFLAGS) /r /I.. /I..\..\include\$(PLATFORM) /I$(INTDIR) /I..\..\somdd\win32 /fo$@ ..\win32\$(DLLNAME).rc

dist:




test:

