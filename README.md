# Various PowerShell Scripts
A collection of useful PowerShell scripts for Windows.

---

### Available Scripts
- **[Black Theme](Black%20Theme.ps1)** - Applies a true black theme to Windows.
- **[Browser Policies](Browser%20Policies.ps1)** - Adds policies to configure essential browser settings (supports Edge, Brave, and Chrome).
- **[Clean Context Menu](Clean%20Context%20Menu.ps1)** - Removes unnecessary options from the right-click context menu.
- **[Core Parking](Core%20Parking.ps1)** - Prevents Windows from parking CPU cores.
- **[DLSS Overlay](DLSS%20Overlay.ps1)** - Shows the DLSS version overlay in-game.
- **[Digital Markets Act](Digital%20Markets%20Act.ps1)** - Enables EU DMA compliance, allowing native removal of enforced apps like Edge and Store, reducing telemetry, and unlocking additional system settings. Learn more [here](https://youtu.be/MfBNxGw_5J8?is=VMEVvqxa6HWFmF2N).
- **[Higher Scaling No Accel](Higher%20Scaling%20No%20Accel.ps1)** - Removes desktop mouse acceleration when using scaling above 100% (recommended only when all monitors use the same scaling value).
- **[Legacy File Explorer](Legacy%20File%20Explorer.ps1)** - Restores the classic file explorer ribbon on Windows 11.
- **[Legacy Settings](Legacy%20Settings.ps1)** - Adds a Legacy Settings flyout to the desktop context menu with quick access to classic Control Panel applets.
- **[Manage Windows Updates](Manage%20Windows%20Updates.ps1)** - Pauses updates for 1 year or disables them entirely.
- **[NetFx3](NetFx3.ps1)** - Installs .NET Framework 3.5 instantly using local installation media instead of Windows Update servers, avoiding slow download times.
- **[Open File Security Warning](Open%20File%20Security%20Warning.ps1)** - Removes the security warning and automatic file blocking for downloaded files.
- **[Start Menu Version](Start%20Menu%20Version.ps1)** - Activates the new 25H2 start menu or reverts to the 24H2 version on supported Windows 11 26200 builds.
- **[User Account Control](User%20Account%20Control.ps1)** - Disables the UAC elevation prompt for administrative tasks.

---

> [!TIP]
> If the script closes immediately, open PowerShell as Administrator and run:
> ```powershell
> Set-ExecutionPolicy Unrestricted -Force
> ```

> [!NOTE]
> All scripts include a revert option.
