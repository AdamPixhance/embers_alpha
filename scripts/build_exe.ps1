param(
    [switch]$Clean
)

$ErrorActionPreference = 'Stop'

$Root = Split-Path -Parent $PSScriptRoot
Push-Location $Root

try {
    $Python = Join-Path $Root '.venv\Scripts\python.exe'
    if (-not (Test-Path $Python)) {
        throw 'Missing .venv. Create it first and install dependencies.'
    }

    if ($Clean) {
        if (Test-Path 'build') { Remove-Item 'build' -Recurse -Force }
        if (Test-Path 'dist') { Remove-Item 'dist' -Recurse -Force }
    }

    & $Python -m pip install --upgrade pip
    & $Python -m pip install pyinstaller

    & $Python -m PyInstaller `
        --noconfirm `
        --clean `
        --name Embers0.1 `
        --windowed `
        --onedir `
        --add-data "styles.css;." `
        --add-data "data/Habits.xlsx;data" `
        --collect-all nicegui `
        app.py

    $DistRoot = Join-Path $Root 'dist\Embers0.1'
    if (-not (Test-Path $DistRoot)) {
        throw 'Build output not found at dist\Embers0.1'
    }

    $DataDir = Join-Path $DistRoot 'data'
    $BackupsDir = Join-Path $DistRoot 'backups'
    New-Item -ItemType Directory -Path $DataDir -Force | Out-Null
    New-Item -ItemType Directory -Path $BackupsDir -Force | Out-Null

    Copy-Item (Join-Path $Root 'data\Habits.xlsx') (Join-Path $DataDir 'Habits.xlsx') -Force
    Copy-Item (Join-Path $Root 'README.md') (Join-Path $DistRoot 'README.md') -Force

    Write-Host ''
    Write-Host 'Build complete.' -ForegroundColor Green
    Write-Host "Output: $DistRoot"
}
finally {
    Pop-Location
}
