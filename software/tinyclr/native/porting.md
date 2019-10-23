# Porting TinyCLR
---
![TinyCLR Logo](../images/tinyclr-logo-noborder.jpg)

TinyCLR OS can be ported to new devices. We provide the precompiled .NET interpreter and runtime for several architectures. Currently Cortex M3, Cortex M4, Cortex M7, ARM7, and ARM9 are supported. To get started we'll build the FEZCLR firmware that the FEZ uses.

1. Clone the [ports repo](https://github.com/ghi-electronics/TinyCLR-Ports) to your computer. Make sure to clone the master branch so you're using the latest stable version. If you're new to git or haven't even heard of it, take a look at the [Git Book](https://git-scm.com/book/en/v2) to learn more about it.
2. Download and install [GCC](https://developer.arm.com/open-source/gnu-toolchain/gnu-rm/downloads). The latest version we have tested is `7-2018-q2-update`.
3. Download and extract the contents of [CMSIS](https://github.com/ARM-software/CMSIS_5/releases/download/5.4.0/ARM.CMSIS.5.4.0.pack) into the CMSIS folder of the cloned repo. While the file extension is `*.pack`, it's actually a zip that you can extract once you rename it to `*.zip`.
4. Download and extract the latest [TinyCLR OS Core Library](https://github.com/ghi-electronics/TinyCLR-Ports/releases) into the Core folder of the cloned repo. Make sure to download the version corresponding to the version of the source code that you're trying to build. If you're building the master branch, then you want to use the very latest released version.
5. Open a command prompt, change the directory to the cloned repo, and then execute `build.bat FEZCLR`.

The compiled firmware can then be found in the repo directory under `build\release\FEZCLR`. The build system automatically produces firmware images in hex format (.hex), a raw binary (.bin), and either a binary meant to be loaded by our [GHI Bootloader](../../../hardware/loaders/ghi-bootloader.md) with its U command (.glb) or a binary meant to be loaded by the same bootloader with the X command (.ghi). For the FEZCLR firmware we built, flash the `FEZCLR Firmware.glb` to your FEZ following the instructions on the [bootloader](../../../hardware/loaders/ghi-bootloader.md) page. When you restart it, it should be running TinyCLR OS and you can deploy to it from Visual Studio.

## Creating your own device
To create a new firmware for a board that a `Target` already exists for, you just need to create a new folder under Devices to define your board. You can do this easily by copying an existing board, like the FEZ, and making the changes you need for your board. Make sure you update the scatterfile to place the final firmware image in memory where it needs to be. For example, the FEZ scatterfile expects the GHI Bootloader to be present but you need to place your firmware's image at the start of flash.

To make using a custom port easier, we're specifically making the USB product ID 0x5000 under our vendor ID (0x1B9F) available for anyone to use for the USB debug interface on their TinyCLR device. Make sure to only use this product ID because other product IDs are assigned by us for our own use. Of course, if you have your own vendor ID, you are free to use it. So when you copy an existing device to make a new one, be sure to verify the USB vendor and product IDs are correct.

## Creating a new target
To port to a new board with a new `Target`, make sure it is one of the architectures that we have made a core library available for. Then, like above, you'll need to make a new folder for your device under the Devices folder. You'll also need to create a new folder under Targets that implements the needed APIs. 

The TinyCLR runtime requires you to provide a few APIs for it to function correctly: deployment, interrupt, power, and time. The runtime also makes a few APIs available to you automatically: the API provider itself; a memory allocator; a recurring task creator; and a way to interact with managed objects, arguments, and events. Beyond that, you can provide whatever APIs you need like GPIO and SPI. See the [native API document](apis.md) for details on APIs. On top of providing several APIs, you must call all the functions under `TinyCLR_Startup_*` to properly initialize the system. The `main.cpp` provided in the repo that our existing ports use and the build system includes is a good starting point.

## Contributing
We are taking contributions to the TinyCLR OS ports and documentation, but we don't have an established process just yet, so standard contributing practices apply. Create a fork of the repo, create a new branch from dev, work on your changes, then submit a PR.
Make sure to follow the existing style for the project and keep your changes easily reviewable. Your changes will need to be licensed under Apache 2 and you need to sign a Contributor License Agreement with us before your PR can be accepted.
