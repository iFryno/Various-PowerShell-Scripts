    If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator"))
    {Start-Process PowerShell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
    Exit}
    $Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + " (Administrator)"
    $Host.UI.RawUI.BackgroundColor = "Black"
	$Host.PrivateData.ProgressBackgroundColor = "Black"
    $Host.PrivateData.ProgressForegroundColor = "White"
    Clear-Host

    Write-Host "Manage CPU Core Parking"
    Write-Host ""
    Write-Host "1. Core Parking: Off "
    Write-Host "2. Core Parking: Default"
    Write-Host ""
    while ($true) {
    $choice = Read-Host " "
    if ($choice -match '^[1-2]$') {
    switch ($choice) {
    1 {

Clear-Host
# unhide processor performance core parking min cores
powercfg /attributes SUB_PROCESSOR CPMINCORES -ATTRIB_HIDE
# unhide processor performance core parking max cores
powercfg /attributes SUB_PROCESSOR CPMAXCORES -ATTRIB_HIDE
# unpark min cores
powercfg /setacvalueindex SCHEME_CURRENT SUB_PROCESSOR CPMINCORES 100
powercfg /setdcvalueindex SCHEME_CURRENT SUB_PROCESSOR CPMINCORES 100
# unpark max cores
powercfg /setacvalueindex SCHEME_CURRENT SUB_PROCESSOR CPMAXCORES 100
powercfg /setdcvalueindex SCHEME_CURRENT SUB_PROCESSOR CPMAXCORES 100
# apply changes
powercfg /setactive SCHEME_CURRENT
# open settings
Start-Process powercfg.cpl
exit

      }
    2 {

Clear-Host
# hide processor performance core parking min cores
powercfg /attributes SUB_PROCESSOR CPMINCORES +ATTRIB_HIDE
# hide processor performance core parking max cores
powercfg /attributes SUB_PROCESSOR CPMAXCORES +ATTRIB_HIDE
# park min cores
powercfg /setacvalueindex SCHEME_CURRENT SUB_PROCESSOR CPMINCORES 10
powercfg /setdcvalueindex SCHEME_CURRENT SUB_PROCESSOR CPMINCORES 10
# apply changes
powercfg /setactive SCHEME_CURRENT
# open settings
Start-Process powercfg.cpl
exit

      }
    } } else { Write-Host "Invalid input. Please select a valid option (1-2)." } }
