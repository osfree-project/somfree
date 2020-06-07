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

:myloop

if "%1" == "" goto done

if exist "%1" del "%1"
if exist "%1.manifest" del "%1.manifest"

shift

goto myloop

:done
