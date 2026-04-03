    If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator"))
    {Start-Process PowerShell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
    Exit}
    $Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + " (Administrator)"
    $Host.UI.RawUI.BackgroundColor = "Black"
	$Host.PrivateData.ProgressBackgroundColor = "Black"
    $Host.PrivateData.ProgressForegroundColor = "White"
    Clear-Host

	Write-Host "Start Menu Version`n"
	Write-Host "1. Start Menu: 25H2"
	Write-Host "2. Start Menu: 24H2`n"
    while ($true) {
    $choice = Read-Host " "
    if ($choice -match '^[1-2]$') {
    switch ($choice) {
    1 {

Clear-Host
# 25h2 start menu
Reg.exe add 'HKLM\SYSTEM\ControlSet001\Control\FeatureManagement\Overrides\14\2792562829' /v 'EnabledState' /t REG_DWORD /d '2' /f *>$null
Reg.exe add 'HKLM\SYSTEM\ControlSet001\Control\FeatureManagement\Overrides\14\3036241548' /v 'EnabledState' /t REG_DWORD /d '2' /f *>$null
Reg.exe add 'HKLM\SYSTEM\ControlSet001\Control\FeatureManagement\Overrides\14\734731404' /v 'EnabledState' /t REG_DWORD /d '2' /f *>$null
Reg.exe add 'HKLM\SYSTEM\ControlSet001\Control\FeatureManagement\Overrides\14\762256525' /v 'EnabledState' /t REG_DWORD /d '2' /f *>$null
# set start menu apps view to list
Reg.exe add 'HKCU\Software\Microsoft\Windows\CurrentVersion\Start' /v 'AllAppsViewMode' /t REG_DWORD /d '2' /f *>$null
Clear-Host
Write-Host "Restart to apply..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
exit

      }
    2 {

Clear-Host
# 24h2 start menu
Reg.exe add 'HKLM\SYSTEM\ControlSet001\Control\FeatureManagement\Overrides\14\2792562829' /v 'EnabledState' /t REG_DWORD /d '0' /f *>$null
Reg.exe add 'HKLM\SYSTEM\ControlSet001\Control\FeatureManagement\Overrides\14\3036241548' /v 'EnabledState' /t REG_DWORD /d '0' /f *>$null
Reg.exe add 'HKLM\SYSTEM\ControlSet001\Control\FeatureManagement\Overrides\14\734731404' /v 'EnabledState' /t REG_DWORD /d '0' /f *>$null
Reg.exe add 'HKLM\SYSTEM\ControlSet001\Control\FeatureManagement\Overrides\14\762256525' /v 'EnabledState' /t REG_DWORD /d '0' /f *>$null
# start menu apps view
Reg.exe delete 'HKCU\Software\Microsoft\Windows\CurrentVersion\Start' /v 'AllAppsViewMode' /f *>$null
Clear-Host
Write-Host "Restart to apply..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
exit

      }
    } } else { Write-Host "Invalid input. Please select a valid option (1-2).`n" } }
