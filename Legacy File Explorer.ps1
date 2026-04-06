	# ADMINISTRATOR PRIVILEGES
	If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator"))
	{Start-Process PowerShell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
	Exit}

	# WINDOW SETTINGS
	$Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + " (Administrator)"
	$Host.UI.RawUI.BackgroundColor = "Black"
	$Host.PrivateData.ProgressBackgroundColor = "Black"
	$Host.PrivateData.ProgressForegroundColor = "White"
	Clear-Host

	# INPUT UI
    Write-Host "Restore the Legacy File Explorer on Windows 11`n"
    Write-Host "1. File Explorer: Legacy"
    Write-Host "2. File Explorer: Default`n"
    while ($true) {
    $choice = Read-Host " "
    if ($choice -match '^[1-2]$') {
    switch ($choice) {
    1 {

Clear-Host

# CREATE REG FILE
$MultilineComment = @"
Windows Registry Editor Version 5.00

; LEGACY FILE EXPLORER
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

# SAVE REG FILE
Set-Content -Path "$env:SystemRoot\Temp\LegacyExplorer.reg" -Value $MultilineComment -Force

# IMPORT REG FILE
Start-Process -Wait "regedit.exe" -ArgumentList "/S `"$env:SystemRoot\Temp\LegacyExplorer.reg`"" -WindowStyle Hidden

# DELETE REG FILE
Remove-Item "$env:SystemRoot\Temp\LegacyExplorer.reg" -Force

# STOP EXPLORER
Stop-Process -Force -Name explorer -ErrorAction SilentlyContinue | Out-Null

# START EXPLORER
Start-Process explorer.exe

exit

      }
    2 {

Clear-Host

# CREATE REG FILE
$MultilineComment = @"
Windows Registry Editor Version 5.00

; DEFAULT FILE EXPLORER
[-HKEY_CURRENT_USER\Software\Classes\CLSID\{2aa9162e-c906-4dd9-ad0b-3d24a8eef5a0}]
[-HKEY_CURRENT_USER\Software\Classes\CLSID\{6480100b-5a83-4d1e-9f69-8ae5a88e9a33}]

[HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Toolbar\ShellBrowser]
"ITBar7Layout"=-

[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Ribbon]
"MinimizedStateTabletModeOff"=-
"MinimizedStateTabletModeOn"=-
"@

# SAVE REG FILE
Set-Content -Path "$env:SystemRoot\Temp\DefaultExplorer.reg" -Value $MultilineComment -Force

# IMPORT REG FILE
Start-Process -Wait "regedit.exe" -ArgumentList "/S `"$env:SystemRoot\Temp\DefaultExplorer.reg`"" -WindowStyle Hidden

# DELETE REG FILE
Remove-Item "$env:SystemRoot\Temp\DefaultExplorer.reg" -Force

# STOP EXPLORER
Stop-Process -Force -Name explorer -ErrorAction SilentlyContinue | Out-Null

# START EXPLORER
Start-Process explorer.exe

exit

      }
    } } else { Write-Host "Invalid input. Please select a valid option (1-2).`n" -ForegroundColor Red } }
