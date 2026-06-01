# Various PowerShell Scripts

A collection of useful PowerShell scripts that don't require a dedicated repository.

## Available Scripts

- **Black Theme** - Applies a true black theme to Windows.
- **Browser Policies** - Adds policies to configure essential browser settings in Edge, Brave, and Chrome.
- **Core Parking** - Adjusts OS-managed CPU core parking.
- **DLSS Overlay** - Shows the DLSS version overlay in-game.
- **Digital Markets Act** - Enables EU DMA compliance, allowing native removal of enforced apps like Edge and Store, reducing the amount of diagnostic data sent, and unlocking additional system settings. Learn more [here](https://youtu.be/MfBNxGw_5J8?is=VMEVvqxa6HWFmF2N).
- **Higher Scaling No Accel** - Removes desktop mouse acceleration when using scaling above 100%. (Credit: MarkC)
- **Legacy File Explorer** - Restores the classic file explorer ribbon on Windows 11.
- **Legacy Settings** - Adds a Legacy Settings flyout to the desktop context menu with quick access to classic Control Panel applets.
- **Manage Windows Updates** - Pauses updates for 1 year or disables them entirely.
- **NetFx3** - Installs .NET Framework 3.5 instantly using local installation media instead of Windows Update servers, avoiding slow download times.
- **Open File Security Warning** - Removes the security warning and automatic file blocking for downloaded files.
- **Start Menu Version** - Activates the new 25H2 start menu or reverts to the 24H2 version on supported Windows 11 26200 builds.
- **User Account Control** - Disables the UAC elevation prompt for administrative tasks.

> [!TIP]
> If the script closes immediately, open PowerShell as Administrator and run:
> ```powershell
> Set-ExecutionPolicy Unrestricted -Force
> ```

> [!NOTE]
> All scripts include a revert option.
