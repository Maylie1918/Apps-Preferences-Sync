::��������
@echo off
color F0
title Photoshop Preferences Sync
cls
echo "  _____  _           _            _                  "
echo " |  __ \| |         | |          | |                 "
echo " | |__) | |__   ___ | |_ ___  ___| |__   ___  _ __   "
echo " |  ___/| '_ \ / _ \| __/ _ \/ __| '_ \ / _ \| '_ \  "
echo " | |    | | | | (_) | || (_) \__ | | | | (_) | |_) | "
echo " |_|    |_| |_|\___/ \__\___/|___|_| |_|\___/| .__/  "
echo " |  _  \         / _|                        | |     "
echo " | |__) _ __ ___| |_ ___ _ __ ___ ____   ____|_|__ _ "
echo " |  ___| '__/ _ |  _/ _ | '__/ _ | '_ \ / __/ _ / __|"
echo " | |   | | |  __| ||  __| | |  __| | | | (_|  __\__ \"
echo " |_|   |_|  \___|_| \___|_|  \___|_| |_|\___\___|___/"
echo "  / ____|                                            "
echo " | (___  _   _ _ __   ___                            "
echo "  \___ \| | | | '_ \ / __|                           "
echo "  ____) | |_| | | | | (__                            "
echo " |_____/ \__, |_| |_|\___|                           "
echo "          __/ |                                      "
echo "         |___/                                       "
echo "                                                     "

::������غ������ļ���
set Company=Adobe
set App=Photoshop
set PrefDir=Preferences\%App%
if not exist "%AppData%\AppsPreferencesSync\%App%" md "%AppData%\AppsPreferencesSync\%App%"
set DataDir=%AppData%\AppsPreferencesSync\%App%
if not exist "%DataDir%\Recycle" md "%DataDir%\Recycle"
set RecycleDir=%DataDir%\Recycle


::��ȡӦ�ð汾��Ϣ
dir %AppData%\%Company% /b /o:-n|find "%Company% %App%" > %DataDir%\%Company%%App%Version.txt
set /p Version=<%DataDir%\%Company%%App%Version.txt

::���ù��ܲ��������ܺ���
set PADir=%AppData%\%Company%\%Version%\%Version% Settings
set PA1=UIPrefs.psp
set PA1zh=��ѡ��
set PA2=WorkSpaces
set PA2zh=������
set PA3=New Doc Sizes.json
set PA3zh=�½��ĵ��ߴ�

set PBDir=%AppData%\%Company%\%Version%\Presets
set PB1=Custom Toolbars
set PB1zh=������
set PB2=Menu Customization
set PB2zh=�˵��Զ���
set PB3=Color Swatches
set PB3zh=ɫ��
set PB4=Brushes
set PB4zh=��ˢ
set PB5=Keyboard Shortcuts
set PB5zh=��ݼ�


:menu
set choice=none
echo.
echo.
echo 1. ����ʹ��ϰ��			4. ������ļ���
echo 2. �ָ�ʹ��ϰ�� 		5. ������౸��
echo 3. ��ԭĬ��			6. ʹ�����ð�
echo Q. �˳�
echo.
echo.
set /p choice=�������������ţ�
if /i "%choice%"=="1" goto 1
if /i "%choice%"=="2" goto 2
if /i "%choice%"=="3" goto 3
if /i "%choice%"=="4" goto 4
if /i "%choice%"=="5" goto 5
if /i "%choice%"=="6" goto 6
if /i "%choice%"=="q" goto exit
echo.
echo ѡ����Ч�����������롭��
goto menu
goto 0

:1
@echo off
echo �����С���

::���ɱ����Ƶ�����վ
dir %PrefDir% /b /o:-n> %DataDir%\%Company%%App%OldPreferences.txt

::����ʱ�䴴���ļ���
set DateTimeDir=%PrefDir%\%date:~0,4%.%date:~5,2%.%date:~8,2%-%time:~0,2%.%time:~3,2%.%time:~6,2%-%ComputerName%
md "%DateTimeDir%"

md "%DateTimeDir%\%PA1zh%"
xcopy "%PADir%\%PA1%" "%DateTimeDir%\%PA1zh%" /s /q /y
md "%DateTimeDir%\%PA2zh%"
xcopy "%PADir%\%PA2%" "%DateTimeDir%\%PA2zh%" /s /q /y
md "%DateTimeDir%\%PA3zh%"
xcopy "%PADir%\%PA3%" "%DateTimeDir%\%PA3zh%" /s /q /y

md "%DateTimeDir%\Presets"
xcopy "%PBDir%" "%DateTimeDir%\Presets" /s /q /y

echo ������ɣ����������������&pause>nul
goto menu

:2
@echo off



echo ��ɣ����������������&pause>nul
goto menu

:3
@echo off



echo ��ɣ����������������&pause>nul
goto menu

:4
@echo off
echo ���ڴ�����ļ��С���

start explorer "%PADir%"
start explorer "%PBDir%"

echo ��ɣ����������������&pause>nul
goto menu

:5
@echo off

echo echo ��ʼ�ƶ�������վ����>%DataDir%\MoveOldPreferences.bat
::���ɱ����Ƶ�����վ
dir %PrefDir% /b /o:-n>%DataDir%\%Company%%App%OldPreferences.txt
setlocal enabledelayedexpansion
for /f "eol=* skip=5 tokens=*" %%i in (%DataDir%\%Company%%App%OldPreferences.txt) do (
:: ���ñ���TimeDirNameΪÿ������
set TimeDirName=%%i
:: ��ÿ���������
set Moveline=@md %RecycleDir%\!TimeDirName! ^& xcopy %CD%\%PrefDir%\!TimeDirName! %RecycleDir%\!TimeDirName! /s /q /y ^&^& rd /s/q %CD%\%PrefDir%\!TimeDirName!
:: ���޸ĺ��ȫ���д����ƶ�bat
echo !Moveline!>>%DataDir%\MoveOldPreferences.bat)
echo �ѻ�ȡ��Ҫ�ƶ�������վ���ļ��б�
call %DataDir%\MoveOldPreferences.bat

echo ���ƶ�������վ�����������������&pause>nul
goto menu

:6
@echo off


echo ��ɣ����������������&pause>nul
goto menu

:exit
