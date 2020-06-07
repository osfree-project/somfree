#
#  Copyright 2012, Roger Brown
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

APPNAME=somtk
INTDIR=$(BUILDTYPE)
OUTDIR_TMP=$(INTDIR)\content
MAKEDEFS_CFS=..\..\makedefs\$(PLATFORM)\$(BUILDTYPE)\makedefs.cfl
TARGET_DDF=$(INTDIR)\somtkpkg.ddf
TARGET_CAB=$(OUTDIR_DIST)\$(APPNAME).cab
TARGET_ZIP=$(OUTDIR_DIST)\$(APPNAME).zip
TARGET_MSI=$(OUTDIR_DIST)\$(APPNAME).msi
DDF2WXS_DLL=..\..\toolbox2\ddf2wxs\bin\$(BUILDTYPE)\netcoreapp2.1\ddf2wxs.dll
MAKEZIP_DLL=..\..\toolbox2\makezip\bin\$(BUILDTYPE)\netcoreapp2.1\makezip.dll
DEPVERS_H=..\..\include\$(PLATFORM)\depvers.h
SOM_IR=$(INTDIR)\som.ir
SC=$(SOMTOOLS_BIN)\sc.exe

all:

clean:
	if exist $(OUTDIR_TMP) rmdir /S /Q $(OUTDIR_TMP)
	$(CLEAN) "$(TARGET_MSI)" "$(TARGET_CAB)" "$(TARGET_ZIP)" "$(TARGET_DDF)" setup.inf setup.rpt "$(OUTDIR_DIST)\$(APPNAME).wixpdb" 
	$(CLEAN) somtk.wxs somtk.wixobj "$(SOM_IR)" "$(TARGET_DDF).$(PLATFORM)" "$(TARGET_DDF).cabinet"
	
dist: $(TARGET_CAB) $(TARGET_MSI) $(TARGET_ZIP)

$(INTDIR) $(OUTDIR_TMP):
	mkdir $@

$(OUTDIR_TMP)\include: $(OUTDIR_TMP)
	mkdir $@
	copy ..\..\somtk\include\*.xh $@	
	copy ..\..\somtk\include\*.h $@	
	copy ..\..\somkpub\include\*.xh $@	
	copy ..\..\somkpub\include\*.h $@	
	copy ..\..\somidl\*.idl $@	
	copy ..\..\somidl\$(PLATFORM)\*.xh $@
	copy ..\..\somidl\$(PLATFORM)\*.h $@
	copy ..\..\somidl\$(PLATFORM)\somcls.api $@

$(TARGET_DDF): $(OUTDIR_TMP)\include ..\win32\somtkpkg.mak $(SOM_IR)
	echo .Set CabinetName1=$(APPNAME).cab > $@
	echo .Set DiskDirectory1=$(OUTDIR_DIST) >> $@
	echo .Set CabinetFileCountThreshold=0 >> $@
	echo .Set FolderFileCountThreshold=0 >> $@
	echo .Set FolderSizeThreshold=0 >> $@
	echo .Set MaxCabinetSize=0 >> $@
	echo .Set MaxDiskFileCount=0 >> $@
	echo .Set MaxDiskSize=0 >> $@
	echo .Set DestinationDir=include >> $@
	"$(RHBTOOLS_BIN)\find.exe" $(OUTDIR_TMP)\include -type f >> $@
	echo .Set DestinationDir=bin >> $@
	echo ..\..\somenv\win32\somenv.cmd >> $@
	for %d in ( somdsvr somdd somdchk sc dsom irdump pdl regimpl somipc somossvr somcpp ) do echo $(OUTDIR_BIN)\%d.exe >> $@
	for %d in ( som somtc somir somd somos somdcomm somem somnmf somabs1 somref ) do echo $(OUTDIR_BIN)\%d.dll >> $@
	for %d in ( somany somcdr somcorba somcslib somestrm somp soms somst somu somu2 ) do echo $(OUTDIR_BIN)\%d.dll >> $@
	echo .Set DestinationDir=lib >> $@
	echo $(OUTDIR_LIB)\somtk.lib >> $@
	echo .Set DestinationDir=etc >> $@
	echo $(SOM_IR) >> $@
	echo $(OUTDIR_ETC)\somenv.ini >> $@
	echo .Set DestinationDir=etc\dsom >> $@
	echo ..\..\somdd\rsrc\impl.db >> $@

"$(TARGET_DDF).win32i86": "$(TARGET_DDF)"  
	copy /Y "$(TARGET_DDF)" $@
	echo .Set DestinationDir=SystemFolder >> $@
	echo $(OUTDIR_BIN)\somddmsg.dll >> $@

"$(TARGET_DDF).win64amd": "$(TARGET_DDF)"  
	copy /Y "$(TARGET_DDF)" $@
	echo .Set DestinationDir=msg >> $@
	echo $(OUTDIR_BIN)\somddmsg.dll >> $@

"$(TARGET_DDF).cabinet": "$(TARGET_DDF)" 
	copy /Y "$(TARGET_DDF)" $@
	echo .Set DestinationDir=msg >> $@
	echo $(OUTDIR_BIN)\somddmsg.dll >> $@

"$(TARGET_DDF).win64arm" "$(TARGET_DDF).win32arm": "$(TARGET_DDF)"

$(TARGET_MSI): "$(TARGET_DDF).$(PLATFORM)" ..\pkg\license.rtf "$(DDF2WXS_DLL)" "$(DEPVERS_H)" 
	if exist $@ del $@
	if exist ..\pkg\$(PLATFORM).wxs dotnet "$(DDF2WXS_DLL)" -i ..\pkg\$(PLATFORM).wxs -o somtk.wxs -d "$(TARGET_DDF).$(PLATFORM)" -h "$(DEPVERS_H)" -p somtkpkg
	if exist somtk.wxs "$(WIX)\bin\candle.exe" -nologo somtk.wxs -ext WixUtilExtension 
	if exist somtk.wixobj "$(WIX)\bin\light.exe" -nologo -cultures:null -out $@ somtk.wixobj -ext WixUtilExtension -ext WixUIExtension

$(TARGET_CAB): $(TARGET_DDF).cabinet
	if exist setup.inf del setup.inf
	if exist setup.rpt del setup.rpt
	makecab /F $(TARGET_DDF).cabinet

$(TARGET_ZIP): $(TARGET_DDF).cabinet "$(MAKEZIP_DLL)"
	dotnet "$(MAKEZIP_DLL)" -d $(TARGET_DDF).cabinet -o $@

$(SOM_IR): $(OUTDIR_TMP)\include
	set SOMIR=$(SOM_IR)
	for %e in ( $(OUTDIR_TMP)\include\*.idl )  do "$(SC)" -sir -u -I $(OUTDIR_TMP)\include %e
	dir $(SOM_IR)

test:

