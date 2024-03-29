# Special Pins
---

Beside power and standard GPIO pins, there are a number of predefined pins that have special functionality on SITCore SoMs and SoCs: 
* RESET
* LDR
* APP
* MOD
* WKUP
* VBAT

All special pins except RESET and VBAT can be used as GPIO or peripheral pins, however it is up to the designer to make sure these pins do not interfere with their special features.

## RESET

The SITCore chip is held in reset while the RESET(NRST) pin is held low. Releasing RESET and allowing it to go high will begin the system startup process.

All SITCore processors have a permanent internal pull up resistor on the RESET pin. An external pull up resistor is not required on the RESET(NRST) pin.

## LDR

The LDR pin is normally pulled high internally during startup or reset, allowing TinyCLR OS to run. When the LDR pin is pulled low during startup or reset, the device enters GHI Electronics bootloader mode, which is used to load the firmware. LDR has an internal pull up resistor.

The [Bootloader](bootloader.md) page details its use.

## APP

The APP pin is used to prevent the application from running. The APP pin is checked shortly after startup. When the APP pin is high (internall pull up) the application will run normally; otherwise, the system will not run the application and hold waiting for new deployment. The pin has an internal pull up resistor.

If desired, the APP pin feature can be disabled so the application can't be stopped. See [Device Info](tutorials/device-info.md) for more details.

## MOD

The MOD pin is used to select the debugging/deployment interface, as explained in the [Debugging](tutorials/debugging.md) tutorial. An internal pull up keeps the pin high during power up to select USB debugging. Setting the pin low will switch to serial debugging.

## WKUP

The WKUP pin is used to wake the system up from Shut Down mode. See the [Power Management](tutorials/power-management.md) page for more information.

## VBAT

The VBAT pin on SITCore SoCs and SoMs is used to provide battery power to the [Real Time Clock](tutorials/real-time-clock.md) (RTC) and its battery backed memory.

## Debug Interface

USB or Serial can be used for [debugging](tutorials/debugging.md).
