	If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator"))
	{Start-Process PowerShell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
	Exit}
	$ProgressPreference = 'SilentlyContinue'
	$ErrorActionPreference = 'SilentlyContinue'
	$Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + " (Administrator)"
	$Host.UI.RawUI.BackgroundColor = "Black"
	$Host.PrivateData.ProgressBackgroundColor = "Black"
	$Host.PrivateData.ProgressForegroundColor = "White"
	Clear-Host

	Write-Host "Remove Unnecessary Right Click Context Menu Options"
	Write-Host ""
	Write-Host "1. Context Menu: Clean"
	Write-Host "2. Context Menu: Default"
    Write-Host ""
	while ($true) {
		$choice = Read-Host " "
	if ($choice -match '^[1-2]$') {
	switch ($choice) {
	1 {

Clear-Host
# restore legacy context menu
Reg.exe add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /ve /t REG_SZ /d "" /f *>$null
# remove customize this folder
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoCustomizeThisFolder" /t REG_DWORD /d "1" /f *>$null
# remove pin to quick access
Reg.exe delete "HKCR\Folder\shell\pintohome" /f *>$null
# remove add to favorites
Reg.exe delete "HKCR\*\shell\pintohomefile" /f *>$null
# remove troubleshoot compatibility
Reg.exe delete "HKCR\exefile\shellex\ContextMenuHandlers\Compatibility" /f *>$null
# remove open in terminal
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /v "{9F156763-7844-4DC4-B2B1-901F640F5155}" /t REG_SZ /d "" /f *>$null
# remove scan with defender
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /v "{09A47860-11B0-4DA5-AFA5-26D86198A780}" /t REG_SZ /d "" /f *>$null
# remove give access to
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /v "{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}" /t REG_SZ /d "" /f *>$null
# remove include in library
Reg.exe delete "HKCR\Folder\ShellEx\ContextMenuHandlers\Library Location" /f *>$null
# remove share
Reg.exe delete "HKCR\AllFilesystemObjects\shellex\ContextMenuHandlers\ModernSharing" /f *>$null
# remove previous versions
Reg.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "NoPreviousVersionsPage" /t REG_DWORD /d "1" /f *>$null
# remove send to
Reg.exe delete "HKCR\AllFilesystemObjects\shellex\ContextMenuHandlers\SendTo" /f *>$null
Reg.exe delete "HKCR\UserLibraryFolder\shellex\ContextMenuHandlers\SendTo" /f *>$null
Clear-Host
Write-Host "Restart to apply..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
exit

	  }
	2 {

Clear-Host
# revert legacy context menu
Reg.exe delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f *>$null
# restore customize this folder
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoCustomizeThisFolder" /f *>$null
# restore pin to quick access
Reg.exe delete "HKCU\SOFTWARE\Classes\Folder\shell\pintohome" /f *>$null
Reg.exe add "HKLM\SOFTWARE\Classes\Folder\shell\pintohome" /v "MUIVerb" /t REG_SZ /d "Pin to Quick access" /f *>$null
Reg.exe delete "HKLM\SOFTWARE\Classes\Folder\shell\pintohome" /v "ProgrammaticAccessOnly" /f *>$null
Reg.exe delete "HKLM\SOFTWARE\Classes\Folder\shell\pintohome" /v "NeverDefault" /f *>$null
Reg.exe add "HKLM\SOFTWARE\Classes\Folder\shell\pintohome\command" /v "DelegateExecute" /t REG_SZ /d "{b455f46e-e4af-4035-b0a4-cf18d2f6f28e}" /f *>$null
# restore add to favorites
Reg.exe add "HKCR\*\shell\pintohomefile" /v "CommandStateHandler" /t REG_SZ /d "{b455f46e-e4af-4035-b0a4-cf18d2f6f28e}" /f *>$null
Reg.exe delete "HKCR\*\shell\pintohomefile" /v "CommandStateSync" /f *>$null
Reg.exe add "HKCR\*\shell\pintohomefile" /v "CommandStateSync" /t REG_SZ /d "" /f *>$null
Reg.exe add "HKCR\*\shell\pintohomefile" /v "MUIVerb" /t REG_SZ /d "@shell32.dll,-51608" /f *>$null
Reg.exe delete "HKCR\*\shell\pintohomefile" /v "NeverDefault" /f *>$null
Reg.exe add "HKCR\*\shell\pintohomefile" /v "NeverDefault" /t REG_SZ /d "" /f *>$null
Reg.exe add "HKCR\*\shell\pintohomefile" /v "SkipCloudDownload" /t REG_DWORD /d "0" /f *>$null
Reg.exe add "HKCR\*\shell\pintohomefile\command" /v "DelegateExecute" /t REG_SZ /d "{b455f46e-e4af-4035-b0a4-cf18d2f6f28e}" /f *>$null
# restore troubleshoot compatibility
Reg.exe add "HKCR\exefile\shellex\ContextMenuHandlers\Compatibility" /ve /t REG_SZ /d "{1d27f844-3a1f-4410-85ac-14651078412d}" /f *>$null
# restore open in terminal
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /v "{9F156763-7844-4DC4-B2B1-901F640F5155}" /f *>$null
# restore scan with defender
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /v "{09A47860-11B0-4DA5-AFA5-26D86198A780}" /f *>$null
# restore give access to
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked" /v "{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}" /f *>$null
# restore include in library
Reg.exe add "HKCR\Folder\ShellEx\ContextMenuHandlers\Library Location" /ve /t REG_SZ /d "{3dad6c5d-2167-4cae-9914-f99e41c12cfa}" /f *>$null
# restore share
Reg.exe add "HKCR\AllFilesystemObjects\shellex\ContextMenuHandlers\ModernSharing" /ve /t REG_SZ /d "{e2bf9676-5f8f-435c-97eb-11607a5bedf7}" /f *>$null
# restore previous versions
Reg.exe delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "NoPreviousVersionsPage" /f *>$null
# restore send to
Reg.exe add "HKCR\AllFilesystemObjects\shellex\ContextMenuHandlers\SendTo" /ve /t REG_SZ /d "{7BA4C740-9E81-11CF-99D3-00AA004AE837}" /f *>$null
Reg.exe add "HKCR\UserLibraryFolder\shellex\ContextMenuHandlers\SendTo" /ve /t REG_SZ /d "{7BA4C740-9E81-11CF-99D3-00AA004AE837}" /f *>$null
Clear-Host
Write-Host "Restart to apply..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
exit

	  }
	} } else { Write-Host "Invalid input. Please select a valid option (1-2)." } }

