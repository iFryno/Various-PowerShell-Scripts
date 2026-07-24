if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
    Start-Process PowerShell.exe -ArgumentList ('-NoProfile -ExecutionPolicy Bypass -File "{0}"' -f $PSCommandPath) -Verb RunAs
    exit
}

$Host.UI.RawUI.BackgroundColor = 'Black'
$Host.UI.RawUI.ForegroundColor = 'White'
Clear-Host

Write-Host "User Account Control`n"
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
            # Disable User Account Control
            Reg.exe add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' /v 'EnableLUA' /t REG_DWORD /d '0' /f *>$null
            Reg.exe add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' /v 'PromptOnSecureDesktop' /t REG_DWORD /d '0' /f *>$null
            Reg.exe add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' /v 'ConsentPromptBehaviorAdmin' /t REG_DWORD /d '0' /f *>$null

            Clear-Host
            Write-Host "Restart to apply.`n" -ForegroundColor Yellow
            Write-Host 'Press any key to exit...' -NoNewline
            $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
            exit
        }
        2 {
            # Enable User Account Control
            Reg.exe add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' /v 'EnableLUA' /t REG_DWORD /d '1' /f *>$null
            Reg.exe add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' /v 'PromptOnSecureDesktop' /t REG_DWORD /d '1' /f *>$null
            Reg.exe add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' /v 'ConsentPromptBehaviorAdmin' /t REG_DWORD /d '5' /f *>$null

            Clear-Host
            Write-Host "Restart to apply.`n" -ForegroundColor Yellow
            Write-Host 'Press any key to exit...' -NoNewline
            $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
            exit
        }
    }
}
