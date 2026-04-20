#Requires -RunAsAdministrator
<#
.SYNOPSIS
    Registers .md and .markdown files to open with Markdown Viewer desktop app.

.DESCRIPTION
    Sets up Windows file associations so that double-clicking a .md or .markdown
    file in Explorer opens it in the Markdown Viewer Neutralinojs app.

    Must be run as Administrator (elevated).

.EXAMPLE
    Right-click PowerShell → Run as Administrator → .\register-file-association.ps1
#>

$ErrorActionPreference = 'Stop'

# Resolve the launcher script path (uses bin/ binary which avoids antivirus blocks)
$ExePath = Join-Path $PSScriptRoot 'launch.cmd'

if (-not (Test-Path $ExePath)) {
    Write-Error "Launcher not found at $ExePath"
    exit 1
}

$ExePath = (Resolve-Path $ExePath).Path
$IconPath = Join-Path $PSScriptRoot 'resources\assets\icon.jpg'
if (Test-Path $IconPath) {
    $IconPath = (Resolve-Path $IconPath).Path
} else {
    $IconPath = $ExePath
}

$ProgId = 'MarkdownViewer.md'
$AppName = 'Markdown Viewer'

Write-Host "Registering file associations..." -ForegroundColor Cyan
Write-Host "  Executable: $ExePath"

# --- Create ProgId ---
$progIdKey = "HKLM:\SOFTWARE\Classes\$ProgId"
New-Item -Path $progIdKey -Force | Out-Null
Set-ItemProperty -Path $progIdKey -Name '(Default)' -Value "$AppName Document"

# Default icon
$iconKey = "$progIdKey\DefaultIcon"
New-Item -Path $iconKey -Force | Out-Null
Set-ItemProperty -Path $iconKey -Name '(Default)' -Value "`"$IconPath`""

# Shell open command — passes the file path as an argument to the exe
$commandKey = "$progIdKey\shell\open\command"
New-Item -Path $commandKey -Force | Out-Null
Set-ItemProperty -Path $commandKey -Name '(Default)' -Value "`"$ExePath`" `"%1`""

# --- Associate extensions ---
foreach ($ext in @('.md', '.markdown')) {
    $extKey = "HKLM:\SOFTWARE\Classes\$ext"
    New-Item -Path $extKey -Force | Out-Null
    Set-ItemProperty -Path $extKey -Name '(Default)' -Value $ProgId

    # Register in OpenWithProgids so it appears in "Open with" even if another
    # app is already the default
    $openWithKey = "$extKey\OpenWithProgids"
    New-Item -Path $openWithKey -Force | Out-Null
    New-ItemProperty -Path $openWithKey -Name $ProgId -PropertyType String -Value '' -Force | Out-Null
}

# --- Register in Applications ---
$appKey = "HKLM:\SOFTWARE\Classes\Applications\launch.cmd"
New-Item -Path $appKey -Force | Out-Null
Set-ItemProperty -Path $appKey -Name 'FriendlyAppName' -Value $AppName

$appCommandKey = "$appKey\shell\open\command"
New-Item -Path $appCommandKey -Force | Out-Null
Set-ItemProperty -Path $appCommandKey -Name '(Default)' -Value "`"$ExePath`" `"%1`""

$appExtKey = "$appKey\SupportedTypes"
New-Item -Path $appExtKey -Force | Out-Null
New-ItemProperty -Path $appExtKey -Name '.md' -PropertyType String -Value '' -Force | Out-Null
New-ItemProperty -Path $appExtKey -Name '.markdown' -PropertyType String -Value '' -Force | Out-Null

# --- Notify Explorer of the change ---
$signature = @'
[DllImport("shell32.dll", CharSet = CharSet.Auto, SetLastError = true)]
public static extern void SHChangeNotify(uint wEventId, uint uFlags, IntPtr dwItem1, IntPtr dwItem2);
'@
$type = Add-Type -MemberDefinition $signature -Name 'WinAPI' -Namespace 'FileAssoc' -PassThru
$type::SHChangeNotify(0x08000000, 0x0000, [IntPtr]::Zero, [IntPtr]::Zero)

Write-Host "`nDone! .md and .markdown files are now associated with Markdown Viewer." -ForegroundColor Green
Write-Host "Double-click any .md file in Explorer to open it." -ForegroundColor Green
