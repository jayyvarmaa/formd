# ForMD Build & Package Automation
# This script builds the Neutralinojs app and compiles the NSIS installer.

Write-Host "--- ForMD: Starting Build Process ---" -ForegroundColor Cyan

# 1. Sync resources
Write-Host "[1/3] Syncing web resources..." -ForegroundColor Yellow
node prepare.js

# 2. Build Neutralino app
Write-Host "[2/3] Compiling Neutralinojs binaries..." -ForegroundColor Yellow
npx @neutralinojs/neu build --embed-resources

# 3. Compile NSIS Installer
Write-Host "[3/3] Generating Windows Installer (.exe)..." -ForegroundColor Yellow

$nsisPath = "makensis"
if (-not (Get-Command $nsisPath -ErrorAction SilentlyContinue)) {
    $defaultNsis = "C:\Program Files (x86)\NSIS\makensis.exe"
    if (Test-Path $defaultNsis) {
        $nsisPath = "$defaultNsis"
    }
}

if ($nsisPath -ne "makensis" -or (Get-Command $nsisPath -ErrorAction SilentlyContinue)) {
    & $nsisPath installer.nsi
    if ($LASTEXITCODE -eq 0) {
        Write-Host "`nSUCCESS: ForMD_Setup.exe has been created in $(Get-Location)" -ForegroundColor Green
    } else {
        Write-Error "NSIS Compilation failed."
    }
} else {
    Write-Host "`nWARNING: 'makensis' command not found." -ForegroundColor Red
    Write-Host "The app was built successfully, but the .exe installer could not be generated." -ForegroundColor Gray
    Write-Host "Please install NSIS (https://nsis.sourceforge.io/) and ensure 'makensis' is in your PATH." -ForegroundColor Gray
}
