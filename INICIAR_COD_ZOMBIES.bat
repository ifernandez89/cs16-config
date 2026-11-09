@echo off
title Counter-Strike 1.6 - Call of Duty: Nazi Zombies Classic
echo =======================================================
echo   INICIANDO CS 1.6 - CALL OF DUTY: NAZI ZOMBIES
echo =======================================================
echo   Inspirado en Call of Duty: World at War (2008)
echo.
echo   - Oleadas Progresivas con Zombis cada vez mas fuertes
echo   - Sistema de Puntos por impacto (+10) y bajas (+50/+100/+130)
echo   - Maquina Perk-a-Cola: Juggernog, Speed Cola, Double Tap, Quick Revive
echo   - Caja Misteriosa ($950) con ruleta de armas o el Osito
echo   - Power-ups aleatorios: Max Ammo, Insta-Kill, Nuke, Double Points
echo   - Reparacion de barricadas con tecla 'E' (+use)
echo.
echo   Binds utiles dentro del juego:
echo     [P] o escribe /perks  -> Menu de Ventajas
echo     [B] o escribe /box    -> Tirar de Caja Misteriosa
echo     [H]                   -> Menu Interactivo con control de Zombies
echo =======================================================
echo.

set "GAME_EXE=C:\Program Files (x86)\Counter-Strike 1.6\hl.exe"

if exist "%GAME_EXE%" (
    echo Iniciando mapa de supervivencia zombie...
    start "" "%GAME_EXE%" -game cstrike -nomaster -noforcemaccel -noforcemparms -noforcemspd +exec cod_zombies.cfg +map zm_italycamp
) else (
    echo [ERROR] No se encontro hl.exe en la ruta predeterminada:
    echo %GAME_EXE%
    pause
)
