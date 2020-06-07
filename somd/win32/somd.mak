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

DLLNAME=somd

TARGET_DLL=$(OUTDIR)\$(DLLNAME).dll
TARGET_PDB=$(OUTDIR)\$(DLLNAME).pdb
TARGET_DEF=..\$(PLATFORM_DEF)\$(DLLNAME).def

PARTOPTS=	$(STDOPT)								\
			/DWIN32_LEAN_AND_MEAN 					\
			/DBUILD_SOMD							\
			/DHAVE_CONFIG_H							\
			/I$(INTDIR)								\
			/I..\include							\
			/I..\..\include\$(PLATFORM)				\
			/I..\..\include\$(PLATFORM_DEF)			\
			/I..\..\include							\
			/I..\..\som\$(PLATFORM)\$(BUILDTYPE)	\
			/I..\..\somref\$(PLATFORM)\$(BUILDTYPE)	\
			/I..\..\somidl\$(PLATFORM)				\
			/I..\..\somcdr\$(PLATFORM)\$(BUILDTYPE)	\
			/I..\..\somcdr\include					\
			/I..\..\rhbmtut\include					\
			/I..\..\uuid\include					\
			/I..\..\somtc\include					\
			/I..\..\soms\include					\
			/I..\..\somu\include					\
			/I..\..\somkpub\include					\
			/I..\..\somtk\include					\
			$(CC_OUT_PDB)$(TARGET_PDB)			

OBJS=	$(INTDIR)\rhbsomd.obj	\
		$(INTDIR)\orb.obj		\
		$(INTDIR)\boa.obj		\
		$(INTDIR)\somoa.obj		\
		$(INTDIR)\somdobj.obj	\
		$(INTDIR)\somdcprx.obj	\
		$(INTDIR)\cntxt.obj		\
		$(INTDIR)\principl.obj	\
		$(INTDIR)\request.obj	\
		$(INTDIR)\poa.obj		\
		$(INTDIR)\servmgr.obj	\
		$(INTDIR)\somdfenc.obj	\
		$(INTDIR)\somdmprx.obj	\
		$(INTDIR)\servreq.obj	\
		$(INTDIR)\nvlist.obj	\
		$(INTDIR)\impldef.obj	\
		$(INTDIR)\implrep.obj	\
		$(INTDIR)\somdserv.obj	\
		$(INTDIR)\om.obj		\
		$(INTDIR)\somdom.obj	\
		$(INTDIR)\unotypes.obj	\
		$(INTDIR)\somdtcdt.obj	\
		$(INTDIR)\somdstub.obj	\
		$(INTDIR)\rhborbst.obj	\
		$(INTDIR)\rhbgiop1.obj	\
		$(INTDIR)\rhbgiop2.obj	\
		$(INTDIR)\rhbgiop3.obj	\
		$(INTDIR)\rhbgiop4.obj	\
		$(INTDIR)\rhbgiop5.obj	\
		$(INTDIR)\rhbgiop6.obj	\
		$(INTDIR)\rhbgiop7.obj	\
		$(INTDIR)\rhbgiop8.obj	\
		$(INTDIR)\rhbgiop9.obj	\
		$(INTDIR)\rhbgiops.obj	\
		$(INTDIR)\link386.obj

all: $(TARGET_DLL)

clean:
	$(CLEAN)	$(TARGET_DLL)				\
				$(TARGET_PDB)				\
				$(OBJS)						\
				$(OUTDIR)\$(DLLNAME).exp	\
				$(OUTDIR)\$(DLLNAME).lib	\
				$(INTDIR)\$(DLLNAME).res
	
$(TARGET_DLL): $(OBJS) $(OUTDIR) $(TARGET_DEF) $(INTDIR)\$(DLLNAME).res
	$(CC) $(CC_OUT_DLL)$@ $(OBJS)		\
			$(CC_OUT_PDB)$(TARGET_PDB)	\
			$(CC_LINK)					\
			$(LDFLAGS)					\
			$(LD_DEF)$(TARGET_DEF)		\
			$(INTDIR)\$(DLLNAME).res
	$(POSTLINK_DLL) $@

$(INTDIR)\rhbsomd.obj: ..\src\rhbsomd.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\rhbsomd.c

$(INTDIR)\orb.obj: ..\src\orb.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\orb.c

$(INTDIR)\boa.obj: ..\src\boa.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\boa.c

$(INTDIR)\somoa.obj: ..\src\somoa.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\somoa.c

$(INTDIR)\somdobj.obj: ..\src\somdobj.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\somdobj.c

$(INTDIR)\somdcprx.obj: ..\src\somdcprx.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\somdcprx.c

$(INTDIR)\cntxt.obj: ..\src\cntxt.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\cntxt.c

$(INTDIR)\principl.obj: ..\src\principl.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\principl.c

$(INTDIR)\request.obj: ..\src\request.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\request.c

$(INTDIR)\poa.obj: ..\src\poa.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\poa.c

$(INTDIR)\servmgr.obj: ..\src\servmgr.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\servmgr.c

$(INTDIR)\somdfenc.obj: ..\src\somdfenc.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\somdfenc.c

$(INTDIR)\somdstub.obj: ..\src\somdstub.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\somdstub.c

$(INTDIR)\somdmprx.obj: ..\src\somdmprx.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\somdmprx.c

$(INTDIR)\somdserv.obj: ..\src\somdserv.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\somdserv.c

$(INTDIR)\servreq.obj: ..\src\servreq.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\servreq.c

$(INTDIR)\impldef.obj: ..\src\impldef.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\impldef.c

$(INTDIR)\implrep.obj: ..\src\implrep.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\implrep.c

$(INTDIR)\somdom.obj: ..\src\somdom.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\somdom.c

$(INTDIR)\om.obj: ..\src\om.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\om.c

$(INTDIR)\nvlist.obj: ..\src\nvlist.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\nvlist.c

$(INTDIR)\unotypes.obj: ..\src\unotypes.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\unotypes.c

$(INTDIR)\somdtcdt.obj: ..\src\somdtcdt.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\somdtcdt.c

$(INTDIR)\rhbgiop1.obj: ..\src\rhbgiop1.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\rhbgiop1.c

$(INTDIR)\rhbgiop2.obj: ..\src\rhbgiop2.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\rhbgiop2.c

$(INTDIR)\rhbgiop3.obj: ..\src\rhbgiop3.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\rhbgiop3.c

$(INTDIR)\rhbgiop4.obj: ..\src\rhbgiop4.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\rhbgiop4.c

$(INTDIR)\rhbgiop5.obj: ..\src\rhbgiop5.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\rhbgiop5.c

$(INTDIR)\rhbgiop6.obj: ..\src\rhbgiop6.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\rhbgiop6.c

$(INTDIR)\rhbgiop7.obj: ..\src\rhbgiop7.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\rhbgiop7.c

$(INTDIR)\rhbgiop8.obj: ..\src\rhbgiop8.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\rhbgiop8.c

$(INTDIR)\rhbgiop9.obj: ..\src\rhbgiop9.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\rhbgiop9.c

$(INTDIR)\rhbgiops.obj: ..\src\rhbgiops.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\rhbgiops.c

$(INTDIR)\rhborbst.obj: ..\src\rhborbst.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\src\rhborbst.c

$(INTDIR)\link386.obj: ..\win32\link386.c $(INTDIR)
	$(CC) /c $(PARTOPTS) $(CC_OUT_OBJ)$@ ..\win32\link386.c

$(INTDIR):
	mkdir $@

$(INTDIR)\$(DLLNAME).res: ..\win32\$(DLLNAME).rc
	rc /nologo /r /I.. /I..\..\include\$(PLATFORM) /fo$@ ..\win32\$(DLLNAME).rc

dist:




test:

