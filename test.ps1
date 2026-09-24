if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
    Start-Process PowerShell.exe -ArgumentList ('-NoProfile -ExecutionPolicy Bypass -File "{0}"' -f $PSCommandPath) -Verb RunAs
    exit
}

$Host.UI.RawUI.BackgroundColor = 'Black'
$Host.UI.RawUI.ForegroundColor = 'White'
Clear-Host

Write-Host "Digital Markets Act`n"
Write-Host '1. Enable'
Write-Host "2. Disable`n"

$break = $false
do {
    $choice = ($Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')).Character

    switch ($choice) {
        1 {
            Clear-Host

            # Create reg1.exe to bypass UCPD (credit: zoicware)
            Copy-Item (Get-Command reg.exe).Source .\reg1.exe -Force -EA 0

            # Set device setup region to Ireland
            & .\reg1.exe add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\DeviceRegion' /v 'DeviceRegion' /t REG_DWORD /d '68' /f *>$null

            # Remove reg1.exe
            Remove-Item .\reg1.exe -Force -EA 0

            Write-Host "Restart to apply.`n" -ForegroundColor Yellow
            Write-Host 'Press any key to exit...' -NoNewline
            $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
            $break = $true
        }
        2 {
            Clear-Host

            # Get original device setup region
            $Nation = Get-ItemPropertyValue -Path 'Registry::HKEY_USERS\.DEFAULT\Control Panel\International\Geo' -Name 'Nation'

            # Create reg1.exe to bypass UCPD
            Copy-Item (Get-Command reg.exe).Source .\reg1.exe -Force -EA 0

            # Set device setup region back to original
            & .\reg1.exe add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Control Panel\DeviceRegion' /v 'DeviceRegion' /t REG_DWORD /d $Nation /f *>$null

            # Remove reg1.exe
            Remove-Item .\reg1.exe -Force -EA 0

            Write-Host "Restart to apply.`n" -ForegroundColor Yellow
            Write-Host 'Press any key to exit...' -NoNewline
            $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
            $break = $true
        }
        default {
            Write-Host "Invalid option.`n" -ForegroundColor Red
        }
    }
} while (!$break)
