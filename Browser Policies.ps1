	if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator"))
	{Start-Process PowerShell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
	exit}

	$Host.UI.RawUI.WindowTitle = "Administrator: " + (Split-Path -Leaf $myInvocation.MyCommand.Definition)
	$Host.UI.RawUI.BackgroundColor = "Black"
	$Host.PrivateData.ProgressBackgroundColor = "Black"
	$Host.PrivateData.ProgressForegroundColor = "White"

	Write-Host "Browser Policies`n"
	Write-Host "1. Edge"
	Write-Host "2. Brave"
	Write-Host "3. Chrome"
	Write-Host "4. Remove`n"

	while ($true) {
	$choice = Read-Host " "
	if ($choice -match '^[1-4]$') {
	switch ($choice) {
	1 {

	Clear-Host

	# Add policies to Edge
	Reg.exe add 'HKLM\SOFTWARE\Policies\Microsoft\Edge' /v 'StartupBoostEnabled' /t REG_DWORD /d '0' /f *>$null
	Reg.exe add 'HKLM\SOFTWARE\Policies\Microsoft\Edge' /v 'BackgroundModeEnabled' /t REG_DWORD /d '0' /f *>$null
	Reg.exe add 'HKLM\SOFTWARE\Policies\Microsoft\Edge' /v 'HardwareAccelerationModeEnabled' /t REG_DWORD /d '0' /f *>$null
	Reg.exe add 'HKLM\SOFTWARE\Policies\Microsoft\Edge' /v 'GenAILocalFoundationalModelSettings' /t REG_DWORD /d '1' /f *>$null

	Clear-Host
	Write-Host "Restart Edge to apply..."
	$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
	exit

	  }
	2 {

	Clear-Host

	# Add policies to Brave
	Reg.exe add 'HKLM\SOFTWARE\Policies\BraveSoftware\Brave' /v 'BackgroundModeEnabled' /t REG_DWORD /d '0' /f *>$null
	Reg.exe add 'HKLM\SOFTWARE\Policies\BraveSoftware\Brave' /v 'HighEfficiencyModeEnabled' /t REG_DWORD /d '1' /f *>$null
	Reg.exe add 'HKLM\SOFTWARE\Policies\BraveSoftware\Brave' /v 'HardwareAccelerationModeEnabled' /t REG_DWORD /d '0' /f *>$null

	Clear-Host
	Write-Host "Restart Brave to apply..."
	$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
	exit

	  }
	3 {

	Clear-Host

	# Add policies to Chrome
	Reg.exe add 'HKLM\SOFTWARE\Policies\Google\Chrome' /v 'BackgroundModeEnabled' /t REG_DWORD /d '0' /f *>$null
	Reg.exe add 'HKLM\SOFTWARE\Policies\Google\Chrome' /v 'HighEfficiencyModeEnabled' /t REG_DWORD /d '1' /f *>$null
	Reg.exe add 'HKLM\SOFTWARE\Policies\Google\Chrome' /v 'HardwareAccelerationModeEnabled' /t REG_DWORD /d '0' /f *>$null
	Reg.exe add 'HKLM\SOFTWARE\Policies\Google\Chrome' /v 'GenAILocalFoundationalModelSettings' /t REG_DWORD /d '1' /f *>$null

	Clear-Host
	Write-Host "Restart Chrome to apply..."
	$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
	exit

	  }
	4 {

	Clear-Host

	# Remove policies from Edge, Brave, and Chrome
	Reg.exe delete 'HKLM\SOFTWARE\Policies\Google\Chrome' /f *>$null
	Reg.exe delete 'HKLM\SOFTWARE\Policies\Microsoft\Edge' /f *>$null
	Reg.exe delete 'HKLM\SOFTWARE\Policies\BraveSoftware\Brave' /f *>$null

	Clear-Host
	Write-Host "Restart your browser to apply..."
	$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
	exit

	  }
	} } else { Write-Host "Invalid input.`n" -ForegroundColor Red } }
