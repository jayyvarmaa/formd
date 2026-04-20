; ---------------------------------------------------------
; ForMD Windows Installer (NSIS)
; ---------------------------------------------------------

; --- Definitions ---
!define APP_NAME "ForMD"
!define APP_VERSION "1.0.0"
!define EXE_NAME "formd-win_x64.exe"
!define INSTALLER_NAME "ForMD_Setup.exe"
!define COMPANY_NAME "jayyvarmaa"
!define HELP_URL "https://github.com/jayyvarmaa/formd"
!define UPDATE_URL "https://github.com/jayyvarmaa/formd/releases"

; --- Includes ---
!include "MUI2.nsh"
!include "FileFunc.nsh"

; --- General Settings ---
Name "${APP_NAME}"
OutFile "${INSTALLER_NAME}"
InstallDir "$LOCALAPPDATA\${APP_NAME}"
RequestExecutionLevel user
Icon "resources\assets\icon.jpg"

; --- Modern UI Appearance ---
!define MUI_ABORTWARNING
!define MUI_ICON "resources\assets\icon.jpg"
!define MUI_UNICON "resources\assets\icon.jpg"

; --- Pages ---
!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

!insertmacro MUI_LANGUAGE "English"

; --- Installation Sections ---
Section "Install"
    SetOutPath "$INSTDIR"
    
    ; Add files from the build distribution (assuming 'dist/formd' folder)
    File /r "dist\formd\*"
    
    ; Note: If using 'neu build --release', use the zip or portable files instead.
    ; Here we assume the standard output from 'neu build'.
    
    ; Create Uninstaller
    WriteUninstaller "$INSTDIR\Uninstall.exe"
    
    ; Create Shortcuts
    CreateDirectory "$SMPROGRAMS\${APP_NAME}"
    CreateShortCut "$SMPROGRAMS\${APP_NAME}\${APP_NAME}.lnk" "$INSTDIR\${EXE_NAME}" "" "$INSTDIR\${EXE_NAME}" 0
    CreateShortCut "$DESKTOP\${APP_NAME}.lnk" "$INSTDIR\${EXE_NAME}" "" "$INSTDIR\${EXE_NAME}" 0
    
    ; Add to Control Panel (Add/Remove Programs)
    WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "DisplayName" "${APP_NAME}"
    WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "UninstallString" "$INSTDIR\Uninstall.exe"
    WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "DisplayIcon" "$INSTDIR\${EXE_NAME}"
    WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "DisplayVersion" "${APP_VERSION}"
    WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "Publisher" "${COMPANY_NAME}"
    WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}" "URLInfoAbout" "${HELP_URL}"
    
    ; Register .md file association (Optional)
    WriteRegStr HKCU "Software\Classes\.md" "" "ForMD.Markdown"
    WriteRegStr HKCU "Software\Classes\ForMD.Markdown" "" "Markdown Document"
    WriteRegStr HKCU "Software\Classes\ForMD.Markdown\DefaultIcon" "" "$INSTDIR\${EXE_NAME},0"
    WriteRegStr HKCU "Software\Classes\ForMD.Markdown\shell\open\command" "" '"$INSTDIR\${EXE_NAME}" "%1"'

SectionEnd

; --- Uninstallation Section ---
Section "Uninstall"
    ; Remove shortcuts
    Delete "$SMPROGRAMS\${APP_NAME}\${APP_NAME}.lnk"
    Delete "$DESKTOP\${APP_NAME}.lnk"
    RMDir "$SMPROGRAMS\${APP_NAME}"
    
    ; Remove registry entries
    DeleteRegKey HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APP_NAME}"
    DeleteRegKey HKCU "Software\Classes\ForMD.Markdown"
    
    ; Remove files
    Delete "$INSTDIR\*.*"
    RMDir /r "$INSTDIR"
SectionEnd
