    If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator"))
    {Start-Process PowerShell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
    Exit}
    $Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + " (Administrator)"
    $Host.UI.RawUI.BackgroundColor = "Black"
	$Host.PrivateData.ProgressBackgroundColor = "Black"
    $Host.PrivateData.ProgressForegroundColor = "White"
    Clear-Host

    Write-Host "EU Digital Markets Act (DMA)"
    Write-Host ""
    Write-Host "1. DMA: On"
    Write-Host "2. DMA: Default"
    while ($true) {
    $choice = Read-Host " "
    if ($choice -match '^[1-2]$') {
    switch ($choice) {
    1 {

Clear-Host
Copy-Item (Get-Command reg.exe).Source .\reg1.exe -Force -EA 0
& .\reg1.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\DeviceRegion" /v DeviceRegion /t REG_DWORD /d 68 /f | Out-Null
Remove-Item .\reg1.exe -Force -EA 0
Write-Host "Restart to apply..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
exit

      }
    2 {

Clear-Host
Copy-Item (Get-Command reg.exe).Source .\reg1.exe -Force -EA 0
& .\reg1.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\DeviceRegion" /v DeviceRegion /t REG_DWORD /d 244 /f | Out-Null
Remove-Item .\reg1.exe -Force -EA 0
Write-Host "Restart to apply..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
exit

      }
    } } else { Write-Host "Invalid input. Please select a valid option (1-2)." } }