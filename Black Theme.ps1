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
    Write-Host "True Black Windows Theme`n"
    Write-Host "1. Theme: Black"
    Write-Host "2. Theme: Default`n"
    while ($true) {
    $choice = Read-Host " "
    if ($choice -match '^[1-2]$') {
    switch ($choice) {
    1 {

Clear-Host

# CREATE REG FILE
$MultilineComment = @"
Windows Registry Editor Version 5.00

; BACKGROUND TYPE SOLID COLOR
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Wallpapers]
"BackgroundType"=dword:00000001

; SOLID COLOR BLACK
[HKEY_CURRENT_USER\Control Panel\Colors]
"Background"="0 0 0"

; REMOVE WALLPAPER
[HKEY_CURRENT_USER\Control Panel\Desktop]
"WallPaper"=""

; DARK MODE
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize]
"AppsUseLightTheme"=dword:00000000
"SystemUsesLightTheme"=dword:00000000

; DISABLE TRANSPARENCY
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize]
"EnableTransparency"=dword:00000000

; BLACK ACCENT COLOR
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Accent]
"AccentColorMenu"=dword:00000000
"AccentPalette"=hex:64,64,64,00,6b,6b,6b,00,00,00,00,00,00,00,00,00,00,00,00,\
  00,00,00,00,00,00,00,00,00,00,00,00,00
"StartColorMenu"=dword:00000000

[HKEY_CURRENT_USER\Software\Microsoft\Windows\DWM]
"AccentColor"=dword:ff191919
"ColorizationAfterglow"=dword:c4191919
"ColorizationColor"=dword:c4191919
"EnableWindowColorization"=dword:00000001

; ENABLE SHOW ACCENT COLOR ON START AND TASKBAR
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize]
"ColorPrevalence"=dword:00000001
"@

# SAVE REG FILE
Set-Content -Path "$env:SystemRoot\Temp\BlackTheme.reg" -Value $MultilineComment -Force

# IMPORT REG FILE
Start-Process -Wait "regedit.exe" -ArgumentList "/S `"$env:SystemRoot\Temp\BlackTheme.reg`"" -WindowStyle Hidden

# DELETE REG FILE
Remove-Item "$env:SystemRoot\Temp\BlackTheme.reg" -Force

# CREATE BLACK IMAGE
Add-Type -AssemblyName System.Windows.Forms
$screenWidth = [System.Windows.Forms.SystemInformation]::PrimaryMonitorSize.Width
$screenHeight = [System.Windows.Forms.SystemInformation]::PrimaryMonitorSize.Height
Add-Type -AssemblyName System.Drawing
$file = "$env:SystemRoot\Web\Black.png"
$edit = New-Object System.Drawing.Bitmap $screenWidth, $screenHeight
$color = [System.Drawing.Brushes]::Black
$graphics = [System.Drawing.Graphics]::FromImage($edit)
$graphics.FillRectangle($color, 0, 0, $edit.Width, $edit.Height)
$graphics.Dispose()
$edit.Save($file)
$edit.Dispose()

# BLACK LOCK SCREEN
New-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP' -Force *>$null
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP' -Name 'LockScreenImagePath' -Value '$env:SystemRoot\Web\Black.png' -Force
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP' -Name 'LockScreenImageStatus' -Value 1 -Force

Clear-Host

Write-Host "Restart to apply..."

$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

exit

      }
    2 {

Clear-Host

# CREATE REG FILE
$MultilineComment = @"
Windows Registry Editor Version 5.00

; BACKGROUND TYPE PICTURE
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Wallpapers]
"BackgroundType"=dword:00000000

; DEFAULT WALLPAPER
[HKEY_CURRENT_USER\Control Panel\Desktop]
"WallPaper"="C:\\Windows\\web\\wallpaper\\Windows\\img0.jpg"

; LIGHT MODE
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize]
"AppsUseLightTheme"=dword:00000001
"SystemUsesLightTheme"=dword:00000001

; ENABLE TRANSPARENCY
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize]
"EnableTransparency"=dword:00000001

; DEFAULT ACCENT COLOR
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent]
"AccentColorMenu"=dword:ffd47800
"AccentPalette"=hex:99,eb,ff,00,4c,c2,ff,00,00,91,f8,00,00,78,d4,00,00,67,c0,\
  00,00,3e,92,00,00,1a,68,00,f7,63,0c,00
"StartColorMenu"=dword:ffc06700

[HKEY_CURRENT_USER\Software\Microsoft\Windows\DWM]
"AccentColor"=dword:ffd47800
"ColorizationAfterglow"=dword:c40078d4
"ColorizationColor"=dword:c40078d4
"EnableWindowColorization"=dword:00000000

; DISABLE SHOW ACCENT COLOR ON START AND TASKBAR
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize]
"ColorPrevalence"=dword:00000000
"@

# SAVE REG FILE
Set-Content -Path "$env:SystemRoot\Temp\DefaultTheme.reg" -Value $MultilineComment -Force

# IMPORT REG FILE
Start-Process -Wait "regedit.exe" -ArgumentList "/S `"$env:SystemRoot\Temp\DefaultTheme.reg`"" -WindowStyle Hidden

# DELETE REG FILE
Remove-Item "$env:SystemRoot\Temp\DefaultTheme.reg" -Force

# DELETE BLACK IMAGE
Remove-Item "$env:SystemRoot\Web\Black.png" -Force *>$null

# DEFAULT LOCK SCREEN
Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP' -Name 'LockScreenImagePath' -Force *>$null
Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP' -Name 'LockScreenImageStatus' -Force *>$null

Clear-Host

Write-Host "Restart to apply..."

$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

exit

      }
    } } else { Write-Host "Invalid input. Please select a valid option (1-2).`n" -ForegroundColor Red } }
