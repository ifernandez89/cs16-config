# Script de Instalacion Automatica para CS 1.6 Config

$scriptPath = $PSScriptRoot
$sourceCstrike = Join-Path $scriptPath "cstrike"

$targetPaths = @(
    "$env:LOCALAPPDATA\VirtualStore\Program Files (x86)\Counter-Strike 1.6\cstrike",
    "C:\Program Files (x86)\Counter-Strike 1.6\cstrike"
)

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "Instalador de Config Counter-Strike 1.6" -ForegroundColor Yellow
Write-Host "==========================================" -ForegroundColor Cyan

$installed = $false

foreach ($target in $targetPaths) {
    $parent = Split-Path $target -Parent
    if (Test-Path $parent) {
        if (-not (Test-Path $target)) {
            New-Item -ItemType Directory -Path $target -Force | Out-Null
        }
        try {
            Copy-Item -Path "$sourceCstrike\*" -Destination $target -Recurse -Force -ErrorAction Stop
            Write-Host "[OK] Configuracion instalada exitosamente en: $target" -ForegroundColor Green
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
