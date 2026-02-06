    If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator"))
    {Start-Process PowerShell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
    Exit}
    $Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + " (Administrator)"
    $Host.UI.RawUI.BackgroundColor = "Black"
	$Host.PrivateData.ProgressBackgroundColor = "Black"
    $Host.PrivateData.ProgressForegroundColor = "White"
    Clear-Host

    Write-Host "No Desktop Mouse Acceleration with Higher Scaling"
    Write-Host ""
    Write-Host "1. 100%"
    Write-Host "2. 125%"
    Write-Host "3. 150%"
    Write-Host "4. 175%"
    Write-Host "5. 200%"
    Write-Host "6. 225%"
	while ($true) {
    $choice = Read-Host " "
    if ($choice -match '^[1-6]$') {
    switch ($choice) {
    1 {

Clear-Host
Write-Host "100%..."
# create reg file
$MultilineComment = @"
Windows Registry Editor Version 5.00

; 6-11 pointer speed
[HKEY_CURRENT_USER\Control Panel\Mouse]
"MouseSensitivity"="10"

; disable enhance pointer precision
[HKEY_CURRENT_USER\Control Panel\Mouse]
"MouseSpeed"="0"
"MouseThreshold1"="0"
"MouseThreshold2"="0"

; mouse curve default
[HKEY_CURRENT_USER\Control Panel\Mouse]
"SmoothMouseXCurve"=hex:\
    00,00,00,00,00,00,00,00,\
	c0,cc,0c,00,00,00,00,00,\
	80,99,19,00,00,00,00,00,\
	40,66,26,00,00,00,00,00,\
	00,33,33,00,00,00,00,00
"SmoothMouseYCurve"=hex:\
    00,00,00,00,00,00,00,00,\
	00,00,38,00,00,00,00,00,\
	00,00,70,00,00,00,00,00,\
	00,00,a8,00,00,00,00,00,\
	00,00,e0,00,00,00,00,00

; dpi scaling 100%
[HKEY_CURRENT_USER\Control Panel\Desktop]
"Win8DpiScaling"=dword:00000001
"LogPixels"=dword:00000060

; disable fix scaling for apps
[HKEY_CURRENT_USER\Control Panel\Desktop]
"EnablePerProcessSystemDPI"=dword:00000000
"@
Set-Content -Path "$env:TEMP\100%.reg" -Value $MultilineComment -Force
# import reg file
Regedit.exe /S "$env:TEMP\100%.reg"
Timeout /T 5 | Out-Null
Clear-Host
Write-Host "Restart to apply..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
exit

      }
    2 {

Clear-Host
Write-Host "125%..."
# create reg file
$MultilineComment = @"
Windows Registry Editor Version 5.00

; 6-11 pointer speed
[HKEY_CURRENT_USER\Control Panel\Mouse]
"MouseSensitivity"="10"

; enable enhance pointer precision
[HKEY_CURRENT_USER\Control Panel\Mouse]
"MouseSpeed"="1"
"MouseThreshold1"="6"
"MouseThreshold2"="10"

; mouse curve 125% scaling
[HKEY_CURRENT_USER\Control Panel\Mouse]
"SmoothMouseXCurve"=hex:\
	00,00,00,00,00,00,00,00,\
	00,00,10,00,00,00,00,00,\
	00,00,20,00,00,00,00,00,\
	00,00,30,00,00,00,00,00,\
	00,00,40,00,00,00,00,00
"SmoothMouseYCurve"=hex:\
	00,00,00,00,00,00,00,00,\
	00,00,38,00,00,00,00,00,\
	00,00,70,00,00,00,00,00,\
	00,00,A8,00,00,00,00,00,\
	00,00,E0,00,00,00,00,00

; dpi scaling 125%
[HKEY_CURRENT_USER\Control Panel\Desktop]
"Win8DpiScaling"=dword:00000001
"LogPixels"=dword:00000078

; enable fix scaling for apps
[HKEY_CURRENT_USER\Control Panel\Desktop]
"EnablePerProcessSystemDPI"=dword:00000001
"@
Set-Content -Path "$env:TEMP\125%.reg" -Value $MultilineComment -Force
# import reg file
Regedit.exe /S "$env:TEMP\125%.reg"
Timeout /T 5 | Out-Null
Clear-Host
Write-Host "Restart to apply..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
exit

      }
    3 {

Clear-Host
Write-Host "150%..."
# create reg file
$MultilineComment = @"
Windows Registry Editor Version 5.00

; 6-11 pointer speed
[HKEY_CURRENT_USER\Control Panel\Mouse]
"MouseSensitivity"="10"

; enable enhance pointer precision
[HKEY_CURRENT_USER\Control Panel\Mouse]
"MouseSpeed"="1"
"MouseThreshold1"="6"
"MouseThreshold2"="10"

; mouse curve 150% scaling
[HKEY_CURRENT_USER\Control Panel\Mouse]
"SmoothMouseXCurve"=hex:\
	00,00,00,00,00,00,00,00,\
	30,33,13,00,00,00,00,00,\
	60,66,26,00,00,00,00,00,\
	90,99,39,00,00,00,00,00,\
	C0,CC,4C,00,00,00,00,00
"SmoothMouseYCurve"=hex:\
	00,00,00,00,00,00,00,00,\
	00,00,38,00,00,00,00,00,\
	00,00,70,00,00,00,00,00,\
	00,00,A8,00,00,00,00,00,\
	00,00,E0,00,00,00,00,00

; dpi scaling 150%
[HKEY_CURRENT_USER\Control Panel\Desktop]
"Win8DpiScaling"=dword:00000001
"LogPixels"=dword:00000090

; enable fix scaling for apps
[HKEY_CURRENT_USER\Control Panel\Desktop]
"EnablePerProcessSystemDPI"=dword:00000001
"@
Set-Content -Path "$env:TEMP\150%.reg" -Value $MultilineComment -Force
# import reg file
Regedit.exe /S "$env:TEMP\150%.reg"
Timeout /T 5 | Out-Null
Clear-Host
Write-Host "Restart to apply..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
exit

      }
    4 {

Clear-Host
Write-Host "175%..."
# create reg file
$MultilineComment = @"
Windows Registry Editor Version 5.00

; 6-11 pointer speed
[HKEY_CURRENT_USER\Control Panel\Mouse]
"MouseSensitivity"="10"

; enable enhance pointer precision
[HKEY_CURRENT_USER\Control Panel\Mouse]
"MouseSpeed"="1"
"MouseThreshold1"="6"
"MouseThreshold2"="10"

; mouse curve 175% scaling
[HKEY_CURRENT_USER\Control Panel\Mouse]
"SmoothMouseXCurve"=hex:\
	00,00,00,00,00,00,00,00,\
	60,66,16,00,00,00,00,00,\
	C0,CC,2C,00,00,00,00,00,\
	20,33,43,00,00,00,00,00,\
	80,99,59,00,00,00,00,00
"SmoothMouseYCurve"=hex:\
	00,00,00,00,00,00,00,00,\
	00,00,38,00,00,00,00,00,\
	00,00,70,00,00,00,00,00,\
	00,00,A8,00,00,00,00,00,\
	00,00,E0,00,00,00,00,00

; dpi scaling 175%
[HKEY_CURRENT_USER\Control Panel\Desktop]
"Win8DpiScaling"=dword:00000001
"LogPixels"=dword:000000a8

; enable fix scaling for apps
[HKEY_CURRENT_USER\Control Panel\Desktop]
"EnablePerProcessSystemDPI"=dword:00000001
"@
Set-Content -Path "$env:TEMP\175%.reg" -Value $MultilineComment -Force
# import reg file
Regedit.exe /S "$env:TEMP\175%.reg"
Timeout /T 5 | Out-Null
Clear-Host
Write-Host "Restart to apply..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
exit

      }
    5 {

Clear-Host
Write-Host "200%..."
# create reg file
$MultilineComment = @"
Windows Registry Editor Version 5.00

; 6-11 pointer speed
[HKEY_CURRENT_USER\Control Panel\Mouse]
"MouseSensitivity"="10"

; enable enhance pointer precision
[HKEY_CURRENT_USER\Control Panel\Mouse]
"MouseSpeed"="1"
"MouseThreshold1"="6"
"MouseThreshold2"="10"

; mouse curve 200% scaling
[HKEY_CURRENT_USER\Control Panel\Mouse]
"SmoothMouseXCurve"=hex:\
	00,00,00,00,00,00,00,00,\
	90,99,19,00,00,00,00,00,\
	20,33,33,00,00,00,00,00,\
	B0,CC,4C,00,00,00,00,00,\
	40,66,66,00,00,00,00,00
"SmoothMouseYCurve"=hex:\
	00,00,00,00,00,00,00,00,\
	00,00,38,00,00,00,00,00,\
	00,00,70,00,00,00,00,00,\
	00,00,A8,00,00,00,00,00,\
	00,00,E0,00,00,00,00,00

; dpi scaling 200%
[HKEY_CURRENT_USER\Control Panel\Desktop]
"Win8DpiScaling"=dword:00000001
"LogPixels"=dword:000000c0

; enable fix scaling for apps
[HKEY_CURRENT_USER\Control Panel\Desktop]
"EnablePerProcessSystemDPI"=dword:00000001
"@
Set-Content -Path "$env:TEMP\200%.reg" -Value $MultilineComment -Force
# import reg file
Regedit.exe /S "$env:TEMP\200%.reg"
Timeout /T 5 | Out-Null
Clear-Host
Write-Host "Restart to apply..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
exit

      }
    6 {

Clear-Host
Write-Host "225%..."
# create reg file
$MultilineComment = @"
Windows Registry Editor Version 5.00

; 6-11 pointer speed
[HKEY_CURRENT_USER\Control Panel\Mouse]
"MouseSensitivity"="10"

; enable enhance pointer precision
[HKEY_CURRENT_USER\Control Panel\Mouse]
"MouseSpeed"="1"
"MouseThreshold1"="6"
"MouseThreshold2"="10"

; mouse curve 225% scaling
[HKEY_CURRENT_USER\Control Panel\Mouse]
"SmoothMouseXCurve"=hex:\
	00,00,00,00,00,00,00,00,\
	C0,CC,1C,00,00,00,00,00,\
	80,99,39,00,00,00,00,00,\
	40,66,56,00,00,00,00,00,\
	00,33,73,00,00,00,00,00
"SmoothMouseYCurve"=hex:\
	00,00,00,00,00,00,00,00,\
	00,00,38,00,00,00,00,00,\
	00,00,70,00,00,00,00,00,\
	00,00,A8,00,00,00,00,00,\
	00,00,E0,00,00,00,00,00

; dpi scaling 225%
[HKEY_CURRENT_USER\Control Panel\Desktop]
"Win8DpiScaling"=dword:00000001
"LogPixels"=dword:000000d8

; enable fix scaling for apps
[HKEY_CURRENT_USER\Control Panel\Desktop]
"EnablePerProcessSystemDPI"=dword:00000001
"@
Set-Content -Path "$env:TEMP\225%.reg" -Value $MultilineComment -Force
# import reg file
Regedit.exe /S "$env:TEMP\225%.reg"
Timeout /T 5 | Out-Null
Clear-Host
Write-Host "Restart to apply..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
exit

      }
    } } else { Write-Host "Invalid input. Please select a valid option (1-6)." } }