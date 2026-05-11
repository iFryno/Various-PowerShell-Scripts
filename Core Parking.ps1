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
	Write-Host "Manage CPU Core Parking`n"
	Write-Host "1. Disable"
	Write-Host "2. Default`n"
	while ($true) {
	$choice = Read-Host " "
	if ($choice -match '^[1-2]$') {
	switch ($choice) {
	1 {

Clear-Host

# Unhide processor performance core parking min cores
powercfg /attributes SUB_PROCESSOR CPMINCORES -ATTRIB_HIDE

# Unpark CPU cores
powercfg /setacvalueindex SCHEME_CURRENT SUB_PROCESSOR CPMINCORES 100
powercfg /setdcvalueindex SCHEME_CURRENT SUB_PROCESSOR CPMINCORES 100

# Apply changes
powercfg /setactive SCHEME_CURRENT

# Open power plan settings
Start-Process powercfg.cpl

exit

	  }
	2 {

Clear-Host

# Unhide processor performance core parking min cores
powercfg /attributes SUB_PROCESSOR CPMINCORES -ATTRIB_HIDE

# Park CPU cores
powercfg /setacvalueindex SCHEME_CURRENT SUB_PROCESSOR CPMINCORES 10
powercfg /setdcvalueindex SCHEME_CURRENT SUB_PROCESSOR CPMINCORES 10

# Apply changes
powercfg /setactive SCHEME_CURRENT

# Open power plan settings
Start-Process powercfg.cpl

exit

	  }
	} } else { Write-Host "Invalid input. Please select a valid option (1-2).`n" -ForegroundColor Red } }
