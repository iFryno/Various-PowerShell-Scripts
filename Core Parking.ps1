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
	Write-Host "Manage CPU Core Parking`n"
	Write-Host "1. Core Parking: Disabled"
	Write-Host "2. Core Parking: Default`n"
    while ($true) {
    $choice = Read-Host " "
    if ($choice -match '^[1-2]$') {
    switch ($choice) {
    1 {

Clear-Host

# UNHIDE PROCESSOR PERFORMANCE CORE PARKING MIN CORES
powercfg /attributes SUB_PROCESSOR CPMINCORES -ATTRIB_HIDE

# UNHIDE PROCESSOR PERFORMANCE CORE PARKING MAX CORES
powercfg /attributes SUB_PROCESSOR CPMAXCORES -ATTRIB_HIDE

# UNPARK MIN CORES
powercfg /setacvalueindex SCHEME_CURRENT SUB_PROCESSOR CPMINCORES 100
powercfg /setdcvalueindex SCHEME_CURRENT SUB_PROCESSOR CPMINCORES 100

# UNPARK MAX CORES
powercfg /setacvalueindex SCHEME_CURRENT SUB_PROCESSOR CPMAXCORES 100
powercfg /setdcvalueindex SCHEME_CURRENT SUB_PROCESSOR CPMAXCORES 100

# APPLY CHANGES
powercfg /setactive SCHEME_CURRENT

# OPEN POWERCFG SETTINGS
Start-Process powercfg.cpl

exit

      }
    2 {

Clear-Host

# HIDE PROCESSOR PERFORMANCE CORE PARKING MIN CORES
powercfg /attributes SUB_PROCESSOR CPMINCORES +ATTRIB_HIDE

# HIDE PROCESSOR PERFORMANCE CORE PARKING MAX CORES
powercfg /attributes SUB_PROCESSOR CPMAXCORES +ATTRIB_HIDE

# PARK MIN CORES
powercfg /setacvalueindex SCHEME_CURRENT SUB_PROCESSOR CPMINCORES 10
powercfg /setdcvalueindex SCHEME_CURRENT SUB_PROCESSOR CPMINCORES 10

# APPLY CHANGES
powercfg /setactive SCHEME_CURRENT

# OPEN POWERCFG SETTINGS
Start-Process powercfg.cpl

exit

      }
    } } else { Write-Host "Invalid input. Please select a valid option (1-2).`n" -ForegroundColor Red } }
