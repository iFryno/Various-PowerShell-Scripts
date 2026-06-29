if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
Start-Process PowerShell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
exit
}

function Get-State($v) {
if ($v -eq 100) { return "unparked" }
else { return "parked" }
}

function Show-Status {
$raw = powercfg /query SCHEME_CURRENT SUB_PROCESSOR CPMINCORES

$acHex = ($raw | Select-String "AC Power Setting Index").ToString().Split(':')[1].Trim()
$dcHex = ($raw | Select-String "DC Power Setting Index").ToString().Split(':')[1].Trim()

$ac = [int]$acHex
$dc = [int]$dcHex

Write-Host "Core Parking Status`n"
Write-Host "AC (plugged in): $ac% - $(Get-State $ac)"
Write-Host "DC (on battery): $dc% - $(Get-State $dc)"
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

} } else { Write-Host "Invalid input.`n" -ForegroundColor Red } }
