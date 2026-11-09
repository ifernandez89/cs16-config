@echo off
title Counter-Strike 1.6 - Call of Duty: Nazi Zombies Classic
echo =======================================================
echo   INICIANDO CS 1.6 - CALL OF DUTY: NAZI ZOMBIES
echo   (SUPERVIVENCIA EN HORDA - RONDA TRAS RONDA)
echo =======================================================
echo.
echo   - Oleadas Progresivas de Zombis (Escala de Vida y Velocidad)
echo   - Menu de Ventajas Perk-a-Cola (Tecla 'P' o /perks)
echo   - Caja Misteriosa Aleatoria ($950) (Tecla 'B' o /box)
echo   - Reparacion de Barricadas (Tecla 'E' manteniendola pulsada)
echo.

set "GAME_DIR=C:\Program Files (x86)\Counter-Strike 1.6"

if exist "%GAME_DIR%\hl.exe" (
    cd /d "%GAME_DIR%"
    start "" hl.exe -game cstrike -nomaster -noforcemaccel -noforcemparms -noforcemspd +exec cod_zombies.cfg
) else (
    echo [ERROR] No se encontro hl.exe en: %GAME_DIR%
    pause
)
