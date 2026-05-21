	# Check for administrator privileges
	if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator"))
	{Start-Process PowerShell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
	Exit}

	# Configure window settings
	$Host.UI.RawUI.WindowTitle = (Split-Path -Leaf $myInvocation.MyCommand.Definition) + " (Administrator)"
	$Host.UI.RawUI.BackgroundColor = "Black"
	$Host.PrivateData.ProgressBackgroundColor = "Black"
	$Host.PrivateData.ProgressForegroundColor = "White"
	Clear-Host

	# Show input UI
	Write-Host "DLSS Version Overlay`n"
	Write-Host "1. Enable"
	Write-Host "2. Disable`n"

	while ($true) {
	$choice = Read-Host " "
	if ($choice -match '^[1-2]$') {
	switch ($choice) {
	1 {

# Show DLSS overlay
Reg.exe add 'HKLM\SOFTWARE\NVIDIA Corporation\Global\NGXCore' /v 'ShowDlssIndicator' /t REG_DWORD /d '1024' /f *>$null

Clear-Host

Write-Host "Changes will take effect on next game launch..."

$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

exit

	  }
	2 {

# Remove DLSS overlay
Reg.exe delete 'HKLM\SOFTWARE\NVIDIA Corporation\Global\NGXCore' /v 'ShowDlssIndicator' /f *>$null

Clear-Host

Write-Host "Changes will take effect on next game launch..."

$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

exit

	  }
	} } else { Write-Host "Invalid input. Please select a valid option (1-2).`n" -ForegroundColor Red } }
