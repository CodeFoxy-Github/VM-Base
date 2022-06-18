@echo off
echo If VirtualBox is NOT installed enter "yes"
echo else just press enter key
timeout 3 /nobreak
cls
set /p ans="install VirtualBox6.1.34 ?"
if %ans% == yes (
winget install Oracle.VirtualBox
)
msiexec.exe /i %cd%\VirtualBox-6.1.34a-150636-Win.exe /QN /L*V "C:\Temp\msilog.log"
echo 1. Windows 10 Home x64
echo 2. Windows 10 Professional x64
set /p id="Enter ID: "
if %id% == 1 (
start "" "https://drive.google.com/uc?id=1SQHTssEtXWNppTeQH9IP2ds88DMhnY-E&confirm=t"
)
if %id% == 2 (
start "" "https://drive.google.com/uc?id=1Z6vD5BNrMqKOWAt7iZ9txA37bYHPynCU&export=download&confirm=t"
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
