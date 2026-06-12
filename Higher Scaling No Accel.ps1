if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
Start-Process PowerShell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
exit
}

Write-Host "Higher Scaling No Accel`n"
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
Write-Host "100%..." -NoNewline

# Create reg file
$regContent = @"
Windows Registry Editor Version 5.00

; Set pointer speed to default
[HKEY_CURRENT_USER\Control Panel\Mouse]
"MouseSensitivity"="10"

; Disable enhance pointer precision
[HKEY_CURRENT_USER\Control Panel\Mouse]
"MouseSpeed"="0"
"MouseThreshold1"="0"
"MouseThreshold2"="0"

[HKEY_USERS\.DEFAULT\Control Panel\Mouse]
"MouseSpeed"="0"
"MouseThreshold1"="0"
"MouseThreshold2"="0"

; Set EPP curve for 100% scaling with no acceleration
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

[HKEY_USERS\.DEFAULT\Control Panel\Mouse]
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

; Set scaling to 100%
[HKEY_CURRENT_USER\Control Panel\Desktop]
"LogPixels"=dword:00000060
"Win8DpiScaling"=dword:00000001

; Disable fix scaling for apps
[HKEY_CURRENT_USER\Control Panel\Desktop]
"EnablePerProcessSystemDPI"=dword:00000000
"@

# Save reg file
Set-Content -Path "$env:SystemRoot\Temp\100%.reg" -Value $regContent -Force

# Import reg file
Start-Process -Wait "regedit.exe" -ArgumentList "/S `"$env:SystemRoot\Temp\100%.reg`"" -WindowStyle Hidden

# Delete reg file
Remove-Item "$env:SystemRoot\Temp\100%.reg" -Force

Clear-Host
Write-Host "Restart to apply.`n"
Write-Host "Press any key to exit..." -NoNewline
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
exit
}

2 {

Clear-Host
Write-Host "125%..." -NoNewline

# Create reg file
$regContent = @"
Windows Registry Editor Version 5.00

; Set pointer speed to default
[HKEY_CURRENT_USER\Control Panel\Mouse]
"MouseSensitivity"="10"

; Enable enhance pointer precision
[HKEY_CURRENT_USER\Control Panel\Mouse]
"MouseSpeed"="1"
"MouseThreshold1"="6"
"MouseThreshold2"="10"

[HKEY_USERS\.DEFAULT\Control Panel\Mouse]
"MouseSpeed"="1"
"MouseThreshold1"="6"
"MouseThreshold2"="10"

; Set EPP curve for 125% scaling with no acceleration
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

[HKEY_USERS\.DEFAULT\Control Panel\Mouse]
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

; Set scaling to 125%
[HKEY_CURRENT_USER\Control Panel\Desktop]
"LogPixels"=dword:00000078
"Win8DpiScaling"=dword:00000001

; Enable fix scaling for apps
[HKEY_CURRENT_USER\Control Panel\Desktop]
"EnablePerProcessSystemDPI"=dword:00000001
"@

# Save reg file
Set-Content -Path "$env:SystemRoot\Temp\125%.reg" -Value $regContent -Force

# Import reg file
Start-Process -Wait "regedit.exe" -ArgumentList "/S `"$env:SystemRoot\Temp\125%.reg`"" -WindowStyle Hidden

# Delete reg file
Remove-Item "$env:SystemRoot\Temp\125%.reg" -Force

Clear-Host
Write-Host "Restart to apply.`n"
Write-Host "Press any key to exit..." -NoNewline
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
exit
}

3 {

Clear-Host
Write-Host "150%..." -NoNewline

# Create reg file
$regContent = @"
Windows Registry Editor Version 5.00

; Set pointer speed to default
[HKEY_CURRENT_USER\Control Panel\Mouse]
"MouseSensitivity"="10"

; Enable enhance pointer precision
[HKEY_CURRENT_USER\Control Panel\Mouse]
"MouseSpeed"="1"
"MouseThreshold1"="6"
"MouseThreshold2"="10"

[HKEY_USERS\.DEFAULT\Control Panel\Mouse]
"MouseSpeed"="1"
"MouseThreshold1"="6"
"MouseThreshold2"="10"

; Set EPP curve for 150% scaling with no acceleration
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

[HKEY_USERS\.DEFAULT\Control Panel\Mouse]
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

; Set scaling to 150%
[HKEY_CURRENT_USER\Control Panel\Desktop]
"LogPixels"=dword:00000090
"Win8DpiScaling"=dword:00000001

; Enable fix scaling for apps
[HKEY_CURRENT_USER\Control Panel\Desktop]
"EnablePerProcessSystemDPI"=dword:00000001
"@

# Save reg file
Set-Content -Path "$env:SystemRoot\Temp\150%.reg" -Value $regContent -Force

# Import reg file
Start-Process -Wait "regedit.exe" -ArgumentList "/S `"$env:SystemRoot\Temp\150%.reg`"" -WindowStyle Hidden

# Delete reg file
Remove-Item "$env:SystemRoot\Temp\150%.reg" -Force

Clear-Host
Write-Host "Restart to apply.`n"
Write-Host "Press any key to exit..." -NoNewline
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
exit
}

4 {

Clear-Host
Write-Host "175%..." -NoNewline

# Create reg file
$regContent = @"
Windows Registry Editor Version 5.00

; Set pointer speed to default
[HKEY_CURRENT_USER\Control Panel\Mouse]
"MouseSensitivity"="10"

; Enable enhance pointer precision
[HKEY_CURRENT_USER\Control Panel\Mouse]
"MouseSpeed"="1"
"MouseThreshold1"="6"
"MouseThreshold2"="10"

[HKEY_USERS\.DEFAULT\Control Panel\Mouse]
"MouseSpeed"="1"
"MouseThreshold1"="6"
"MouseThreshold2"="10"

; Set EPP curve for 175% scaling with no acceleration
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

[HKEY_USERS\.DEFAULT\Control Panel\Mouse]
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

; Set scaling to 175%
[HKEY_CURRENT_USER\Control Panel\Desktop]
"LogPixels"=dword:000000a8
"Win8DpiScaling"=dword:00000001

; Enable fix scaling for apps
[HKEY_CURRENT_USER\Control Panel\Desktop]
"EnablePerProcessSystemDPI"=dword:00000001
"@

# Save reg file
Set-Content -Path "$env:SystemRoot\Temp\175%.reg" -Value $regContent -Force

# Import reg file
Start-Process -Wait "regedit.exe" -ArgumentList "/S `"$env:SystemRoot\Temp\175%.reg`"" -WindowStyle Hidden

# Delete reg file
Remove-Item "$env:SystemRoot\Temp\175%.reg" -Force

Clear-Host
Write-Host "Restart to apply.`n"
Write-Host "Press any key to exit..." -NoNewline
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
exit
}

5 {

Clear-Host
Write-Host "200%..." -NoNewline

# Create reg file
$regContent = @"
Windows Registry Editor Version 5.00

; Set pointer speed to default
[HKEY_CURRENT_USER\Control Panel\Mouse]
"MouseSensitivity"="10"

; Enable enhance pointer precision
[HKEY_CURRENT_USER\Control Panel\Mouse]
"MouseSpeed"="1"
"MouseThreshold1"="6"
"MouseThreshold2"="10"

[HKEY_USERS\.DEFAULT\Control Panel\Mouse]
"MouseSpeed"="1"
"MouseThreshold1"="6"
"MouseThreshold2"="10"

; Set EPP curve for 200% scaling with no acceleration
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

[HKEY_USERS\.DEFAULT\Control Panel\Mouse]
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

; Set scaling to 200%
[HKEY_CURRENT_USER\Control Panel\Desktop]
"LogPixels"=dword:000000c0
"Win8DpiScaling"=dword:00000001

; Enable fix scaling for apps
[HKEY_CURRENT_USER\Control Panel\Desktop]
"EnablePerProcessSystemDPI"=dword:00000001
"@

# Save reg file
Set-Content -Path "$env:SystemRoot\Temp\200%.reg" -Value $regContent -Force

# Import reg file
Start-Process -Wait "regedit.exe" -ArgumentList "/S `"$env:SystemRoot\Temp\200%.reg`"" -WindowStyle Hidden

# Delete reg file
Remove-Item "$env:SystemRoot\Temp\200%.reg" -Force

Clear-Host
Write-Host "Restart to apply.`n"
Write-Host "Press any key to exit..." -NoNewline
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
exit
}

6 {

Clear-Host
Write-Host "225%..." -NoNewline

# Create reg file
$regContent = @"
Windows Registry Editor Version 5.00

; Set pointer speed to default
[HKEY_CURRENT_USER\Control Panel\Mouse]
"MouseSensitivity"="10"

; Enable enhance pointer precision
[HKEY_CURRENT_USER\Control Panel\Mouse]
"MouseSpeed"="1"
"MouseThreshold1"="6"
"MouseThreshold2"="10"

[HKEY_USERS\.DEFAULT\Control Panel\Mouse]
"MouseSpeed"="1"
"MouseThreshold1"="6"
"MouseThreshold2"="10"

; Set EPP curve for 225% scaling with no acceleration
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

[HKEY_USERS\.DEFAULT\Control Panel\Mouse]
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

; Set scaling to 225%
[HKEY_CURRENT_USER\Control Panel\Desktop]
"LogPixels"=dword:000000d8
"Win8DpiScaling"=dword:00000001

; Enable fix scaling for apps
[HKEY_CURRENT_USER\Control Panel\Desktop]
"EnablePerProcessSystemDPI"=dword:00000001
"@

# Save reg file
Set-Content -Path "$env:SystemRoot\Temp\225%.reg" -Value $regContent -Force

# Import reg file
Start-Process -Wait "regedit.exe" -ArgumentList "/S `"$env:SystemRoot\Temp\225%.reg`"" -WindowStyle Hidden

# Delete reg file
Remove-Item "$env:SystemRoot\Temp\225%.reg" -Force

Clear-Host
Write-Host "Restart to apply.`n"
Write-Host "Press any key to exit..." -NoNewline
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
exit
}

7 {

Clear-Host
Write-Host "Default..." -NoNewline

# Create reg file
$regContent = @"
Windows Registry Editor Version 5.00

; Set pointer speed to default
[HKEY_CURRENT_USER\Control Panel\Mouse]
"MouseSensitivity"="10"

; Disable enhance pointer precision (should not be on by default)
[HKEY_CURRENT_USER\Control Panel\Mouse]
"MouseSpeed"="0"
"MouseThreshold1"="0"
"MouseThreshold2"="0"

[HKEY_USERS\.DEFAULT\Control Panel\Mouse]
"MouseSpeed"="0"
"MouseThreshold1"="0"
"MouseThreshold2"="0"

; Set EPP curve to default
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

[HKEY_USERS\.DEFAULT\Control Panel\Mouse]
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

; Reset scaling
[HKEY_CURRENT_USER\Control Panel\Desktop]
"LogPixels"=-
"Win8DpiScaling"=-

; Reset fix scaling for apps
[HKEY_CURRENT_USER\Control Panel\Desktop]
"EnablePerProcessSystemDPI"=-
"@

# Save reg file
Set-Content -Path "$env:SystemRoot\Temp\Default.reg" -Value $regContent -Force

# Import reg file
Start-Process -Wait "regedit.exe" -ArgumentList "/S `"$env:SystemRoot\Temp\Default.reg`"" -WindowStyle Hidden

# Delete reg file
Remove-Item "$env:SystemRoot\Temp\Default.reg" -Force

Clear-Host
Write-Host "Restart to apply.`n"
Write-Host "Press any key to exit..." -NoNewline
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
exit
}

} } else { Write-Host "Invalid input.`n" -ForegroundColor Red } }
