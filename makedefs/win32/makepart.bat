@echo off
rem
rem  Copyright 2008, Roger Brown
rem
rem  This file is part of Roger Brown's Toolkit.
rem
rem  This program is free software: you can redistribute it and/or modify it
rem  under the terms of the GNU Lesser General Public License as published by the
rem  Free Software Foundation, either version 3 of the License, or (at your
rem  option) any later version.
rem 
rem  This program is distributed in the hope that it will be useful, but WITHOUT
rem  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
rem  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
rem  more details.
rem
rem  You should have received a copy of the GNU Lesser General Public License
rem  along with this program.  If not, see <http://www.gnu.org/licenses/>
rem
rem  $Id$

set ACTION=%1
set PART=%2
set MAKEVERB=%3
set RC=1

if "%MAKE%" == "" goto finally

if "%ACTION%" == "makepart" goto makepart

%MAKE% makepart ACTION=%ACTION% PART=%PART%

set RC=%ERRORLEVEL%

goto :finally

:makepart

rem echo makepart...

rem echo PART = %PART%
rem echo PLATFORM = %PLATFORM%
rem echo CFG = %CFG%

set PART_MAK=..\..\%PART%\%PLATFORM_MAKEFILE%\%PART%.mak

rem dir %PART_MAK%

if not exist %PART_MAK% set PART_MAK=..\..\%PART%\win32\%PART%.mak

if not exist %PART_MAK% exit 0

if not exist ..\..\%PART%\%PLATFORM% mkdir ..\..\%PART%\%PLATFORM%

if not exist ..\..\%PART%\%PLATFORM% exit 1

pushd ..\..\%PART%\%PLATFORM%

if not "%ERRORLEVEL%" == "0" exit %ERRORLEVEL%

%MAKE% /E /F %PART_MAK% CPP="%CPP%" CFG=%CFG% ProgramFiles="%ProgramFiles%" %MAKEVERB%

set RC=%ERRORLEVEL%

if not "%RC%" == "0" goto makeend

if not "%MAKEVERB%" == "clean" goto makeend

if not exist "%BUILDTYPE%" goto makeend

rmdir "%BUILDTYPE%"

if exist "%BUILDTYPE%" dir "%BUILDTYPE%"

if exist "%BUILDTYPE%" exit 1

set RC=%ERRORLEVEL%

:makeend

popd

:finally

exit %RC%
