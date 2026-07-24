if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
    Start-Process PowerShell.exe -ArgumentList ('-NoProfile -ExecutionPolicy Bypass -File "{0}"' -f $PSCommandPath) -Verb RunAs
    exit
}

$Host.UI.RawUI.BackgroundColor = 'Black'
$Host.UI.RawUI.ForegroundColor = 'White'
Clear-Host

Write-Host "Open File Security Warning`n"
Write-Host '1. Disable'
Write-Host "2. Enable`n"

while ($true) {
    $choice = Read-Host ' '

    if ($choice -notmatch '^[1-2]$') {
        Write-Host "Invalid option.`n" -ForegroundColor Red
        continue
    }

    switch ($choice) {
        1 {
            # Disable open file security warning
            Reg.exe add 'HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3' /v '1806' /t REG_DWORD /d '0' /f *>$null
            Reg.exe add 'HKLM\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3' /v '1806' /t REG_DWORD /d '0' /f *>$null
            Reg.exe add 'HKLM\SOFTWARE\Policies\Microsoft\Internet Explorer\Security' /v 'DisableSecuritySettingsCheck' /t REG_DWORD /d '1' /f *>$null

            Clear-Host
            Write-Host "Restart to apply.`n" -ForegroundColor Yellow
            Write-Host 'Press any key to exit...' -NoNewline
            $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
            exit
        }
        2 {
            # Enable open file security warning
            Reg.exe delete 'HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3' /v '1806' /f *>$null
            Reg.exe delete 'HKLM\SOFTWARE\Policies\Microsoft\Internet Explorer\Security' /v 'DisableSecuritySettingsCheck' /f *>$null
            Reg.exe add 'HKLM\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\3' /v '1806' /t REG_DWORD /d '1' /f *>$null

            Clear-Host
            Write-Host "Restart to apply.`n" -ForegroundColor Yellow
            Write-Host 'Press any key to exit...' -NoNewline
            $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
            exit
        }
    }
}
