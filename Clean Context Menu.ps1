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
# clean context menu
# legacy context menu
Reg.exe add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve >$null 2>&1

# remove add to favorites
Reg.exe delete 'HKCR\*\shell\pintohomefile' /f >$null 2>&1

# remove customize this folder
Reg.exe delete 'HKCR\Directory\shellex\PropertySheetHandlers\{ef43ecfe-2ab9-4632-bf21-58909dd177f0}' /f >$null 2>&1
Reg.exe delete 'HKCR\Drive\shellex\PropertySheetHandlers\{ef43ecfe-2ab9-4632-bf21-58909dd177f0}' /f >$null 2>&1
# policies
Reg.exe delete 'HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer' /v 'NoCustomizeThisFolder' /f >$null 2>&1
Reg.exe delete 'HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer' /v 'NoCustomizeWebView' /f >$null 2>&1
Reg.exe delete 'HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer' /v 'ClassicShell' /f >$null 2>&1
Reg.exe add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer' /v 'NoCustomizeThisFolder' /t REG_DWORD /d '1' /f >$null 2>&1
Reg.exe delete 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer' /v 'NoCustomizeWebView' /f >$null 2>&1
Reg.exe delete 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer' /v 'ClassicShell' /f >$null 2>&1

# remove give access to
Reg.exe delete 'HKCR\*\shellex\ContextMenuHandlers\Sharing' /f >$null 2>&1
Reg.exe delete 'HKCR\Directory\Background\shellex\ContextMenuHandlers\Sharing' /f >$null 2>&1
Reg.exe delete 'HKCR\Directory\shellex\ContextMenuHandlers\Sharing' /f >$null 2>&1
Reg.exe delete 'HKCR\Drive\shellex\ContextMenuHandlers\Sharing' /f >$null 2>&1
Reg.exe delete 'HKCR\LibraryFolder\background\shellex\ContextMenuHandlers\Sharing' /f >$null 2>&1
Reg.exe delete 'HKCR\UserLibraryFolder\shellex\ContextMenuHandlers\Sharing' /f >$null 2>&1

# remove open in terminal
Reg.exe add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked' /v '{9F156763-7844-4DC4-B2B1-901F640F5155}' /t REG_SZ /d `"`" /f >$null 2>&1

# remove restore previous versions
Reg.exe delete 'HKCR\AllFilesystemObjects\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}' /f >$null 2>&1
Reg.exe delete 'HKCR\CLSID\{450D8FBA-AD25-11D0-98A8-0800361B1103}\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}' /f >$null 2>&1
Reg.exe delete 'HKCR\Directory\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}' /f >$null 2>&1
Reg.exe delete 'HKCR\Drive\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}' /f >$null 2>&1
Reg.exe delete 'HKCR\AllFilesystemObjects\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}' /f >$null 2>&1
Reg.exe delete 'HKCR\CLSID\{450D8FBA-AD25-11D0-98A8-0800361B1103}\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}' /f >$null 2>&1
Reg.exe delete 'HKCR\Directory\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}' /f >$null 2>&1
Reg.exe delete 'HKCR\Drive\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}' /f >$null 2>&1
# policies
Reg.exe delete 'HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer' /v 'NoPreviousVersionsPage' /f >$null 2>&1
Reg.exe delete 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer' /v 'NoPreviousVersionsPage' /f >$null 2>&1
Reg.exe delete 'HKLM\SOFTWARE\Policies\Microsoft\PreviousVersions' /v 'DisableLocalPage' /f >$null 2>&1
Reg.exe delete 'HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer' /v 'NoPreviousVersionsPage' /f >$null 2>&1
Reg.exe delete 'HKCU\Software\Policies\Microsoft\PreviousVersions' /v 'DisableLocalPage' /f >$null 2>&1
     
# remove print
Reg.exe add 'HKCR\SystemFileAssociations\image\shell\print' /v 'ProgrammaticAccessOnly' /t REG_SZ /d `"`" /f >$null 2>&1
Reg.exe add 'HKCR\batfile\shell\print' /v 'ProgrammaticAccessOnly' /t REG_SZ /d `"`" /f >$null 2>&1
Reg.exe add 'HKCR\cmdfile\shell\print' /v 'ProgrammaticAccessOnly' /t REG_SZ /d `"`" /f >$null 2>&1
Reg.exe add 'HKCR\docxfile\shell\print' /v 'ProgrammaticAccessOnly' /t REG_SZ /d `"`" /f >$null 2>&1
Reg.exe add 'HKCR\fonfile\shell\print' /v 'ProgrammaticAccessOnly' /t REG_SZ /d `"`" /f >$null 2>&1
Reg.exe add 'HKCR\htmlfile\shell\print' /v 'ProgrammaticAccessOnly' /t REG_SZ /d `"`" /f >$null 2>&1
Reg.exe add 'HKCR\inffile\shell\print' /v 'ProgrammaticAccessOnly' /t REG_SZ /d `"`" /f >$null 2>&1
Reg.exe add 'HKCR\inifile\shell\print' /v 'ProgrammaticAccessOnly' /t REG_SZ /d `"`" /f >$null 2>&1
Reg.exe add 'HKCR\JSEFile\Shell\Print' /v 'ProgrammaticAccessOnly' /t REG_SZ /d `"`" /f >$null 2>&1
Reg.exe add 'HKCR\otffile\shell\print' /v 'ProgrammaticAccessOnly' /t REG_SZ /d `"`" /f >$null 2>&1
Reg.exe add 'HKCR\pfmfile\shell\print' /v 'ProgrammaticAccessOnly' /t REG_SZ /d `"`" /f >$null 2>&1
Reg.exe add 'HKCR\regfile\shell\print' /v 'ProgrammaticAccessOnly' /t REG_SZ /d `"`" /f >$null 2>&1
Reg.exe add 'HKCR\rtffile\shell\print' /v 'ProgrammaticAccessOnly' /t REG_SZ /d `"`" /f >$null 2>&1
Reg.exe add 'HKCR\ttcfile\shell\print' /v 'ProgrammaticAccessOnly' /t REG_SZ /d `"`" /f >$null 2>&1
Reg.exe add 'HKCR\ttffile\shell\print' /v 'ProgrammaticAccessOnly' /t REG_SZ /d `"`" /f >$null 2>&1
Reg.exe add 'HKCR\txtfile\shell\print' /v 'ProgrammaticAccessOnly' /t REG_SZ /d `"`" /f >$null 2>&1
Reg.exe add 'HKCR\VBEFile\Shell\Print' /v 'ProgrammaticAccessOnly' /t REG_SZ /d `"`" /f >>$null 2>&1
Reg.exe add 'HKCR\VBSFile\Shell\Print' /v 'ProgrammaticAccessOnly' /t REG_SZ /d `"`" /f >$null 2>&1
Reg.exe add 'HKCR\WSFFile\Shell\Print' /v 'ProgrammaticAccessOnly' /t REG_SZ /d `"`" /f >$null 2>&1

# remove send
Reg.exe delete 'HKCR\AllFilesystemObjects\shellex\ContextMenuHandlers\SendTo' /f >$null 2>&1
Reg.exe delete 'HKCR\UserLibraryFolder\shellex\ContextMenuHandlers\SendTo' /f >$null 2>&1

# remove share
Reg.exe delete 'HKCR\AllFilesystemObjects\shellex\ContextMenuHandlers\ModernSharing' /f >$null 2>&1
Reg.exe delete 'HKCR\*\shellex\ContextMenuHandlers\ModernSharing' /f >$null 2>&1

# remove scan with defender
Reg.exe add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked' /v '{09A47860-11B0-4DA5-AFA5-26D86198A780}' /t REG_SZ /d `"`" /f >$null 2>&1
Clear-Host
Write-Host "Restart to apply..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
exit

	  }
	2 {

Clear-Host
# default context menu
$regFile = @'
Windows Registry Editor Version 5.00

[-HKEY_LOCAL_MACHINE\Software\Classes\.bat\ShellNew]
  
[-HKEY_LOCAL_MACHINE\Software\Classes\.ps1\ShellNew]
  
[-HKEY_LOCAL_MACHINE\Software\Classes\.reg\ShellNew]
  
[-HKEY_LOCAL_MACHINE\Software\Classes\DesktopBackground\Shell\KillNotResponding]
  
[-HKEY_LOCAL_MACHINE\Software\Classes\DesktopBackground\Shell\ShutDown]
  
[-HKEY_LOCAL_MACHINE\Software\Classes\DesktopBackground\Shell\SnippingTool]
  
[-HKEY_LOCAL_MACHINE\Software\Classes\DesktopBackground\Shell\taskmgr]
  
[-HKEY_LOCAL_MACHINE\Software\Classes\Directory\background\shell\OpenElevatedCmd]
  
[-HKEY_LOCAL_MACHINE\Software\Classes\Directory\background\shell\OpenElevatedPS]
  
[-HKEY_LOCAL_MACHINE\Software\Classes\Directory\shell\OpenElevatedCmd]
  
[-HKEY_LOCAL_MACHINE\Software\Classes\Directory\shell\OpenElevatedPS]
  
[-HKEY_LOCAL_MACHINE\Software\Classes\Drive\shell\OpenElevatedCmd]
  
[-HKEY_LOCAL_MACHINE\Software\Classes\Drive\shell\OpenElevatedPS]
  
[-HKEY_LOCAL_MACHINE\Software\Classes\LibraryFolder\Shell\OpenElevatedCmd]
  
[-HKEY_LOCAL_MACHINE\Software\Classes\LibraryFolder\Shell\OpenElevatedPS]
  
[-HKEY_LOCAL_MACHINE\Software\Classes\Microsoft.PowerShellScript.1\Shell\runas]
  
[-HKEY_LOCAL_MACHINE\Software\Classes\Msi.Package\shell\runas]
  
[-HKEY_LOCAL_MACHINE\Software\Classes\SystemFileAssociations\.ps1\Shell\run_edit]
  
[-HKEY_LOCAL_MACHINE\Software\Classes\VBSFile\Shell\runas]

[-HKEY_CLASSES_ROOT\*\shell\runas]
 
[-HKEY_CLASSES_ROOT\*\shell\runas\command]
 
[-HKEY_CLASSES_ROOT\Directory\shell\runas]
 
[-HKEY_CLASSES_ROOT\Directory\shell\runas\command]

[-HKEY_CLASSES_ROOT\*\shell\Delete Permanently]

[-HKEY_CURRENT_USER\SOFTWARE\Classes\*\shellex\Delete Permanently]

[HKEY_CLASSES_ROOT\*\shell\pintohomefile]
"CommandStateHandler"="{b455f46e-e4af-4035-b0a4-cf18d2f6f28e}"
"CommandStateSync"=""
"MUIVerb"="@shell32.dll,-51608"
"NeverDefault"=""
"SkipCloudDownload"=dword:00000000

[HKEY_CLASSES_ROOT\*\shell\pintohomefile\command]
"DelegateExecute"="{b455f46e-e4af-4035-b0a4-cf18d2f6f28e}"

[HKEY_CLASSES_ROOT\Directory\shellex\PropertySheetHandlers\{ef43ecfe-2ab9-4632-bf21-58909dd177f0}]
@=""

[HKEY_CLASSES_ROOT\Drive\shellex\PropertySheetHandlers\{ef43ecfe-2ab9-4632-bf21-58909dd177f0}]
@=""

[HKEY_CLASSES_ROOT\*\shellex\ContextMenuHandlers\Sharing]
@="{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}"

[HKEY_CLASSES_ROOT\Directory\Background\shellex\ContextMenuHandlers\Sharing]
@="{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}"

[HKEY_CLASSES_ROOT\Directory\shellex\ContextMenuHandlers\Sharing]
@="{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}"

[HKEY_CLASSES_ROOT\LibraryFolder\background\shellex\ContextMenuHandlers\Sharing]
@="{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}"

[HKEY_CLASSES_ROOT\UserLibraryFolder\shellex\ContextMenuHandlers\Sharing]
@="{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}"

[HKEY_CLASSES_ROOT\Drive\shellex\ContextMenuHandlers\Sharing]
@="{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}"

[HKEY_CLASSES_ROOT\Directory\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}]

[HKEY_CLASSES_ROOT\CLSID\{450D8FBA-AD25-11D0-98A8-0800361B1103}\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}]

[HKEY_CLASSES_ROOT\AllFilesystemObjects\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}]

[HKEY_CLASSES_ROOT\Directory\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}]

[HKEY_CLASSES_ROOT\CLSID\{450D8FBA-AD25-11D0-98A8-0800361B1103}\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}]

[HKEY_CLASSES_ROOT\AllFilesystemObjects\shellex\ContextMenuHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}]

[HKEY_CLASSES_ROOT\Drive\shellex\PropertySheetHandlers\{596AB062-B4D2-4215-9F74-E9109B0A8153}]

[HKEY_CLASSES_ROOT\AllFilesystemObjects\shellex\ContextMenuHandlers\SendTo]
@="{7BA4C740-9E81-11CF-99D3-00AA004AE837}"

[HKEY_CLASSES_ROOT\UserLibraryFolder\shellex\ContextMenuHandlers\SendTo]
@="{7BA4C740-9E81-11CF-99D3-00AA004AE837}"

[HKEY_CLASSES_ROOT\AllFilesystemObjects\shellex\ContextMenuHandlers\ModernSharing]
@="{e2bf9676-5f8f-435c-97eb-11607a5bedf7}"

[HKEY_CLASSES_ROOT\DesktopBackground\Shell\Personalize]
@=hex(2):40,00,25,00,73,00,79,00,73,00,74,00,65,00,6d,00,72,00,6f,00,6f,00,74,\
  00,25,00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,74,00,\
  68,00,65,00,6d,00,65,00,63,00,70,00,6c,00,2e,00,64,00,6c,00,6c,00,2c,00,2d,\
  00,31,00,30,00,00,00
"HideInSafeMode"=""
"Icon"=hex(2):25,00,73,00,79,00,73,00,74,00,65,00,6d,00,72,00,6f,00,6f,00,74,\
  00,25,00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,74,00,\
  68,00,65,00,6d,00,65,00,63,00,70,00,6c,00,2e,00,64,00,6c,00,6c,00,2c,00,2d,\
  00,31,00,00,00
"Position"="Bottom"
"SettingsURI"="ms-settings:personalization"

[HKEY_CLASSES_ROOT\DesktopBackground\Shell\Personalize\command]
"DelegateExecute"="{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}"

[HKEY_CLASSES_ROOT\DesktopBackground\Shell\Display]
@=hex(2):40,00,25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,\
  00,25,00,5c,00,53,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,64,00,\
  69,00,73,00,70,00,6c,00,61,00,79,00,2e,00,64,00,6c,00,6c,00,2c,00,2d,00,34,\
  00,00,00
"Icon"=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,\
  00,25,00,5c,00,53,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,64,00,\
  69,00,73,00,70,00,6c,00,61,00,79,00,2e,00,64,00,6c,00,6c,00,2c,00,2d,00,31,\
  00,00,00
"Position"="Bottom"
"SettingsUri"="ms-settings:display"

[HKEY_CLASSES_ROOT\DesktopBackground\Shell\Display\command]
"DelegateExecute"="{556FF0D6-A1EE-49E5-9FA4-90AE116AD744}"

[HKEY_CLASSES_ROOT\Folder\ShellEx\ContextMenuHandlers\Library Location]
@="{3dad6c5d-2167-4cae-9914-f99e41c12cfa}"

[HKEY_LOCAL_MACHINE\SOFTWARE\Classes\Folder\ShellEx\ContextMenuHandlers\Library Location]
@="{3dad6c5d-2167-4cae-9914-f99e41c12cfa}"

[-HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked{09A47860-11B0-4DA5-AFA5-26D86198A780}]
'@

Reg.exe delete 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer' /v 'NoCustomizeThisFolder' /f *>$null
Reg.exe delete 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked' /v '{9F156763-7844-4DC4-B2B1-901F640F5155}' /f *>$null
Reg.exe delete 'HKCR\SystemFileAssociations\image\shell\print' /v 'ProgrammaticAccessOnly' /f *>$null
Reg.exe delete 'HKCR\batfile\shell\print' /v 'ProgrammaticAccessOnly' /f *>$null   
Reg.exe delete 'HKCR\cmdfile\shell\print' /v 'ProgrammaticAccessOnly' /f *>$null 
Reg.exe delete 'HKCR\docxfile\shell\print' /v 'ProgrammaticAccessOnly' /f *>$null 
Reg.exe delete 'HKCR\fonfile\shell\print' /v 'ProgrammaticAccessOnly' /f *>$null 
Reg.exe delete 'HKCR\htmlfile\shell\print' /v 'ProgrammaticAccessOnly' /f *>$null 
Reg.exe delete 'HKCR\inffile\shell\print' /v 'ProgrammaticAccessOnly' /f *>$null 
Reg.exe delete 'HKCR\inifile\shell\print' /v 'ProgrammaticAccessOnly' /f *>$null 
Reg.exe delete 'HKCR\JSEFile\Shell\Print' /v 'ProgrammaticAccessOnly' /f *>$null 
Reg.exe delete 'HKCR\otffile\shell\print' /v 'ProgrammaticAccessOnly' /f *>$null 
Reg.exe delete 'HKCR\pfmfile\shell\print' /v 'ProgrammaticAccessOnly' /f *>$null 
Reg.exe delete 'HKCR\regfile\shell\print' /v 'ProgrammaticAccessOnly' /f *>$null 
Reg.exe delete 'HKCR\rtffile\shell\print' /v 'ProgrammaticAccessOnly' /f *>$null 
Reg.exe delete 'HKCR\ttcfile\shell\print' /v 'ProgrammaticAccessOnly' /f *>$null 
Reg.exe delete 'HKCR\ttffile\shell\print' /v 'ProgrammaticAccessOnly' /f *>$null 
Reg.exe delete 'HKCR\txtfile\shell\print' /v 'ProgrammaticAccessOnly' /f *>$null 
Reg.exe delete 'HKCR\VBEFile\Shell\Print' /v 'ProgrammaticAccessOnly' /f *>$null
Reg.exe delete 'HKCR\VBSFile\Shell\Print' /v 'ProgrammaticAccessOnly' /f *>$null
Reg.exe delete 'HKCR\WSFFile\Shell\Print' /v 'ProgrammaticAccessOnly' /f *>$null
Reg.exe delete 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked' /v '{b8cdcb65-b1bf-4b42-9428-1dfdb7ee92af}' /f *>$null 
Reg.exe delete 'HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked' /v '{b8cdcb65-b1bf-4b42-9428-1dfdb7ee92af}' /f *>$null
Reg.exe delete 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked' /v '{EE07CEF5-3441-4CFB-870A-4002C724783A}' /f *>$null
Reg.exe delete 'HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked' /v '{EE07CEF5-3441-4CFB-870A-4002C724783A}' /f *>$null
Reg.exe delete 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked' /v '{1d27f844-3a1f-4410-85ac-14651078412d}' /f *>$null

$path = New-Item -Path "$env:TEMP\RestoreContext.reg" -Value $regFile -Force 
Start-Process regedit.exe -ArgumentList "/s $($path.FullName)"
Clear-Host
Write-Host "Restart to apply..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
exit

	  }
	} } else { Write-Host "Invalid input. Please select a valid option (1-2)." } }
