::窗口设置
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

::创建相关函数和文件夹
set Company=Adobe
set App=Photoshop
set PrefDir=Preferences\%App%
if not exist "%AppData%\AppsPreferencesSync\%App%" md "%AppData%\AppsPreferencesSync\%App%"
set DataDir=%AppData%\AppsPreferencesSync\%App%
if not exist "%DataDir%\Recycle" md "%DataDir%\Recycle"
set RecycleDir=%DataDir%\Recycle


::读取应用版本信息
dir %AppData%\%Company% /b /o:-n|find "%Company% %App%" > %DataDir%\%Company%%App%Version.txt
set /p Version=<%DataDir%\%Company%%App%Version.txt

::设置功能并创建功能函数
set PADir=%AppData%\%Company%\%Version%\%Version% Settings
set PA1=UIPrefs.psp
set PA1zh=首选项
set PA2=WorkSpaces
set PA2zh=工作区
set PA3=New Doc Sizes.json
set PA3zh=新建文档尺寸

set PBDir=%AppData%\%Company%\%Version%\Presets
set PB1=Custom Toolbars
set PB1zh=工具栏
set PB2=Menu Customization
set PB2zh=菜单自定义
set PB3=Color Swatches
set PB3zh=色板
set PB4=Brushes
set PB4zh=笔刷
set PB5=Keyboard Shortcuts
set PB5zh=快捷键


:menu
set choice=none
echo.
echo.
echo 1. 备份使用习惯			4. 打开相关文件夹
echo 2. 恢复使用习惯 		5. 清除多余备份
echo 3. 还原默认			6. 使用配置包
echo Q. 退出
echo.
echo.
set /p choice=请输入操作的序号：
if /i "%choice%"=="1" goto 1
if /i "%choice%"=="2" goto 2
if /i "%choice%"=="3" goto 3
if /i "%choice%"=="4" goto 4
if /i "%choice%"=="5" goto 5
if /i "%choice%"=="6" goto 6
if /i "%choice%"=="q" goto exit
echo.
echo 选择无效，请重新输入……
goto menu
goto 0

:1
@echo off
echo 备份中……

::将旧备份移到回收站
dir %PrefDir% /b /o:-n> %DataDir%\%Company%%App%OldPreferences.txt

::根据时间创建文件夹
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

echo 备份完成，按任意键继续……&pause>nul
goto menu

:2
@echo off



echo 完成，按任意键继续……&pause>nul
goto menu

:3
@echo off



echo 完成，按任意键继续……&pause>nul
goto menu

:4
@echo off
echo 正在打开相关文件夹……

start explorer "%PADir%"
start explorer "%PBDir%"

echo 完成，按任意键继续……&pause>nul
goto menu

:5
@echo off

echo echo 开始移动到回收站……>%DataDir%\MoveOldPreferences.bat
::将旧备份移到回收站
dir %PrefDir% /b /o:-n>%DataDir%\%Company%%App%OldPreferences.txt
setlocal enabledelayedexpansion
for /f "eol=* skip=5 tokens=*" %%i in (%DataDir%\%Company%%App%OldPreferences.txt) do (
:: 设置变量TimeDirName为每行内容
set TimeDirName=%%i
:: 给每行添加命令
set Moveline=@md %RecycleDir%\!TimeDirName! ^& xcopy %CD%\%PrefDir%\!TimeDirName! %RecycleDir%\!TimeDirName! /s /q /y ^&^& rd /s/q %CD%\%PrefDir%\!TimeDirName!
:: 把修改后的全部行存入移动bat
echo !Moveline!>>%DataDir%\MoveOldPreferences.bat)
echo 已获取需要移动到回收站的文件列表
call %DataDir%\MoveOldPreferences.bat

echo 已移动到回收站，按任意键继续……&pause>nul
goto menu

:6
@echo off


echo 完成，按任意键继续……&pause>nul
goto menu

:exit
