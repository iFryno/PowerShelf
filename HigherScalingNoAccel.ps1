if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
    Start-Process PowerShell.exe -ArgumentList ('-NoProfile -ExecutionPolicy Bypass -File "{0}"' -f $PSCommandPath) -Verb RunAs
    exit
}

$Host.UI.RawUI.BackgroundColor = 'Black'
$Host.UI.RawUI.ForegroundColor = 'White'
Clear-Host

Write-Host "Higher Scaling No Accel`n"
Write-Host '1. 100%'
Write-Host '2. 125%'
Write-Host '3. 150%'
Write-Host '4. 175%'
Write-Host '5. 200%'
Write-Host '6. 225%'
Write-Host "7. Default`n"

$break = $false
do {
    $choice = ($Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')).Character

    switch ($choice) {
        1 {
            Clear-Host
            Write-Host '100%...' -NoNewline

            $regContent = (@'
            Windows Registry Editor Version 5.00

            ; Set pointer speed to 6/11
            [HKEY_CURRENT_USER\Control Panel\Mouse]
            "MouseSensitivity"="10"

            [HKEY_USERS\.DEFAULT\Control Panel\Mouse]
            "MouseSensitivity"="10"

            ; Disable enhance pointer precision
            [HKEY_CURRENT_USER\Control Panel\Mouse]
            "MouseSpeed"="0"
            "MouseThreshold1"="0"
            "MouseThreshold2"="0"

            [HKEY_USERS\.DEFAULT\Control Panel\Mouse]
            "MouseSpeed"="0"
            "MouseThreshold1"="0"
            "MouseThreshold2"="0"

            ; Set EPP curve for 100% scaling with no acceleration (credit: MarkC)
            [HKEY_CURRENT_USER\Control Panel\Mouse]
            "SmoothMouseXCurve"=hex:\
            00,00,00,00,00,00,00,00,\
            c0,cc,0c,00,00,00,00,00,\
            80,99,19,00,00,00,00,00,\
            40,66,26,00,00,00,00,00,\
            00,33,33,00,00,00,00,00
            "SmoothMouseYCurve"=hex:\
            00,00,00,00,00,00,00,00,\
            00,00,38,00,00,00,00,00,\
            00,00,70,00,00,00,00,00,\
            00,00,a8,00,00,00,00,00,\
            00,00,e0,00,00,00,00,00

            [HKEY_USERS\.DEFAULT\Control Panel\Mouse]
            "SmoothMouseXCurve"=hex:\
            00,00,00,00,00,00,00,00,\
            c0,cc,0c,00,00,00,00,00,\
            80,99,19,00,00,00,00,00,\
            40,66,26,00,00,00,00,00,\
            00,33,33,00,00,00,00,00
            "SmoothMouseYCurve"=hex:\
            00,00,00,00,00,00,00,00,\
            00,00,38,00,00,00,00,00,\
            00,00,70,00,00,00,00,00,\
            00,00,a8,00,00,00,00,00,\
            00,00,e0,00,00,00,00,00

            ; Set scaling to 100%
            [HKEY_CURRENT_USER\Control Panel\Desktop]
            "LogPixels"=dword:00000060
            "Win8DpiScaling"=dword:00000001

            [HKEY_CURRENT_USER\Control Panel\Desktop\WindowMetrics]
            "AppliedDPI"=dword:00000060

            ; Disable fix scaling for apps
            [HKEY_CURRENT_USER\Control Panel\Desktop]
            "EnablePerProcessSystemDPI"=dword:00000000
'@ -replace '(?m)^ {12}')

            $regPath = Join-Path $env:SystemRoot 'Temp\100%.reg'
            Set-Content -Path $regPath -Value $regContent -Force
            Start-Process -Wait 'regedit.exe' -ArgumentList "/S $regPath" -WindowStyle Hidden
            Remove-Item $regPath -Force

            Clear-Host
            Write-Host "Restart to apply.`n" -ForegroundColor Yellow
            Write-Host 'Press any key to exit...' -NoNewline
            $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
            $break = $true
        }
        2 {
            Clear-Host
            Write-Host '125%...' -NoNewline

            $regContent = (@'
            Windows Registry Editor Version 5.00

            ; Set pointer speed to 6/11
            [HKEY_CURRENT_USER\Control Panel\Mouse]
            "MouseSensitivity"="10"

            [HKEY_USERS\.DEFAULT\Control Panel\Mouse]
            "MouseSensitivity"="10"

            ; Enable enhance pointer precision
            [HKEY_CURRENT_USER\Control Panel\Mouse]
            "MouseSpeed"="1"
            "MouseThreshold1"="6"
            "MouseThreshold2"="10"

            [HKEY_USERS\.DEFAULT\Control Panel\Mouse]
            "MouseSpeed"="1"
            "MouseThreshold1"="6"
            "MouseThreshold2"="10"

            ; Set EPP curve for 125% scaling with no acceleration
            [HKEY_CURRENT_USER\Control Panel\Mouse]
            "SmoothMouseXCurve"=hex:\
            00,00,00,00,00,00,00,00,\
            00,00,10,00,00,00,00,00,\
            00,00,20,00,00,00,00,00,\
            00,00,30,00,00,00,00,00,\
            00,00,40,00,00,00,00,00
            "SmoothMouseYCurve"=hex:\
            00,00,00,00,00,00,00,00,\
            00,00,38,00,00,00,00,00,\
            00,00,70,00,00,00,00,00,\
            00,00,a8,00,00,00,00,00,\
            00,00,e0,00,00,00,00,00

            [HKEY_USERS\.DEFAULT\Control Panel\Mouse]
            "SmoothMouseXCurve"=hex:\
            00,00,00,00,00,00,00,00,\
            00,00,10,00,00,00,00,00,\
            00,00,20,00,00,00,00,00,\
            00,00,30,00,00,00,00,00,\
            00,00,40,00,00,00,00,00
            "SmoothMouseYCurve"=hex:\
            00,00,00,00,00,00,00,00,\
            00,00,38,00,00,00,00,00,\
            00,00,70,00,00,00,00,00,\
            00,00,a8,00,00,00,00,00,\
            00,00,e0,00,00,00,00,00

            ; Set scaling to 125%
            [HKEY_CURRENT_USER\Control Panel\Desktop]
            "LogPixels"=dword:00000078
            "Win8DpiScaling"=dword:00000001

            [HKEY_CURRENT_USER\Control Panel\Desktop\WindowMetrics]
            "AppliedDPI"=dword:00000078

            ; Enable fix scaling for apps
            [HKEY_CURRENT_USER\Control Panel\Desktop]
            "EnablePerProcessSystemDPI"=dword:00000001
'@ -replace '(?m)^ {12}')

            $regPath = Join-Path $env:SystemRoot 'Temp\125%.reg'
            Set-Content -Path $regPath -Value $regContent -Force
            Start-Process -Wait 'regedit.exe' -ArgumentList "/S $regPath" -WindowStyle Hidden
            Remove-Item $regPath -Force

            Clear-Host
            Write-Host "Restart to apply.`n" -ForegroundColor Yellow
            Write-Host 'Press any key to exit...' -NoNewline
            $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
            $break = $true
        }
        3 {
            Clear-Host
            Write-Host '150%...' -NoNewline

            $regContent = (@'
            Windows Registry Editor Version 5.00

            ; Set pointer speed to 6/11
            [HKEY_CURRENT_USER\Control Panel\Mouse]
            "MouseSensitivity"="10"

            [HKEY_USERS\.DEFAULT\Control Panel\Mouse]
            "MouseSensitivity"="10"

            ; Enable enhance pointer precision
            [HKEY_CURRENT_USER\Control Panel\Mouse]
            "MouseSpeed"="1"
            "MouseThreshold1"="6"
            "MouseThreshold2"="10"

            [HKEY_USERS\.DEFAULT\Control Panel\Mouse]
            "MouseSpeed"="1"
            "MouseThreshold1"="6"
            "MouseThreshold2"="10"

            ; Set EPP curve for 150% scaling with no acceleration
            [HKEY_CURRENT_USER\Control Panel\Mouse]
            "SmoothMouseXCurve"=hex:\
            00,00,00,00,00,00,00,00,\
            30,33,13,00,00,00,00,00,\
            60,66,26,00,00,00,00,00,\
            90,99,39,00,00,00,00,00,\
            c0,cc,4c,00,00,00,00,00
            "SmoothMouseYCurve"=hex:\
            00,00,00,00,00,00,00,00,\
            00,00,38,00,00,00,00,00,\
            00,00,70,00,00,00,00,00,\
            00,00,a8,00,00,00,00,00,\
            00,00,e0,00,00,00,00,00

            [HKEY_USERS\.DEFAULT\Control Panel\Mouse]
            "SmoothMouseXCurve"=hex:\
            00,00,00,00,00,00,00,00,\
            30,33,13,00,00,00,00,00,\
            60,66,26,00,00,00,00,00,\
            90,99,39,00,00,00,00,00,\
            c0,cc,4c,00,00,00,00,00
            "SmoothMouseYCurve"=hex:\
            00,00,00,00,00,00,00,00,\
            00,00,38,00,00,00,00,00,\
            00,00,70,00,00,00,00,00,\
            00,00,a8,00,00,00,00,00,\
            00,00,e0,00,00,00,00,00

            ; Set scaling to 150%
            [HKEY_CURRENT_USER\Control Panel\Desktop]
            "LogPixels"=dword:00000090
            "Win8DpiScaling"=dword:00000001

            [HKEY_CURRENT_USER\Control Panel\Desktop\WindowMetrics]
            "AppliedDPI"=dword:00000090

            ; Enable fix scaling for apps
            [HKEY_CURRENT_USER\Control Panel\Desktop]
            "EnablePerProcessSystemDPI"=dword:00000001
'@ -replace '(?m)^ {12}')

            $regPath = Join-Path $env:SystemRoot 'Temp\150%.reg'
            Set-Content -Path $regPath -Value $regContent -Force
            Start-Process -Wait 'regedit.exe' -ArgumentList "/S $regPath" -WindowStyle Hidden
            Remove-Item $regPath -Force

            Clear-Host
            Write-Host "Restart to apply.`n" -ForegroundColor Yellow
            Write-Host 'Press any key to exit...' -NoNewline
            $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
            $break = $true
        }
        4 {
            Clear-Host
            Write-Host '175%...' -NoNewline

            $regContent = (@'
            Windows Registry Editor Version 5.00

            ; Set pointer speed to 6/11
            [HKEY_CURRENT_USER\Control Panel\Mouse]
            "MouseSensitivity"="10"

            [HKEY_USERS\.DEFAULT\Control Panel\Mouse]
            "MouseSensitivity"="10"

            ; Enable enhance pointer precision
            [HKEY_CURRENT_USER\Control Panel\Mouse]
            "MouseSpeed"="1"
            "MouseThreshold1"="6"
            "MouseThreshold2"="10"

            [HKEY_USERS\.DEFAULT\Control Panel\Mouse]
            "MouseSpeed"="1"
            "MouseThreshold1"="6"
            "MouseThreshold2"="10"

            ; Set EPP curve for 175% scaling with no acceleration
            [HKEY_CURRENT_USER\Control Panel\Mouse]
            "SmoothMouseXCurve"=hex:\
            00,00,00,00,00,00,00,00,\
            60,66,16,00,00,00,00,00,\
            c0,cc,2c,00,00,00,00,00,\
            20,33,43,00,00,00,00,00,\
            80,99,59,00,00,00,00,00
            "SmoothMouseYCurve"=hex:\
            00,00,00,00,00,00,00,00,\
            00,00,38,00,00,00,00,00,\
            00,00,70,00,00,00,00,00,\
            00,00,a8,00,00,00,00,00,\
            00,00,e0,00,00,00,00,00

            [HKEY_USERS\.DEFAULT\Control Panel\Mouse]
            "SmoothMouseXCurve"=hex:\
            00,00,00,00,00,00,00,00,\
            60,66,16,00,00,00,00,00,\
            c0,cc,2c,00,00,00,00,00,\
            20,33,43,00,00,00,00,00,\
            80,99,59,00,00,00,00,00
            "SmoothMouseYCurve"=hex:\
            00,00,00,00,00,00,00,00,\
            00,00,38,00,00,00,00,00,\
            00,00,70,00,00,00,00,00,\
            00,00,a8,00,00,00,00,00,\
            00,00,e0,00,00,00,00,00

            ; Set scaling to 175%
            [HKEY_CURRENT_USER\Control Panel\Desktop]
            "LogPixels"=dword:000000a8
            "Win8DpiScaling"=dword:00000001

            [HKEY_CURRENT_USER\Control Panel\Desktop\WindowMetrics]
            "AppliedDPI"=dword:000000a8

            ; Enable fix scaling for apps
            [HKEY_CURRENT_USER\Control Panel\Desktop]
            "EnablePerProcessSystemDPI"=dword:00000001
'@ -replace '(?m)^ {12}')

            $regPath = Join-Path $env:SystemRoot 'Temp\175%.reg'
            Set-Content -Path $regPath -Value $regContent -Force
            Start-Process -Wait 'regedit.exe' -ArgumentList "/S $regPath" -WindowStyle Hidden
            Remove-Item $regPath -Force

            Clear-Host
            Write-Host "Restart to apply.`n" -ForegroundColor Yellow
            Write-Host 'Press any key to exit...' -NoNewline
            $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
            $break = $true
        }
        5 {
            Clear-Host
            Write-Host '200%...' -NoNewline

            $regContent = (@'
            Windows Registry Editor Version 5.00

            ; Set pointer speed to 6/11
            [HKEY_CURRENT_USER\Control Panel\Mouse]
            "MouseSensitivity"="10"

            [HKEY_USERS\.DEFAULT\Control Panel\Mouse]
            "MouseSensitivity"="10"

            ; Enable enhance pointer precision
            [HKEY_CURRENT_USER\Control Panel\Mouse]
            "MouseSpeed"="1"
            "MouseThreshold1"="6"
            "MouseThreshold2"="10"

            [HKEY_USERS\.DEFAULT\Control Panel\Mouse]
            "MouseSpeed"="1"
            "MouseThreshold1"="6"
            "MouseThreshold2"="10"

            ; Set EPP curve for 200% scaling with no acceleration
            [HKEY_CURRENT_USER\Control Panel\Mouse]
            "SmoothMouseXCurve"=hex:\
            00,00,00,00,00,00,00,00,\
            90,99,19,00,00,00,00,00,\
            20,33,33,00,00,00,00,00,\
            b0,cc,4c,00,00,00,00,00,\
            40,66,66,00,00,00,00,00
            "SmoothMouseYCurve"=hex:\
            00,00,00,00,00,00,00,00,\
            00,00,38,00,00,00,00,00,\
            00,00,70,00,00,00,00,00,\
            00,00,a8,00,00,00,00,00,\
            00,00,e0,00,00,00,00,00

            [HKEY_USERS\.DEFAULT\Control Panel\Mouse]
            "SmoothMouseXCurve"=hex:\
            00,00,00,00,00,00,00,00,\
            90,99,19,00,00,00,00,00,\
            20,33,33,00,00,00,00,00,\
            b0,cc,4c,00,00,00,00,00,\
            40,66,66,00,00,00,00,00
            "SmoothMouseYCurve"=hex:\
            00,00,00,00,00,00,00,00,\
            00,00,38,00,00,00,00,00,\
            00,00,70,00,00,00,00,00,\
            00,00,a8,00,00,00,00,00,\
            00,00,e0,00,00,00,00,00

            ; Set scaling to 200%
            [HKEY_CURRENT_USER\Control Panel\Desktop]
            "LogPixels"=dword:000000c0
            "Win8DpiScaling"=dword:00000001

            [HKEY_CURRENT_USER\Control Panel\Desktop\WindowMetrics]
            "AppliedDPI"=dword:000000c0

            ; Enable fix scaling for apps
            [HKEY_CURRENT_USER\Control Panel\Desktop]
            "EnablePerProcessSystemDPI"=dword:00000001
'@ -replace '(?m)^ {12}')

            $regPath = Join-Path $env:SystemRoot 'Temp\200%.reg'
            Set-Content -Path $regPath -Value $regContent -Force
            Start-Process -Wait 'regedit.exe' -ArgumentList "/S $regPath" -WindowStyle Hidden
            Remove-Item $regPath -Force

            Clear-Host
            Write-Host "Restart to apply.`n" -ForegroundColor Yellow
            Write-Host 'Press any key to exit...' -NoNewline
            $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
            $break = $true
        }
        6 {
            Clear-Host
            Write-Host '225%...' -NoNewline

            $regContent = (@'
            Windows Registry Editor Version 5.00

            ; Set pointer speed to 6/11
            [HKEY_CURRENT_USER\Control Panel\Mouse]
            "MouseSensitivity"="10"

            [HKEY_USERS\.DEFAULT\Control Panel\Mouse]
            "MouseSensitivity"="10"

            ; Enable enhance pointer precision
            [HKEY_CURRENT_USER\Control Panel\Mouse]
            "MouseSpeed"="1"
            "MouseThreshold1"="6"
            "MouseThreshold2"="10"

            [HKEY_USERS\.DEFAULT\Control Panel\Mouse]
            "MouseSpeed"="1"
            "MouseThreshold1"="6"
            "MouseThreshold2"="10"

            ; Set EPP curve for 225% scaling with no acceleration
            [HKEY_CURRENT_USER\Control Panel\Mouse]
            "SmoothMouseXCurve"=hex:\
            00,00,00,00,00,00,00,00,\
            c0,cc,1c,00,00,00,00,00,\
            80,99,39,00,00,00,00,00,\
            40,66,56,00,00,00,00,00,\
            00,33,73,00,00,00,00,00
            "SmoothMouseYCurve"=hex:\
            00,00,00,00,00,00,00,00,\
            00,00,38,00,00,00,00,00,\
            00,00,70,00,00,00,00,00,\
            00,00,a8,00,00,00,00,00,\
            00,00,e0,00,00,00,00,00

            [HKEY_USERS\.DEFAULT\Control Panel\Mouse]
            "SmoothMouseXCurve"=hex:\
            00,00,00,00,00,00,00,00,\
            c0,cc,1c,00,00,00,00,00,\
            80,99,39,00,00,00,00,00,\
            40,66,56,00,00,00,00,00,\
            00,33,73,00,00,00,00,00
            "SmoothMouseYCurve"=hex:\
            00,00,00,00,00,00,00,00,\
            00,00,38,00,00,00,00,00,\
            00,00,70,00,00,00,00,00,\
            00,00,a8,00,00,00,00,00,\
            00,00,e0,00,00,00,00,00

            ; Set scaling to 225%
            [HKEY_CURRENT_USER\Control Panel\Desktop]
            "LogPixels"=dword:000000d8
            "Win8DpiScaling"=dword:00000001

            [HKEY_CURRENT_USER\Control Panel\Desktop\WindowMetrics]
            "AppliedDPI"=dword:000000d8

            ; Enable fix scaling for apps
            [HKEY_CURRENT_USER\Control Panel\Desktop]
            "EnablePerProcessSystemDPI"=dword:00000001
'@ -replace '(?m)^ {12}')

            $regPath = Join-Path $env:SystemRoot 'Temp\225%.reg'
            Set-Content -Path $regPath -Value $regContent -Force
            Start-Process -Wait 'regedit.exe' -ArgumentList "/S $regPath" -WindowStyle Hidden
            Remove-Item $regPath -Force

            Clear-Host
            Write-Host "Restart to apply.`n" -ForegroundColor Yellow
            Write-Host 'Press any key to exit...' -NoNewline
            $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
            $break = $true
        }
        7 {
            Clear-Host
            Write-Host 'Default...' -NoNewline

            $regContent = (@'
            Windows Registry Editor Version 5.00

            ; Set pointer speed to 6/11
            [HKEY_CURRENT_USER\Control Panel\Mouse]
            "MouseSensitivity"="10"

            [HKEY_USERS\.DEFAULT\Control Panel\Mouse]
            "MouseSensitivity"="10"

            ; Disable enhance pointer precision (should not be on by default)
            [HKEY_CURRENT_USER\Control Panel\Mouse]
            "MouseSpeed"="0"
            "MouseThreshold1"="0"
            "MouseThreshold2"="0"

            [HKEY_USERS\.DEFAULT\Control Panel\Mouse]
            "MouseSpeed"="0"
            "MouseThreshold1"="0"
            "MouseThreshold2"="0"

            ; Set EPP curve to default
            [HKEY_CURRENT_USER\Control Panel\Mouse]
            "SmoothMouseXCurve"=hex:\
            00,00,00,00,00,00,00,00,\
            15,6e,00,00,00,00,00,00,\
            00,40,01,00,00,00,00,00,\
            29,dc,03,00,00,00,00,00,\
            00,00,28,00,00,00,00,00
            "SmoothMouseYCurve"=hex:\
            00,00,00,00,00,00,00,00,\
            fd,11,01,00,00,00,00,00,\
            00,24,04,00,00,00,00,00,\
            00,fc,12,00,00,00,00,00,\
            00,c0,bb,01,00,00,00,00

            [HKEY_USERS\.DEFAULT\Control Panel\Mouse]
            "SmoothMouseXCurve"=hex:\
            00,00,00,00,00,00,00,00,\
            15,6e,00,00,00,00,00,00,\
            00,40,01,00,00,00,00,00,\
            29,dc,03,00,00,00,00,00,\
            00,00,28,00,00,00,00,00
            "SmoothMouseYCurve"=hex:\
            00,00,00,00,00,00,00,00,\
            fd,11,01,00,00,00,00,00,\
            00,24,04,00,00,00,00,00,\
            00,fc,12,00,00,00,00,00,\
            00,c0,bb,01,00,00,00,00

            ; Reset scaling
            [HKEY_CURRENT_USER\Control Panel\Desktop]
            "LogPixels"=-
            "Win8DpiScaling"=-

            [HKEY_CURRENT_USER\Control Panel\Desktop\WindowMetrics]
            "AppliedDPI"=-

            ; Reset fix scaling for apps
            [HKEY_CURRENT_USER\Control Panel\Desktop]
            "EnablePerProcessSystemDPI"=-
'@ -replace '(?m)^ {12}')

            $regPath = Join-Path $env:SystemRoot 'Temp\Default.reg'
            Set-Content -Path $regPath -Value $regContent -Force
            Start-Process -Wait 'regedit.exe' -ArgumentList "/S $regPath" -WindowStyle Hidden
            Remove-Item $regPath -Force

            Clear-Host
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
