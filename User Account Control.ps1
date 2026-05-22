	if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator"))
	{Start-Process PowerShell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
	exit}

	$Host.UI.RawUI.WindowTitle = "Administrator: " + (Split-Path -Leaf $myInvocation.MyCommand.Definition)
	$Host.UI.RawUI.BackgroundColor = "Black"
	$Host.PrivateData.ProgressBackgroundColor = "Black"
	$Host.PrivateData.ProgressForegroundColor = "White"

	Write-Host "User Account Control`n"
	Write-Host "1. Disable"
	Write-Host "2. Enable`n"

	while ($true) {
	$choice = Read-Host " "
	if ($choice -match '^[1-2]$') {
	switch ($choice) {
	1 {

	Clear-Host

	# Disable user account control
	Reg.exe add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' /v 'EnableLUA' /t REG_DWORD /d '0' /f *>$null
	Reg.exe add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' /v 'PromptOnSecureDesktop' /t REG_DWORD /d '0' /f *>$null
	Reg.exe add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' /v 'ConsentPromptBehaviorAdmin' /t REG_DWORD /d '0' /f *>$null

	Write-Host "Restart to apply..."
	$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
	exit

	  }
	2 {

	Clear-Host

	# Enable user account control
	Reg.exe add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' /v 'EnableLUA' /t REG_DWORD /d '1' /f *>$null
	Reg.exe add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' /v 'PromptOnSecureDesktop' /t REG_DWORD /d '1' /f *>$null
	Reg.exe add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' /v 'ConsentPromptBehaviorAdmin' /t REG_DWORD /d '5' /f *>$null

	Write-Host "Restart to apply..."
	$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
	exit

	  }
	} } else { Write-Host "Invalid input.`n" -ForegroundColor Red } }
