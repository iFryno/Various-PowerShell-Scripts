if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
Start-Process PowerShell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
exit
}

Write-Host "Manage Windows Updates`n"
Write-Host "1. Pause"
Write-Host "2. Disable"
Write-Host "3. Enable`n"

while ($true) {
$choice = Read-Host " "
if ($choice -match '^[1-3]$') {
switch ($choice) {

1 {

$today = (Get-Date).ToUniversalTime().ToString('yyyy-MM-ddTHH:mm:ssZ')
$pause = (Get-Date).AddDays(365).ToUniversalTime().ToString('yyyy-MM-ddTHH:mm:ssZ')

# Pause Windows updates for 1 year
Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseUpdatesStartTime" /t REG_SZ /d $today /f *>$null
Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseUpdatesExpiryTime" /t REG_SZ /d $pause /f *>$null
Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseQualityUpdatesEndTime" /t REG_SZ /d $pause /f *>$null
Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseFeatureUpdatesEndTime" /t REG_SZ /d $pause /f *>$null
Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseFeatureUpdatesStartTime" /t REG_SZ /d $today /f *>$null
Reg.exe add "HKLM\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" /v "PauseQualityUpdatesStartTime" /t REG_SZ /d $today /f *>$null

# Open Windows Update page
Start-Process ms-settings:windowsupdate

exit
}

2 {

Clear-Host
Write-Host "Disabling..." -NoNewline

# Disable Windows updates
Reg.exe add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' /v 'WUServer' /t REG_SZ /d 'https://blocked.invalid/' /f *>$null
Reg.exe add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' /v 'WUStatusServer' /t REG_SZ /d 'https://blocked.invalid/' /f *>$null
Reg.exe add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' /v 'UpdateServiceUrlAlternate' /t REG_SZ /d 'https://blocked.invalid/' /f *>$null
Reg.exe add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' /v 'SetProxyBehaviorForUpdateDetection' /t REG_DWORD /d '0' /f *>$null
Reg.exe add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' /v 'SetDisableUXWUAccess' /t REG_DWORD /d '1' /f *>$null
Reg.exe add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' /v 'DoNotConnectToWindowsUpdateInternetLocations' /t REG_DWORD /d '1' /f *>$null
Reg.exe add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' /v 'ExcludeWUDriversInQualityUpdate' /t REG_DWORD /d '1' /f *>$null
Reg.exe add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU' /v 'NoAutoUpdate' /t REG_DWORD /d '1' /f *>$null
Reg.exe add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU' /v 'UseWUServer' /t REG_DWORD /d '1' /f *>$null
Reg.exe add 'HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc' /v 'Start' /t REG_DWORD /d '4' /f *>$null
Reg.exe add 'HKU\S-1-5-20\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings' /v 'DownloadMode' /t REG_DWORD /d '0' /f *>$null

# Disable Windows Update scheduled task
Disable-ScheduledTask -TaskName 'Microsoft\Windows\WindowsUpdate\Scheduled Start' -ErrorAction SilentlyContinue | Out-Null

Clear-Host
Write-Host "Restart to apply.`n"
Write-Host "Press any key to exit..." -NoNewline
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
exit
}

3 {

Clear-Host
Write-Host "Enabling..." -NoNewline

# Enable Windows updates
Reg.exe delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' /v 'WUServer' /f *>$null
Reg.exe delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' /v 'WUStatusServer' /f *>$null
Reg.exe delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' /v 'UpdateServiceUrlAlternate' /f *>$null
Reg.exe delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' /v 'SetProxyBehaviorForUpdateDetection' /f *>$null
Reg.exe delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' /v 'SetDisableUXWUAccess' /f *>$null
Reg.exe delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' /v 'DoNotConnectToWindowsUpdateInternetLocations' /f *>$null
Reg.exe delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' /v 'ExcludeWUDriversInQualityUpdate' /f *>$null
Reg.exe delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU' /v 'NoAutoUpdate' /f *>$null
Reg.exe delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU' /v 'UseWUServer' /f *>$null
Reg.exe add 'HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc' /v 'Start' /t REG_DWORD /d '2' /f *>$null
Reg.exe delete 'HKU\S-1-5-20\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings' /v 'DownloadMode' /f *>$null

# Enable Windows Update scheduled task
Enable-ScheduledTask -TaskName 'Microsoft\Windows\WindowsUpdate\Scheduled Start' -ErrorAction SilentlyContinue | Out-Null

Clear-Host
Write-Host "Restart to apply.`n"
Write-Host "Press any key to exit..." -NoNewline
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
exit
}

} } else { Write-Host "Invalid input.`n" -ForegroundColor Red } }
