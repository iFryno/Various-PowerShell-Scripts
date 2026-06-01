if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
Start-Process PowerShell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
exit
}

Write-Host "User Account Control`n"
Write-Host "1. Disable"
Write-Host "2. Enable`n"

while ($true) {
$choice = Read-Host " "
if ($choice -match '^[1-2]$') {
switch ($choice) {

1 {

# Disable user account control
Reg.exe add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' /v 'EnableLUA' /t REG_DWORD /d '0' /f *>$null
Reg.exe add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' /v 'PromptOnSecureDesktop' /t REG_DWORD /d '0' /f *>$null
Reg.exe add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' /v 'ConsentPromptBehaviorAdmin' /t REG_DWORD /d '0' /f *>$null

Clear-Host
Write-Host "Restart to apply."
Write-Host "Press any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
exit
}

2 {

# Enable user account control
Reg.exe add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' /v 'EnableLUA' /t REG_DWORD /d '1' /f *>$null
Reg.exe add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' /v 'PromptOnSecureDesktop' /t REG_DWORD /d '1' /f *>$null
Reg.exe add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' /v 'ConsentPromptBehaviorAdmin' /t REG_DWORD /d '5' /f *>$null

Clear-Host
Write-Host "Restart to apply."
Write-Host "Press any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
exit
}

} } else { Write-Host "Invalid input.`n" -ForegroundColor Red } }
