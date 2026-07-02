if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
Start-Process PowerShell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
exit
}

Write-Host "Digital Markets Act`n"
Write-Host "1. Enable"
Write-Host "2. Disable`n"

while ($true) {
$choice = Read-Host " "
if ($choice -match '^[1-2]$') {
switch ($choice) {

1 {

# Create reg1.exe to bypass UCPD (credit: zoicware)
Copy-Item (Get-Command reg.exe).Source .\reg1.exe -Force -EA 0

# Set device setup region to Ireland
& .\reg1.exe add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\DeviceRegion' /v 'DeviceRegion' /t REG_DWORD /d '68' /f *>$null

# Remove reg1.exe
Remove-Item .\reg1.exe -Force -EA 0

Clear-Host
Write-Host "Restart to apply.`n"
Write-Host "Press any key to exit..." -NoNewline
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
exit
}

2 {

# Create reg1.exe to bypass UCPD
Copy-Item (Get-Command reg.exe).Source .\reg1.exe -Force -EA 0

# Set device setup region to United States
& .\reg1.exe add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\DeviceRegion' /v 'DeviceRegion' /t REG_DWORD /d '244' /f *>$null

# Remove reg1.exe
Remove-Item .\reg1.exe -Force -EA 0

Clear-Host
Write-Host "Restart to apply.`n"
Write-Host "Press any key to exit..." -NoNewline
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
exit
}

} } else { Write-Host "Invalid input.`n" -ForegroundColor Red } }
