if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
    Start-Process PowerShell.exe -ArgumentList ('-NoProfile -ExecutionPolicy Bypass -File "{0}"' -f $PSCommandPath) -Verb RunAs
    exit
}

$Host.UI.RawUI.BackgroundColor = 'Black'
$Host.UI.RawUI.ForegroundColor = 'White'
Clear-Host

Write-Host "Legacy Settings`n"
Write-Host '1. Add'
Write-Host "2. Remove`n"

$break = $false
do {
    $choice = ($Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')).Character

    switch ($choice) {
        1 {
            Clear-Host

            # Add legacy settings to desktop context menu
            Reg.exe add 'HKCR\DesktopBackground\Shell\Personalization' /v 'Icon' /t REG_SZ /d 'shell32.dll,-137' /f *>$null
            Reg.exe add 'HKCR\DesktopBackground\Shell\Personalization' /v 'MUIVerb' /t REG_SZ /d 'Legacy settings' /f *>$null
            Reg.exe add 'HKCR\DesktopBackground\Shell\Personalization' /v 'Position' /t REG_SZ /d 'Bottom' /f *>$null
            Reg.exe add 'HKCR\DesktopBackground\Shell\Personalization' /v 'SubCommands' /t REG_SZ /d '""' /f *>$null
            Reg.exe add 'HKCR\DesktopBackground\Shell\Personalization\shell\001flyout' /v 'Icon' /t REG_SZ /d 'SndVol.exe,-101' /f *>$null
            Reg.exe add 'HKCR\DesktopBackground\Shell\Personalization\shell\001flyout' /v 'MUIVerb' /t REG_SZ /d 'Sound' /f *>$null
            Reg.exe add 'HKCR\DesktopBackground\Shell\Personalization\shell\001flyout\command' /ve /t REG_SZ /d 'rundll32.exe shell32.dll,Control_RunDLL mmsys.cpl,,0' /f *>$null
            Reg.exe add 'HKCR\DesktopBackground\Shell\Personalization\shell\002flyout' /v 'Icon' /t REG_SZ /d 'powercpl.dll,0' /f *>$null
            Reg.exe add 'HKCR\DesktopBackground\Shell\Personalization\shell\002flyout' /v 'MUIVerb' /t REG_SZ /d 'Power Options' /f *>$null
            Reg.exe add 'HKCR\DesktopBackground\Shell\Personalization\shell\002flyout\command' /ve /t REG_SZ /d 'rundll32.exe shell32.dll,Control_RunDLL powercfg.cpl' /f *>$null
            Reg.exe add 'HKCR\DesktopBackground\Shell\Personalization\shell\003flyout' /v 'Icon' /t REG_SZ /d 'main.cpl' /f *>$null
            Reg.exe add 'HKCR\DesktopBackground\Shell\Personalization\shell\003flyout' /v 'MUIVerb' /t REG_SZ /d 'Mouse Properties' /f *>$null
            Reg.exe add 'HKCR\DesktopBackground\Shell\Personalization\shell\003flyout\command' /ve /t REG_SZ /d 'rundll32.exe shell32.dll,Control_RunDLL main.cpl,,0' /f *>$null
            Reg.exe add 'HKCR\DesktopBackground\Shell\Personalization\shell\004flyout' /v 'Icon' /t REG_SZ /d 'SystemPropertiesAdvanced.exe' /f *>$null
            Reg.exe add 'HKCR\DesktopBackground\Shell\Personalization\shell\004flyout' /v 'MUIVerb' /t REG_SZ /d 'System Properties' /f *>$null
            Reg.exe add 'HKCR\DesktopBackground\Shell\Personalization\shell\004flyout\command' /ve /t REG_SZ /d 'SystemPropertiesAdvanced.exe' /f *>$null
            Reg.exe add 'HKCR\DesktopBackground\Shell\Personalization\shell\005flyout' /v 'Icon' /t REG_SZ /d 'desk.cpl' /f *>$null
            Reg.exe add 'HKCR\DesktopBackground\Shell\Personalization\shell\005flyout' /v 'MUIVerb' /t REG_SZ /d 'Desktop Icon Settings' /f *>$null
            Reg.exe add 'HKCR\DesktopBackground\Shell\Personalization\shell\005flyout\command' /ve /t REG_SZ /d 'rundll32.exe shell32.dll,Control_RunDLL desk.cpl,,0' /f *>$null

            Write-Host "Legacy Settings added.`n" -ForegroundColor Green
            Write-Host 'Press any key to exit...' -NoNewline
            $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
            $break = $true
        }
        2 {
            Clear-Host

            # Remove legacy settings from desktop context menu
            Reg.exe delete 'HKCR\DesktopBackground\Shell\Personalization' /f *>$null

            Write-Host "Legacy Settings removed.`n" -ForegroundColor Green
            Write-Host 'Press any key to exit...' -NoNewline
            $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
            $break = $true
        }
        default {
            Write-Host "Invalid option.`n" -ForegroundColor Red
        }
    }
} while (!$break)
