# ForMD Linux Build & Package Automation
# This script uses Docker to build the Linux binaries and package them as a .deb installer.

Write-Host "--- ForMD: Starting Linux Build Process ---" -ForegroundColor Cyan

# 1. Check for Docker
if (-not (Get-Command docker -ErrorAction SilentlyContinue)) {
    Write-Error "Docker is not installed or not in your PATH. Docker is required to build the Linux package on Windows."
    exit 1
}

# 2. Ensure output directory exists
if (-not (Test-Path "output")) {
    New-Item -ItemType Directory -Path "output" | Out-Null
}

# 3. Run Docker Build
Write-Host "[1/2] Building Linux package via Docker..." -ForegroundColor Yellow
docker compose up --build

if ($LASTEXITCODE -eq 0) {
    Write-Host "`n[2/2] Extracting artifacts..." -ForegroundColor Yellow
    
    # The artifacts are already copied to the 'output' folder via docker-compose volume mapping
    $debFile = Get-ChildItem -Path "output" -Filter "*.deb" | Select-Object -First 1
    
    if ($debFile) {
        Write-Host "`nSUCCESS: Linux package created: $($debFile.FullName)" -ForegroundColor Green
        
        # Optionally copy the .deb to the root for easier access, similar to setup.exe
        Copy-Item -Path $debFile.FullName -Destination "ForMD_Linux_x64.deb" -Force
        Write-Host "A copy has been placed at: $(Get-Location)\ForMD_Linux_x64.deb" -ForegroundColor Gray
    } else {
        Write-Host "`nWARNING: Build finished but no .deb file was found in the output directory." -ForegroundColor Red
    }
} else {
    Write-Error "Docker build failed."
    exit 1
}
