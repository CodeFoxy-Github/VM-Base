rem //this is sync with ver 2.4.2
@echo off
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
    bitsadmin /transfer mydownloadjob /download /priority FOREGROUND "https://github.com/CodeFoxy-Github/VM-Base/raw/main/aria2c.exe" "%path%/aric2c.exe"
set path = %cd%
echo If VirtualBox is NOT installed enter "yes"
timeout 3 /nobreak
cls
set /p ans="install VirtualBox6.1.34 ? (yes/no)"
if %ans% == yes (
aria2c https://raw.githubusercontent.com/CodeFoxy-Github/VM-Base/main/winget.zip
Call :UnZipFile "%cd%" "%cd%\winget.zip"
cd test
winget install Oracle.VirtualBox
cd %path%
)
cls
echo 1. Windows 10 Home x64
echo 2. Windows 10 Professional x64
echo (Password is : "your mom"(have space))
set /p id="Enter ID: "
if %id% == 1 (
aria2c https://drive.google.com/uc?id=1SQHTssEtXWNppTeQH9IP2ds88DMhnY-E&confirm=t
)
if %id% == 2 (
aria2c https://drive.google.com/uc?id=1Z6vD5BNrMqKOWAt7iZ9txA37bYHPynCU&confirm=t
)

echo if download is completed press any key to install
timeout /t -1
cls
cd C:\Program Files\Oracle\VirtualBox
if %id% == 1 (
VBoxManage createvm --name "Windows 10 Home x64" --register
)
if %id% == 2 (
VBoxManage createvm --name "Windows 10 Professional x64" --register
)
setlocal

cd /d %~dp0


Call :UnZipFile "%USERPROFILE%\VirtualBox VMs" "%cd%\%id%.zip"

:UnZipFile <ExtractTo> <newzipfile>
set vbs="%temp%\0D5G0H8E0T9ZAH.vbs"
if exist %vbs% del /f /q %vbs%
>%vbs%  echo Set fso = CreateObject("Scripting.FileSystemObject")
>>%vbs% echo If NOT fso.FolderExists(%1) Then
>>%vbs% echo fso.CreateFolder(%1)
>>%vbs% echo End If
>>%vbs% echo set objShell = CreateObject("Shell.Application")
>>%vbs% echo set FilesInZip=objShell.NameSpace(%2).items
>>%vbs% echo objShell.NameSpace(%1).CopyHere(FilesInZip)
>>%vbs% echo Set fso = Nothing
>>%vbs% echo Set objShell = Nothing
cscript //nologo %vbs%
if exist %vbs% del /f /q %vbs%
echo install completed!
timeout /t -1
