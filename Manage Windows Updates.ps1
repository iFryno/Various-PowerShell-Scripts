    If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator"))
    {Start-Process PowerShell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
    Exit}
    $Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + " (Administrator)"
    $Host.UI.RawUI.BackgroundColor = "Black"
	$Host.PrivateData.ProgressBackgroundColor = "Black"
    $Host.PrivateData.ProgressForegroundColor = "White"
    Clear-Host

    Write-Host "Manage Automatic Windows Updates"
    Write-Host ""
    Write-Host "1. Pause"
    Write-Host "2. Disable"
    Write-Host "3. Default"
    Write-Host ""
    while ($true) {
    $choice = Read-Host " "
    if ($choice -match '^[1-3]$') {
    switch ($choice) {
    1 {

Clear-Host
# pause updates
$pause = (Get-Date).AddDays(365)
$today = Get-Date
$today = $today.ToUniversalTime().ToString( 'yyyy-MM-ddTHH:mm:ssZ' )
$pause = $pause.ToUniversalTime().ToString( 'yyyy-MM-ddTHH:mm:ssZ' )
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings' -Name 'PauseUpdatesExpiryTime' -Value $pause -Force >$null
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings' -Name 'PauseFeatureUpdatesEndTime' -Value $pause -Force >$null
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings' -Name 'PauseFeatureUpdatesStartTime' -Value $today -Force >$null
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings' -Name 'PauseQualityUpdatesEndTime' -Value $pause -Force >$null
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings' -Name 'PauseQualityUpdatesStartTime' -Value $today -Force >$null
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings' -Name 'PauseUpdatesStartTime' -Value $today -Force >$null
# open settings
Start-Process ms-settings:windowsupdate
exit

      }
    2 {

Clear-Host
Write-Host "Disabling Updates. Please wait..."
# disable updates
Reg.exe add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' /v 'WUServer' /t REG_SZ /d 'https://blocked.invalid/' /f *> $null
Reg.exe add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' /v 'WUStatusServer' /t REG_SZ /d 'https://blocked.invalid/' /f *> $null
Reg.exe add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' /v 'UpdateServiceUrlAlternate' /t REG_SZ /d 'https://blocked.invalid/' /f *> $null
Reg.exe add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' /v 'SetProxyBehaviorForUpdateDetection' /t REG_DWORD /d '0' /f *> $null
Reg.exe add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' /v 'SetDisableUXWUAccess' /t REG_DWORD /d '1' /f *> $null
Reg.exe add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' /v 'DoNotConnectToWindowsUpdateInternetLocations' /t REG_DWORD /d '1' /f *> $null
Reg.exe add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' /v 'ExcludeWUDriversInQualityUpdate' /t REG_DWORD /d '1' /f *> $null
Reg.exe add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU' /v 'NoAutoUpdate' /t REG_DWORD /d '1' /f *> $null
Reg.exe add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU' /v 'UseWUServer' /t REG_DWORD /d '1' /f *> $null
Reg.exe add 'HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc' /v 'Start' /t REG_DWORD /d '4' /f  *> $null
Reg.exe add 'HKU\S-1-5-20\Software\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Settings' /v 'DownloadMode' /t REG_DWORD /d '0' /f *> $null
Disable-ScheduledTask -TaskName 'Microsoft\Windows\WindowsUpdate\Scheduled Start' -ErrorAction SilentlyContinue | Out-Null
Clear-Host
Write-Host "Restart to apply..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
exit

      }
    3 {

Clear-Host
Write-Host "Enabling Updates. Please wait..."
# enable updates
Reg.exe delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' /v 'WUServer' /f *> $null
Reg.exe delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' /v 'WUStatusServer' /f *> $null
Reg.exe delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' /v 'UpdateServiceUrlAlternate' /f *> $null
Reg.exe delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' /v 'SetProxyBehaviorForUpdateDetection' /f *> $null
Reg.exe delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' /v 'SetDisableUXWUAccess' /f *> $null
Reg.exe delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' /v 'DoNotConnectToWindowsUpdateInternetLocations' /f *> $null
Reg.exe delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate' /v 'ExcludeWUDriversInQualityUpdate' /f *> $null
Reg.exe delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU' /v 'NoAutoUpdate' /f *> $null
Reg.exe delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU' /v 'UseWUServer' /f *> $null
Reg.exe add 'HKLM\SYSTEM\CurrentControlSet\Services\UsoSvc' /v 'Start' /t REG_DWORD /d '2' /f *> $null
Enable-ScheduledTask -TaskName 'Microsoft\Windows\WindowsUpdate\Scheduled Start' -ErrorAction SilentlyContinue | Out-Null
gpupdate /force *> $null
# unpause updates
Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings' -Name 'PauseUpdatesExpiryTime' -ErrorAction SilentlyContinue
Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings' -Name 'PauseFeatureUpdatesEndTime' -ErrorAction SilentlyContinue
Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings' -Name 'PauseFeatureUpdatesStartTime' -ErrorAction SilentlyContinue
Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings' -Name 'PauseQualityUpdatesEndTime' -ErrorAction SilentlyContinue
Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings' -Name 'PauseQualityUpdatesStartTime' -ErrorAction SilentlyContinue
Remove-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings' -Name 'PauseUpdatesStartTime' -ErrorAction SilentlyContinue
Clear-Host
Write-Host "Restart to apply..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
exit

      }
    } } else { Write-Host "Invalid input. Please select a valid option (1-3)." } }
