	# ADMINISTRATOR PRIVILEGES
	if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator"))
	{Start-Process PowerShell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
	Exit}

	# WINDOW SETTINGS
	$Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + " (Administrator)"
	$Host.UI.RawUI.BackgroundColor = "Black"
	$Host.PrivateData.ProgressBackgroundColor = "Black"
	$Host.PrivateData.ProgressForegroundColor = "White"
	Clear-Host

	# INPUT UI
    Write-Host "No Desktop Mouse Acceleration with Higher Scaling`n"
    Write-Host "1. 100%"
    Write-Host "2. 125%"
    Write-Host "3. 150%"
    Write-Host "4. 175%"
    Write-Host "5. 200%"
    Write-Host "6. 225%"
	Write-Host "7. Default`n"
    while ($true) {
    $choice = Read-Host " "
    if ($choice -match '^[1-7]$') {
    switch ($choice) {
    1 {

Clear-Host

Write-Host "100%..."

# CREATE REG FILE
$MultilineComment = @"
Windows Registry Editor Version 5.00

; DEFAULT POINTER SPEED
[HKEY_CURRENT_USER\Control Panel\Mouse]
"MouseSensitivity"="10"

; DISABLE ENHANCE POINTER PRECISION
[HKEY_CURRENT_USER\Control Panel\Mouse]
"MouseSpeed"="0"
"MouseThreshold1"="0"
"MouseThreshold2"="0"

; 100% NO SCALING CURVE
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

; 100% DPI SCALING
[HKEY_CURRENT_USER\Control Panel\Desktop]
"LogPixels"=dword:00000060
"Win8DpiScaling"=dword:00000001

; DISABLE FIX SCALING FOR APPS
[HKEY_CURRENT_USER\Control Panel\Desktop]
"EnablePerProcessSystemDPI"=dword:00000000
"@

# SAVE REG FILE
Set-Content -Path "$env:SystemRoot\Temp\100%.reg" -Value $MultilineComment -Force

# IMPORT REG FILE
Start-Process -Wait "regedit.exe" -ArgumentList "/S `"$env:SystemRoot\Temp\100%.reg`"" -WindowStyle Hidden

# DELETE REG FILE
Remove-Item "$env:SystemRoot\Temp\100%.reg" -Force

Clear-Host

Write-Host "Restart to apply..."

$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

exit

      }
    2 {

Clear-Host

Write-Host "125%..."

# CREATE REG FILE
$MultilineComment = @"
Windows Registry Editor Version 5.00

; DEFAULT POINTER SPEED
[HKEY_CURRENT_USER\Control Panel\Mouse]
"MouseSensitivity"="10"

; ENABLE ENHANCE POINTER PRECISION
[HKEY_CURRENT_USER\Control Panel\Mouse]
"MouseSpeed"="1"
"MouseThreshold1"="6"
"MouseThreshold2"="10"

; 125% NO SCALING CURVE
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

; 125% DPI SCALING
[HKEY_CURRENT_USER\Control Panel\Desktop]
"LogPixels"=dword:00000078
"Win8DpiScaling"=dword:00000001

; ENABLE FIX SCALING FOR APPS
[HKEY_CURRENT_USER\Control Panel\Desktop]
"EnablePerProcessSystemDPI"=dword:00000001
"@

# SAVE REG FILE
Set-Content -Path "$env:SystemRoot\Temp\125%.reg" -Value $MultilineComment -Force

# IMPORT REG FILE
Start-Process -Wait "regedit.exe" -ArgumentList "/S `"$env:SystemRoot\Temp\125%.reg`"" -WindowStyle Hidden

# DELETE REG FILE
Remove-Item "$env:SystemRoot\Temp\125%.reg" -Force

Clear-Host

Write-Host "Restart to apply..."

$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

exit

      }
    3 {

Clear-Host

Write-Host "150%..."

# CREATE REG FILE
$MultilineComment = @"
Windows Registry Editor Version 5.00

; DEFAULT POINTER SPEED
[HKEY_CURRENT_USER\Control Panel\Mouse]
"MouseSensitivity"="10"

; ENABLE ENHANCE POINTER PRECISION
[HKEY_CURRENT_USER\Control Panel\Mouse]
"MouseSpeed"="1"
"MouseThreshold1"="6"
"MouseThreshold2"="10"

; 150% NO SCALING CURVE
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

; 150% DPI SCALING
[HKEY_CURRENT_USER\Control Panel\Desktop]
"LogPixels"=dword:00000090
"Win8DpiScaling"=dword:00000001

; ENABLE FIX SCALING FOR APPS
[HKEY_CURRENT_USER\Control Panel\Desktop]
"EnablePerProcessSystemDPI"=dword:00000001
"@

# SAVE REG FILE
Set-Content -Path "$env:SystemRoot\Temp\150%.reg" -Value $MultilineComment -Force

# IMPORT REG FILE
Start-Process -Wait "regedit.exe" -ArgumentList "/S `"$env:SystemRoot\Temp\150%.reg`"" -WindowStyle Hidden

# DELETE REG FILE
Remove-Item "$env:SystemRoot\Temp\150%.reg" -Force

Clear-Host

Write-Host "Restart to apply..."

$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

exit

      }
    4 {

Clear-Host

Write-Host "175%..."

# CREATE REG FILE
$MultilineComment = @"
Windows Registry Editor Version 5.00

; DEFAULT POINTER SPEED
[HKEY_CURRENT_USER\Control Panel\Mouse]
"MouseSensitivity"="10"

; ENABLE ENHANCE POINTER PRECISION
[HKEY_CURRENT_USER\Control Panel\Mouse]
"MouseSpeed"="1"
"MouseThreshold1"="6"
"MouseThreshold2"="10"

; 175% NO SCALING CURVE
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

; 175% DPI SCALING
[HKEY_CURRENT_USER\Control Panel\Desktop]
"LogPixels"=dword:000000a8
"Win8DpiScaling"=dword:00000001

; ENABLE FIX SCALING FOR APPS
[HKEY_CURRENT_USER\Control Panel\Desktop]
"EnablePerProcessSystemDPI"=dword:00000001
"@

# SAVE REG FILE
Set-Content -Path "$env:SystemRoot\Temp\175%.reg" -Value $MultilineComment -Force

# IMPORT REG FILE
Start-Process -Wait "regedit.exe" -ArgumentList "/S `"$env:SystemRoot\Temp\175%.reg`"" -WindowStyle Hidden

# DELETE REG FILE
Remove-Item "$env:SystemRoot\Temp\175%.reg" -Force

Clear-Host

Write-Host "Restart to apply..."

$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

exit

      }
    5 {

Clear-Host

Write-Host "200%..."

# CREATE REG FILE
$MultilineComment = @"
Windows Registry Editor Version 5.00

; DEFAULT POINTER SPEED
[HKEY_CURRENT_USER\Control Panel\Mouse]
"MouseSensitivity"="10"

; ENABLE ENHANCE POINTER PRECISION
[HKEY_CURRENT_USER\Control Panel\Mouse]
"MouseSpeed"="1"
"MouseThreshold1"="6"
"MouseThreshold2"="10"

; 200% NO SCALING CURVE
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

; 200% DPI SCALING
[HKEY_CURRENT_USER\Control Panel\Desktop]
"LogPixels"=dword:000000c0
"Win8DpiScaling"=dword:00000001

; ENABLE FIX SCALING FOR APPS
[HKEY_CURRENT_USER\Control Panel\Desktop]
"EnablePerProcessSystemDPI"=dword:00000001
"@

# SAVE REG FILE
Set-Content -Path "$env:SystemRoot\Temp\200%.reg" -Value $MultilineComment -Force

# IMPORT REG FILE
Start-Process -Wait "regedit.exe" -ArgumentList "/S `"$env:SystemRoot\Temp\200%.reg`"" -WindowStyle Hidden

# DELETE REG FILE
Remove-Item "$env:SystemRoot\Temp\200%.reg" -Force

Clear-Host

Write-Host "Restart to apply..."

$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

exit

      }
    6 {

Clear-Host

Write-Host "225%..."

# CREATE REG FILE
$MultilineComment = @"
Windows Registry Editor Version 5.00

; DEFAULT POINTER SPEED
[HKEY_CURRENT_USER\Control Panel\Mouse]
"MouseSensitivity"="10"

; ENABLE ENHANCE POINTER PRECISION
[HKEY_CURRENT_USER\Control Panel\Mouse]
"MouseSpeed"="1"
"MouseThreshold1"="6"
"MouseThreshold2"="10"

; 225% NO SCALING CURVE
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

; 225% DPI SCALING
[HKEY_CURRENT_USER\Control Panel\Desktop]
"LogPixels"=dword:000000d8
"Win8DpiScaling"=dword:00000001

; ENABLE FIX SCALING FOR APPS
[HKEY_CURRENT_USER\Control Panel\Desktop]
"EnablePerProcessSystemDPI"=dword:00000001
"@

# SAVE REG FILE
Set-Content -Path "$env:SystemRoot\Temp\225%.reg" -Value $MultilineComment -Force

# IMPORT REG FILE
Start-Process -Wait "regedit.exe" -ArgumentList "/S `"$env:SystemRoot\Temp\225%.reg`"" -WindowStyle Hidden

# DELETE REG FILE
Remove-Item "$env:SystemRoot\Temp\225%.reg" -Force

Clear-Host

Write-Host "Restart to apply..."

$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

exit

      }
    7 {

Clear-Host

Write-Host "Default..."

# CREATE REG FILE
$MultilineComment = @"
Windows Registry Editor Version 5.00

; DEFAULT POINTER SPEED
[HKEY_CURRENT_USER\Control Panel\Mouse]
"MouseSensitivity"="10"

; DISABLE ENHANCE POINTER PRECISION (SHOULDNT BE ON BY DEFAULT)
[HKEY_CURRENT_USER\Control Panel\Mouse]
"MouseSpeed"="0"
"MouseThreshold1"="0"
"MouseThreshold2"="0"

; DEFAULT CURVE
[HKEY_CURRENT_USER\Control Panel\Mouse]
"SmoothMouseXCurve"=hex:\
00,00,00,00,00,00,00,00,\
15,6e,00,00,00,00,00,00,\
00,40,01,00,00,00,00,00,\
29,dc,03,00,00,00,00,00,\
00,00,28,00,00,00,00,00
"SmoothMouseYCurve"=hex:\
00,00,00,00,00,00,00,00,\
fd,11,01,00,00,00,00,00,\
00,24,04,00,00,00,00,00,\
00,fc,12,00,00,00,00,00,\
00,c0,bb,01,00,00,00,00

; RESET SCALING
[HKEY_CURRENT_USER\Control Panel\Desktop]
"LogPixels"=-
"Win8DpiScaling"=-

; RESET FIX SCALING FOR APPS
[HKEY_CURRENT_USER\Control Panel\Desktop]
"EnablePerProcessSystemDPI"=-
"@

# SAVE REG FILE
Set-Content -Path "$env:SystemRoot\Temp\Default.reg" -Value $MultilineComment -Force

# IMPORT REG FILE
Start-Process -Wait "regedit.exe" -ArgumentList "/S `"$env:SystemRoot\Temp\Default.reg`"" -WindowStyle Hidden

# DELETE REG FILE
Remove-Item "$env:SystemRoot\Temp\Default.reg" -Force

Clear-Host

Write-Host "Restart to apply..."

$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

exit

      }
    } } else { Write-Host "Invalid input. Please select a valid option (1-7).`n" -ForegroundColor Red } }
