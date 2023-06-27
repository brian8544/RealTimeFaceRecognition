:start
@echo off
cls
setlocal enabledelayedexpansion

set "msbuildPath=C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe"
set "solutionPath=D:\Repositories\RealTimeFaceRecognition-PRIVATE\RealtimeFacialRecognition.sln"
set "buildPath=D:\Repositories\RealTimeFaceRecognition-PRIVATE\x64"
set "vcpkgPath=D:\Repositories\vcpkg"

:: Prepare library packages, if not exist.
%vcpkgPath%\vcpkg install curl
%vcpkgPath%\vcpkg install opencv4
%vcpkgPath%\vcpkg install dlib

:: Remove existing build folder if it exists.
IF EXIST "%buildPath%" (
    rmdir /s /q "%buildPath%"
)

:: Build the solution using MSBuild.
"%msbuildPath%" "%solutionPath%" /p:Configuration=Release /m /v:m

if exist "%buildPath%\Debug\" (
    set "binPath=%buildPath%\Debug\"
) else (
    set "binPath=%buildPath%\Release\"
)
echo binPath is set to: %binPath%

:: Delete unnecessary files from the release folder.
echo --- Some errors may show up, depending on which build mode has been used. Don't worry ---
del /s /q "%binPath%*.log"
del /s /q "%binPath%*.pdb"
del /s /q "%binPath%*.obj"
del /s /q "%binPath%*.idb"
del /s /q "%binPath%*.ilk"
del /s /q "%binPath%*.iobj"
del /s /q "%binPath%*.ipdb"
del /s /q "%binPath%*.recipe"
del /s /q "%binPath%*.txt"

del /s /q "%binPath%vcpkg.applocal.log

rmdir /s /q "%binPath%Realtime.53afeaad.tlog"

pause
endlocal
goto start
exit
