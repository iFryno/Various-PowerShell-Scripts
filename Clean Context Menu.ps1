if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
Start-Process PowerShell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
exit
}

Write-Host "Clean Context Menu`n"
Write-Host "1. Enable"
Write-Host "2. Disable`n"

while ($true) {
$choice = Read-Host " "
if ($choice -match '^[1-2]$') {
switch ($choice) {

1 {

Clear-Host
Write-Host "Enabling..." -NoNewline

# Create reg file
$regContent = @"
Windows Registry Editor Version 5.00

; Remove modern context menu
[HKEY_CURRENT_USER\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32]
@=""

; Remove troubleshoot compatibility
[-HKEY_CLASSES_ROOT\exefile\shellex\ContextMenuHandlers\Compatibility]

; Remove pin to quick access
[-HKEY_CLASSES_ROOT\Folder\shell\pintohome]

; Remove add to favorites
[-HKEY_CLASSES_ROOT\*\shell\pintohomefile]

; Remove include in library
[-HKEY_CLASSES_ROOT\Folder\ShellEx\ContextMenuHandlers\Library Location]

; Remove share
[-HKEY_CLASSES_ROOT\AllFilesystemObjects\shellex\ContextMenuHandlers\ModernSharing]

; Remove send to
[-HKEY_CLASSES_ROOT\AllFilesystemObjects\shellex\ContextMenuHandlers\SendTo]
[-HKEY_CLASSES_ROOT\UserLibraryFolder\shellex\ContextMenuHandlers\SendTo]

; Remove customize this folder
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer]
"NoCustomizeThisFolder"=dword:00000001

; Remove restore previous versions
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer]
"NoPreviousVersionsPage"=dword:00000001

; Remove scan with defender
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked]
"{09A47860-11B0-4DA5-AFA5-26D86198A780}"=""

; Remove pin to start
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked]
"{470C0EBD-5D73-4d58-9CED-E91E22E23282}"=""

; Remove cast to device
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked]
"{7AD84985-87B4-4a16-BE58-8B72A5B390F7}"=""

; Remove open in terminal
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked]
"{9F156763-7844-4DC4-B2B1-901F640F5155}"=""

; Remove extract all
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked]
"{b8cdcb65-b1bf-4b42-9428-1dfdb7ee92af}"=""

; Remove give access to
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked]
"{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}"=""
"@

# Save reg file
Set-Content -Path "$env:SystemRoot\Temp\CleanContextMenu.reg" -Value $regContent -Force

# Import reg file
Start-Process -Wait "regedit.exe" -ArgumentList "/S `"$env:SystemRoot\Temp\CleanContextMenu.reg`"" -WindowStyle Hidden

# Delete reg file
Remove-Item "$env:SystemRoot\Temp\CleanContextMenu.reg" -Force

Clear-Host
Write-Host "Restart to apply.`n"
Write-Host "Press any key to exit..." -NoNewline
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
exit
}

2 {

Clear-Host
Write-Host "Disabling..." -NoNewline

# Create reg file
$regContent = @"
Windows Registry Editor Version 5.00

; Restore modern context menu
[-HKEY_CURRENT_USER\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}]

; Restore troubleshoot compatibility
[HKEY_CLASSES_ROOT\exefile\shellex\ContextMenuHandlers\Compatibility]
@="{1d27f844-3a1f-4410-85ac-14651078412d}"

; Restore pin to quick access
[HKEY_CLASSES_ROOT\Folder\shell\pintohome]
"AppliesTo"="System.ParsingName:<>\"::{f874310e-b6b7-47dc-bc84-b9e6b38f5903}\" AND System.ParsingName:<>\"::{679f85cb-0220-4080-b29b-5540cc05aab6}\" AND System.IsFolder:=System.StructuredQueryType.Boolean#True"
"CommandStateHandler"="{b455f46e-e4af-4035-b0a4-cf18d2f6f28e}"
"CommandStateSync"=""
"MUIVerb"="@shell32.dll,-51601"
"SkipCloudDownload"=dword:00000000

[HKEY_CLASSES_ROOT\Folder\shell\pintohome\command]
"DelegateExecute"="{b455f46e-e4af-4035-b0a4-cf18d2f6f28e}"

; Restore add to favorites
[HKEY_CLASSES_ROOT\*\shell\pintohomefile]
"CommandStateHandler"="{b455f46e-e4af-4035-b0a4-cf18d2f6f28e}"
"CommandStateSync"=""
"MUIVerb"="@shell32.dll,-51608"
"NeverDefault"=""
"SkipCloudDownload"=dword:00000000

[HKEY_CLASSES_ROOT\*\shell\pintohomefile\command]
"DelegateExecute"="{b455f46e-e4af-4035-b0a4-cf18d2f6f28e}"

; Restore include in library
[HKEY_CLASSES_ROOT\Folder\ShellEx\ContextMenuHandlers\Library Location]
@="{3dad6c5d-2167-4cae-9914-f99e41c12cfa}"

; Restore share
[HKEY_CLASSES_ROOT\AllFilesystemObjects\shellex\ContextMenuHandlers\ModernSharing]
@="{e2bf9676-5f8f-435c-97eb-11607a5bedf7}"

; Restore send to
[HKEY_CLASSES_ROOT\AllFilesystemObjects\shellex\ContextMenuHandlers\SendTo]
@="{7BA4C740-9E81-11CF-99D3-00AA004AE837}"

[HKEY_CLASSES_ROOT\UserLibraryFolder\shellex\ContextMenuHandlers\SendTo]
@="{7BA4C740-9E81-11CF-99D3-00AA004AE837}"

; Restore customize this folder
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer]
"NoCustomizeThisFolder"=-

; Restore restore previous versions
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer]
"NoPreviousVersionsPage"=-

; Restore scan with defender
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked]
"{09A47860-11B0-4DA5-AFA5-26D86198A780}"=-

; Restore pin to start
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked]
"{470C0EBD-5D73-4d58-9CED-E91E22E23282}"=-

; Restore cast to device
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked]
"{7AD84985-87B4-4a16-BE58-8B72A5B390F7}"=-

; Restore open in terminal
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked]
"{9F156763-7844-4DC4-B2B1-901F640F5155}"=-

; Restore extract all
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked]
"{b8cdcb65-b1bf-4b42-9428-1dfdb7ee92af}"=-

; Restore give access to
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked]
"{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}"=-
"@

# Save reg file
Set-Content -Path "$env:SystemRoot\Temp\DefaultContextMenu.reg" -Value $regContent -Force

# Import reg file
Start-Process -Wait "regedit.exe" -ArgumentList "/S `"$env:SystemRoot\Temp\DefaultContextMenu.reg`"" -WindowStyle Hidden

# Delete reg file
Remove-Item "$env:SystemRoot\Temp\DefaultContextMenu.reg" -Force

Clear-Host
Write-Host "Restart to apply.`n"
Write-Host "Press any key to exit..." -NoNewline
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
exit
}

} } else { Write-Host "Invalid input.`n" -ForegroundColor Red } }
