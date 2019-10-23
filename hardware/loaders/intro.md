# Bootloaders Introduction
---
![Bootloader](images/bootloader-noborder.png)

A bootloader is a small software that boots up the system and runs the firmware. It is also used to update the firmware.

Our products ship with the GHI Bootloader preloaded. This simplifies the firmware update process, especially when using the [TinyCLR Config](../../software/tinyclr/tinyclr-config.md) tool.

## GHI Bootloader
The [GHI Bootloader](ghi-bootloader.md) page describes the bootloader commands and how to use the bootloader to load firmware onto a device.

## STM32 Bootloader
The [STM32 Bootloader](stm32-bootloader.md) page covers loading .hex, .bin, and .dfu files onto our STM32 based devices. This includes loading the GHI Bootloader onto ST based products.

## SAM-BA Bootloader
The [SAM-BA Bootloader](sam-ba-bootloader.md) lives on many Atmel chips. It is necessary to load files (loaders and/or firmware) onto the chip. Several TinyCLR OS supported boards will use this loader to load the GHI Bootloader.
