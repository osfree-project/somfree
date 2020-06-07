@echo off
rem $Id$

if "%ProgramFiles%\somtk\bin\" == "%~dp0" set SOMBASE=%ProgramFiles%\somtk
if "%ProgramFiles(x86)%\somtk\bin\" == "%~dp0" set SOMBASE=%ProgramFiles(x86)%\somtk
if "%ProgramW6432%\somtk\bin\" == "%~dp0" set SOMBASE=%ProgramW6432%\somtk

if "%SOMBASE%x" == "x" if exist "%ProgramFiles%\somtk" set SOMBASE=%ProgramFiles%\somtk

if "%SOMBASE%x" == "x" goto firsttime

set PATH=%SOMBASE%\bin;%PATH%
set LIB=.;%SOMBASE%\lib;%LIB%
set INCLUDE=.;%SOMBASE%\include;%INCLUDE%
set SMMINCLUDE=.;%SOMBASE%\include
set SOMENV=%SOMBASE%\etc\somenv.ini
set SC=%SOMBASE%\bin\sc.exe
set SOMIR=%SOMBASE%\etc\som.ir

goto end

:firsttime
echo Edit %0 to set SOMBASE.

:end
