@echo off
setlocal EnableDelayedExpansion
set path=%path%;%~dp0
set sw=HKLM\SOFTWARE
set u=Microsoft\Windows\CurrentVersion\Uninstall
set k=MozillaMaintenanceService
if not "%ProgramFiles(x86)%"=="" set x=Wow6432Node\

reg query "%sw%\%x%%u%\%k%" > nul 2>&1
if !errorlevel!==0 (
for /f "tokens=*" %%a in ('^
reg query "%sw%\%x%%u%\%k%" /v UninstallString ^|
findstr "UninstallString" ^|
sed "s/UninstallString\|REG_SZ//g" ^|
sed "s/^[ \t]*//g"') do (
%%a /S
)
)

:CheckUninstallKey
reg query "%sw%\%x%%u%\%k%" > nul 2>&1
if !errorlevel!==0 goto CheckUninstallKey
endlocal
