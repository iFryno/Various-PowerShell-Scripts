	if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator"))
	{Start-Process PowerShell.exe -ArgumentList ("-NoProfile -ExecutionPolicy Bypass -File `"{0}`"" -f $PSCommandPath) -Verb RunAs
	exit}

	$Host.UI.RawUI.WindowTitle = "Administrator: " + (Split-Path -Leaf $myInvocation.MyCommand.Definition)
	$Host.UI.RawUI.BackgroundColor = "Black"
	$Host.PrivateData.ProgressBackgroundColor = "Black"
	$Host.PrivateData.ProgressForegroundColor = "White"
	Clear-Host

	Write-Host "Installation Media (USB Boot Drive) needs to be plugged in! Press Enter to continue..." -ForegroundColor Red
	do { $key = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") } while ($key.VirtualKeyCode -ne 13)

	Clear-Host

	$usbDrive = Read-Host -Prompt "Enter USB Drive Letter"
	$usbDrive = $usbDrive.TrimEnd(":")
	$sourcePath = "$usbDrive`:\sources\sxs"

	Clear-Host

	If (-Not (Test-Path $sourcePath)) {
		Write-Host "Error: Path $sourcePath does not exist. Make sure the USB drive is correct and contains sources\sxs folder." -ForegroundColor Red
		$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
		Exit
	}

	# Install NetFx3
	Write-Host "Installing NetFx3..."
	dism /online /enable-feature /featurename:NetFx3 /all /source:$sourcePath /limitaccess | Out-Null

	# Open optional features
	Start-Process "$env:SystemDrive\Windows\system32\optionalfeatures.exe"

	Exit