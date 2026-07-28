if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
    Start-Process PowerShell.exe -ArgumentList ('-NoProfile -ExecutionPolicy Bypass -File "{0}"' -f $PSCommandPath) -Verb RunAs
    exit
}

$Host.UI.RawUI.BackgroundColor = 'Black'
$Host.UI.RawUI.ForegroundColor = 'White'
Clear-Host

Write-Host "Browser Policies`n"
Write-Host '1. Edge'
Write-Host '2. Brave'
Write-Host '3. Chrome'
Write-Host "4. Remove`n"

$break = $false
do {
    $choice = ($Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')).Character

    switch ($choice) {
        1 {
            Clear-Host

            # Add policies to Edge
            Reg.exe add 'HKLM\SOFTWARE\Policies\Microsoft\Edge' /v 'StartupBoostEnabled' /t REG_DWORD /d '0' /f *>$null
            Reg.exe add 'HKLM\SOFTWARE\Policies\Microsoft\Edge' /v 'BackgroundModeEnabled' /t REG_DWORD /d '0' /f *>$null
            Reg.exe add 'HKLM\SOFTWARE\Policies\Microsoft\Edge' /v 'HardwareAccelerationModeEnabled' /t REG_DWORD /d '0' /f *>$null
            Reg.exe add 'HKLM\SOFTWARE\Policies\Microsoft\Edge' /v 'GenAILocalFoundationalModelSettings' /t REG_DWORD /d '1' /f *>$null

            Write-Host "Restart Edge to apply.`n" -ForegroundColor Yellow
            Write-Host 'Press any key to exit...' -NoNewline
            $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
            $break = $true
        }
        2 {
            Clear-Host

            # Add policies to Brave
            Reg.exe add 'HKLM\SOFTWARE\Policies\BraveSoftware\Brave' /v 'BackgroundModeEnabled' /t REG_DWORD /d '0' /f *>$null
            Reg.exe add 'HKLM\SOFTWARE\Policies\BraveSoftware\Brave' /v 'HighEfficiencyModeEnabled' /t REG_DWORD /d '1' /f *>$null
            Reg.exe add 'HKLM\SOFTWARE\Policies\BraveSoftware\Brave' /v 'HardwareAccelerationModeEnabled' /t REG_DWORD /d '0' /f *>$null

            Write-Host "Restart Brave to apply.`n" -ForegroundColor Yellow
            Write-Host 'Press any key to exit...' -NoNewline
            $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
            $break = $true
        }
        3 {
            Clear-Host

            # Add policies to Chrome
            Reg.exe add 'HKLM\SOFTWARE\Policies\Google\Chrome' /v 'BackgroundModeEnabled' /t REG_DWORD /d '0' /f *>$null
            Reg.exe add 'HKLM\SOFTWARE\Policies\Google\Chrome' /v 'HighEfficiencyModeEnabled' /t REG_DWORD /d '1' /f *>$null
            Reg.exe add 'HKLM\SOFTWARE\Policies\Google\Chrome' /v 'HardwareAccelerationModeEnabled' /t REG_DWORD /d '0' /f *>$null
            Reg.exe add 'HKLM\SOFTWARE\Policies\Google\Chrome' /v 'GenAILocalFoundationalModelSettings' /t REG_DWORD /d '1' /f *>$null

            Write-Host "Restart Chrome to apply.`n" -ForegroundColor Yellow
            Write-Host 'Press any key to exit...' -NoNewline
            $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
            $break = $true
        }
        4 {
            Clear-Host

            # Remove policies from Edge, Brave and Chrome
            Reg.exe delete 'HKLM\SOFTWARE\Policies\Google\Chrome' /f *>$null
            Reg.exe delete 'HKLM\SOFTWARE\Policies\Microsoft\Edge' /f *>$null
            Reg.exe delete 'HKLM\SOFTWARE\Policies\BraveSoftware\Brave' /f *>$null

            Write-Host "Restart your browser to apply.`n" -ForegroundColor Yellow
            Write-Host 'Press any key to exit...' -NoNewline
            $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
            $break = $true
        }
        default {
            Write-Host "Invalid option.`n" -ForegroundColor Red
        }
    }
} while (!$break)
