<h1 align="center">PowerShelf</h1>
<p align="center">A collection of useful PowerShell scripts to configure and customize Windows.</p>

---

### Available Scripts
- **[Black Theme](BlackTheme.ps1)** - Applies a true black theme to Windows.
- **[Browser Policies](BrowserPolicies.ps1)** - Adds policies to configure essential browser settings (supports Edge, Brave and Chrome).
- **[Clean Context Menu](CleanContextMenu.ps1)** - Removes unnecessary options from the right-click context menu.
- **[Core Parking](CoreParking.ps1)** - Disables OS-managed CPU core parking.
- **[DLSS Overlay](DlssOverlay.ps1)** - Shows the DLSS version overlay in-game.
- **[Digital Markets Act](DigitalMarketsAct.ps1)** - Allows native removal of enforced apps such as Edge and Store, reduces telemetry, and unlocks additional system settings. Learn more [here](https://youtu.be/MfBNxGw_5J8?is=VMEVvqxa6HWFmF2N).
- **[Higher Scaling No Accel](HigherScalingNoAccel.ps1)** - Removes desktop mouse acceleration when using scaling above 100% (recommended only when all monitors use the same scaling value).
- **[Legacy Explorer Ribbon](LegacyExplorerRibbon.ps1)** - Restores the old Windows 10 File Explorer ribbon on Windows 11.
- **[Legacy Settings](LegacySettings.ps1)** - Adds a Legacy Settings flyout to the desktop context menu with quick access to classic Control Panel applets.
- **[Manage Windows Updates](ManageWindowsUpdates.ps1)** - Pauses Windows updates for 1 year, disables them entirely or disables driver updates.
- **[NetFx3](NetFx3.ps1)** - Installs .NET Framework 3.5 instantly using local installation media instead of Windows Update servers, avoiding slow download times.
- **[Open File Security Warning](OpenFileSecurityWarning.ps1)** - Removes the security warning and automatic file blocking for downloaded files.
- **[Start Menu Version](StartMenuVersion.ps1)** - Activates the new 25H2 Start Menu or reverts to the 24H2 version on supported Windows 11 26200 builds.
- **[User Account Control](UserAccountControl.ps1)** - Disables the UAC elevation prompt for administrative tasks.

---

> [!TIP]
> If the script closes immediately, open PowerShell as Administrator and run:
> ```powershell
> Set-ExecutionPolicy Unrestricted -Force
> ```

> [!NOTE]
> All scripts include a revert option.
