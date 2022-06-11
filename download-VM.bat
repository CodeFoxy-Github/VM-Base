@echo off
echo "#1 Windows 10 Home x64"
set /p id="Enter ID: "
if %id% == 1 (
start "" "https://drive.google.com/uc?id=1SQHTssEtXWNppTeQH9IP2ds88DMhnY-E&confirm=t"
)
timeout /t 200
setlocal

cd /d %~dp0


Call :UnZipFile "%USERPROFILE%\VirtualBox VMs" "%cd%\%id%.zip"

:UnZipFile <ExtractTo> <newzipfile>
set vbs="%temp%\_.vbs"
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
exit /b

cd C:\Program Files\Oracle\VirtualBox\
VirtualBox.exe
