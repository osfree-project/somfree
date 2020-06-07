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

!INCLUDE $(MAKEDEFS)

INTDIR=$(BUILDTYPE)
APPNAME=config
CONFIG_SRC=..\src
CONFIG_C=$(CONFIG_SRC)\config.c
CONFIG2_C=$(CONFIG_SRC)\config2.c
CONFIG2_CPP=$(CONFIG_SRC)\config2.cpp
CONFIG_EXE=$(OUTDIR_TOOLS)\config.exe
CONFIG_PDB=$(OUTDIR_TOOLS)\config.pdb
CONFIG_OBJ=.\$(INTDIR)\config.obj
CONFIG2_OBJ=.\$(INTDIR)\config2.obj
CONFIG_IP=..\..\include\$(PLATFORM_DEF)
CONFIG_I=..\..\include\$(PLATFORM)
CONFIG_H=$(CONFIG_I)\config.h
CONFIG_HPP=$(CONFIG_I)\config.hpp
CONFIG_LOG=$(INTDIR)\config.log
IMPLIB_DIR=$(OUTDIR_LIB)
OBJS=$(CONFIG_OBJ) $(CONFIG2_OBJ)

HOSTDIR_CONFIG_EXE=$(HOSTDIR_TOOLS)\config.exe

all: checkenv $(OUTDIR_TOOLS) $(INTDIR) $(CONFIG_I) $(CONFIG_HPP)

checkenv:
	if "$(OUTDIR_BIN)" == "" exit 1
	if "$(OUTDIR_ETC)" == "" exit 1
	if "$(OUTDIR_LIB)" == "" exit 1
	if "$(OUTDIR_DLL)" == "" exit 1
	if "$(OUTDIR_TESTS)" == "" exit 1
	if "$(OUTDIR_TOOLS)" == "" exit 1
	if "$(CLEAN)" == "" exit 1
	if "$(MIDL)" == "" exit 1
	if "$(MKTYPLIB)" == "" exit 1
	if "$(CC)" == "" exit 1
	if "$(CXX)" == "" exit 1
	if "$(CC_OUT_OBJ)" == "" exit 1
	if "$(CC_OUT_EXE)" == "" exit 1
	if "$(CC_OUT_DLL)" == "" exit 1
	if "$(RCFLAGS)" == "" exit 1
	if "$(LDFLAGS)" == "" exit 1
	if "$(STDOPT)" == "" exit 1
	if "$(STDOPTXX)" == "" exit 1

$(CONFIG_OBJ): $(CONFIG_C) ..\win32\config.mak 
	$(CC) $(STDOPT) -DBUILD_CONFIG -c $(CONFIG_C) $(CC_OUT_OBJ)$@ $(CC_OUT_PDB)$(CONFIG_PDB)
	
$(CONFIG2_OBJ): $(CONFIG2_C) ..\win32\config.mak 
	$(CC) $(STDOPT) -DBUILD_CONFIG -c $(CONFIG2_C) $(CC_OUT_OBJ)$@ $(CC_OUT_PDB)$(CONFIG_PDB)

$(CONFIG_EXE): $(OBJS) $(INTDIR)\$(APPNAME).res
	$(CC) $(OBJS) $(CC_OUT_EXE)$@ $(CC_OUT_PDB)$(CONFIG_PDB) $(CC_LINK) $(LD_SUBSYSTEM_CONSOLE) $(LD_ENTRY_MAIN) $(LDFLAGS) $(INTDIR)\$(APPNAME).res
	$(POSTLINK_EXE) $@
	
clean:
	$(CLEAN) $(CONFIG_EXE)		\
			 $(CONFIG_PDB)		\
			 $(CONFIG_HPP)		\
			 $(CONFIG_H)		\
			 $(OBJS)			\
			 $(CONFIG_LOG)		\
			 $(INTDIR)\$(APPNAME).res
	$(CLEAN) $(INTDIR)\CONFIG3.EXE $(INTDIR)\CONFIG3.OBJ
	$(CLEAN) $(INTDIR)\CONFIG3.EXP $(INTDIR)\CONFIG3.LIB

$(CONFIG_H): $(HOSTDIR_CONFIG_EXE) $(CONFIG2_C) $(CONFIG2_CPP)
	set INCLUDE=IMPLIB_DIR;$(INCLUDE)
	set CONFIG2_C=$(CONFIG2_C)
	set CONFIG2_CPP=$(CONFIG2_CPP)
	set CONFIG_H=$(CONFIG_H)
	set CONFIG_HPP=$(CONFIG_HPP)
	set CONFIG_CC=$(CC) 
	set CONFIG_CXX=$(CXX)
	set CONFIG_CC_EP=$(CC) /EP
	set CONFIG_CXX_EP=$(CXX) /EP /I../src
	set CONFIG_LINKOPTS=$(CC_OUT_OBJ)$(INTDIR)\CONFIG3.OBJ $(CC_OUT_EXE)$(INTDIR)\CONFIG3.EXE $(CC_LINK) $(LDFLAGS) $(LD_SUBSYSTEM_CONSOLE) $(LD_ENTRY_MAIN) $(LD_PDB_NONE)
	set CONFIG_LOG=$(CONFIG_LOG)
	$(HOSTDIR_CONFIG_EXE) /DWIN32_LEAN_AND_MEAN /I$(CONFIG_I) /I$(CONFIG_IP) /I$(CONFIG_SRC) $(CONFIG_OPTS)
	dir $@
	echo $(MAKE)
	$(CLEAN) $(INTDIR)\CONFIG3.EXE $(INTDIR)\CONFIG3.OBJ
	$(CLEAN) $(INTDIR)\CONFIG3.EXP $(INTDIR)\CONFIG3.LIB

$(CONFIG_HPP): $(CONFIG_H) 

$(INTDIR) $(IMPLIB_DIR) $(CONFIG_I):
	mkdir $@

$(INTDIR)\$(APPNAME).res: ..\win32\$(APPNAME).rc
	rc /nologo $(RCFLAGS) /r /I.. /I..\..\include\$(PLATFORM) /fo$@ ..\win32\$(APPNAME).rc

dist:


test:

