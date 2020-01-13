# Bootstrap Pins
---
There are four pins that should be exposed on any SITCore circuit board. These pins are RESET, LDR, MOD, and APP. The LDR and MOD pins are only used during startup (or reset) and can be used as a GPIO or peripheral pin once your application is running.

## RESET

The SITCore chip is held in reset while the reset pin is low. Releasing the reset and allowing it to go high will begin the system startup process. When designing your own circuit board, the reset pin must be pulled high for the processor to start running. On our SITCore Modules and Dev Boards we pull reset high through a 10K resistor, allowing reset to be pulled low through the reset button.

## LDR

The LDR pin is used to enter the GHI Electronics bootloader mode. The LDR pin is normally pulled high during startup or reset, allowing the managed application to execute. When the LDR pin is pulled low during startup or reset, the device enters GHI Electronics bootloader mode which is used to load the SITCore firmware. There is no need for a pull up resistor on the LDR pin as the LDR pin is pulled high through a pull up resistor internal to the processor.

## MOD

The MOD pin is used to select the debugging/deployment interface. The MOD pin is pulled high by an internal pull up resistor -- there is no need to add a pull up resistor to the MOD pin when designing a custom circuit board.

By default the MOD pin is pulled high during reset which allows for deployment and debugging over USB. Pulling the MOD pin low during startup or reset allows for deployment and debugging over UART. Note that on our SITCore Dev Boards we include an FT232R USB to serial converter chip to provide a convenient way to connect a PC to the boards serial debug/deploy port.

## APP

The APP pin is used to prevent the application from running. The APP pin is checked shortly after startup and reset. When the APP pin is high your application will run normally. If the APP pin is low when the bootloader is ready to run your application, the application will be prevented from running. There is no need for an external pull up on the APP pin as it is pulled high by an internal pull up.

As the function of the APP pin may change in the future, it is not recommended that your application use this pin if it can be avoided.


### Loading the Firmware

1. Activate the bootloader by holding the LDR signal low while resetting the board.
2. Open [TinyCLR Config](../../software/tinyclr/tinyclr-config.md) tool.
3. Click the loader tab.
4. Select the correct COM port. If you are not seeing it then the device is not in the loader mode.
5. Click the `Update to Latest` button.

You can also update the firmware manually. Go to the [GHI Electronics Bootloader](../../software/tinyclr/bootloader.md) page for instructions on using the bootloader and manually loading firmware. You can download the firmware [here](../../software/tinyclr/downloads.md).

## Device Startup
The SITCore is held in reset when the reset pin is low. Releasing it will begin the system startup process.

There are three different components of the device firmware:
1. GHI Electronics Bootloader: Initializes the system, updates TinyCLR when needed, and executes TinyCLR.
2. TinyCLR: loads, debugs, and executes the managed application.
3. Managed application: the program developed by the customer.

Which components get executed on startup can be control by manipulating the LDR pin. It is pulled high on
startup. When low, the device waits in the GHI Electronics Bootloader. Otherwise, the managed application is executed. APP
is reserved for future use.

Additionally, the communications interface between the host PC and the SITCore is selected on startup through the
MODE pin, which is pulled high on startup. The USB interface is selected when MODE is high and COM1 is selected
when MODE is low.

The above discussed functions of the LDR, APP, and MODE pins are only available during startup. After startup, the pins return to the
default GPIO state and are available as GPIO in your application.

### Start Coding
Now that you have installed the bootloader and firmware on the SITCore, you can setup your host computer and start programming.  Go to the TinyCLR [Getting Started](../../software/tinyclr/getting-started.md) page for instructions.