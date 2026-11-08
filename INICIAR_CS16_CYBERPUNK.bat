@echo off
title Counter-Strike 1.6 - Protocolo Cyberpunk TPS
echo =======================================================
echo   INICIANDO COUNTER-STRIKE 1.6 CYBERPUNK EDITION
echo =======================================================
echo   - Modo Tercera Persona Calibrado (TPS)
echo   - Roster de 9 Armaduras y Guanteletes Repulsores
echo   - Reticula Holografica Kiroshi en Francotiradores
echo   - Granadas EMP / Glitch y Radio Tactica IA NEXO
echo.
echo Presiona 'V' o 'F5' dentro del juego para alternar entre 1ra y 3ra persona.
echo =======================================================
echo.

set "GAME_EXE=C:\Program Files (x86)\Counter-Strike 1.6\hl.exe"

if exist "%GAME_EXE%" (
    start "" "%GAME_EXE%" -game cstrike -nomaster -noforcemaccel -noforcemparms -noforcemspd
) else (
    echo [ERROR] No se encontro hl.exe en la ruta predeterminada.
    pause
)

