if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
    Start-Process PowerShell.exe -ArgumentList ('-NoProfile -ExecutionPolicy Bypass -File "{0}"' -f $PSCommandPath) -Verb RunAs
    exit
}

$Host.UI.RawUI.BackgroundColor = 'Black'
$Host.UI.RawUI.ForegroundColor = 'White'
Clear-Host

Write-Host "DLSS Overlay`n"
Write-Host '1. Enable'
Write-Host "2. Disable`n"

$break = $false
do {
    $choice = ($Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')).Character

    switch ($choice) {
        1 {
            Clear-Host

            # Enable DLSS overlay
            Reg.exe add 'HKLM\SOFTWARE\NVIDIA Corporation\Global\NGXCore' /v 'ShowDlssIndicator' /t REG_DWORD /d '1024' /f *>$null

            Write-Host "Changes will take effect on next game launch.`n" -ForegroundColor Yellow
            Write-Host 'Press any key to exit...' -NoNewline
            $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
            $break = $true
        }
        2 {
            Clear-Host

            # Disable DLSS overlay
            Reg.exe delete 'HKLM\SOFTWARE\NVIDIA Corporation\Global\NGXCore' /v 'ShowDlssIndicator' /f *>$null

            Write-Host "Changes will take effect on next game launch.`n" -ForegroundColor Yellow
            Write-Host 'Press any key to exit...' -NoNewline
            $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
            $break = $true
        }
        default {
            Write-Host "Invalid option.`n" -ForegroundColor Red
        }
    }
} while (!$break)
