# SAM-BA Bootloader
---
The SAM-BA Bootloader lives on many Atmel chips. It is necessary to load files (loaders and/or firmware) onto the chip. Several TinyCLR OS supported boards will use this loader to load the software.

## Uploading bin Files
To set the chip in SAM-BA mode, hold down the dedicated button on your board (SYS A on UCM Dev and Breakout boards) while the system powers up (or during reset). If there is no such button, follow the instructions from the specific product on how set the device in SAM-BA mode. For example, connect G400 pin SPI1_MISO to ground. Keep the button pressed (pin grounded) for three seconds after power up or reset, then release the pin. The device manager will show a COM port similar to "Bossa Program Port" or "GPS Detect".

1. If it is not already installed, download and install the [SAM-BA tool](http://www.microchip.com/developmenttools/productdetails.aspx?partno=atmel%20sam-ba%20in-system%20programmer) from Microchip. The latest version we have tested is 2.18 for Windows. (The tool may not show correctly. Try to make the window larger to see all hidden buttons!)
2. Open the SAM-BA program then select the COM port for your device in the connection box and your board type below it (at91sam9x35-ek for G400), then click connect.
3. Near the middle of the window, go to the `DataFlash AT45DB/DCB` tab.
4. Under `Scripts`, select `Enable Dataflash (SPI0 CS0)` then click the `Execute` button.
5. Under `Scripts`, select `Erase All` then click `Execute`. This will take some time to complete.  It seems that if SAM-BA loses focus during the erase procedure it can seem to lock up.  We recommend that once you click the `Execute` button you leave the computer alone until the erase procedure is completed.
6. Under `Scripts`, select `Send Boot File`, click execute, then browse to and select the bootloader for the device.
7. Once the transfer finishes, go to `File` > `Quit` and then reset the board. Make sure to properly quit the program or connection errors may result on subsequent uses.
8. Now reset the board.  Congratulations, your board is now running the loaded program!