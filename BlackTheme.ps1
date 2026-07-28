if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
    Start-Process PowerShell.exe -ArgumentList ('-NoProfile -ExecutionPolicy Bypass -File "{0}"' -f $PSCommandPath) -Verb RunAs
    exit
}

$Host.UI.RawUI.BackgroundColor = 'Black'
$Host.UI.RawUI.ForegroundColor = 'White'
Clear-Host

Write-Host "Windows Theme`n"
Write-Host '1. Black'
Write-Host "2. Default`n"

$break = $false
do {
    $choice = ($Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')).Character

    switch ($choice) {
        1 {
            Clear-Host
            Write-Host 'Black...' -NoNewline

            $regContent = (@'
            Windows Registry Editor Version 5.00

            ; Set background type to solid color
            [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Wallpapers]
            "BackgroundType"=dword:00000001

            ; Set background color to black
            [HKEY_CURRENT_USER\Control Panel\Colors]
            "Background"="0 0 0"

            ; Remove wallpaper
            [HKEY_CURRENT_USER\Control Panel\Desktop]
            "WallPaper"=""

            ; Enable dark mode
            [HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize]
            "AppsUseLightTheme"=dword:00000000
            "SystemUsesLightTheme"=dword:00000000

            ; Disable transparency effects
            [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize]
            "EnableTransparency"=dword:00000000

            ; Set accent color to black (credit: zoicware)
            [HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Accent]
            "AccentColorMenu"=dword:00000000
            "AccentPalette"=hex:64,64,64,00,6b,6b,6b,00,00,00,00,00,\
              00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00,00
            "StartColorMenu"=dword:00000000

            [HKEY_CURRENT_USER\Software\Microsoft\Windows\DWM]
            "AccentColor"=dword:ff191919
            "ColorizationAfterglow"=dword:c4191919
            "ColorizationColor"=dword:c4191919
            "EnableWindowColorization"=dword:00000001

            ; Enable show accent color on Start and taskbar
            [HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize]
            "ColorPrevalence"=dword:00000001
'@ -replace '(?m)^ {12}')

            $regPath = Join-Path $env:SystemRoot 'Temp\BlackTheme.reg'
            Set-Content -Path $regPath -Value $regContent -Force
            Start-Process -Wait 'regedit.exe' -ArgumentList "/S $regPath" -WindowStyle Hidden
            Remove-Item $regPath -Force

            # Create black image for the lock screen
            Add-Type -AssemblyName System.Windows.Forms
            Add-Type -AssemblyName System.Drawing

            $screenWidth = [System.Windows.Forms.SystemInformation]::PrimaryMonitorSize.Width
            $screenHeight = [System.Windows.Forms.SystemInformation]::PrimaryMonitorSize.Height
            $imagePath = 'C:\Windows\Black.png'

            $bitmap = New-Object System.Drawing.Bitmap $screenWidth, $screenHeight
            $graphics = [System.Drawing.Graphics]::FromImage($bitmap)
            $graphics.FillRectangle([System.Drawing.Brushes]::Black, 0, 0, $bitmap.Width, $bitmap.Height)
            $graphics.Dispose()
            $bitmap.Save($imagePath)
            $bitmap.Dispose()

            # Set lock screen to black
            Reg.exe add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP' /v 'LockScreenImagePath' /t REG_SZ /d $imagePath /f *>$null
            Reg.exe add 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP' /v 'LockScreenImageStatus' /t REG_DWORD /d '1' /f *>$null

            # Disable acrylic background on the logon screen
            Reg.exe add 'HKLM\SOFTWARE\Policies\Microsoft\Windows\System' /v 'DisableAcrylicBackgroundOnLogon' /t REG_DWORD /d '1' /f *>$null

            Clear-Host
            Write-Host "Restart to apply.`n" -ForegroundColor Yellow
            Write-Host 'Press any key to exit...' -NoNewline
            $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
            $break = $true
        }
        2 {
            Clear-Host
            Write-Host 'Default...' -NoNewline

            $regContent = (@'
            Windows Registry Editor Version 5.00

            ; Set background type to picture
            [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Wallpapers]
            "BackgroundType"=dword:00000000

            ; Set wallpaper to default
            [HKEY_CURRENT_USER\Control Panel\Desktop]
            "WallPaper"="C:\\Windows\\web\\wallpaper\\Windows\\img0.jpg"

            ; Enable light mode
            [HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize]
            "AppsUseLightTheme"=dword:00000001
            "SystemUsesLightTheme"=dword:00000001

            ; Enable transparency effects
            [HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize]
            "EnableTransparency"=dword:00000001

            ; Set accent color to default
            [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Accent]
            "AccentColorMenu"=dword:ffd47800
            "AccentPalette"=hex:99,eb,ff,00,4c,c2,ff,00,00,91,f8,00,\
              00,78,d4,00,00,67,c0,00,00,3e,92,00,00,1a,68,00,f7,63,0c,00
            "StartColorMenu"=dword:ffc06700

            [HKEY_CURRENT_USER\Software\Microsoft\Windows\DWM]
            "AccentColor"=dword:ffd47800
            "ColorizationAfterglow"=dword:c40078d4
            "ColorizationColor"=dword:c40078d4
            "EnableWindowColorization"=dword:00000000

            ; Disable show accent color on Start and taskbar
            [HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize]
            "ColorPrevalence"=dword:00000000
'@ -replace '(?m)^ {12}')

            $regPath = Join-Path $env:SystemRoot 'Temp\DefaultTheme.reg'
            Set-Content -Path $regPath -Value $regContent -Force
            Start-Process -Wait 'regedit.exe' -ArgumentList "/S $regPath" -WindowStyle Hidden
            Remove-Item $regPath -Force

            # Delete black image
            Remove-Item 'C:\Windows\Black.png' -Force *>$null

            # Reset lock screen
            Reg.exe delete 'HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\PersonalizationCSP' /f *>$null

            # Reset acrylic background on the logon screen
            Reg.exe delete 'HKLM\SOFTWARE\Policies\Microsoft\Windows\System' /v 'DisableAcrylicBackgroundOnLogon' /f *>$null

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
