#Requires -RunAsAdministrator
<#
.SYNOPSIS
    Removes the Markdown Viewer file associations for .md and .markdown files.
#>

$ErrorActionPreference = 'Stop'

$ProgId = 'MarkdownViewer.md'

Write-Host "Removing file associations..." -ForegroundColor Cyan

# Remove ProgId
$progIdKey = "HKLM:\SOFTWARE\Classes\$ProgId"
if (Test-Path $progIdKey) {
    Remove-Item -Path $progIdKey -Recurse -Force
    Write-Host "  Removed ProgId: $ProgId"
}

# Remove extension associations
foreach ($ext in @('.md', '.markdown')) {
    $extKey = "HKLM:\SOFTWARE\Classes\$ext"
    if (Test-Path $extKey) {
        $current = (Get-ItemProperty -Path $extKey -Name '(Default)' -ErrorAction SilentlyContinue).'(Default)'
        if ($current -eq $ProgId) {
            Remove-Item -Path $extKey -Recurse -Force
            Write-Host "  Removed extension key: $ext"
        } else {
            # Only remove from OpenWithProgids
            $openWithKey = "$extKey\OpenWithProgids"
            if (Test-Path $openWithKey) {
                Remove-ItemProperty -Path $openWithKey -Name $ProgId -Force -ErrorAction SilentlyContinue
                Write-Host "  Removed $ProgId from $ext\OpenWithProgids"
            }
        }
    }
}

# Remove Applications entry
$appKey = "HKLM:\SOFTWARE\Classes\Applications\launch.cmd"
if (Test-Path $appKey) {
    Remove-Item -Path $appKey -Recurse -Force
    Write-Host "  Removed Applications entry"
}

# Notify Explorer
$signature = @'
[DllImport("shell32.dll", CharSet = CharSet.Auto, SetLastError = true)]
public static extern void SHChangeNotify(uint wEventId, uint uFlags, IntPtr dwItem1, IntPtr dwItem2);
'@
$type = Add-Type -MemberDefinition $signature -Name 'WinAPI' -Namespace 'FileAssocRemove' -PassThru
$type::SHChangeNotify(0x08000000, 0x0000, [IntPtr]::Zero, [IntPtr]::Zero)

Write-Host "`nDone! Markdown Viewer file associations removed." -ForegroundColor Green
