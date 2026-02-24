param(
    [switch]$BuildExeFirst,
    [string]$InnoCompilerPath = ''
)

$ErrorActionPreference = 'Stop'

$Root = Split-Path -Parent $PSScriptRoot
Push-Location $Root

try {
    if ($BuildExeFirst -or -not (Test-Path '.\dist\Embers0.1\Embers0.1.exe')) {
        & powershell -NoProfile -ExecutionPolicy Bypass -File '.\scripts\build_exe.ps1'
    }

    $iscc = $InnoCompilerPath
    if (-not $iscc) {
        $cmd = Get-Command iscc.exe -ErrorAction SilentlyContinue
        if ($cmd) {
            $iscc = $cmd.Source
        }
    }

    if (-not $iscc) {
        throw 'Inno Setup compiler (iscc.exe) not found. Install Inno Setup 6 and retry.'
    }

    $Version = Get-Date -Format 'yyyy.MM.dd'
    & $iscc "/DMyAppVersion=$Version" '.\installer\Embers0.1.iss'

    Write-Host ''
    Write-Host 'Installer build complete.' -ForegroundColor Green
    Write-Host 'Output: .\dist-installer\'
}
finally {
    Pop-Location
}
