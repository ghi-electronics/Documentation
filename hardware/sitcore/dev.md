# SITCore Dev Boards

---

![Development Options](images/sitcore-dev-boards.jpg)

We offer three development boards making it possible to start programming applications within minutes without designing or building new hardware. These boards are not only suitable for prototypes, but for short production runs as well.

## SITCore SC13048Q Dev Board

![Development Options](images/sc13048q.jpg)

The SC13048Q Dev Board includes an SC13048Q soldered to the board and a built in 1.8 inch color serial display. It has a 10 pin socket header for connecting peripherals. Peripheral connectors include mikroBus connector, external power, CAN, USB host and client and RTC backup supercap.  It also has a buzzer, LEDs, a reset button, and user programmable boot buttons.

To start development using the SC13048Q Dev Board, just connect the board's USB Client port to a host computer using a USB-C cable. Go to the [Getting Started](../../software/tinyclr/getting-started.md) page in the TinyCLR section of the documentation page for further instructions.

The board can be powered through either the USB client connectors or the barrel jack. Always use the barrel jack for power when using the display. USB does not provide sufficient power needed for displays.

[SC13048Q Dev Board Schematic](pdfs/sc13048q-dev-rev-b-schematic.pdf)

[SC13048Q Dev Board 3D STEP File](http://files.ghielectronics.com/downloads/3D/SITCore/Dev/SC13048Q%20Dev%20Rev%20C.step)

> [!Note]
> All boards with a barrel power jack accept a 5.5 x 2.1 mm power plug. The pin is positive, the sleeve is negative.

> [!Note]
> SC13048 Dev board uses linear voltage regulators that run hotter with higher input voltages. Generally we recommend an input voltage of 6 to 12 volts, but if your project draws a lot of current, use a lower voltage to keep the regulator cooler.

## SITCore SC20100S Dev Board

![Development Options](images/sc20100.jpg)

The SC20100S Dev Board includes an SC20100S soldered to the board and a built in 1.8 inch color serial display. It has a 40 pin socket headers for connecting peripherals. Peripheral connectors include two mikroBus connectors, external power, CAN, USB host and client, RTC supercap and an SD card slot.  It also has a buzzer, LEDs, a reset button, and user programmable boot buttons.

To start development using the SC20100S Dev Board, just connect the board's USB Client port to a host computer using a USB-C cable. Go to the [Getting Started](../../software/tinyclr/getting-started.md) page in the TinyCLR section of the documentation page for further instructions.

The board can be powered through either the USB client connectors or the barrel jack. Always use the barrel jack for power when using displays, especially the larger ones. USB does not provide sufficient power needed for displays.

[SC20100S Dev Board Schematic](pdfs/sc20100s-dev-rev-c-schematic.pdf)

[SC20100S Dev Board 3D STEP File](http://files.ghielectronics.com/downloads/3D/SITCore/Dev/SC20100S%20Dev%20Rev%20C.step)

> [!Note]
> All boards with a barrel power jack accept a 5.5 x 2.1 mm power plug. The pin is positive, the sleeve is negative.

## SITCore SCM20260D Dev Board

![Development Options](images/SCM20260D.jpg)

The SCM20260D Dev Board is the fastest and easiest way to start developing with the SCM20260D. This board includes an SCM20260D DIMM module and a 4.3 inch capacitive touch display. It provides standard connectors for input/output, and two 40 pin socket headers for connecting peripherals and a display. Peripheral connectors include two mikroBus connectors, external power, Ethernet, CAN, USB host and client, RTC supercap, DCMI interface and an SD card slot.  It also has a buzzer, LEDs, a reset button, and user programmable boot buttons.

To start development using the SCM20260D Dev Board, just install the module on the board, plug in the display (if needed), and connect the board's USB Client port to a host computer using a USB-C cable. Go to the [Getting Started](../../software/tinyclr/getting-started.md) page in the TinyCLR section of the documentation page for further instructions.

The board can be powered through either the USB client connectors or the barrel jack. Always use the barrel jack for power when using displays, especially the larger ones. USB does not provide sufficient power needed for displays.

[SCM20260D Dev Board Schematic](pdfs/scm20260d-dev-rev-c-schematic.pdf)

[SCM20260D Dev Board 3D STEP File](http://files.ghielectronics.com/downloads/3D/SITCore/Dev/SCM20260D%20Dev%20Rev%20C.step)

> [!Note]
> All boards with a barrel power jack accept a 5.5 x 2.1 mm power plug. The pin is positive, the sleeve is negative.

### SC20260 Dev Display Options

![UD435](images/ud435.jpg)

One of the headers on the SCM20260 Dev board includes all necessary parallel display signals. It also includes I2C and a couple of GPIOs allowing for support of capacitive touch panels. Out-of-the-box, the SCM20260 Dev board includes a 4.3" display with capacitive touch.

* Display Module: [ER-TFT043-3](https://www.buydisplay.com/)
* Touch Panel: [ER-TPC043-2](https://www.buydisplay.com/)

[4.3" Display Module Schematic](pdfs/ud435-rev-b-schematic.pdf)

This display module has a 4.3" 480x272 TFT display with a capacitive touch screen. It plugs directly into the SCM20260D Dev Board and uses I2C1 for capacitive touch and PJ14 for the touch interrupt. The backlight is controllable through PA15.

The [TinyCLR Samples repo](https://github.com/ghi-electronics/TinyCLR-Samples) has usage examples. You can learn more in the [Graphics](../../software/tinyclr/tutorials/graphics.md) and [Display](../../software/tinyclr/tutorials/displays.md) sections of the TinyCLR tutorials.

See below for the display configuration values:

Property | Value
---------|---------
Width | 480
Height | 272
DataFormat | RGB565
Pixel Clock Rate | 8 MHz <= x <= 16MHz
Pixel Polarity | low
DataEnable Is Fixed | false
DataEnable Polarity | low
Horizontal Back Porch | 46
Horizontal Front Porch | 16
Horizontal Sync Polarity | low
Horizontal Sync Pulse Width | 1
Vertical Back Porch | 23
Vertical Front Porch | 7
Vertical Sync Polarity | low
Vertical Sync Pulse Width | 1

### SC20260 Dev Camera Options

The SC20260 SoC and its related SoMs include a parallel Digital Camera Interface. The Dev Board exposes the camera signals on a dedicated header. While any compatible display can be connected, the pinout matches the popular OV9655 breakout board, available from many sources around the web and shown below:

![OV9655 Breakout](images/ov9655-breakout.jpg)

It is important to note that some of these breakout boards ship with voltage regulators that don't seem to work properly, while others work well. Please understand that these are just our observations -- we cannot guarantee the functionality or quality of any third party products.

Here are images of OV9655 modules where one works and the other doesn't.

The good modules have regulators labeled "3DB8N" and "3Cb2b:"

![Good camera](images/good-camera.jpg).

The bad modules have voltage regulators labeled "2EB2S" and "3AB2I:"

![Bad camera](images/bad-camera.jpg)

### Demo Program

The SITCore SCM20260D Dev Board ships with a demonstration program that can be found on our [TinyCLR-Samples](https://github.com/ghi-electronics/TinyCLR-Samples) GitHub repository.

---

## USB-C Functionality

All SITCore single board computers use a USB-C connector for application deployment and debugging. While USB-C has many advantages, we've also noticed some flaws. Every USB-A to USB-C cable tested worked as expected. Testing USB-C to USB-C cables gave interesting and unexpected results. Most USB-C hubs also do not work when using USB-C to USB-C cables. If you are having problems deploying or debugging, try connecting the board directly to your computer with a USB-A to USB-C cable.

---

You can visit our main website at [**www.ghielectronics.com**](http://www.ghielectronics.com) and our community forums at [**forums.ghielectronics.com**](https://forums.ghielectronics.com/).
