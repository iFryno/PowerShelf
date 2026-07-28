if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
    Start-Process PowerShell.exe -ArgumentList ('-NoProfile -ExecutionPolicy Bypass -File "{0}"' -f $PSCommandPath) -Verb RunAs
    exit
}

$Host.UI.RawUI.BackgroundColor = 'Black'
$Host.UI.RawUI.ForegroundColor = 'White'
Clear-Host

Write-Host "Start Menu Version`n"
Write-Host '1. 25H2'
Write-Host "2. 24H2`n"

$break = $false
do {
    $choice = ($Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')).Character

    switch ($choice) {
        1 {
            Clear-Host

            # Set Start Menu version to 25H2
            Reg.exe add 'HKLM\SYSTEM\ControlSet001\Control\FeatureManagement\Overrides\14\2792562829' /v 'EnabledState' /t REG_DWORD /d '2' /f *>$null
            Reg.exe add 'HKLM\SYSTEM\ControlSet001\Control\FeatureManagement\Overrides\14\3036241548' /v 'EnabledState' /t REG_DWORD /d '2' /f *>$null
            Reg.exe add 'HKLM\SYSTEM\ControlSet001\Control\FeatureManagement\Overrides\14\734731404' /v 'EnabledState' /t REG_DWORD /d '2' /f *>$null
            Reg.exe add 'HKLM\SYSTEM\ControlSet001\Control\FeatureManagement\Overrides\14\762256525' /v 'EnabledState' /t REG_DWORD /d '2' /f *>$null

            # Set Start Menu apps view to list
            Reg.exe add 'HKCU\Software\Microsoft\Windows\CurrentVersion\Start' /v 'AllAppsViewMode' /t REG_DWORD /d '2' /f *>$null

            Write-Host "Restart to apply.`n" -ForegroundColor Yellow
            Write-Host 'Press any key to exit...' -NoNewline
            $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
            $break = $true
        }
        2 {
            Clear-Host

            # Set Start Menu version to 24H2
            Reg.exe add 'HKLM\SYSTEM\ControlSet001\Control\FeatureManagement\Overrides\14\2792562829' /v 'EnabledState' /t REG_DWORD /d '0' /f *>$null
            Reg.exe add 'HKLM\SYSTEM\ControlSet001\Control\FeatureManagement\Overrides\14\3036241548' /v 'EnabledState' /t REG_DWORD /d '0' /f *>$null
            Reg.exe add 'HKLM\SYSTEM\ControlSet001\Control\FeatureManagement\Overrides\14\734731404' /v 'EnabledState' /t REG_DWORD /d '0' /f *>$null
            Reg.exe add 'HKLM\SYSTEM\ControlSet001\Control\FeatureManagement\Overrides\14\762256525' /v 'EnabledState' /t REG_DWORD /d '0' /f *>$null

            # Reset Start Menu apps view
            Reg.exe delete 'HKCU\Software\Microsoft\Windows\CurrentVersion\Start' /v 'AllAppsViewMode' /f *>$null

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
