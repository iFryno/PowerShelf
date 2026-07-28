if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
    Start-Process PowerShell.exe -ArgumentList ('-NoProfile -ExecutionPolicy Bypass -File "{0}"' -f $PSCommandPath) -Verb RunAs
    exit
}

$Host.UI.RawUI.BackgroundColor = 'Black'
$Host.UI.RawUI.ForegroundColor = 'White'
Clear-Host

Write-Host "Explorer Ribbon`n"
Write-Host '1. Legacy'
Write-Host "2. Default`n"

$break = $false
do {
    $choice = ($Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')).Character

    switch ($choice) {
        1 {
            Clear-Host

            # Enable legacy Explorer ribbon
            Reg.exe add 'HKCU\Software\Classes\CLSID\{2aa9162e-c906-4dd9-ad0b-3d24a8eef5a0}' /ve /t REG_SZ /d 'CLSID_ItemsViewAdapter' /f *>$null
            Reg.exe add 'HKCU\Software\Classes\CLSID\{2aa9162e-c906-4dd9-ad0b-3d24a8eef5a0}\InProcServer32' /ve /t REG_SZ /d 'C:\Windows\System32\Windows.UI.FileExplorer.dll_' /f *>$null
            Reg.exe add 'HKCU\Software\Classes\CLSID\{2aa9162e-c906-4dd9-ad0b-3d24a8eef5a0}\InProcServer32' /v 'ThreadingModel' /t REG_SZ /d 'Apartment' /f *>$null
            Reg.exe add 'HKCU\Software\Classes\CLSID\{6480100b-5a83-4d1e-9f69-8ae5a88e9a33}' /ve /t REG_SZ /d 'File Explorer Xaml Island View Adapter' /f *>$null
            Reg.exe add 'HKCU\Software\Classes\CLSID\{6480100b-5a83-4d1e-9f69-8ae5a88e9a33}\InProcServer32' /ve /t REG_SZ /d 'C:\Windows\System32\Windows.UI.FileExplorer.dll_' /f *>$null
            Reg.exe add 'HKCU\Software\Classes\CLSID\{6480100b-5a83-4d1e-9f69-8ae5a88e9a33}\InProcServer32' /v 'ThreadingModel' /t REG_SZ /d 'Apartment' /f *>$null
            $ITBar7Layout = [byte[]](
                0x13, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x20, 0x00, 0x00, 0x00,
                0x10, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, 0x07, 0x00, 0x00,
                0x5e, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
            )
            New-Item -Path 'HKCU:\Software\Microsoft\Internet Explorer\Toolbar\ShellBrowser' -Force | Out-Null
            Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Internet Explorer\Toolbar\ShellBrowser' -Name 'ITBar7Layout' -Value $ITBar7Layout -Type Binary -Force

            # Initialize Explorer for minimized ribbon
            Stop-Process -Force -Name explorer -ErrorAction SilentlyContinue

            Start-Process explorer.exe
            while (!(Get-Process explorer -ErrorAction SilentlyContinue)) {
                Start-Sleep -Milliseconds 100
            }
            Start-Sleep 1

            # Enable minimized ribbon
            Reg.exe add 'HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Ribbon' /v 'MinimizedStateTabletModeOff' /t REG_DWORD /d 1 /f *> $null
            Reg.exe add 'HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Ribbon' /v 'MinimizedStateTabletModeOn' /t REG_DWORD /d 1 /f *> $null

            # Restart Explorer
            Stop-Process -Force -Name explorer -ErrorAction SilentlyContinue

            # Open Explorer
            Start-Process explorer.exe

            $break = $true
        }
        2 {
            Clear-Host

            # Disable legacy Explorer ribbon
            Reg.exe delete 'HKCU\Software\Classes\CLSID\{2aa9162e-c906-4dd9-ad0b-3d24a8eef5a0}' /f *>$null
            Reg.exe delete 'HKCU\Software\Classes\CLSID\{6480100b-5a83-4d1e-9f69-8ae5a88e9a33}' /f *>$null
            Reg.exe delete 'HKCU\Software\Microsoft\Internet Explorer\Toolbar\ShellBrowser' /v 'ITBar7Layout' /f *>$null
            Reg.exe delete 'HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Ribbon' /v 'MinimizedStateTabletModeOff' /f *>$null
            Reg.exe delete 'HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Ribbon' /v 'MinimizedStateTabletModeOn' /f *>$null

            # Restart Explorer
            Stop-Process -Force -Name explorer -ErrorAction SilentlyContinue

            # Open Explorer
            Start-Process explorer.exe

            $break = $true
        }
        default {
            Write-Host "Invalid option.`n" -ForegroundColor Red
        }
    }
} while (!$break)
