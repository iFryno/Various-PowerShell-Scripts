if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
Start-Process PowerShell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
exit
}

$Host.UI.RawUI.BackgroundColor = "Black"
$Host.UI.RawUI.ForegroundColor = "White"
Clear-Host

Write-Host "File Explorer`n"
Write-Host "1. Legacy"
Write-Host "2. Default`n"

while ($true) {
$choice = Read-Host " "
if ($choice -match '^[1-2]$') {
switch ($choice) {

1 {

Clear-Host
Write-Host "Legacy..." -NoNewline

# Create reg file
$regContent = @"
Windows Registry Editor Version 5.00

; Enable legacy File Explorer ribbon
[HKEY_CURRENT_USER\Software\Classes\CLSID\{2aa9162e-c906-4dd9-ad0b-3d24a8eef5a0}]
@="CLSID_ItemsViewAdapter"

[HKEY_CURRENT_USER\Software\Classes\CLSID\{2aa9162e-c906-4dd9-ad0b-3d24a8eef5a0}\InProcServer32]
@="C:\\Windows\\System32\\Windows.UI.FileExplorer.dll_"
"ThreadingModel"="Apartment"

[HKEY_CURRENT_USER\Software\Classes\CLSID\{6480100b-5a83-4d1e-9f69-8ae5a88e9a33}]
@="File Explorer Xaml Island View Adapter"

[HKEY_CURRENT_USER\Software\Classes\CLSID\{6480100b-5a83-4d1e-9f69-8ae5a88e9a33}\InProcServer32]
@="C:\\Windows\\System32\\Windows.UI.FileExplorer.dll_"
"ThreadingModel"="Apartment"

[HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Toolbar\ShellBrowser]
"ITBar7Layout"=hex:13,00,00,00,00,00,00,00,00,00,00,00,20,00,00,00,\
10,00,01,00,00,00,00,00,01,00,00,00,01,07,00,00,5e,01,00,00,\
00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\
00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\
00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\
00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\
00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\
00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\
00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\
00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,\
00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Ribbon]
"MinimizedStateTabletModeOff"=dword:00000000
"MinimizedStateTabletModeOn"=dword:00000001
"@

# Save reg file
Set-Content -Path "$env:SystemRoot\Temp\Legacy Explorer.reg" -Value $regContent -Force

# Import reg file
Start-Process -Wait "regedit.exe" -ArgumentList "/S `"$env:SystemRoot\Temp\Legacy Explorer.reg`"" -WindowStyle Hidden

# Delete reg file
Remove-Item "$env:SystemRoot\Temp\Legacy Explorer.reg" -Force

# Restart Explorer
Stop-Process -Force -Name explorer -ErrorAction SilentlyContinue | Out-Null

# Open Explorer
Start-Process explorer.exe

exit
}

2 {

Clear-Host
Write-Host "Default..." -NoNewline

# Create reg file
$regContent = @"
Windows Registry Editor Version 5.00

; Disable legacy File Explorer ribbon
[-HKEY_CURRENT_USER\Software\Classes\CLSID\{2aa9162e-c906-4dd9-ad0b-3d24a8eef5a0}]
[-HKEY_CURRENT_USER\Software\Classes\CLSID\{6480100b-5a83-4d1e-9f69-8ae5a88e9a33}]

[HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Toolbar\ShellBrowser]
"ITBar7Layout"=-

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Ribbon]
"MinimizedStateTabletModeOff"=-
"MinimizedStateTabletModeOn"=-
"@

# Save reg file
Set-Content -Path "$env:SystemRoot\Temp\Default Explorer.reg" -Value $regContent -Force

# Import reg file
Start-Process -Wait "regedit.exe" -ArgumentList "/S `"$env:SystemRoot\Temp\Default Explorer.reg`"" -WindowStyle Hidden

# Delete reg file
Remove-Item "$env:SystemRoot\Temp\Default Explorer.reg" -Force

# Restart Explorer
Stop-Process -Force -Name explorer -ErrorAction SilentlyContinue | Out-Null

# Open Explorer
Start-Process explorer.exe

exit
}

} } else { Write-Host "Invalid option.`n" -ForegroundColor Red } }
