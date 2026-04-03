    If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator"))
    {Start-Process PowerShell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
    Exit}
    $Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + " (Administrator)"
    $Host.UI.RawUI.BackgroundColor = "Black"
	$Host.PrivateData.ProgressBackgroundColor = "Black"
    $Host.PrivateData.ProgressForegroundColor = "White"
    Clear-Host

    Write-Host "True Black Windows Theme`n"
    Write-Host "1. Theme: Black"
    Write-Host "2. Theme: Default`n"
    while ($true) {
    $choice = Read-Host " "
    if ($choice -match '^[1-2]$') {
    switch ($choice) {
    1 {

Clear-Host
# create reg file
$MultilineComment = @"
Windows Registry Editor Version 5.00

; background type solid color
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Wallpapers]
"BackgroundType"=dword:00000001

; solid color black
[HKEY_CURRENT_USER\Control Panel\Colors]
"Background"="0 0 0"

; remove wallpaper
[HKEY_CURRENT_USER\Control Panel\Desktop]
"WallPaper"=""

; dark mode
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize]
"AppsUseLightTheme"=dword:00000000
"SystemUsesLightTheme"=dword:00000000

; disable transparency
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize]
"EnableTransparency"=dword:00000000

; black accent color
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

; enable show accent color on start and taskbar
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize]
"ColorPrevalence"=dword:00000001
"@
# save reg file
Set-Content -Path "$env:SystemRoot\Temp\BlackTheme.reg" -Value $MultilineComment -Force
# import reg file
Start-Process -Wait "regedit.exe" -ArgumentList "/S `"$env:SystemRoot\Temp\BlackTheme.reg`"" -WindowStyle Hidden
# delete reg file
Remove-Item "$env:SystemRoot\Temp\BlackTheme.reg" -Force
# create new image
Add-Type -AssemblyName System.Windows.Forms
$screenWidth = [System.Windows.Forms.SystemInformation]::PrimaryMonitorSize.Width
$screenHeight = [System.Windows.Forms.SystemInformation]::PrimaryMonitorSize.Height
Add-Type -AssemblyName System.Drawing
$file = "C:\Windows\Black.png"
$edit = New-Object System.Drawing.Bitmap $screenWidth, $screenHeight
$color = [System.Drawing.Brushes]::Black
$graphics = [System.Drawing.Graphics]::FromImage($edit)
$graphics.FillRectangle($color, 0, 0, $edit.Width, $edit.Height)
$graphics.Dispose()
$edit.Save($file)
$edit.Dispose()
# black lockscreen
New-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP' -Force *>$null
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP' -Name 'LockScreenImagePath' -Value 'C:\Windows\Black.png' -Force
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP' -Name 'LockScreenImageStatus' -Value 1 -Force
Clear-Host
Write-Host "Restart to apply..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
exit

      }
    2 {

Clear-Host
# create reg file
$MultilineComment = @"
Windows Registry Editor Version 5.00

; background type picture
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Wallpapers]
"BackgroundType"=dword:00000000

; default wallpaper
[HKEY_CURRENT_USER\Control Panel\Desktop]
"WallPaper"="C:\\Windows\\web\\wallpaper\\Windows\\img0.jpg"

; light mode
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize]
"AppsUseLightTheme"=dword:00000001
"SystemUsesLightTheme"=dword:00000001

; enable transparency
[HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize]
"EnableTransparency"=dword:00000001

; default accent color
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

; disable show accent color on start and taskbar
[HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize]
"ColorPrevalence"=dword:00000000
"@
# save reg file
Set-Content -Path "$env:SystemRoot\Temp\DefaultTheme.reg" -Value $MultilineComment -Force
# import reg file
Start-Process -Wait "regedit.exe" -ArgumentList "/S `"$env:SystemRoot\Temp\DefaultTheme.reg`"" -WindowStyle Hidden
# delete reg file
Remove-Item "$env:SystemRoot\Temp\DefaultTheme.reg" -Force
# delete image
Remove-Item "C:\Windows\Black.png" -Force *>$null
# default lockscreen
Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP' -Name 'LockScreenImagePath' -Force *>$null
Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP' -Name 'LockScreenImageStatus' -Force *>$null
Clear-Host
Write-Host "Restart to apply..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
exit

      }
    } } else { Write-Host "Invalid input. Please select a valid option (1-2).`n" } }
