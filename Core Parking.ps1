if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
Start-Process PowerShell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
exit
}

$Host.UI.RawUI.BackgroundColor = "Black"
$Host.UI.RawUI.ForegroundColor = "White"
Clear-Host

function Get-State($v) {
if ($v -eq 100) { return "unparked" }
else { return "parked" }
}

function Get-CPMinCoresValue($isAC) {
$acdc = if ($isAC) { "ACSettingIndex" } else { "DCSettingIndex" }
$activeScheme = (Get-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power\User\PowerSchemes" -Name "ActivePowerScheme").ActivePowerScheme
$path = "HKLM:\SYSTEM\CurrentControlSet\Control\Power\User\PowerSchemes\$activeScheme\54533251-82be-4824-96c1-47b60b740d00\0cc5b647-c1df-4637-891a-dec35c318583"
(Get-ItemProperty -Path $path -Name $acdc).$acdc
}

function Show-Status {
$ac = Get-CPMinCoresValue $true
$dc = Get-CPMinCoresValue $false

Write-Host "Core Parking Status`n"
Write-Host "AC (plugged in): $(Get-State $ac)"
Write-Host "DC (on battery): $(Get-State $dc)"
}

Write-Host "Core Parking`n"
Write-Host "1. Disable"
Write-Host "2. Enable`n"

while ($true) {
$choice = Read-Host " "
if ($choice -match '^[1-2]$') {
switch ($choice) {

1 {

Clear-Host

# Unhide processor performance core parking min cores
powercfg /attributes SUB_PROCESSOR CPMINCORES -ATTRIB_HIDE

# Unpark CPU cores
powercfg /setacvalueindex SCHEME_CURRENT SUB_PROCESSOR CPMINCORES 100
powercfg /setdcvalueindex SCHEME_CURRENT SUB_PROCESSOR CPMINCORES 100

# Apply changes
powercfg /setactive SCHEME_CURRENT

Show-Status

Write-Host "`nPress any key to exit..." -NoNewline
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
exit
}

2 {

Clear-Host

# Unhide processor performance core parking min cores
powercfg /attributes SUB_PROCESSOR CPMINCORES -ATTRIB_HIDE

# Park CPU cores
powercfg /setacvalueindex SCHEME_CURRENT SUB_PROCESSOR CPMINCORES 10
powercfg /setdcvalueindex SCHEME_CURRENT SUB_PROCESSOR CPMINCORES 10

# Apply changes
powercfg /setactive SCHEME_CURRENT

Show-Status

Write-Host "`nPress any key to exit..." -NoNewline
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
exit
}

} } else { Write-Host "Invalid option.`n" -ForegroundColor Red } }
