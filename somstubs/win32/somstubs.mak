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

!IF "$(PLATFORM_DEF)" == ""
PLATFORM_DEF=win32
!ENDIF

INTDIR=$(BUILDTYPE)

SOMIR_PDB=$(OUTDIR_LIB)\somir.pdb
SOMIR_LIB=$(OUTDIR_LIB)\somir.lib
SOMIR_DLL=$(OUTDIR_LIB)\somir.dll
SOMIR_EXP=$(OUTDIR_LIB)\somir.exp
SOMOS_PDB=$(OUTDIR_LIB)\somos.pdb
SOMOS_LIB=$(OUTDIR_LIB)\somos.lib
SOMNMF_PDB=$(OUTDIR_LIB)\somnmf.pdb
SOMNMF_LIB=$(OUTDIR_LIB)\somnmf.lib
SOMOS_DLL=$(OUTDIR_LIB)\somos.dll
SOMNMF_DLL=$(OUTDIR_LIB)\somnmf.dll
SOMNMF_MAP=$(INTDIR)\somnmf.map
SOMOS_EXP=$(OUTDIR_LIB)\somos.exp
SOMNMF_EXP=$(OUTDIR_LIB)\somnmf.exp
SOMIR_OBJ=$(INTDIR)\somir.obj
SOMOS_OBJ=$(INTDIR)\somos.obj
SOMNMF_OBJ=$(INTDIR)\somnmf.obj
SOMNMF_DEF=..\..\somnmf\$(PLATFORM_DEF)\somnmf.def
SOMOS_DEF=..\..\somos\$(PLATFORM_DEF)\somos.def
SOMIR_DEF=..\..\somir\$(PLATFORM_DEF)\somir.def
SOMIR_RES=$(OUTDIR_LIB)\somir.res
SOMOS_RES=$(OUTDIR_LIB)\somos.res
SOMNMF_RES=$(OUTDIR_LIB)\somnmf.res
SOMNMF_RC=..\..\somnmf\$(PLATFORM_DEF)\somnmf.rc
SOMOS_RC=..\..\somos\$(PLATFORM_DEF)\somos.rc
SOMIR_RC=..\..\somir\$(PLATFORM_DEF)\somir.rc

CC_OPTS=$(STDOPT)						\
		/DWIN32_LEAN_AND_MEAN			\
		/DDONT_COMMENT_LIB				\
		/DHAVE_CONFIG_H					\
		/DBUILD_SOMSTUBS				\
		/I..\include					\
		/I..\..\include\$(PLATFORM)		\
		/I..\..\include\$(PLATFORM_DEF) \
		/I..\..\include					\
		/I..\..\somidl\$(PLATFORM)		\
		/I..\..\somkpub\include			\
		/I..\..\somtk\include

all: $(BUILDTYPE) $(SOMNMF_LIB) $(SOMOS_LIB) 
# $(SOMIR_LIB)

clean: 
	$(CLEAN) $(SOMNMF_DLL) $(SOMNMF_PDB)
	$(CLEAN) $(SOMOS_DLL) $(SOMOS_PDB)
	$(CLEAN) $(SOMNMF_OBJ) $(SOMNMF_MAP)
	$(CLEAN) $(SOMOS_OBJ)
	$(CLEAN) $(SOMNMF_EXP)
	$(CLEAN) $(SOMOS_EXP)
	$(CLEAN) $(SOMNMF_LIB)
	$(CLEAN) $(SOMOS_LIB)
	$(CLEAN) $(SOMOS_RES)
	$(CLEAN) $(SOMIR_LIB) $(SOMIR_PDB)
	$(CLEAN) $(SOMIR_OBJ)
	$(CLEAN) $(SOMIR_EXP)
	$(CLEAN) $(SOMIR_DLL)
	$(CLEAN) $(SOMIR_RES)
	$(CLEAN) $(SOMNMF_RES)

$(BUILDTYPE):
	mkdir $(BUILDTYPE)

$(SOMNMF_LIB): $(SOMNMF_DLL)

$(SOMOS_LIB): $(SOMOS_DLL)

$(SOMIR_LIB): $(SOMIR_DLL)

$(SOMOS_DLL): $(SOMOS_OBJ) $(SOMOS_DEF) $(SOMOS_RES)
	$(CC) $(CC_OUT_DLL)$@ $(SOMOS_OBJ) $(CC_OUT_PDB)$(SOMOS_PDB) \
		$(CC_LINK) $(LDFLAGS) $(LD_SUBSYSTEM_CONSOLE) $(LD_DEF)$(SOMOS_DEF) $(SOMOS_RES)
	$(POSTLINK_DLL) $@

$(SOMIR_DLL): $(SOMIR_OBJ) $(SOMIR_DEF) $(SOMIR_RES)
	$(CC) $(CC_OUT_DLL)$@ $(SOMIR_OBJ) $(CC_OUT_PDB)$(SOMIR_PDB) \
		$(CC_LINK) $(LDFLAGS) $(LD_SUBSYSTEM_CONSOLE)  $(LD_DEF)$(SOMIR_DEF) $(SOMIR_RES)
	$(POSTLINK_DLL) $@

$(SOMNMF_DLL): $(SOMNMF_OBJ) $(SOMNMF_DEF) $(SOMNMF_RES)
	$(CC) $(CC_OUT_DLL)$@ $(SOMNMF_OBJ) \
			$(CC_OUT_PDB)$(SOMNMF_PDB) \
			$(CC_LINK) $(LDFLAGS) $(LD_SUBSYSTEM_CONSOLE) \
			$(LD_DEF)$(SOMNMF_DEF) $(SOMNMF_RES)
	$(POSTLINK_DLL) $@

$(SOMOS_OBJ): ..\..\somos\src\stub.c
	$(CC) $(CC_OPTS) -c ..\..\somos\src\stub.c $(CC_OUT_OBJ)$@ $(CC_OUT_PDB)$(SOMOS_PDB)

$(SOMNMF_OBJ): ..\..\somnmf\src\stub.c
	$(CC) $(CC_OPTS) -c ..\..\somnmf\src\stub.c $(CC_OUT_OBJ)$@  $(CC_OUT_PDB)$(SOMNMF_PDB)

$(SOMIR_OBJ): ..\..\somir\src\stub.c
	$(CC) $(CC_OPTS) -c ..\..\somir\src\stub.c $(CC_OUT_OBJ)$@ $(CC_OUT_PDB)$(SOMIR_PDB)

$(SOMIR_RES): $(SOMIR_RC)
	rc /nologo /r /I..\..\somir /I..\..\include\$(PLATFORM) /fo$@ $(SOMIR_RC)

$(SOMNMF_RES): $(SOMNMF_RC)
	rc /nologo /r /I..\..\somnmf /I..\..\include\$(PLATFORM) /fo$@ $(SOMNMF_RC)

$(SOMOS_RES): $(SOMOS_RC)
	rc /nologo /r /I..\..\somir /I..\..\include\$(PLATFORM) /fo$@ $(SOMOS_RC)

dist:




test:

