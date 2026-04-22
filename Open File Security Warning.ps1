	# ADMINISTRATOR PRIVILEGES
	if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator"))
	{Start-Process PowerShell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
	Exit}

	# WINDOW SETTINGS
	$Host.UI.RawUI.WindowTitle = (Split-Path -Leaf $myInvocation.MyCommand.Definition) + " (Administrator)"
	$Host.UI.RawUI.BackgroundColor = "Black"
	$Host.PrivateData.ProgressBackgroundColor = "Black"
	$Host.PrivateData.ProgressForegroundColor = "White"
	Clear-Host

	# INPUT UI
	Write-Host "Open File Security Warning`n"
	Write-Host "1. Disabled"
	Write-Host "2. Default`n"
    while ($true) {
    $choice = Read-Host " "
    if ($choice -match '^[1-2]$') {
    switch ($choice) {
    1 {

Clear-Host

# DISABLE OPEN FILE SECURITY WARNING
Reg.exe add 'HKLM\SOFTWARE\Policies\Microsoft\Internet Explorer\Security' /v 'DisableSecuritySettingsCheck' /t REG_DWORD /d '1' /f *>$null
Reg.exe add 'HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3' /v '1806' /t REG_DWORD /d '0' /f *>$null
Reg.exe add 'HKLM\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3' /v '1806' /t REG_DWORD /d '0' /f *>$null

Clear-Host

Write-Host "Restart to apply..."

$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

exit

      }
    2 {

Clear-Host

# RESET OPEN FILE SECURITY WARNING
Reg.exe delete 'HKLM\SOFTWARE\Policies\Microsoft\Internet Explorer\Security' /v 'DisableSecuritySettingsCheck' /f *>$null
Reg.exe delete 'HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3' /v '1806' /f *>$null
Reg.exe add 'HKLM\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3' /v '1806' /t REG_DWORD /d '1' /f *>$null

Clear-Host

Write-Host "Restart to apply..."

$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

exit

      }
    } } else { Write-Host "Invalid input. Please select a valid option (1-2).`n" -ForegroundColor Red } }
