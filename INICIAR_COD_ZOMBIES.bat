@echo off
title Counter-Strike 1.6 - Call of Duty: Nazi Zombies Classic
echo =======================================================
echo   INICIANDO CS 1.6 - CALL OF DUTY: NAZI ZOMBIES
echo =======================================================
echo.

set "GAME_DIR=C:\Program Files (x86)\Counter-Strike 1.6"

if exist "%GAME_DIR%\hl.exe" (
    echo [OK] Carpeta del juego detectada.
    echo Iniciando Counter-Strike 1.6...
    cd /d "%GAME_DIR%"
    start "" hl.exe -game cstrike -nomaster -noforcemaccel -noforcemparms -noforcemspd
) else (
    echo [ERROR] No se encontro hl.exe en: %GAME_DIR%
    pause
)
