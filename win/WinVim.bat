REM based on https://stackoverflow.com/questions/19497399/basic-text-editor-in-command-prompt
REM as noted, the UI sucks but it has a soul

@echo off
title WinVim
color a
cls
echo WinVim 1.02
echo.
echo To save press CTRL+Z then press enter
echo.
echo Make sure to include extension in file name
set /p name=File Name:
copy con %name%
if exist %name% copy %name% + con

