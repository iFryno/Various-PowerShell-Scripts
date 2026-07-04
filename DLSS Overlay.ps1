if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
Start-Process PowerShell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
exit
}

$Host.UI.RawUI.BackgroundColor = "Black"
$Host.UI.RawUI.ForegroundColor = "White"
Clear-Host

Write-Host "DLSS Overlay`n"
Write-Host "1. Enable"
Write-Host "2. Disable (Default)`n"

while ($true) {
$choice = Read-Host " "
if ($choice -match '^[1-2]$') {
switch ($choice) {

1 {

# Enable DLSS overlay
Reg.exe add 'HKLM\SOFTWARE\NVIDIA Corporation\Global\NGXCore' /v 'ShowDlssIndicator' /t REG_DWORD /d '1024' /f *>$null

Clear-Host
Write-Host "Changes will take effect on next game launch.`n"
Write-Host "Press any key to exit..." -NoNewline
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
exit
}

2 {

# Disable DLSS overlay
Reg.exe delete 'HKLM\SOFTWARE\NVIDIA Corporation\Global\NGXCore' /v 'ShowDlssIndicator' /f *>$null

Clear-Host
Write-Host "Changes will take effect on next game launch.`n"
Write-Host "Press any key to exit..." -NoNewline
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
exit
}

} } else { Write-Host "Invalid option.`n" -ForegroundColor Red } }
