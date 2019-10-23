# GHI Bootloader
---
The GHI Bootloader is used to update the firmware on our devices. It is the first program to run and unless the device specific LDR pins are set (see device documentation for details), it will execute the firmware on the device (if present). 

The bootloader communicates over a USB virtual serial port and a regular serial port. The interface used is controlled by a MODE pin. See your device specifications for details on interface configuration and selection and which version of the bootloader it runs.

> [!Tip]
> If you are running Windows 7 or Windows 8, you must install drivers for the bootloader to appear in Windows. See "USB Drivers" in the [**downloads section**](ghi-bootloader.md#usb-drivers).

## Bootloader v2
All commands and results are terminated with CR and LF (\r\n). "OK." will be sent after each successful command.

On startup, a banner is sent that is terminated by "OK.". Once the banner is received, you are free to enter any of the case-insensitive single-character commands described below.

Most commands require confirmation. Send Y or y followed by a new-line to proceed or anything else to cancel.

- V: returns the current version.
- N: returns the current device type.
- E: erases all user sectors of the device.
- R: runs the firmware if present.
- B: increases the baud rate in serial mode to 921,600.
- X: upload a `ghi` file to the device using 1K XMODEM. Only send *.ghi files meant for your device.
- U: upload a `glb` file to the device using 1K XMODEM. Only send *.glb files meant for your device.

## Loading the Firmware

The individual product pages include further instructions on the firmware needed and how to set the board in the loader mode. Once you have downloaded the firmware and set the board in loader mode, use the instructions below to load the firmware.

### Using TinyCLR Config
TinyCLR Config tool includes multiple features developers need to work with TinyCLR OS-enabled devices. It simplifies the firmware update and it includes options for accessing the TinyCLR firmware at runtime.

Using this tool is the recommended path; however, manual installation instructions are also included on this page. Read more on the [TinyCLR Config](../../software/tinyclr/tinyclr-config.md) page.

### Manually Loading the Firmware
TinyCLR Config tool should be used to update the firmware. As a backup, use these instructions:

1. Put your board in bootloader mode. Each product has a specific way to enter the boot loader.
2. Open any terminal software, for example [Tera Term](http://ttssh2.osdn.jp/).
3. Select serial and pick the COM port associated with your board. (If unsure, check Device Manager)
4. Press `V` and then enter. You will see back the boot loader version number (v2.x.x)
5. Press `U` or `X` and then enter. Use `X` for firmware file type GHI and `U` for firmware file type GLB. 
6. Press `Y` to confirm then enter. You will now see `CCCC`...
7. Go to `File` -> `Transfer` -> `XMODEM` -> `Send` and then check the `1K` option.
8. Select the firmware file.
9. When the transfer is complete, reset your board.

#### GLB File Format
The glb files that are loaded onto devices have some additional metadata that help the bootloader function in addition to the raw data itself. The first 1,024 bytes of a glb file is the upload header. Starting from offset 0 are the below fields. The rest of the header is currently reserved.

1. 32 bit signature number that is unique for each device.
2. 32 bit unsigned address in flash that this image should be copied to.
3. 32 bit unsigned length of the image to flash rounded to the nearest 1,024 bytes.
4. 16 bit CRC-CCITT of the image.

After the upload header is the actual image to flash. If its length is not divisible by 1,024 bytes, it is padded until it is. For images that are meant to be bootable, the address in the upload header should be set to the entry point defined for the specific device. Bootable images have an additional 1,024 byte header at the beginning of the image that is used to verify the image before booting it. The boot image is also padded to the nearest 1,024 bytes. Starting from offset 0 are the below fields. The rest of the header is currently reserved.

1. 32 bit signature number that is unique for each device.
2. 32 bit unsigned address in flash that is the entry point the bootloader will invoke.
3. 32 bit unsigned length of the boot image rounded to the nearest 1,024 bytes.
4. 16 bit CRC-CCITT of the boot image bounded by the specified address and length.

## Bootloader v1
Currently the Embedded Master, EMX, G120, G120E and USBizi ship with this version of the bootloader. All results are terminated with LF (\n). Commands are executed as soon as they entered without waiting for a new-line. "BL" or "Done." will be sent after each command.

On startup, a banner is sent that is terminated by "BL". Once the banner is received, you are free to enter any of the case-sensitive single-character commands described below.

- V: returns the current version.
- E: erases all user sectors of the device (* is sent while erasing).
- R: runs the firmware if present.
- B: increases the baud rate in serial mode to 921,600.
- X: upload a file to the device using 1K XMODEM. Only send *.ghi files meant for your device. The firmware is automatically run after a successful upload.

> [!Tip]
> The USB interface on Version 1.0 doesn't always work on Windows 7 and newer operating systems. Use the serial interface instead.

### Upgrading GHI Bootloader v1 to v2
Some of our devices ship with v1 loader but require v2 loader to work with TinyCLR OS, such as G120.

1. Download the bootloader file from the list below.
2. Put your device in v1 mode (instructions are found on each product's documentation page).
3. The PC will now detect a virtual serial (COM) device. If you need drivers, they are in the [NETMF](../../software/netmf/intro.md) SDK.
4. Open any terminal software, we recommend [Tera Term](http://ttssh2.osdn.jp/).
5. Select serial and pick the COM port associated with your board.
6. Enter `E` and you will see back "Erase all memory! Are you sure?" now enter `Y`. (The bootloader is case sensitive)
7. Enter `X` and you will see `CCCC`... showing on the terminal.
8. Now go to `File` -> `Transfer` -> `XMODEM` -> `Send` and then check the `1K` option.
9. Select the bootloader file you have downloaded above.
10. You will see `File Transfer Finished Successfully`.
11. Change the configuration switches back to the off position and reset the board.
12. You are now running GHI Electronics bootloader v2!


## Bootloader Downloads

Most products already ship with bootloader already installed. But in case the loader needs to be reloaded, the individual product pages include instructions on how to load the bootloader. Here you can find the various bootloaders available for the various products.

### FEZCLR (used on FEZ and BrainPad)
File | Date | Status | MD5
--- | --- | --- | ---
[v2.0.4](http://files.ghielectronics.com/downloads/Bootloaders/FEZCLR%20Bootloader%20v2.0.4.dfu) | 2017-08-31 | Alpha | 33F7FCAE266D07209C079CEA38AAB583
[v2.0.3](http://files.ghielectronics.com/downloads/Bootloaders/FEZCLR%20Bootloader%20v2.0.3.dfu) | 2017-07-07 | Alpha | 056919694D6A5F06546F9B721AE141CE

### UC2550
File | Date | Status | MD5
--- | --- | --- | ---
[v2.0.4](http://files.ghielectronics.com/downloads/Bootloaders/UC2550%20Bootloader%20v2.0.4.dfu) | 2018-04-05 | Alpha | 692FA78A161BAA2AEF17E9F85A6AF141

### UC5550
File | Date | Status | MD5
--- | --- | --- | ---
[v2.0.5](http://files.ghielectronics.com/downloads/Bootloaders/UC5550%20Bootloader%20v2.0.5.dfu) | 2018-09-28 | Alpha | 9F4DB868E5501773CC52048D8085B8D6
[v2.0.4](http://files.ghielectronics.com/downloads/Bootloaders/UC5550%20Bootloader%20v2.0.4.dfu) | 2018-04-05 | Alpha | 594744A52EC07CEFE6212669D33A5FE1

### G120 and G120E
File | Date | Status | MD5
--- | --- | --- | ---
[v2.0.4](http://files.ghielectronics.com/downloads/Bootloaders/G120%20Bootloader%20v2.0.4.ghi) | 2017-08-31 | Alpha | 7052D6FFB1890987DDCC4043895788D3
[v2.0.2](http://files.ghielectronics.com/downloads/Bootloaders/G120%20Bootloader%20v2.0.2.ghi) | 2017-03-07 | Alpha | 00ECD55A24607336863B1D61B91C3D86

### G400S and G400D
File | Date | Status | MD5
--- | --- | --- | ---
[v2.0.4](http://files.ghielectronics.com/downloads/Bootloaders/G400%20Bootloader%20v2.0.4.bin) | 2017-09-13 | Alpha | BD46D86D41DCD42C4FC50D27AF02E5EE
[v2.0.2](http://files.ghielectronics.com/downloads/Bootloaders/G400%20Bootloader%20v2.0.2.bin) | 2017-04-06 | Alpha | 81D45A8F078AA8E633C824C7BB3279DC
[v2.0.1](http://files.ghielectronics.com/downloads/Bootloaders/G400%20Bootloader%20v2.0.1.bin) | 2016-06-27 | Alpha | 42CD50E4105939611ABF360475EBF4E5

### USBizi
File | Date | Status | MD5
--- | --- | --- | ---
[v1.0.7 144](http://files.ghielectronics.com/downloads/Bootloaders/USBizi%20144%20Bootloader%20v1.0.7.hex) | 2015-05-05 | Production | 853557479D8797EAB650B98E3D333DCF
[v1.0.7 100](http://files.ghielectronics.com/downloads/Bootloaders/USBizi%20100%20Bootloader%20v1.0.7.hex) | 2015-05-05 | Production | 34D17AA5CA4E13D5447C80AB8094D064


## USB Drivers

Only needed for Windows 7 and 8 since they do not automatically load drivers for the bootloader interface.

File | Date | Status | MD5
--- | --- | --- | ---
[v1.0.0 x64](http://files.ghielectronics.com/downloads/Bootloaders/Drivers/GHI%20Electronics%20Bootloader%20Driver%20x64%20v1.0.0.msi) | 2018-12-27 | Production | 74D66FC4236126A83CCCFE28D556F339
[v1.0.0 x86](http://files.ghielectronics.com/downloads/Bootloaders/Drivers/GHI%20Electronics%20Bootloader%20Driver%20x86%20v1.0.0.msi) | 2018-12-27 | Production | 8BDE68132452E22B14597C0972ABA8FD
[v0.6.0 x64](http://files.ghielectronics.com/downloads/Bootloaders/Drivers/GHI%20Electronics%20Bootloader%20Driver%20x64%20v0.6.0.msi) | 2017-08-31 | Alpha | AEDD7C00854BBF99AC3FDAB4976E1F33
[v0.6.0 x86](http://files.ghielectronics.com/downloads/Bootloaders/Drivers/GHI%20Electronics%20Bootloader%20Driver%20x86%20v0.6.0.msi) | 2017-08-31 | Alpha | A0F487D32B882199F0A69E6CAA8DE4CB
