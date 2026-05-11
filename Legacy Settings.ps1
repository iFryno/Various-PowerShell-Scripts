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
	Write-Host "Legacy Settings in Desktop Context Menu`n"
	Write-Host "1. Add"
	Write-Host "2. Remove`n"
	while ($true) {
	$choice = Read-Host " "
	if ($choice -match '^[1-2]$') {
	switch ($choice) {
	1 {

Clear-Host

# Add legacy settings to desktop context menu
Reg.exe add 'HKCR\DesktopBackground\Shell\Personalization' /v 'Icon' /t REG_SZ /d 'shell32.dll,-137' /f *>$null
Reg.exe add 'HKCR\DesktopBackground\Shell\Personalization' /v 'MUIVerb' /t REG_SZ /d 'Legacy settings' /f *>$null
Reg.exe add 'HKCR\DesktopBackground\Shell\Personalization' /v 'Position' /t REG_SZ /d 'Bottom' /f *>$null
Reg.exe add 'HKCR\DesktopBackground\Shell\Personalization' /v 'SubCommands' /t REG_SZ /d '""' /f *>$null
Reg.exe add 'HKCR\DesktopBackground\Shell\Personalization\shell\005flyout' /v 'Icon' /t REG_SZ /d 'SndVol.exe,-101' /f *>$null
Reg.exe add 'HKCR\DesktopBackground\Shell\Personalization\shell\005flyout' /v 'MUIVerb' /t REG_SZ /d 'Sound' /f *>$null
Reg.exe add 'HKCR\DesktopBackground\Shell\Personalization\shell\005flyout\command' /ve /t REG_SZ /d 'rundll32.exe shell32.dll,Control_RunDLL mmsys.cpl,,0' /f *>$null
Reg.exe add 'HKCR\DesktopBackground\Shell\Personalization\shell\008flyout' /v 'Icon' /t REG_SZ /d 'main.cpl' /f *>$null
Reg.exe add 'HKCR\DesktopBackground\Shell\Personalization\shell\008flyout' /v 'MUIVerb' /t REG_SZ /d 'Mouse Properties' /f *>$null
Reg.exe add 'HKCR\DesktopBackground\Shell\Personalization\shell\008flyout\command' /ve /t REG_SZ /d 'rundll32.exe shell32.dll,Control_RunDLL main.cpl,,0' /f *>$null
Reg.exe add 'HKCR\DesktopBackground\Shell\Personalization\shell\009flyout' /v 'Icon' /t REG_SZ /d 'desk.cpl' /f *>$null
Reg.exe add 'HKCR\DesktopBackground\Shell\Personalization\shell\009flyout' /v 'MUIVerb' /t REG_SZ /d 'Desktop Icon Settings' /f *>$null
Reg.exe add 'HKCR\DesktopBackground\Shell\Personalization\shell\009flyout\command' /ve /t REG_SZ /d 'rundll32.exe shell32.dll,Control_RunDLL desk.cpl,,0' /f *>$null

Clear-Host

Write-Host "Done. Press any key to exit..."

$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

exit

	  }
	2 {

Clear-Host

# Remove legacy settings from desktop context menu
Reg.exe delete 'HKCR\DesktopBackground\Shell\Personalization' /f *>$null

Clear-Host

Write-Host "Done. Press any key to exit..."

$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

exit

	  }
	} } else { Write-Host "Invalid input. Please select a valid option (1-2).`n" -ForegroundColor Red } }
