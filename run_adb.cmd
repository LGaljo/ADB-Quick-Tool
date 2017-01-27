@echo off
title ADB quick tool
cd /d "%~dp0"


:home
cls
echo.
echo ############################################################################
echo #                            ADB quick tool                                #
echo #                          Done by LGaljo@XDA                              #
echo #                                 BETA 1                                   #
echo ############################################################################
echo.
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo + Choose your action:                                                      +
echo +      1)  Check for connected devices                                     +
echo +      2)  Enter ADB shell                                                 +
echo +      3)  Create logcat                                                   +
echo +      4)  Install APK file                                                +
echo +      5)  More ADB commands                                               +
echo +      6)  Exit                                                            +
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo.
echo Select a task: 
echo ==============
echo.


set /p web=Type option: 
if "%web%"=="1" goto _devices
if "%web%"=="2" goto _adbshell
if "%web%"=="3" goto _logging
if "%web%"=="4" goto _apk
if "%web%"=="5" goto _more
if "%web%"=="6" goto bye
goto home


:_devices
cls
echo.
.\bin\adb.exe devices
echo.
pause
goto home


:_adbshell
cls
echo.
bin\adb.exe shell
echo.
pause
goto home


:_logging
cls
echo.
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo + Choose your action:                                                      +
echo +      1)  Create logcat                                                   +
echo +      2)  Create dmesg                                                    +
echo +      3)  Go back                                                         +
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo.
set /p web=Type option: 
if "%web%"=="1" goto _logcat
if "%web%"=="2" goto _dmesg
if "%web%"=="3" goto home
echo.
goto home


:_logcat
cls
echo.
echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo + View Alternative Log Buffer:                                                      +
echo +      1) radio ... View the buffer that contains radio/telephony related messages. +
echo +      2) events .. View the buffer containing events-related messages.             +
echo +      3) main .... View the main log buffer (default)                              +
echo +      4) Go back                                                                   +
echo +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo.
set /p web=Type option: 
if "%web%"=="1" set buffer=-b radio
if "%web%"=="2" set buffer=-b events
if "%web%"=="3" set buffer=-b main
if "%web%"=="4" goto _logcat1
echo.
cls
echo Log Buffer set
echo.
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo + Control Log Output Format:                                               +
echo +      1)  brief ......... Display priority/tag and PID of the process     +
echo +                          issuing the message (the default format).       +
echo +      2)  process ....... Display PID only.                               +
echo +      3)  tag ........... Display the priority/tag only.                  +
echo +      4)  raw ........... Display the raw log message, with               +
echo +                          no other metadata fields.                       +
echo +      5)  time .......... Display the date, invocation time,              +
echo +                          priority/tag, and PID of the process            +
echo +                          issuing the message.                            +
echo +      6)  threadtime .... Display the date, invocation time, priority,    +
echo +                          tag, and the PID and TID of the thread          +
echo +                          issuing the message.                            +
echo +      7)  long .......... Display all metadata fields and separate        +
echo +                          messages with blank lines.                      +
echo +      8)  No flag                                                         +
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo.
set /p web=Type option: 
if "%web%"=="1" set format=-v brief
if "%web%"=="2" set format=-v process
if "%web%"=="3" set format=-v tag
if "%web%"=="4" set format=-v raw
if "%web%"=="5" set format=-v time
if "%web%"=="6" set format=-v threadtime
if "%web%"=="7" set format=-v long
if "%web%"=="8" set format=""
echo.
echo To cancel logging press CTRL+C and then type N
echo.
mkdir .\logcat
.\bin\adb.exe logcat %buffer%%format% -f .\logcat\logcat.exe
echo.
cls
echo.
echo You can find your logcat.txt in logcat folder
echo.
pause
goto home


:_dmesg
echo.
mkdir .\dmesg
.\bin\adb.exe shell cat /proc/kmsg .\dmesg\dmesg.txt
pause
echo.
goto home

:_apk
cls
echo.
echo Place file in this folder:
echo.
explorer .\installAPK
pause
echo.
cd installAPK
ren *.apk file.apk
cd ..
cls
echo.
.\bin\adb.exe install .\installAPK\file.apk
echo.
pause
goto home


:_more
cls
echo.
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo + Choose your action:                                                      +
echo +      1)  Show help for ADB commands                                      +
echo +      2)  Show ADB version                                                +
echo +      3)  Start ADB server                                                +
echo +      4)  Stop ADB server                                                 +
echo +      5)  Go back                                                         +
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo.
set /p web=Type option:
if "%web%"=="1" goto _help
if "%web%"=="2" goto _version
if "%web%"=="3" goto _start
if "%web%"=="4" goto _stop
if "%web%"=="5" goto home
echo.
goto _more


:_start
cls
echo.
echo Starting server...
.\bin\adb.exe start-server
echo Server started!
timeout 3
goto _more


:_stop
cls
echo.
echo Killing server...
.\bin\adb.exe kill-server
echo Server killed!
timeout 3
goto _more


:_help
cls
echo.
.\bin\adb.exe help
echo.
pause 
goto _more


:_version
cls
echo.
.\bin\adb.exe version
echo.
pause 
goto _more


:bye
exit
