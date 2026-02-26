    If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator"))
    {Start-Process PowerShell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
    Exit}
    $Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + " (Administrator)"
    $Host.UI.RawUI.BackgroundColor = "Black"
	$Host.PrivateData.ProgressBackgroundColor = "Black"
    $Host.PrivateData.ProgressForegroundColor = "White"
    Clear-Host

    Write-Host "Manage User Account Control"
    Write-Host ""
    Write-Host "1. UAC: Off"
    Write-Host "2. UAC: Default"
    Write-Host ""
    while ($true) {
    $choice = Read-Host " "
    if ($choice -match '^[1-2]$') {
    switch ($choice) {
    1 {

Clear-Host
# disable uac
$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
New-Item -Path $regPath -Force | Out-Null
Set-ItemProperty -Path $regPath -Name "PromptOnSecureDesktop" -Type DWord -Value 0
Set-ItemProperty -Path $regPath -Name "EnableLUA" -Type DWord -Value 0
Set-ItemProperty -Path $regPath -Name "ConsentPromptBehaviorAdmin" -Type DWord -Value 0
Write-Host "Restart to apply..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
exit

      }
    2 {

Clear-Host
# enable uac
$regPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
New-Item -Path $regPath -Force | Out-Null
Set-ItemProperty -Path $regPath -Name "PromptOnSecureDesktop" -Type DWord -Value 1
Set-ItemProperty -Path $regPath -Name "EnableLUA" -Type DWord -Value 1
Set-ItemProperty -Path $regPath -Name "ConsentPromptBehaviorAdmin" -Type DWord -Value 5
Write-Host "Restart to apply..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
exit

      }
    } } else { Write-Host "Invalid input. Please select a valid option (1-2)." } }
