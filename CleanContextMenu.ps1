if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
    Start-Process PowerShell.exe -ArgumentList ('-NoProfile -ExecutionPolicy Bypass -File "{0}"' -f $PSCommandPath) -Verb RunAs
    exit
}

$Host.UI.RawUI.BackgroundColor = 'Black'
$Host.UI.RawUI.ForegroundColor = 'White'
Clear-Host

Write-Host "Context Menu`n"
Write-Host '1. Clean'
Write-Host "2. Default`n"

$break = $false
do {
    $choice = ($Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')).Character

    switch ($choice) {
        1 {
            Clear-Host
            Write-Host 'Clean...' -NoNewline

            $regContent = (@'
            Windows Registry Editor Version 5.00

            ; Remove modern context menu
            [HKEY_CURRENT_USER\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32]
            @=""

            ; Remove add to favorites
            [-HKEY_CLASSES_ROOT\*\shell\pintohomefile]

            ; Remove cast to device
            [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked]
            "{7AD84985-87B4-4a16-BE58-8B72A5B390F7}"=""

            ; Remove customize this folder
            [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer]
            "NoCustomizeThisFolder"=dword:00000001

            ; Remove extract all
            [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked]
            "{b8cdcb65-b1bf-4b42-9428-1dfdb7ee92af}"=""
            "{EE07CEF5-3441-4CFB-870A-4002C724783A}"=""

            [HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked]
            "{b8cdcb65-b1bf-4b42-9428-1dfdb7ee92af}"=""
            "{EE07CEF5-3441-4CFB-870A-4002C724783A}"=""

            ; Remove give access to
            [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked]
            "{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}"=""

            ; Remove include in library
            [-HKEY_CLASSES_ROOT\Folder\ShellEx\ContextMenuHandlers\Library Location]

            ; Remove map and disconnect network drive
            [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer]
            "NoNetConnectDisconnect"=dword:00000001

            [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer]
            "NoNetConnectDisconnect"=dword:00000001

            ; Remove move to OneDrive
            [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked]
            "{1FA0E654-C9F2-4A1F-9800-B9A75D744B00}"=""

            ; Remove open in Terminal
            [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked]
            "{9F156763-7844-4DC4-B2B1-901F640F5155}"=""

            ; Remove pin to Quick access
            [-HKEY_CLASSES_ROOT\Drive\shell\pintohome]

            [-HKEY_CLASSES_ROOT\Folder\shell\pintohome]

            ; Remove pin to Start
            [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked]
            "{470C0EBD-5D73-4d58-9CED-E91E22E23282}"=""

            ; Remove print
            [HKEY_CLASSES_ROOT\AppX4ztfk9wxr86nxmzzq47px0nh0e58b8fw\Shell\Print]
            "ProgrammaticAccessOnly"=""

            [HKEY_CLASSES_ROOT\SystemFileAssociations\image\shell\print]
            "ProgrammaticAccessOnly"=""

            [HKEY_CLASSES_ROOT\batfile\shell\print]
            "ProgrammaticAccessOnly"=""

            [HKEY_CLASSES_ROOT\cmdfile\shell\print]
            "ProgrammaticAccessOnly"=""

            [HKEY_CLASSES_ROOT\docxfile\shell\print]
            "ProgrammaticAccessOnly"=""

            [HKEY_CLASSES_ROOT\fonfile\shell\print]
            "ProgrammaticAccessOnly"=""

            [HKEY_CLASSES_ROOT\htmlfile\shell\print]
            "ProgrammaticAccessOnly"=""

            [HKEY_CLASSES_ROOT\inffile\shell\print]
            "ProgrammaticAccessOnly"=""

            [HKEY_CLASSES_ROOT\inifile\shell\print]
            "ProgrammaticAccessOnly"=""

            [HKEY_CLASSES_ROOT\JSEFile\Shell\Print]
            "ProgrammaticAccessOnly"=""

            [HKEY_CLASSES_ROOT\otffile\shell\print]
            "ProgrammaticAccessOnly"=""

            [HKEY_CLASSES_ROOT\pfmfile\shell\print]
            "ProgrammaticAccessOnly"=""

            [HKEY_CLASSES_ROOT\regfile\shell\print]
            "ProgrammaticAccessOnly"=""

            [HKEY_CLASSES_ROOT\rtffile\shell\print]
            "ProgrammaticAccessOnly"=""

            [HKEY_CLASSES_ROOT\ttcfile\shell\print]
            "ProgrammaticAccessOnly"=""

            [HKEY_CLASSES_ROOT\ttffile\shell\print]
            "ProgrammaticAccessOnly"=""

            [HKEY_CLASSES_ROOT\txtfile\shell\print]
            "ProgrammaticAccessOnly"=""

            [HKEY_CLASSES_ROOT\VBEFile\Shell\Print]
            "ProgrammaticAccessOnly"=""

            [HKEY_CLASSES_ROOT\VBSFile\Shell\Print]
            "ProgrammaticAccessOnly"=""

            [HKEY_CLASSES_ROOT\WSFFile\Shell\Print]
            "ProgrammaticAccessOnly"=""

            ; Remove restore previous versions
            [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer]
            "NoPreviousVersionsPage"=dword:00000001

            ; Remove rotate left and rotate right
            [-HKEY_CLASSES_ROOT\SystemFileAssociations\.avci\ShellEx\ContextMenuHandlers\ShellImagePreview]

            [-HKEY_CLASSES_ROOT\SystemFileAssociations\.avif\ShellEx\ContextMenuHandlers\ShellImagePreview]

            [-HKEY_CLASSES_ROOT\SystemFileAssociations\.bmp\ShellEx\ContextMenuHandlers\ShellImagePreview]

            [-HKEY_CLASSES_ROOT\SystemFileAssociations\.dds\ShellEx\ContextMenuHandlers\ShellImagePreview]

            [-HKEY_CLASSES_ROOT\SystemFileAssociations\.dib\ShellEx\ContextMenuHandlers\ShellImagePreview]

            [-HKEY_CLASSES_ROOT\SystemFileAssociations\.gif\ShellEx\ContextMenuHandlers\ShellImagePreview]

            [-HKEY_CLASSES_ROOT\SystemFileAssociations\.heic\ShellEx\ContextMenuHandlers\ShellImagePreview]

            [-HKEY_CLASSES_ROOT\SystemFileAssociations\.heif\ShellEx\ContextMenuHandlers\ShellImagePreview]

            [-HKEY_CLASSES_ROOT\SystemFileAssociations\.ico\ShellEx\ContextMenuHandlers\ShellImagePreview]

            [-HKEY_CLASSES_ROOT\SystemFileAssociations\.jfif\ShellEx\ContextMenuHandlers\ShellImagePreview]

            [-HKEY_CLASSES_ROOT\SystemFileAssociations\.jpe\ShellEx\ContextMenuHandlers\ShellImagePreview]

            [-HKEY_CLASSES_ROOT\SystemFileAssociations\.jpeg\ShellEx\ContextMenuHandlers\ShellImagePreview]

            [-HKEY_CLASSES_ROOT\SystemFileAssociations\.jpg\ShellEx\ContextMenuHandlers\ShellImagePreview]

            [-HKEY_CLASSES_ROOT\SystemFileAssociations\.jxr\ShellEx\ContextMenuHandlers\ShellImagePreview]

            [-HKEY_CLASSES_ROOT\SystemFileAssociations\.png\ShellEx\ContextMenuHandlers\ShellImagePreview]

            [-HKEY_CLASSES_ROOT\SystemFileAssociations\.rle\ShellEx\ContextMenuHandlers\ShellImagePreview]

            [-HKEY_CLASSES_ROOT\SystemFileAssociations\.tif\ShellEx\ContextMenuHandlers\ShellImagePreview]

            [-HKEY_CLASSES_ROOT\SystemFileAssociations\.tiff\ShellEx\ContextMenuHandlers\ShellImagePreview]

            [-HKEY_CLASSES_ROOT\SystemFileAssociations\.wdp\ShellEx\ContextMenuHandlers\ShellImagePreview]

            [-HKEY_CLASSES_ROOT\SystemFileAssociations\.webp\ShellEx\ContextMenuHandlers\ShellImagePreview]

            ; Remove scan with Microsoft Defender
            [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked]
            "{09A47860-11B0-4DA5-AFA5-26D86198A780}"=""

            ; Remove send to
            [-HKEY_CLASSES_ROOT\AllFilesystemObjects\shellex\ContextMenuHandlers\SendTo]

            [-HKEY_CLASSES_ROOT\UserLibraryFolder\shellex\ContextMenuHandlers\SendTo]

            ; Remove set as desktop background
            [-HKEY_CLASSES_ROOT\SystemFileAssociations\.avci\Shell\setdesktopwallpaper]

            [-HKEY_CLASSES_ROOT\SystemFileAssociations\.avcs\Shell\setdesktopwallpaper]

            [-HKEY_CLASSES_ROOT\SystemFileAssociations\.avif\Shell\setdesktopwallpaper]

            [-HKEY_CLASSES_ROOT\SystemFileAssociations\.avifs\Shell\setdesktopwallpaper]

            [-HKEY_CLASSES_ROOT\SystemFileAssociations\.bmp\Shell\setdesktopwallpaper]

            [-HKEY_CLASSES_ROOT\SystemFileAssociations\.dib\Shell\setdesktopwallpaper]

            [-HKEY_CLASSES_ROOT\SystemFileAssociations\.gif\Shell\setdesktopwallpaper]

            [-HKEY_CLASSES_ROOT\SystemFileAssociations\.heic\Shell\setdesktopwallpaper]

            [-HKEY_CLASSES_ROOT\SystemFileAssociations\.heics\Shell\setdesktopwallpaper]

            [-HKEY_CLASSES_ROOT\SystemFileAssociations\.heif\Shell\setdesktopwallpaper]

            [-HKEY_CLASSES_ROOT\SystemFileAssociations\.heifs\Shell\setdesktopwallpaper]

            [-HKEY_CLASSES_ROOT\SystemFileAssociations\.jfif\Shell\setdesktopwallpaper]

            [-HKEY_CLASSES_ROOT\SystemFileAssociations\.jpe\Shell\setdesktopwallpaper]

            [-HKEY_CLASSES_ROOT\SystemFileAssociations\.jpeg\Shell\setdesktopwallpaper]

            [-HKEY_CLASSES_ROOT\SystemFileAssociations\.jpg\Shell\setdesktopwallpaper]

            [-HKEY_CLASSES_ROOT\SystemFileAssociations\.png\Shell\setdesktopwallpaper]

            [-HKEY_CLASSES_ROOT\SystemFileAssociations\.tif\Shell\setdesktopwallpaper]

            [-HKEY_CLASSES_ROOT\SystemFileAssociations\.tiff\Shell\setdesktopwallpaper]

            [-HKEY_CLASSES_ROOT\SystemFileAssociations\.wdp\Shell\setdesktopwallpaper]

            [-HKEY_CLASSES_ROOT\SystemFileAssociations\.webp\Shell\setdesktopwallpaper]

            ; Remove share
            [-HKEY_CLASSES_ROOT\AllFilesystemObjects\shellex\ContextMenuHandlers\ModernSharing]

            ; Remove troubleshoot compatibility
            [-HKEY_CLASSES_ROOT\exefile\shellex\ContextMenuHandlers\Compatibility]

            ; Remove turn on BitLocker
            [HKEY_CLASSES_ROOT\Drive\shell\encrypt-bde-elev]
            "LegacyDisable"=""

            ; Remove explore background
            [HKEY_CURRENT_USER\Software\Classes\DesktopBackground\shell\.SpotlightLearnMore]
            "ProgrammaticAccessOnly"=""

            ; Remove next desktop background
            [HKEY_CURRENT_USER\Software\Classes\DesktopBackground\shell\.SpotlightNextImage]
            "ProgrammaticAccessOnly"=""

            [-HKEY_CLASSES_ROOT\DesktopBackground\shellex\ContextMenuHandlers\DesktopSlideshow]

            ; Remove ask Copilot
            [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked]
            "{CB3B0003-8088-4EDE-8769-8B354AB2FF8C}"=""
            "{ED215C26-C810-49CE-929E-31D7E83A82E9}"=""
'@ -replace '(?m)^ {12}')

            $regPath = Join-Path $env:SystemRoot 'Temp\CleanContextMenu.reg'
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
            Write-Host 'Default...' -NoNewline

            $regContent = (@'
            Windows Registry Editor Version 5.00

            ; Restore modern context menu
            [-HKEY_CURRENT_USER\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}]

            ; Restore add to favorites
            [HKEY_CLASSES_ROOT\*\shell\pintohomefile]
            "CommandStateHandler"="{b455f46e-e4af-4035-b0a4-cf18d2f6f28e}"
            "CommandStateSync"=""
            "MUIVerb"="@shell32.dll,-51608"
            "NeverDefault"=""
            "SkipCloudDownload"=dword:00000000

            [HKEY_CLASSES_ROOT\*\shell\pintohomefile\command]
            "DelegateExecute"="{b455f46e-e4af-4035-b0a4-cf18d2f6f28e}"

            ; Restore cast to device
            [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked]
            "{7AD84985-87B4-4a16-BE58-8B72A5B390F7}"=-

            ; Restore customize this folder
            [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer]
            "NoCustomizeThisFolder"=-

            ; Restore extract all
            [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked]
            "{b8cdcb65-b1bf-4b42-9428-1dfdb7ee92af}"=-
            "{EE07CEF5-3441-4CFB-870A-4002C724783A}"=-

            [HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked]
            "{b8cdcb65-b1bf-4b42-9428-1dfdb7ee92af}"=-
            "{EE07CEF5-3441-4CFB-870A-4002C724783A}"=-

            ; Restore give access to
            [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked]
            "{f81e9010-6ea4-11ce-a7ff-00aa003ca9f6}"=-

            ; Restore include in library
            [HKEY_CLASSES_ROOT\Folder\ShellEx\ContextMenuHandlers\Library Location]
            @="{3dad6c5d-2167-4cae-9914-f99e41c12cfa}"

            ; Restore map and disconnect network drive
            [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer]
            "NoNetConnectDisconnect"=-

            [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer]
            "NoNetConnectDisconnect"=-

            ; Restore move to OneDrive
            [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked]
            "{1FA0E654-C9F2-4A1F-9800-B9A75D744B00}"=-

            ; Restore open in Terminal
            [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked]
            "{9F156763-7844-4DC4-B2B1-901F640F5155}"=-

            ; Restore pin to Quick access
            [HKEY_CLASSES_ROOT\Folder\shell\pintohome]
            "AppliesTo"="System.ParsingName:<>\"::{f874310e-b6b7-47dc-bc84-b9e6b38f5903}\" AND System.ParsingName:<>\"::{679f85cb-0220-4080-b29b-5540cc05aab6}\" AND System.IsFolder:=System.StructuredQueryType.Boolean#True"
            "CommandStateHandler"="{b455f46e-e4af-4035-b0a4-cf18d2f6f28e}"
            "CommandStateSync"=""
            "MUIVerb"="@shell32.dll,-51601"
            "SkipCloudDownload"=dword:00000000

            [HKEY_CLASSES_ROOT\Folder\shell\pintohome\command]
            "DelegateExecute"="{b455f46e-e4af-4035-b0a4-cf18d2f6f28e}"

            [HKEY_CLASSES_ROOT\Drive\shell\pintohome]
            "CommandStateHandler"="{b455f46e-e4af-4035-b0a4-cf18d2f6f28e}"
            "CommandStateSync"=""
            "MUIVerb"="@shell32.dll,-51377"
            "NeverDefault"=""

            [HKEY_CLASSES_ROOT\Drive\shell\pintohome\command]
            "DelegateExecute"="{b455f46e-e4af-4035-b0a4-cf18d2f6f28e}"

            ; Restore pin to Start
            [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked]
            "{470C0EBD-5D73-4d58-9CED-E91E22E23282}"=-

            ; Restore print
            [HKEY_CLASSES_ROOT\AppX4ztfk9wxr86nxmzzq47px0nh0e58b8fw\Shell\Print]
            "ProgrammaticAccessOnly"=-

            [HKEY_CLASSES_ROOT\SystemFileAssociations\image\shell\print]
            "ProgrammaticAccessOnly"=-

            [HKEY_CLASSES_ROOT\batfile\shell\print]
            "ProgrammaticAccessOnly"=-

            [HKEY_CLASSES_ROOT\cmdfile\shell\print]
            "ProgrammaticAccessOnly"=-

            [HKEY_CLASSES_ROOT\docxfile\shell\print]
            "ProgrammaticAccessOnly"=-

            [HKEY_CLASSES_ROOT\fonfile\shell\print]
            "ProgrammaticAccessOnly"=-

            [HKEY_CLASSES_ROOT\htmlfile\shell\print]
            "ProgrammaticAccessOnly"=-

            [HKEY_CLASSES_ROOT\inffile\shell\print]
            "ProgrammaticAccessOnly"=-

            [HKEY_CLASSES_ROOT\inifile\shell\print]
            "ProgrammaticAccessOnly"=-

            [HKEY_CLASSES_ROOT\JSEFile\Shell\Print]
            "ProgrammaticAccessOnly"=-

            [HKEY_CLASSES_ROOT\otffile\shell\print]
            "ProgrammaticAccessOnly"=-

            [HKEY_CLASSES_ROOT\pfmfile\shell\print]
            "ProgrammaticAccessOnly"=-

            [HKEY_CLASSES_ROOT\regfile\shell\print]
            "ProgrammaticAccessOnly"=-

            [HKEY_CLASSES_ROOT\rtffile\shell\print]
            "ProgrammaticAccessOnly"=-

            [HKEY_CLASSES_ROOT\ttcfile\shell\print]
            "ProgrammaticAccessOnly"=-

            [HKEY_CLASSES_ROOT\ttffile\shell\print]
            "ProgrammaticAccessOnly"=-

            [HKEY_CLASSES_ROOT\txtfile\shell\print]
            "ProgrammaticAccessOnly"=-

            [HKEY_CLASSES_ROOT\VBEFile\Shell\Print]
            "ProgrammaticAccessOnly"=-

            [HKEY_CLASSES_ROOT\VBSFile\Shell\Print]
            "ProgrammaticAccessOnly"=-

            [HKEY_CLASSES_ROOT\WSFFile\Shell\Print]
            "ProgrammaticAccessOnly"=-

            ; Restore restore previous versions
            [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer]
            "NoPreviousVersionsPage"=-

            ; Restore rotate left and rotate right
            [HKEY_CLASSES_ROOT\SystemFileAssociations\.avci\ShellEx\ContextMenuHandlers\ShellImagePreview]
            @="{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}"

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.avif\ShellEx\ContextMenuHandlers\ShellImagePreview]
            @="{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}"

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.bmp\ShellEx\ContextMenuHandlers\ShellImagePreview]
            @="{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}"

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.dds\ShellEx\ContextMenuHandlers\ShellImagePreview]
            @="{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}"

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.dib\ShellEx\ContextMenuHandlers\ShellImagePreview]
            @="{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}"

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.gif\ShellEx\ContextMenuHandlers\ShellImagePreview]
            @="{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}"

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.heic\ShellEx\ContextMenuHandlers\ShellImagePreview]
            @="{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}"

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.heif\ShellEx\ContextMenuHandlers\ShellImagePreview]
            @="{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}"

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.ico\ShellEx\ContextMenuHandlers\ShellImagePreview]
            @="{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}"

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.jfif\ShellEx\ContextMenuHandlers\ShellImagePreview]
            @="{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}"

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.jpe\ShellEx\ContextMenuHandlers\ShellImagePreview]
            @="{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}"

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.jpeg\ShellEx\ContextMenuHandlers\ShellImagePreview]
            @="{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}"

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.jpg\ShellEx\ContextMenuHandlers\ShellImagePreview]
            @="{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}"

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.jxr\ShellEx\ContextMenuHandlers\ShellImagePreview]
            @="{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}"

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.png\ShellEx\ContextMenuHandlers\ShellImagePreview]
            @="{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}"

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.rle\ShellEx\ContextMenuHandlers\ShellImagePreview]
            @="{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}"

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.tif\ShellEx\ContextMenuHandlers\ShellImagePreview]
            @="{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}"

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.tiff\ShellEx\ContextMenuHandlers\ShellImagePreview]
            @="{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}"

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.wdp\ShellEx\ContextMenuHandlers\ShellImagePreview]
            @="{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}"

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.webp\ShellEx\ContextMenuHandlers\ShellImagePreview]
            @="{FFE2A43C-56B9-4bf5-9A79-CC6D4285608A}"

            ; Restore scan with Microsoft Defender
            [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked]
            "{09A47860-11B0-4DA5-AFA5-26D86198A780}"=-

            ; Restore send to
            [HKEY_CLASSES_ROOT\AllFilesystemObjects\shellex\ContextMenuHandlers\SendTo]
            @="{7BA4C740-9E81-11CF-99D3-00AA004AE837}"

            [HKEY_CLASSES_ROOT\UserLibraryFolder\shellex\ContextMenuHandlers\SendTo]
            @="{7BA4C740-9E81-11CF-99D3-00AA004AE837}"

            ; Restore set as desktop background
            [HKEY_CLASSES_ROOT\SystemFileAssociations\.avci\Shell\setdesktopwallpaper]
            @=hex(2):40,00,25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,\
              00,25,00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,73,00,\
              74,00,6f,00,62,00,6a,00,65,00,63,00,74,00,2e,00,64,00,6c,00,6c,00,2c,00,2d,\
              00,34,00,31,00,37,00,00,00
            "MultiSelectModel"="Player"
            "NeverDefault"=""

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.avci\Shell\setdesktopwallpaper\Command]
            @=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,00,25,\
              00,5c,00,45,00,78,00,70,00,6c,00,6f,00,72,00,65,00,72,00,2e,00,65,00,78,00,\
              65,00,00,00
            "DelegateExecute"="{ff609cc7-d34d-4049-a1aa-2293517ffcc6}"

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.avcs\Shell\setdesktopwallpaper]
            @=hex(2):40,00,25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,\
              00,25,00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,73,00,\
              74,00,6f,00,62,00,6a,00,65,00,63,00,74,00,2e,00,64,00,6c,00,6c,00,2c,00,2d,\
              00,34,00,31,00,37,00,00,00
            "MultiSelectModel"="Player"
            "NeverDefault"=""

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.avcs\Shell\setdesktopwallpaper\Command]
            @=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,00,25,\
              00,5c,00,45,00,78,00,70,00,6c,00,6f,00,72,00,65,00,72,00,2e,00,65,00,78,00,\
              65,00,00,00
            "DelegateExecute"="{ff609cc7-d34d-4049-a1aa-2293517ffcc6}"

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.avif\Shell\setdesktopwallpaper]
            @=hex(2):40,00,25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,\
              00,25,00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,73,00,\
              74,00,6f,00,62,00,6a,00,65,00,63,00,74,00,2e,00,64,00,6c,00,6c,00,2c,00,2d,\
              00,34,00,31,00,37,00,00,00
            "MultiSelectModel"="Player"
            "NeverDefault"=""

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.avif\Shell\setdesktopwallpaper\Command]
            @=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,00,25,\
              00,5c,00,45,00,78,00,70,00,6c,00,6f,00,72,00,65,00,72,00,2e,00,65,00,78,00,\
              65,00,00,00
            "DelegateExecute"="{ff609cc7-d34d-4049-a1aa-2293517ffcc6}"

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.avifs\Shell\setdesktopwallpaper]
            @=hex(2):40,00,25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,\
              00,25,00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,73,00,\
              74,00,6f,00,62,00,6a,00,65,00,63,00,74,00,2e,00,64,00,6c,00,6c,00,2c,00,2d,\
              00,34,00,31,00,37,00,00,00
            "MultiSelectModel"="Player"
            "NeverDefault"=""

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.avifs\Shell\setdesktopwallpaper\Command]
            @=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,00,25,\
              00,5c,00,45,00,78,00,70,00,6c,00,6f,00,72,00,65,00,72,00,2e,00,65,00,78,00,\
              65,00,00,00
            "DelegateExecute"="{ff609cc7-d34d-4049-a1aa-2293517ffcc6}"

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.bmp\Shell\setdesktopwallpaper]
            @=hex(2):40,00,25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,\
              00,25,00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,73,00,\
              74,00,6f,00,62,00,6a,00,65,00,63,00,74,00,2e,00,64,00,6c,00,6c,00,2c,00,2d,\
              00,34,00,31,00,37,00,00,00
            "MultiSelectModel"="Player"
            "NeverDefault"=""
            "SuppressionSlapiPolicy"="ChangeDesktopBackground-Enabled"

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.bmp\Shell\setdesktopwallpaper\Command]
            @=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,00,25,\
              00,5c,00,45,00,78,00,70,00,6c,00,6f,00,72,00,65,00,72,00,2e,00,65,00,78,00,\
              65,00,00,00
            "DelegateExecute"="{ff609cc7-d34d-4049-a1aa-2293517ffcc6}"

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.dib\Shell\setdesktopwallpaper]
            @=hex(2):40,00,25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,\
              00,25,00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,73,00,\
              74,00,6f,00,62,00,6a,00,65,00,63,00,74,00,2e,00,64,00,6c,00,6c,00,2c,00,2d,\
              00,34,00,31,00,37,00,00,00
            "MultiSelectModel"="Player"
            "NeverDefault"=""
            "SuppressionSlapiPolicy"="ChangeDesktopBackground-Enabled"

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.dib\Shell\setdesktopwallpaper\Command]
            @=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,00,25,\
              00,5c,00,45,00,78,00,70,00,6c,00,6f,00,72,00,65,00,72,00,2e,00,65,00,78,00,\
              65,00,00,00
            "DelegateExecute"="{ff609cc7-d34d-4049-a1aa-2293517ffcc6}"

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.gif\Shell\setdesktopwallpaper]
            @=hex(2):40,00,25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,\
              00,25,00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,73,00,\
              74,00,6f,00,62,00,6a,00,65,00,63,00,74,00,2e,00,64,00,6c,00,6c,00,2c,00,2d,\
              00,34,00,31,00,37,00,00,00
            "MultiSelectModel"="Player"
            "NeverDefault"=""

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.gif\Shell\setdesktopwallpaper\Command]
            @=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,00,25,\
              00,5c,00,45,00,78,00,70,00,6c,00,6f,00,72,00,65,00,72,00,2e,00,65,00,78,00,\
              65,00,00,00
            "DelegateExecute"="{ff609cc7-d34d-4049-a1aa-2293517ffcc6}"

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.heic\Shell\setdesktopwallpaper]
            @=hex(2):40,00,25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,\
              00,25,00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,73,00,\
              74,00,6f,00,62,00,6a,00,65,00,63,00,74,00,2e,00,64,00,6c,00,6c,00,2c,00,2d,\
              00,34,00,31,00,37,00,00,00
            "MultiSelectModel"="Player"
            "NeverDefault"=""

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.heic\Shell\setdesktopwallpaper\Command]
            @=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,00,25,\
              00,5c,00,45,00,78,00,70,00,6c,00,6f,00,72,00,65,00,72,00,2e,00,65,00,78,00,\
              65,00,00,00
            "DelegateExecute"="{ff609cc7-d34d-4049-a1aa-2293517ffcc6}"

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.heics\Shell\setdesktopwallpaper]
            @=hex(2):40,00,25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,\
              00,25,00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,73,00,\
              74,00,6f,00,62,00,6a,00,65,00,63,00,74,00,2e,00,64,00,6c,00,6c,00,2c,00,2d,\
              00,34,00,31,00,37,00,00,00
            "MultiSelectModel"="Player"
            "NeverDefault"=""

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.heics\Shell\setdesktopwallpaper\Command]
            @=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,00,25,\
              00,5c,00,45,00,78,00,70,00,6c,00,6f,00,72,00,65,00,72,00,2e,00,65,00,78,00,\
              65,00,00,00
            "DelegateExecute"="{ff609cc7-d34d-4049-a1aa-2293517ffcc6}"

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.heif\Shell\setdesktopwallpaper]
            @=hex(2):40,00,25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,\
              00,25,00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,73,00,\
              74,00,6f,00,62,00,6a,00,65,00,63,00,74,00,2e,00,64,00,6c,00,6c,00,2c,00,2d,\
              00,34,00,31,00,37,00,00,00
            "MultiSelectModel"="Player"
            "NeverDefault"=""

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.heif\Shell\setdesktopwallpaper\Command]
            @=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,00,25,\
              00,5c,00,45,00,78,00,70,00,6c,00,6f,00,72,00,65,00,72,00,2e,00,65,00,78,00,\
              65,00,00,00
            "DelegateExecute"="{ff609cc7-d34d-4049-a1aa-2293517ffcc6}"

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.heifs\Shell\setdesktopwallpaper]
            @=hex(2):40,00,25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,\
              00,25,00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,73,00,\
              74,00,6f,00,62,00,6a,00,65,00,63,00,74,00,2e,00,64,00,6c,00,6c,00,2c,00,2d,\
              00,34,00,31,00,37,00,00,00
            "MultiSelectModel"="Player"
            "NeverDefault"=""

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.heifs\Shell\setdesktopwallpaper\Command]
            @=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,00,25,\
              00,5c,00,45,00,78,00,70,00,6c,00,6f,00,72,00,65,00,72,00,2e,00,65,00,78,00,\
              65,00,00,00
            "DelegateExecute"="{ff609cc7-d34d-4049-a1aa-2293517ffcc6}"

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.jfif\Shell\setdesktopwallpaper]
            @=hex(2):40,00,25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,\
              00,25,00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,73,00,\
              74,00,6f,00,62,00,6a,00,65,00,63,00,74,00,2e,00,64,00,6c,00,6c,00,2c,00,2d,\
              00,34,00,31,00,37,00,00,00
            "MultiSelectModel"="Player"
            "NeverDefault"=""
            "SuppressionSlapiPolicy"="ChangeDesktopBackground-Enabled"

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.jfif\Shell\setdesktopwallpaper\Command]
            @=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,00,25,\
              00,5c,00,45,00,78,00,70,00,6c,00,6f,00,72,00,65,00,72,00,2e,00,65,00,78,00,\
              65,00,00,00
            "DelegateExecute"="{ff609cc7-d34d-4049-a1aa-2293517ffcc6}"

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.jpe\Shell\setdesktopwallpaper]
            @=hex(2):40,00,25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,\
              00,25,00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,73,00,\
              74,00,6f,00,62,00,6a,00,65,00,63,00,74,00,2e,00,64,00,6c,00,6c,00,2c,00,2d,\
              00,34,00,31,00,37,00,00,00
            "MultiSelectModel"="Player"
            "NeverDefault"=""
            "SuppressionSlapiPolicy"="ChangeDesktopBackground-Enabled"

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.jpe\Shell\setdesktopwallpaper\Command]
            @=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,00,25,\
              00,5c,00,45,00,78,00,70,00,6c,00,6f,00,72,00,65,00,72,00,2e,00,65,00,78,00,\
              65,00,00,00
            "DelegateExecute"="{ff609cc7-d34d-4049-a1aa-2293517ffcc6}"

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.jpeg\Shell\setdesktopwallpaper]
            @=hex(2):40,00,25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,\
              00,25,00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,73,00,\
              74,00,6f,00,62,00,6a,00,65,00,63,00,74,00,2e,00,64,00,6c,00,6c,00,2c,00,2d,\
              00,34,00,31,00,37,00,00,00
            "MultiSelectModel"="Player"
            "NeverDefault"=""
            "SuppressionSlapiPolicy"="ChangeDesktopBackground-Enabled"

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.jpeg\Shell\setdesktopwallpaper\Command]
            @=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,00,25,\
              00,5c,00,45,00,78,00,70,00,6c,00,6f,00,72,00,65,00,72,00,2e,00,65,00,78,00,\
              65,00,00,00
            "DelegateExecute"="{ff609cc7-d34d-4049-a1aa-2293517ffcc6}"

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.jpg\Shell\setdesktopwallpaper]
            @=hex(2):40,00,25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,\
              00,25,00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,73,00,\
              74,00,6f,00,62,00,6a,00,65,00,63,00,74,00,2e,00,64,00,6c,00,6c,00,2c,00,2d,\
              00,34,00,31,00,37,00,00,00
            "MultiSelectModel"="Player"
            "NeverDefault"=""
            "SuppressionSlapiPolicy"="ChangeDesktopBackground-Enabled"

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.jpg\Shell\setdesktopwallpaper\Command]
            @=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,00,25,\
              00,5c,00,45,00,78,00,70,00,6c,00,6f,00,72,00,65,00,72,00,2e,00,65,00,78,00,\
              65,00,00,00
            "DelegateExecute"="{ff609cc7-d34d-4049-a1aa-2293517ffcc6}"

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.png\Shell\setdesktopwallpaper]
            @=hex(2):40,00,25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,\
              00,25,00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,73,00,\
              74,00,6f,00,62,00,6a,00,65,00,63,00,74,00,2e,00,64,00,6c,00,6c,00,2c,00,2d,\
              00,34,00,31,00,37,00,00,00
            "MultiSelectModel"="Player"
            "NeverDefault"=""
            "SuppressionSlapiPolicy"="ChangeDesktopBackground-Enabled"

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.png\Shell\setdesktopwallpaper\Command]
            @=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,00,25,\
              00,5c,00,45,00,78,00,70,00,6c,00,6f,00,72,00,65,00,72,00,2e,00,65,00,78,00,\
              65,00,00,00
            "DelegateExecute"="{ff609cc7-d34d-4049-a1aa-2293517ffcc6}"

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.tif\Shell\setdesktopwallpaper]
            @=hex(2):40,00,25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,\
              00,25,00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,73,00,\
              74,00,6f,00,62,00,6a,00,65,00,63,00,74,00,2e,00,64,00,6c,00,6c,00,2c,00,2d,\
              00,34,00,31,00,37,00,00,00
            "MultiSelectModel"="Player"
            "NeverDefault"=""
            "SuppressionSlapiPolicy"="ChangeDesktopBackground-Enabled"

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.tif\Shell\setdesktopwallpaper\Command]
            @=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,00,25,\
              00,5c,00,45,00,78,00,70,00,6c,00,6f,00,72,00,65,00,72,00,2e,00,65,00,78,00,\
              65,00,00,00
            "DelegateExecute"="{ff609cc7-d34d-4049-a1aa-2293517ffcc6}"

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.tiff\Shell\setdesktopwallpaper]
            @=hex(2):40,00,25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,\
              00,25,00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,73,00,\
              74,00,6f,00,62,00,6a,00,65,00,63,00,74,00,2e,00,64,00,6c,00,6c,00,2c,00,2d,\
              00,34,00,31,00,37,00,00,00
            "MultiSelectModel"="Player"
            "NeverDefault"=""

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.tiff\Shell\setdesktopwallpaper\Command]
            @=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,00,25,\
              00,5c,00,45,00,78,00,70,00,6c,00,6f,00,72,00,65,00,72,00,2e,00,65,00,78,00,\
              65,00,00,00
            "DelegateExecute"="{ff609cc7-d34d-4049-a1aa-2293517ffcc6}"

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.wdp\Shell\setdesktopwallpaper]
            @=hex(2):40,00,25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,\
              00,25,00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,73,00,\
              74,00,6f,00,62,00,6a,00,65,00,63,00,74,00,2e,00,64,00,6c,00,6c,00,2c,00,2d,\
              00,34,00,31,00,37,00,00,00
            "MultiSelectModel"="Player"
            "NeverDefault"=""
            "SuppressionSlapiPolicy"="ChangeDesktopBackground-Enabled"

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.wdp\Shell\setdesktopwallpaper\Command]
            @=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,00,25,\
              00,5c,00,45,00,78,00,70,00,6c,00,6f,00,72,00,65,00,72,00,2e,00,65,00,78,00,\
              65,00,00,00
            "DelegateExecute"="{ff609cc7-d34d-4049-a1aa-2293517ffcc6}"

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.webp\Shell\setdesktopwallpaper]
            @=hex(2):40,00,25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,\
              00,25,00,5c,00,73,00,79,00,73,00,74,00,65,00,6d,00,33,00,32,00,5c,00,73,00,\
              74,00,6f,00,62,00,6a,00,65,00,63,00,74,00,2e,00,64,00,6c,00,6c,00,2c,00,2d,\
              00,34,00,31,00,37,00,00,00
            "MultiSelectModel"="Player"
            "NeverDefault"=""
            "SuppressionSlapiPolicy"="ChangeDesktopBackground-Enabled"

            [HKEY_CLASSES_ROOT\SystemFileAssociations\.webp\Shell\setdesktopwallpaper\Command]
            @=hex(2):25,00,53,00,79,00,73,00,74,00,65,00,6d,00,52,00,6f,00,6f,00,74,00,25,\
              00,5c,00,45,00,78,00,70,00,6c,00,6f,00,72,00,65,00,72,00,2e,00,65,00,78,00,\
              65,00,00,00
            "DelegateExecute"="{ff609cc7-d34d-4049-a1aa-2293517ffcc6}"

            ; Restore share
            [HKEY_CLASSES_ROOT\AllFilesystemObjects\shellex\ContextMenuHandlers\ModernSharing]
            @="{e2bf9676-5f8f-435c-97eb-11607a5bedf7}"

            ; Restore troubleshoot compatibility
            [HKEY_CLASSES_ROOT\exefile\shellex\ContextMenuHandlers\Compatibility]
            @="{1d27f844-3a1f-4410-85ac-14651078412d}"

            ; Restore turn on BitLocker
            [HKEY_CLASSES_ROOT\Drive\shell\encrypt-bde-elev]
            "LegacyDisable"=-

            ; Restore explore background
            [HKEY_CURRENT_USER\Software\Classes\DesktopBackground\shell\.SpotlightLearnMore]
            "ProgrammaticAccessOnly"=-

            ; Restore next desktop background
            [HKEY_CURRENT_USER\Software\Classes\DesktopBackground\shell\.SpotlightNextImage]
            "ProgrammaticAccessOnly"=-

            [HKEY_CLASSES_ROOT\DesktopBackground\shellex\ContextMenuHandlers\DesktopSlideshow]
            @="{0bf754aa-c967-445c-ab3d-d8fda9bae7ef}"

            ; Restore ask Copilot
            [HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Shell Extensions\Blocked]
            "{CB3B0003-8088-4EDE-8769-8B354AB2FF8C}"=-
            "{ED215C26-C810-49CE-929E-31D7E83A82E9}"=-
'@ -replace '(?m)^ {12}')

            $regPath = Join-Path $env:SystemRoot 'Temp\DefaultContextMenu.reg'
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
