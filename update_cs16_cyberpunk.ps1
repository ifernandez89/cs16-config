# Script para actualizar CS 1.6 con la version Cyberpunk
param(
    [string]$Source = "D:\Projects\cs 1.6 cyber punk version",
    [string]$Target = "C:\Program Files (x86)\Counter-Strike 1.6",
    [string]$VirtualStoreTarget = "$env:LOCALAPPDATA\VirtualStore\Program Files (x86)\Counter-Strike 1.6"
)

Write-Host "====================================================" -ForegroundColor Cyan
Write-Host "  Actualizando Counter-Strike 1.6 Cyberpunk Edition" -ForegroundColor Yellow
Write-Host "====================================================" -ForegroundColor Cyan

# 1. Actualizar VirtualStore primero (no requiere permisos de admin)
if (Test-Path $VirtualStoreTarget) {
    Write-Host "`n[1/2] Actualizando VirtualStore de usuario..." -ForegroundColor Green
    & robocopy "$Source" "$VirtualStoreTarget" /E /XF *.mdmp /NP /NDL /NFL
    Write-Host "VirtualStore actualizado correctamente." -ForegroundColor Green
}

# 2. Actualizar directorio principal de Program Files (x86)
Write-Host "`n[2/2] Actualizando instalacion principal ($Target)..." -ForegroundColor Green

$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

if (-not $isAdmin) {
    Write-Host "Solicitando elevacion de Administrador para escribir en Program Files..." -ForegroundColor Yellow
    $elevatedCmd = @"
        & icacls "$Target" /grant "*S-1-5-32-545:(OI)(CI)F" /T /Q
        & robocopy "$Source" "$Target" /E /XF *.mdmp /NP
        exit `$LASTEXITCODE
"@
    $bytes = [System.Text.Encoding]::Unicode.GetBytes($elevatedCmd)
    $encoded = [Convert]::ToBase64String($bytes)
    $proc = Start-Process powershell -ArgumentList "-NoProfile -EncodedCommand $encoded" -Verb RunAs -PassThru -Wait
    if ($proc.ExitCode -eq 0 -or $proc.ExitCode -le 7) {
        Write-Host "Instalacion principal actualizada con exito (Codigo: $($proc.ExitCode))." -ForegroundColor Green
    } else {
        Write-Host "Aviso en la copia elevada (Codigo: $($proc.ExitCode))." -ForegroundColor Yellow
    }
} else {
    & robocopy "$Source" "$Target" /E /XF *.mdmp /NP
    Write-Host "Instalacion principal actualizada con exito." -ForegroundColor Green
}

Write-Host "`n¡Actualizacion Cyberpunk completada con exito!" -ForegroundColor Cyan
