if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]'Administrator')) {
    Start-Process PowerShell.exe -ArgumentList ('-NoProfile -ExecutionPolicy Bypass -File "{0}"' -f $PSCommandPath) -Verb RunAs
    exit
}

$Host.UI.RawUI.BackgroundColor = 'Black'
$Host.UI.RawUI.ForegroundColor = 'White'
Clear-Host

Write-Host "Installation media (USB boot drive) needs to be connected.`n" -ForegroundColor Yellow
Write-Host 'Press Enter to continue...' -NoNewline
do {
    $key = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
} while ($key.VirtualKeyCode -ne 13)

Clear-Host

$sourcePath = $null

foreach ($drive in (Get-PSDrive -PSProvider FileSystem)) {
    $testPath = Join-Path $drive.Root 'sources\sxs'

    if (Test-Path $testPath) {
        $sourcePath = $testPath
        break
    }
}

if (-not $sourcePath -or -not (Test-Path $sourcePath)) {
    Write-Host "Error: Could not find a drive containing \sources\sxs. Make sure the installation media is connected.`n" -ForegroundColor Red
    Write-Host 'Press any key to exit...' -NoNewline
    $null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown')
    return
}

# Install NetFx3
Write-Host 'Installing NetFx3...' -NoNewline
dism /online /enable-feature /featurename:NetFx3 /all /source:$sourcePath /limitaccess | Out-Null

# Open optional features
Start-Process optionalfeatures.exe
