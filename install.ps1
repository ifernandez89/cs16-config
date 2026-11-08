# Script de Instalacion Automatica para CS 1.6 - Master Suite & Modpack

$scriptPath = $PSScriptRoot
$sourceCstrike = Join-Path $scriptPath "cstrike"

$targetPaths = @(
    "$env:LOCALAPPDATA\VirtualStore\Program Files (x86)\Counter-Strike 1.6\cstrike",
    "$env:LOCALAPPDATA\VirtualStore\Program Files (x86)\Counter-Strike 1.6\cstrike_spanish",
    "C:\Program Files (x86)\Counter-Strike 1.6\cstrike",
    "C:\Program Files (x86)\Counter-Strike 1.6\cstrike_spanish"
)

Write-Host "==============================================================" -ForegroundColor Cyan
Write-Host "  COUNTER-STRIKE 1.6 - MASTER MODPACK & CONFIG INSTALLER" -ForegroundColor Yellow
Write-Host "==============================================================" -ForegroundColor Cyan
Write-Host "  Contenido incluido:" -ForegroundColor Gray
Write-Host "  - 9 Armaduras Hall of Heroes / Tech Crew (CT, T & VIP)" -ForegroundColor White
Write-Host "  - Guanteletes Repulsores en 1ra persona (v_knife)" -ForegroundColor White
Write-Host "  - Armamento con guantes tácticos de fibra de carbono" -ForegroundColor White
Write-Host "  - Sonidos de disparo y recarga remasterizados (Punch & Reverb)" -ForegroundColor White
Write-Host "  - Radio Táctica con Asistente de IA (Protocolo NEXO)" -ForegroundColor White
Write-Host "  - Tarjetas VGUI de telemetría y config competitiva" -ForegroundColor White
Write-Host "==============================================================" -ForegroundColor Cyan

$installed = $false

foreach ($target in $targetPaths) {
    $parent = Split-Path $target -Parent
    if (Test-Path $parent) {
        if (-not (Test-Path $target)) {
            New-Item -ItemType Directory -Path $target -Force | Out-Null
        }
        try {
            Copy-Item -Path "$sourceCstrike\*" -Destination $target -Recurse -Force -ErrorAction Stop
            Write-Host "[OK] Suite instalada exitosamente en: $target" -ForegroundColor Green
            $installed = $true
        } catch {
            Write-Host "[INFO] No se pudo escribir directamente en $target (permisos reducidos)." -ForegroundColor DarkGray
        }
    }
}

if ($installed) {
    Write-Host "`n¡Instalación completada con éxito! Inicia tu CS 1.6 y disfruta." -ForegroundColor Green
} else {
    Write-Host "`n[!] No se encontro la carpeta por defecto. Copia manualmente los archivos de la carpeta 'cstrike' a la carpeta de tu juego." -ForegroundColor Red
}

Read-Host -Prompt "`nPresiona Enter para salir..."
