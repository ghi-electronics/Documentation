# Special Pins
---

There are a number of predefined pins that have special functionality on SITCore SoMs and SoCs: 
* RESET (NRST)
* LDR (PE3)
* APP (PB7)
* MOD (PD7)
* WKUP (PA0)
* Vbat

All special pins except RESET and Vbat can be used as GPIO or peripheral pins, however it is up to you to make sure your use of these pins does not interfere with their use as special pins if needed. We strongly recommend exposing all special pins in your SITCore designs. You will also need to expose the debug interface(s) you plan to use to deploy and debug your application.

In addition to exposing these pins, it is important to follow the design considerations on the [System on Chip](../../hardware/sitcore/soc.md) or [System on Module](../../hardware/sitcore/som.md) page that corresponds to the SITCore product your are using.

## RESET

The SITCore chip is held in reset while the RESET(NRST) pin is held low. Releasing RESET and allowing it to go high will begin the system startup process.

All SITCore processors have a permanent internal pull up resistor on the RESET pin. An external pull up resistor is not required on the RESET(NRST) pin when designing your own circuit boards.

## LDR

The LDR pin is used to enter the GHI Electronics bootloader mode. The LDR pin is normally pulled high during startup or reset, allowing the managed application to execute. When the LDR pin is pulled low during startup or reset, the device enters GHI Electronics bootloader mode, which is used to load the SITCore firmware. There is no need for a pull up resistor on the LDR pin as the LDR pin is pulled high through a pull up resistor internal to the processor.

## APP

The APP pin is used to prevent the application from running. The APP pin is checked shortly after startup and reset. When the APP pin is high your application will run normally. If the APP pin is low when the bootloader is finished, the bootloader will not transfer execution to your application. There is no need for an external pull up on the APP pin as it is pulled high by an internal pull up.

> [!TIP]
> APP and MOD become inactive when the debug interface is set to none. See [IP Protection](tutorials/ip-protection.md) for details.

## MOD

The MOD pin is used to select the debugging/deployment interface. The MOD pin is pulled high by an internal pull up resistor -- there is no need to add a pull up resistor to the MOD pin when designing a custom circuit board.

By default, the MOD pin is pulled high during reset allowing for deployment and debugging over USB. Pulling the MOD pin low during startup or reset allows for deployment and debugging over UART. Note that our SITCore Dev Boards include a FT232R USB to serial converter chip to provide a convenient way to connect a PC to the board's serial debug/deploy port.

## WKUP

The WKUP pin is used to wake the system up from Shut Down mode. See the [Power Management](tutorials/power-management.md) page for more information.

## Vbat

The Vbat pin on SITCore SoCs and SoMs is used to provide battery power to the [Real Time Clock](tutorials/real-time-clock.md) (RTC). This pin also provides power for battery backed memory (see the [Real Time Clock](tutorials/real-time-clock.md) page for details).

If you require either RTC or battery backed memory, the Vbat pin must be connected to the positive terminal of a supercap or battery. The negative terminal of the battery or supercap needs a connection to GND.

Vbat requires 1.2 to 3.6 volts for correct operation. This is usually provided by either a CR2032 lithium coin cell or a supercap, but other options are available. SITCore Dev boards use a 33 mF 3.3 volt supercap.

The best Vbat option depends on your application. If your board needs to keep correct time while being unpowered for more than a few days, a battery may be a better choice than a supercap. The disadvantage to batteries is they eventually discharge and must be replaced. Supercaps are rechargeable and should last for the life of the product.

It is important that your application correctly sets the charging status of the Vbat pin. Trying to charge a lithium coin cell may damage it and could possibly cause it to leak. Supercaps need to be charged every few days or so (depending on supercap size) before they lose their charge. Information on setting Vbat charge status is found on the [Real Time Clock](tutorials/real-time-clock.md) page.

## Debug Interface

Don't forget to expose either the USB client or UART interface (or both) that you plan on using to deploy and debug your application code. See the [System on Chip (SoC)](../../hardware/sitcore/soc.md) page for details.

## Other Recommended Pin Usage

When designing your own board, we recommend that you add the following peripherals using the stated pins to maintain consistency with our dev boards and sample software.

| Peripheral | Recommended SITCore I/O Assignment |
|--|--|
| User LED | 100 pin devices: PE11 |
|  | 260 pin devices: PB0 |
| Buzzer | PB1 |

