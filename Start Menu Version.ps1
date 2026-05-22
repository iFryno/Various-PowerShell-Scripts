	if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator"))
	{Start-Process PowerShell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
	exit}

	$Host.UI.RawUI.WindowTitle = "Administrator: " + (Split-Path -Leaf $myInvocation.MyCommand.Definition)
	$Host.UI.RawUI.BackgroundColor = "Black"
	$Host.PrivateData.ProgressBackgroundColor = "Black"
	$Host.PrivateData.ProgressForegroundColor = "White"

	Write-Host "Start Menu Version`n"
	Write-Host "1. 25H2"
	Write-Host "2. 24H2`n"

	while ($true) {
	$choice = Read-Host " "
	if ($choice -match '^[1-2]$') {
	switch ($choice) {
	1 {

	Clear-Host

	# Set start menu version to 25H2
	Reg.exe add 'HKLM\SYSTEM\ControlSet001\Control\FeatureManagement\Overrides\14\2792562829' /v 'EnabledState' /t REG_DWORD /d '2' /f *>$null
	Reg.exe add 'HKLM\SYSTEM\ControlSet001\Control\FeatureManagement\Overrides\14\3036241548' /v 'EnabledState' /t REG_DWORD /d '2' /f *>$null
	Reg.exe add 'HKLM\SYSTEM\ControlSet001\Control\FeatureManagement\Overrides\14\734731404'  /v 'EnabledState' /t REG_DWORD /d '2' /f *>$null
	Reg.exe add 'HKLM\SYSTEM\ControlSet001\Control\FeatureManagement\Overrides\14\762256525'  /v 'EnabledState' /t REG_DWORD /d '2' /f *>$null

	# Set start menu apps view to list
	Reg.exe add 'HKCU\Software\Microsoft\Windows\CurrentVersion\Start' /v 'AllAppsViewMode' /t REG_DWORD /d '2' /f *>$null

	Write-Host "Restart to apply..."
	$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
	exit

	  }
	2 {

	Clear-Host

	# Set start menu version to 24H2
	Reg.exe add 'HKLM\SYSTEM\ControlSet001\Control\FeatureManagement\Overrides\14\2792562829' /v 'EnabledState' /t REG_DWORD /d '0' /f *>$null
	Reg.exe add 'HKLM\SYSTEM\ControlSet001\Control\FeatureManagement\Overrides\14\3036241548' /v 'EnabledState' /t REG_DWORD /d '0' /f *>$null
	Reg.exe add 'HKLM\SYSTEM\ControlSet001\Control\FeatureManagement\Overrides\14\734731404'  /v 'EnabledState' /t REG_DWORD /d '0' /f *>$null
	Reg.exe add 'HKLM\SYSTEM\ControlSet001\Control\FeatureManagement\Overrides\14\762256525'  /v 'EnabledState' /t REG_DWORD /d '0' /f *>$null

	# Reset start menu apps view
	Reg.exe delete 'HKCU\Software\Microsoft\Windows\CurrentVersion\Start' /v 'AllAppsViewMode' /f *>$null

	Write-Host "Restart to apply..."
	$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
	exit

	  }
	} } else { Write-Host "Invalid input.`n" -ForegroundColor Red } }
