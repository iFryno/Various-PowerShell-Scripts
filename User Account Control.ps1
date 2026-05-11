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

	# Registry path
	$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"

	# Show input UI
	Write-Host "Manage User Account Control`n"
	Write-Host "1. Disable"
	Write-Host "2. Default`n"
	while ($true) {
	$choice = Read-Host " "
	if ($choice -match '^[1-2]$') {
	switch ($choice) {
	1 {

Clear-Host

# Disable user account control
Set-ItemProperty -Path $regPath -Name "EnableLUA" -Type DWord -Value 0
Set-ItemProperty -Path $regPath -Name "PromptOnSecureDesktop" -Type DWord -Value 0
Set-ItemProperty -Path $regPath -Name "ConsentPromptBehaviorAdmin" -Type DWord -Value 0

Write-Host "Restart to apply..."

$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

exit

	  }
	2 {

Clear-Host

# Enable user account control
Set-ItemProperty -Path $regPath -Name "EnableLUA" -Type DWord -Value 1
Set-ItemProperty -Path $regPath -Name "PromptOnSecureDesktop" -Type DWord -Value 1
Set-ItemProperty -Path $regPath -Name "ConsentPromptBehaviorAdmin" -Type DWord -Value 5

Write-Host "Restart to apply..."

$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

exit

	  }
	} } else { Write-Host "Invalid input. Please select a valid option (1-2).`n" -ForegroundColor Red } }
