# Release Notes

## 1.0.0 on 2018-12-27

### Notes
We're happy to release the first production-ready version of TinyCLR OS, our modern and managed .NET development system for tiny IoT and embedded devices that uses the world-class Microsoft Visual Studio with C# and Visual Basic. TinyCLR can be used commercially on our System on Modules but you can also port it to your own system, free of charge, using our prebuilt cores for ARM7, ARM9, Cortex M3, Cortex M4, and Cortex M7 and the freely available GCC compiler. We're already hard at work on the next release where we plan to bring even more features that make embedded development even faster and easier.

The libraries, extension, and firmwares are all uploaded to their online sources so you can update your firmware using TinyCLR Config, update your packages using the NuGet package manager with the NuGet.org source, and update the VSIX from the extensions area of Visual Studio. To get going, take a look at the [Getting Started](getting-started.md) guide.

### Libraries

#### Changes
- None.

#### Known Issues
- Support for the embedded Visual Basic runtime is incomplete and some uses may throw cryptic compile errors [#51](https://github.com/ghi-electronics/TinyCLR-Libraries/issues/51).
- `DrawPicture` on the BrainPad does not work correctly [#313](https://github.com/ghi-electronics/TinyCLR-Libraries/issues/313).
- SPWF04Sx Wi-Fi on the FEZ does not work unless PA0 is manually set low before initialization [#28](https://github.com/ghi-electronics/TinyCLR-Drivers/issues/28).

### Firmware

#### Changes
- None.

#### Known Issues
- Testing `NaN`s for equality gives unexpected results [#231](https://github.com/ghi-electronics/TinyCLR-Core/issues/231).
- The `.constrained` IL prefix is not supported and throws `UnsupportedInstructionException` [#76](https://github.com/ghi-electronics/TinyCLR-Core/issues/76).
- Using exception filters may crash the system in some uses [#177](https://github.com/ghi-electronics/TinyCLR-Ports/issues/177).
- CAN message timestamps use the wrong origin [#579](https://github.com/ghi-electronics/TinyCLR-Ports/issues/579).
- CAN timing calculation does not use all of the values correctly [#576](https://github.com/ghi-electronics/TinyCLR-Ports/issues/576).
- Signal generator generates incorrect timings in some cases [#526](https://github.com/ghi-electronics/TinyCLR-Ports/issues/526).
- Multi-pin reservations where the first pin is already reserved mistakenly return okay [#580](https://github.com/ghi-electronics/TinyCLR-Ports/issues/580).
- PWM polarity is opposite from what it should be on G120 and G400 [#581](https://github.com/ghi-electronics/TinyCLR-Ports/issues/581).
- The first clock for signal generator is the same as idle state [#582](https://github.com/ghi-electronics/TinyCLR-Ports/issues/582).
- When not debugging the application may slow down [#584](https://github.com/ghi-electronics/TinyCLR-Ports/issues/584).

### TinyCLR Config

#### Changes
- None.

#### Known Issues
- None.

### Extension

#### Changes
- None.

#### Known Issues
- When adding an image or font to a resx file, a reference to the drawing assembly is not automatically added [#90](https://github.com/ghi-electronics/TinyCLR-SDK/issues/90).

### Porting

#### Changes
- None.

#### Known Issues
- None.

## 1.0.0-preview3 on 2018-11-30

### Notes
This release is the third and final planned preview of the 1.0 release for TinyCLR. There have been no major changes in this release -- its entire focus was bug fixing. We'll wait a few weeks to ensure no major issues are discovered before rebuilding with the final release version numbers and doing the final release.

We are also maintaining our decision to keep throwing an exception when `.constrained` is encountered instead of potentially allowing silent and incorrect behavior. It is currently known to be used when accessing overridden members on structs, particularly those from object like `ToString`, `Equals`, and `GetHashCode`. You'll encounter it on `enum` and `TimeSpan`, among others.

The libraries, extension, and firmwares are all uploaded to their online sources so you can update your firmware using TinyCLR Config, update your packages using the NuGet package manager with the NuGet.org source, and update the VSIX from the extensions area of Visual Studio (make sure to include pre-releases for NuGet as this is still a preview). We will still make these binaries available on our own hosting as well, but the expected workflow remains the usual NuGet/marketplace search and download process you have for other packages and extensions. You can find all downloads in their respective sections on the [downloads](downloads.md) page.

### Libraries

#### Changes
- Fixed cases where SPWF04Sx will sometimes lose writes [#14](https://github.com/ghi-electronics/TinyCLR-Drivers/issues/14).
- Fixed `SPWF04SxConnectionType` being misspelled [#26](https://github.com/ghi-electronics/TinyCLR-Drivers/issues/26).
- Fixed `GetFiles` and `EnumerateFileSystemEntries` having an extra slash in path [#309](https://github.com/ghi-electronics/TinyCLR-Libraries/issues/309).
- Fixed managed drawing functions throwing when out of range [#300](https://github.com/ghi-electronics/TinyCLR-Libraries/issues/300).
- Fixed red and blue being swapped in the UI library [#306](https://github.com/ghi-electronics/TinyCLR-Libraries/issues/306).
- Fixed some pins and ports names being out of sync [#193](https://github.com/ghi-electronics/TinyCLR-Libraries/issues/193).
- Fixed software I2C not running at a consistent speed [#515](https://github.com/ghi-electronics/TinyCLR-Ports/issues/515).
- Fixed software SPI not respecting `ChipSelectType` [#459](https://github.com/ghi-electronics/TinyCLR-Ports/issues/459).
- Added missing SD, RTC, and Wi-Fi names to pins [#266](https://github.com/ghi-electronics/TinyCLR-Libraries/issues/266).
- Added chipselect hold and setup time to software SPI [#292](https://github.com/ghi-electronics/TinyCLR-Libraries/issues/292).
- Added support for carrier frequency in signal generator [#477](https://github.com/ghi-electronics/TinyCLR-Ports/issues/477).
- Changed `DrawPixel` in display controller to use the format of the display controller [#543](https://github.com/ghi-electronics/TinyCLR-Ports/issues/543).
- Removed setter from `IDriveProvider.Name` in place of an `Initialize` method [#297](https://github.com/ghi-electronics/TinyCLR-Libraries/issues/297).

#### Known Issues
- Support for the embedded Visual Basic runtime is incomplete and some uses may throw cryptic compile errors [#51](https://github.com/ghi-electronics/TinyCLR-Libraries/issues/51).
- SPWF04Sx Wi-Fi on the FEZ does not work unless PA0 is manually set low before initialization [#28](https://github.com/ghi-electronics/TinyCLR-Drivers/issues/28).

### Firmware

#### Changes
- Fixed PWM jittering when decreasing the pulse width [#102](https://github.com/ghi-electronics/TinyCLR-Devices/issues/102).
- Fixed the reported messages received on CAN being incorrect [#527](https://github.com/ghi-electronics/TinyCLR-Ports/issues/527).
- Fixed the CTS changed event not working [#59](https://github.com/ghi-electronics/TinyCLR-Devices/issues/59).
- Fixed deployment not getting added to api manager [#545](https://github.com/ghi-electronics/TinyCLR-Ports/issues/545).
- Fixed `SupportedDataFormats` in display throwing an exception on access [#572](https://github.com/ghi-electronics/TinyCLR-Ports/issues/572).
- Fixed `DrawString` not resetting row/column on soft reboot [#542](https://github.com/ghi-electronics/TinyCLR-Ports/issues/542).
- Fixed enabling CAN before setting timings throwing the wrong exception [#554](https://github.com/ghi-electronics/TinyCLR-Ports/issues/554).
- Fixed the `Read` and `Write` in storage provider crashing the device [#495](https://github.com/ghi-electronics/TinyCLR-Ports/issues/495).
- Fixed use of filesystem crashing the second deploy without a power cycle [#457](https://github.com/ghi-electronics/TinyCLR-Ports/issues/457).
- Fixed being able to mount the filesystem after previously unmounting it [#491](https://github.com/ghi-electronics/TinyCLR-Ports/issues/491) [#506](https://github.com/ghi-electronics/TinyCLR-Ports/issues/506).
- Fixed the system crashing if the SD card is removed after acquiring the controller [#498](https://github.com/ghi-electronics/TinyCLR-Ports/issues/498).
- Fixed deploying on G120 and G400 sometimes failing [#431](https://github.com/ghi-electronics/TinyCLR-Ports/issues/431).
- Fixed G120 disappearing in TinyCLR Config if the device is rebooted [#513](https://github.com/ghi-electronics/TinyCLR-Ports/issues/513).
- Fixed enabling handshaking on UART2 crashing the G30 [#518](https://github.com/ghi-electronics/TinyCLR-Ports/issues/518).
- Fixed signal generator failing on G400 [#461](https://github.com/ghi-electronics/TinyCLR-Ports/issues/461).
- Fixed software I2C failing on G400 [#458](https://github.com/ghi-electronics/TinyCLR-Ports/issues/458).
- Fixed G80 serial debug not working [#456](https://github.com/ghi-electronics/TinyCLR-Ports/issues/456).
- Fixed GPIO interrupts not always working [#496](https://github.com/ghi-electronics/TinyCLR-Ports/issues/496) [#578](https://github.com/ghi-electronics/TinyCLR-Ports/issues/578).
- Fixed graphics getting corrupt on the UC5550 after some time [#562](https://github.com/ghi-electronics/TinyCLR-Ports/issues/562).
- Fixed RTC not working on G400 [#460](https://github.com/ghi-electronics/TinyCLR-Ports/issues/460).
- Fixed rebooting the device in serial mode taking a long time [#509](https://github.com/ghi-electronics/TinyCLR-Ports/issues/509).
- Fixed the native SPI drivers not respecting `ChipSelectType` [#471](https://github.com/ghi-electronics/TinyCLR-Ports/issues/471).
- Fixed SPI `SupportedDataBitLengths` throwing an exception on access [#557](https://github.com/ghi-electronics/TinyCLR-Ports/issues/557).
- Fixed the storage description having wrong values and format for size, address, and attributes [#544](https://github.com/ghi-electronics/TinyCLR-Ports/issues/544)  [#571](https://github.com/ghi-electronics/TinyCLR-Ports/issues/571).
- Fixed multi-pin reservations not releasing previously reserved pins if a pin fails to reserve [#312](https://github.com/ghi-electronics/TinyCLR-Ports/issues/312).
- Fixed the timestamp for HAL events using the wrong origin [#546](https://github.com/ghi-electronics/TinyCLR-Ports/issues/546).
- Fixed `GetMessagesToWrite` in CAN crashing the device [#555](https://github.com/ghi-electronics/TinyCLR-Ports/issues/555).
- Fixed the UART `DataReceived` event not raising for all data [#547](https://github.com/ghi-electronics/TinyCLR-Ports/issues/547).
- Fixed UART handshaking not always working [#462](https://github.com/ghi-electronics/TinyCLR-Ports/issues/462).
- Fixed UARTHS-B handshaking not working on UC2550 [#517](https://github.com/ghi-electronics/TinyCLR-Ports/issues/517).
- Fixed entering bootloader from TinyCLR Config not working on UC5550 [#503](https://github.com/ghi-electronics/TinyCLR-Ports/issues/503).
- Fixed UC5550 sometimes crashing [#484](https://github.com/ghi-electronics/TinyCLR-Ports/issues/484).
- Removed the `-mlong-calls` compiler flag [#501](https://github.com/ghi-electronics/TinyCLR-Ports/issues/501).
- Removed display backlight from the native driver [#481](https://github.com/ghi-electronics/TinyCLR-Ports/issues/481).
- Improved performance of flushing the display on STM32F7 [#487](https://github.com/ghi-electronics/TinyCLR-Ports/issues/487).
- Changed pins to default pull-up [#563](https://github.com/ghi-electronics/TinyCLR-Ports/issues/563).

#### Known Issues
- Testing `NaN`s for equality gives unexpected results [#231](https://github.com/ghi-electronics/TinyCLR-Core/issues/231).
- The `.constrained` IL prefix is not supported [#76](https://github.com/ghi-electronics/TinyCLR-Core/issues/76).
- Using exception filters may crash the system in some uses [#177](https://github.com/ghi-electronics/TinyCLR-Ports/issues/177).
- CAN message timestamps use the wrong origin [#579](https://github.com/ghi-electronics/TinyCLR-Ports/issues/579).
- CAN timing calculation does not use all of the values correctly [#576](https://github.com/ghi-electronics/TinyCLR-Ports/issues/576).
- Signal generator generates incorrect timings in some cases [#526](https://github.com/ghi-electronics/TinyCLR-Ports/issues/526).
- Multi-pin reservations where the first pin is already reserved mistakenly return okay [#580](https://github.com/ghi-electronics/TinyCLR-Ports/issues/580).
- PWM polarity is opposite from what it should be on G120 and G400 [#581](https://github.com/ghi-electronics/TinyCLR-Ports/issues/581).
- The first clock for signal generator is the same as idle state [#582](https://github.com/ghi-electronics/TinyCLR-Ports/issues/582).

### TinyCLR Config

#### Changes
- Added a version field to the UI [#24](https://github.com/ghi-electronics/TinyCLR-Config/issues/24).

#### Known Issues
- None.

### Extension

#### Changes
- Fixed deploying a project using fewer sectors than a previous project leaving old assemblies on the device [#151](https://github.com/ghi-electronics/TinyCLR-SDK/issues/151).
- Fixed inspecting certain variables in the debugger locking up the device [#152](https://github.com/ghi-electronics/TinyCLR-SDK/issues/152).
- Fixed rebooting TinyCLR sometimes throwing when trying to connect to the USB stream [#155](https://github.com/ghi-electronics/TinyCLR-SDK/issues/155).

#### Known Issues
- When adding an image or font to a resx file, a reference to the drawing assembly is not automatically added [#90](https://github.com/ghi-electronics/TinyCLR-SDK/issues/90).

### Porting

#### Changes
- Fixed product version string showing the version numbers and not the friendly string [#356](https://github.com/ghi-electronics/TinyCLR-Core/issues/356).
- Fixed some API IDs and target names not matching [#292](https://github.com/ghi-electronics/TinyCLR-Ports/issues/292).
- Added interrupt and sleep data to power [#480](https://github.com/ghi-electronics/TinyCLR-Ports/issues/480).
- Added USB get connection status [#568](https://github.com/ghi-electronics/TinyCLR-Ports/issues/568).
- Added OneWire API type ID [#359](https://github.com/ghi-electronics/TinyCLR-Core/issues/359).
- Added TouchController API type ID [#357](https://github.com/ghi-electronics/TinyCLR-Core/issues/357).
- Added USB connection event and property [#367](https://github.com/ghi-electronics/TinyCLR-Core/issues/367).
- Removed the presence event and property from storage [#361](https://github.com/ghi-electronics/TinyCLR-Core/issues/361).

#### Known Issues
- None.

## 1.0.0-preview2 on 2018-09-28

### Notes
This release is the second preview of the 1.0 release for TinyCLR. It also marks the point where we are feature complete for 1.0! If we do another preview release, it'll just be a bug fix release. The biggest change in this release is the addition of a managed graphics provider and the initial release of some drivers for common chips (like the one on our old N18 display). There are also several usability tweaks to SPI and the three signals classes.

To support uploading to the Visual Studio gallery, we had to change the package ID used by the project system extension. This means the old one will not get uninstalled when installing this release, so please uninstall the preview1 or older extensions manually.

We're also releasing a tool to convert desktop TrueType fonts to the format used by TinyCLR. Keep in mind there are legal implications to using and distributing fonts and that we cannot provide advice on that. The tool used to convert binary files to `glb` and `ghi` files was also updated to support generating `UF2` files used by the BrainPad (which has its own new firmware in this release as well, available on https://brainpad.com/).

The UC2550 and UC5550 now come in a `glb` format instead of the old `ghi` format and you can find their device definitions in the ports repo as well. There is also a new bootloader for the UC5550 available on the [bootloader page](../../hardware/loaders/ghi-bootloader.md).

We have decided to keep throwing an exception when `.constrained` is encountered instead of potentially allowing silent and incorrect behavior. It is currently known to be used when accessing overridden members on structs, particularly those from object like `ToString`, `Equals`, and `GetHashCode`. You'll encounter it on `enum` and `TimeSpan`, among others.

The libraries are once again uploaded to our [NuGet account](https://www.nuget.org/profiles/ghielectronics). Make sure to enable finding prereleases in the NuGet package manager. We've also uploaded the extension to the [Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=ghielectronics.tinyclr-projectsystem) so you can download and install it from there and then keep it up to date with Visual Studio. We will still make them available on our own hosting as well, but the expected workflow remains the usual NuGet/marketplace search and download process you have for other packages and extensions. You can find all downloads in their respective sections on the [downloads](downloads.md) page. As before, you can update your firmware using TinyCLR Config and now you can update your packages using the NuGet package manager from the online source.

### Libraries

#### Changes
- Added chip select setup time, hold time, and polarity to SPI settings.
- Added `Now` to `RtcController` that takes a `DataTime`.
- Added `IsValid` to `RtcController`.
- Added `Rgb444` and `VerticalByteStrip1Bpp ` display formats.
- Added I2C display interface type.
- Added a public constructor to `Font`.
- Added infrastructure to provide custom draw targets to be used with a managed graphics implementation using `GraphicsManager` in drawing.
- Added built in draw targets that draw to an in-memory buffer in various formats.
- Added `AssemblyInformationalVersion` attributes to every library.
- Added `SSD1306`, `ST7735`, and `APA102C` drivers.
- Added `Memory` to the native library that exposes members from the native provider.
- Added `ChipSelectType` to `SpiConnectionSettings` to pick between GPIO, controller, and none.
- Fixed red and blue being swapped in the internal field of `Color`.
- Fixed software I2C not working [#365](https://github.com/ghi-electronics/TinyCLR-Ports/issues/365).
- Fixed software SPI not working [#293](https://github.com/ghi-electronics/TinyCLR-Ports/issues/293).
- Moved `SPWF04Sx` driver to the drivers namespace and package.
- Removed `UseControllerChipSelect` from `SpiConnectionSettings`.
- Removed the constructor from `SpiConnectionSettings`.

#### Known Issues
- SPWF04Sx may sometimes lose writes [#14](https://github.com/ghi-electronics/TinyCLR-Drivers/issues/14).
- Support for the embedded Visual Basic runtime is incomplete and some uses may throw cryptic compile errors.
- A number of API names are missing from pins, notably RTC and SD.
- Carrier frequency does not work on signal generator.

### Firmware

#### Changes
- Added new BrainPad BP2 firmware.
- Added signals to UC2550 and UC5550.
- Added filesystem to G30 [#322](https://github.com/ghi-electronics/TinyCLR-Ports/issues/322).
- Fixed `DisplayController.DrawBuffer` failing for data not sized to the entire screen [#410](https://github.com/ghi-electronics/TinyCLR-Ports/issues/410).
- Fixed `DisplayController.DrawPixel` using an incorrect format.
- Fixed ADC on G120E failing if closed multiple times [#438](https://github.com/ghi-electronics/TinyCLR-Ports/issues/438).
- Fixed UART failing to receive any data after receiving an error on G400 [#428](https://github.com/ghi-electronics/TinyCLR-Ports/issues/428).
- Fixed CAN pins being reversed on the UC2550.
- Fixed memory intensive applications crashing low-memory devices [#423](https://github.com/ghi-electronics/TinyCLR-Ports/issues/423).
- Fixed I2C failing on some slaves, [#416](https://github.com/ghi-electronics/TinyCLR-Ports/issues/416).
- Fixed UART `DataReceived` event always returning a count of zero.
- Fixed servo not working on the BrainPad, [#414](https://github.com/ghi-electronics/TinyCLR-Ports/issues/414).
- Fixed multiple I2C devices failing when used together.
- Fixed heavy serial load crashing STM32Fx devices [#411](https://github.com/ghi-electronics/TinyCLR-Ports/issues/411).
- Fixed the `Edge` property on the GPIO interrupt sometimes being incorrect.
- Fixed G400 ADC not always being accurate [#373](https://github.com/ghi-electronics/TinyCLR-Ports/issues/373).
- Fixed several HAL functions having no implementation [#376](https://github.com/ghi-electronics/TinyCLR-Ports/issues/376).
- Fixed the run-app pin failing on USBizi [#333](https://github.com/ghi-electronics/TinyCLR-Ports/issues/333).
- Fixed the UD700 getting corrupt on the UC5550 after a few minutes.
- Implemented all of signal capture and pulse feedback and most of signal generator [#357](https://github.com/ghi-electronics/TinyCLR-Ports/issues/357).
- Implemented many functions missing on USB client [#398](https://github.com/ghi-electronics/TinyCLR-Ports/issues/398).

#### Known Issues
- PWM may jitter when decreasing the pulse length while enabled.
- Testing `NaN`s for equality gives unexpected results.
- The `.constrained` IL prefix is not supported.
- Using exception filters may crash the system in some uses [#177](https://github.com/ghi-electronics/TinyCLR-Ports/issues/177).
- During multi-pin reservations, if a later pin fails to reserve, previously reserved ones are not released [#312](https://github.com/ghi-electronics/TinyCLR-Ports/issues/312).
- Serial debug sometimes fails on G80 [#456](https://github.com/ghi-electronics/TinyCLR-Ports/issues/456).
- Deployment after accessing filesystem fails [#457](https://github.com/ghi-electronics/TinyCLR-Ports/issues/457).
- Software I2C fails on G400 [#458](https://github.com/ghi-electronics/TinyCLR-Ports/issues/458).
- Software SPI fails for some slaves [#459](https://github.com/ghi-electronics/TinyCLR-Ports/issues/459).
- RTC fails on G400 [#460](https://github.com/ghi-electronics/TinyCLR-Ports/issues/460).
- G400 signal generator generates incorrect timings [#461](https://github.com/ghi-electronics/TinyCLR-Ports/issues/461).
- UART handshaking behaves inconsistently [#462](https://github.com/ghi-electronics/TinyCLR-Ports/issues/462).

### TinyCLR Config

#### Changes
- Fixed help URLs.

#### Known Issues
- None.

### Extension

#### Changes
- Updated the package ID of the VSIX.

#### Known Issues
- When adding an image or font to a resx file, a reference to the drawing assembly is not automatically added.

### Porting

#### Changes
- Added timestamps to many device event handlers [#388](https://github.com/ghi-electronics/TinyCLR-Ports/issues/388) [#368](https://github.com/ghi-electronics/TinyCLR-Ports/issues/368).
- Added `IsValid` to `TinyCLR_Rtc_Controller`.
- Added a config object to `TinyCLR_Display_SpiConfiguration`.
- Added `TinyCLR_Display_I2cConfiguration`.
- Added `TinyCLR_Startup_SetMemoryProfile` that allows setting the memory profile of the device.
- Added `GetStats` to `TinyCLR_Memory_Manager` to return amount of memory free and used.
- Added wake source to `TinyCLR_Power_Controller::Sleep`.
- Added contiguous and equal-sized properties to the deployment configuration.
- Added UC2550 and UC5550 device headers to ports.
- Added UF2 support to `imagegen.exe` [#412](https://github.com/ghi-electronics/TinyCLR-Ports/issues/412).
- Changed the sleep level names to `LevelN`.
- Changed SPI, I2C, UART, and CAN configuration to take a config struct.
- Changed CAN read and write to take a message struct.
- Changed `TinyCLR_Startup_SetDeploymentApi` to `TinyCLR_Startup_AddDeploymentRegion`.
- Changed return type to `TinyCLR_Result` on power.
- Changed `TinyCLR_Task_Manager::Enqueue` time unit to be native ticks.
- Changed many of the members in `TinyCLR_Interrupt_Controller`.
- Changed the parameter `apiName` to `data0` (and shifted the rest) in `TinyCLR_Interop_Manager::RaiseEvent`.
- Changed `RegionsRepeat` into contiguous and equal-sized in storage.
- Fixed the linker not always complaining when regions overflow [#30](https://github.com/ghi-electronics/TinyCLR-Ports/issues/30).

#### Known Issues
- None.

## 1.0.0-preview1 on 2018-08-15

### Notes
This release is the first preview of the 1.0 release for TinyCLR. We will have at least one other preview after this one. The biggest change in this release is the rework and simplification of the devices library. It was divided into one library per peripheral to reduce deployment size for apps that don't require all libraries. We did keep the devices package as a metapackage that depends on the other packages so you can easily bring them all into your project if desired.

Many of the devices did keep a familiar API like ADC, DAC, and GPIO. Others like I2C and SPI did keep a similar device API but the controller was reworked. Previously you'd be able to call `FromId` on the device or controller object. Now you must call `FromName` on the controller and then call `GetDevice`. A few others had minor tweaks to names and members. Of particular note are that you must now call `Enable` to turn the display on and mounting with `FileSystem` now requires the `Hdc` property from the `SdCardController` instead of the controller instance itself.

UART saw a lot of changes in this release. The entire storage library was removed and the `SerialCommunication` class was changed into `UartController` to mirror the pattern used with all of the other devices. `DataReader` and `DataWriter` are gone as well, so reading and writing to UART can only be done with a byte array.

We also introduced a new native library that holds many of the things we added to `mscorlib` previously like interops, APIs, system time, `NativeEventDispatcher`, and, new in this release, power.

Given the amount of changes in the HAL layer we do expect a few more bugs in this release, but we are working to iron them all out before 1.0.

`.constrained` continues to throw in this release as we gather more data. It is currently known to be used when accessing overridden members on structs, particularly those from object like `ToString`, `Equals`, and `GetHashCode`. You'll encounter it on `enum` and `TimeSpan`, among others. We will be making a decision soon on whether or not to revert the exception before the final release.

In preparation for the official 1.0 release we are no longer building the firmwares for older unsupported devices. Please see [this doc](http://docs.ghielectronics.com/software/tinyclr/supported-devices.html) for more information. The source code remains available though so we invite you to contribute to it and build your own firmware. We have also uploaded the libraries to our [NuGet account](https://www.nuget.org/profiles/ghielectronics). Make sure to enable finding prereleases in the NuGet package manager. We will still make them available on our own hosting as well, but the expected workflow going forward is the usual NuGet search and download process you have for other packages and extensions. You can find all downloads in their respective sections on the [downloads](downloads.md) page. As before you, can update your firmware using TinyCLR Config and now you can update your packages using the NuGet package manager from the online source. There are no new bootloaders in this release.

### Libraries

#### Changes
- Reworked the APIs of many of the peripherals in `GHIElectronics.TinyCLR.Devices` library, particularly UART.
- Split up the `GHIElectronics.TinyCLR.Devices` into one library per peripheral.
- Removed the `GHIElectronics.TinyCLR.Storage` library.
- Added a new `GHIElectronics.TinyCLR.Native` library and moved `SystemTime`, `Interop`, `Api`, and `DeviceInformation` to it.
- Added `Power` to `GHIElectronics.TinyCLR.Native`.
- Added `DrawPixel` to the display controller.
- Added `DrawBuffer` to the display controller.
- Added `Enable` and `Disable` to many controllers.
- Reworked `SystemTime` to have `GetTime` and `SetTime` with `DateTime` overloads.
- Reworked and simplified the entire provider model, removing many classes in the process.
- Renamed `OutputEnable` to `DataEnable` on `DisplayController`.
- Renamed `ApplySettings` to `SetConfiguration` on `DisplayController`.
- Renamed `PwmPin` to `PwmChannel`.
- Fixed `GetDirectories` always throwing [#343](https://github.com/ghi-electronics/TinyCLR-Ports/issues/343).
- Reduced the default brightness of the light bulb on the BrainPad.

#### Known Issues
- SPWF04Sx may sometimes lose writes.
- Support for the embedded Visual Basic runtime is incomplete and some uses may throw cryptic compile errors.
- A number of API names are missing from pins, notably RTC and SD.
- The `Edge` property of GPIO interrupts is not always correct.
- Many properties on `SignalGenerator` and `SignalCapture` do not work.
- `PulseFeedback` does not work.
- `SoftwareI2C` does not work [#365](https://github.com/ghi-electronics/TinyCLR-Ports/issues/365).
- `DisplayController.DrawBuffer` does not work with a non-zero origin or size different than the entire screen [#410](https://github.com/ghi-electronics/TinyCLR-Ports/issues/410).
- `DisplayController.DrawPixel` draws the incorrect color.
- The timestamp is incorrect when creating a new file.

### Firmware

#### Changes
- Fixed I2C sharing conflicts incorrectly throwing `OutOfMemoryException` [#298](https://github.com/ghi-electronics/TinyCLR-Ports/issues/298).
- Fixed `OutputEnablePolarity` being inverted on UC5550 [#315](https://github.com/ghi-electronics/TinyCLR-Ports/issues/315).
- Fixed some SD cards getting corrupt after use on G400 [#319](https://github.com/ghi-electronics/TinyCLR-Ports/issues/319).
- Fixed G120 getting stuck deploying [#331](https://github.com/ghi-electronics/TinyCLR-Ports/issues/331).
- Fixed CAN not working on G400 [#332](https://github.com/ghi-electronics/TinyCLR-Ports/issues/332).
- Fixed the run app pin not working on USBizi [#333](https://github.com/ghi-electronics/TinyCLR-Ports/issues/333).
- Fixed paths requiring an extra `\` after the drive letter [#334](https://github.com/ghi-electronics/TinyCLR-Ports/issues/334).
- Fixed the display on the G400 reserving PC26 [#336](https://github.com/ghi-electronics/TinyCLR-Ports/issues/336).
- Removed the SPI display controller implementation.

#### Known Issues
- PWM may jitter when decreasing the pulse length while enabled.
- UART handshaking may miss data on STM32F4.
- Testing `NaN`s for equality gives unexpected results.
- `SignalGenerator` and `SignalCapture` do not work on UC2550 and UC5550.
- The UD700 will become corrupted after running for a few minutes on the UC5550.
- Using exception filters may crash the system in some uses [#177](https://github.com/ghi-electronics/TinyCLR-Ports/issues/177).
- Software SPI does not work with some devices [#293](https://github.com/ghi-electronics/TinyCLR-Ports/issues/293).
- During multi-pin reservations if a later pin fails to reserve, previously reserved ones are not released [#312](https://github.com/ghi-electronics/TinyCLR-Ports/issues/312).
- File system is not available on G30 [#322](https://github.com/ghi-electronics/TinyCLR-Ports/issues/322).
- The ADC is not accurate on the G400 [#373](https://github.com/ghi-electronics/TinyCLR-Ports/issues/373).
- Many events do not pass a timestamp [#368](https://github.com/ghi-electronics/TinyCLR-Ports/issues/368).
- Many of the non-essential functions of USB client are not implemented [#398](https://github.com/ghi-electronics/TinyCLR-Ports/issues/398).
- Using UART may eventually lockup the UC5550 [#411](https://github.com/ghi-electronics/TinyCLR-Ports/issues/411).

### TinyCLR Config

#### Changes
- Allowed the app to be resized.

#### Known Issues
- None.

### Extension

#### Changes
- None.

#### Known Issues
- When adding an image or font to a resx file a reference to the drawing assembly is not automatically added.

### Porting

#### Changes
- Simplified many of the controller APIs.
- Removed the controller number from the various controllers.
- Renamed many instances of provider to manager or controller.
- Updated to use the latest GCC.
- Removed `Acquire` and `Release` from core-provided APIs.
- Changed to an initialize and uninitialize pattern for required APIs.
- Added `InteropManager` to `TinyCLR_Interop_MethodData`.
- Merged `DeploymentProvider` and `SdCardProvider`.
- Changed specifying the deployment API to a dedicated function call.
- Changed `InteropManager::GetArgument` to start at index 0 for all arguments, regardless of instance or static.

#### Known Issues
- The linker will not error when regions overflow or overlap [#30](https://github.com/ghi-electronics/TinyCLR-Ports/issues/30).

***

Visit our main website at [**www.ghielectronics.com**](http://www.ghielectronics.com) and our community forums at [**forums.ghielectronics.com**](https://forums.ghielectronics.com/).
