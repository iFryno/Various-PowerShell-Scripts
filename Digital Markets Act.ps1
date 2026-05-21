	# Check for administrator privileges
	if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator"))
	{Start-Process PowerShell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
	Exit}

	# Configure window settings
	$Host.UI.RawUI.WindowTitle = (Split-Path -Leaf $myInvocation.MyCommand.Definition) + " (Administrator)"
	$Host.UI.RawUI.BackgroundColor = "Black"
	$Host.PrivateData.ProgressBackgroundColor = "Black"
	$Host.PrivateData.ProgressForegroundColor = "White"
	Clear-Host

	# Show input UI
	Write-Host "EU Digital Markets Act`n"
	Write-Host "1. Enable"
	Write-Host "2. Default`n"

	while ($true) {
	$choice = Read-Host " "
	if ($choice -match '^[1-2]$') {
	switch ($choice) {
	1 {

Clear-Host

# Create reg1.exe to bypass UCPD (credit: zoicware)
Copy-Item (Get-Command reg.exe).Source .\reg1.exe -Force -EA 0

# Set device setup region to Ireland
& .\reg1.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\DeviceRegion" /v DeviceRegion /t REG_DWORD /d 68 /f *>$null

# Remove reg1.exe
Remove-Item .\reg1.exe -Force -EA 0

Write-Host "Restart to apply..."

$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

exit

	  }
	2 {

Clear-Host

# Create reg1.exe to bypass UCPD
Copy-Item (Get-Command reg.exe).Source .\reg1.exe -Force -EA 0

# Set device setup region to United States
& .\reg1.exe add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\DeviceRegion" /v DeviceRegion /t REG_DWORD /d 244 /f *>$null

# Remove reg1.exe
Remove-Item .\reg1.exe -Force -EA 0

Write-Host "Restart to apply..."

$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

exit

	  }
	} } else { Write-Host "Invalid input. Please select a valid option (1-2).`n" -ForegroundColor Red } }
