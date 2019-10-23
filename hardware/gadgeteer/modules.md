# .NET Gadgeteer Modules
---
This page lists all .NET Gadgeteer modules. All sources are found on the [NETMF and Gadgeteer repo](https://github.com/ghi-electronics/NETMF-Gadgeteer)

## Accel G248
![Accel G248](images/modules/accel-g248.jpg)

The Accel G248 measures acceleration though I2C bus.
* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/Accel%20G248%20Module%20Schematic.pdf)

## Barometer
![Barometer](images/modules/barometer.jpg)

Measures pressure.
* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/Barometer%20Module%20Schematic.pdf)

## Bluetooth
![Bluetooth](images/modules/bluetooth.jpg)

* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/Bluetooth%20Module%20Schematic.pdf)

## Breadboard X1
![Breadboard X1](images/modules/breadboard-x1.jpg)

An easy breadboard option. Simply access the socket directly to wire whatever your heart desires!
* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/BreadBoard%20X1%20Module%20Schematic.pdf)

## Breakout
![Breakout](images/modules/breakout.jpg)

Simply a breakout of all signals.
* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/Breakout%20Module%20Schematic.pdf)

## Breakout TB10
![Breakout TB10](images/modules/breakout-tb10.jpg)

Simply a breakout of all signals, on a terminal block.
* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/Breakout%20TB10%20Module%20Schematic.pdf)

## Button
![Button](images/modules/button.jpg)

The Button module is very simple, with a button connected to pin 3 and an LED connected to pin4.
* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/Button%20Module%20Schematic.pdf)

## Button S7
![Button S7](images/modules/button-s7.jpg)

7 buttons on a single module, with LEDs that light up with button presses! 

Use the same code example provided for the Button Module.

Buttons map:
* Left: Pin  
* Right: Pin 8
* Up: Pin 6
* Down: Pin 7
* Enter: Pin 3
* Back: Pin 4
* Forward: Pin 9

* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/Button%20S7%20Module%20Schematic.pdf)

## CAN DW
![Button S7](images/modules/can-dw.jpg)

* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/CANDW%20Module%20Schematic.pdf)

## Camera
![Camera](images/modules/camera.jpg)

* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/Camera%20Module%20Schematic.pdf)

## Cellular Radio
![Cellular Radio](images/modules/cellular-radio.jpg)

* [Gadgteer driver](https://github.com/ghi-electronics/NETMF-Gadgeteer/tree/master/Modules/GHIElectronics/CellularRadio)
* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/Cellular%20Radio%20Module%20Schematic.pdf)

## Character Display
![Character Display](images/modules/character-display.jpg)

This is a standard and very common HD44780 display.

* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/Character%20Display%20Module%20Schematic.pdf)

## ColorSense
![ColorSense](images/modules/color-sense.jpg)

A color sensor that uses software I2C, not yet supported in TinyCLR OS.

* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/Color%20Sense%20Module%20Schematic.pdf)

## Compass
![Compass](images/modules/compass.jpg)

* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/Compass%20Module%20Schematic.pdf)

## Current ACS712
![Current ACS712](images/modules/current-acs712.jpg)

This is a current sensor that uses ACS712, which simply outputs an analog voltage.

* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/Current%20ACS712%20Module%20Schematic.pdf)

## Display CP7
![Display CP7](images/modules/display-cp7.jpg)

The configurations for the display:
```
// these are the wrong values!
Width = 800,
Height = 480,
PixelClockRate = 24 * 1000 * 1000,
PixelPolarity = false,
OutputEnablePolarity = true,
OutputEnableIsFixed = true,
HorizontalFrontPorch = 16,
HorizontalBackPorch = 46,
HorizontalSyncPulseWidth = 1,
HorizontalSyncPolarity = true,
VerticalFrontPorch = 7,
VerticalBackPorch = 23,
VerticalSyncPulseWidth = 1,
VerticalSyncPolarity = true,
```
* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/Display%20CP7%20Module%20Schematic.pdf)

## Display N18
![Display N18](images/modules/display-n18.jpg)

This is an SPI display that can work on any system with SPI bus, even small ones without TFT display support.

* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/Display%20N18%20Module%20Schematic.pdf)

## Display N7
![Display N7](images/modules/display-n7.jpg)

The configurations for the display:
```
Width = 800,
Height = 480,
PixelClockRate = 24 * 1000 * 1000,
PixelPolarity = false,
OutputEnablePolarity = true,
OutputEnableIsFixed = true,
HorizontalFrontPorch = 16,
HorizontalBackPorch = 46,
HorizontalSyncPulseWidth = 1,
HorizontalSyncPolarity = true,
VerticalFrontPorch = 7,
VerticalBackPorch = 23,
VerticalSyncPulseWidth = 1,
VerticalSyncPolarity = true,
```
* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/Display%20N7%20Module%20Schematic.pdf)

## Display NHVN
![Display NHVN](images/modules/display-nhvn.jpg)

This allows the use of several displays offered by http://newhavendisplay.com/

Supported displays:
* [NHD-4.3-480272EF-ATXL#](http://www.newhavendisplay.com/nhd43480272efatxl-p-5570.html)
* [NHD-4.3-480272EF-ATXL#-CTP](http://www.newhavendisplay.com/nhd43480272efatxlctp-p-5572.html)
* [NHD-4.3-480272EF-ATXL#-T](http://www.newhavendisplay.com/nhd43480272efatxlt-p-5571.html)
* [NHD-7.0-800480EF-ATXL#](http://www.newhavendisplay.com/nhd70800480efatxl-p-6284.html)
* [NHD-7.0-800480EF-ATXL#-CTP](http://www.newhavendisplay.com/nhd70800480efatxlctp-p-6911.html)
* [NHD-7.0-800480EF-ATXV#](http://www.newhavendisplay.com/nhd70800480efatxv-p-6720.html)
* [NHD-7.0-800480EF-ATXV#-CTP](http://www.newhavendisplay.com/nhd70800480efatxvctp-p-6912.html)


The configurations for all 4.3" display:
```
Width = 480,
Height = 272,
PixelClockRate = 20 * 1000 * 1000,
PixelPolarity = false,
OutputEnablePolarity = true,
OutputEnableIsFixed = false,
HorizontalFrontPorch = 2,
HorizontalBackPorch = 2,
HorizontalSyncPulseWidth = 41,
HorizontalSyncPolarity = false,
VerticalFrontPorch = 2,
VerticalBackPorch = 2,
VerticalSyncPulseWidth = 10,
VerticalSyncPolarity = false,
```

The configurations for all 7" display:
```
Width = 800,
Height = 480,
PixelClockRate = 20 * 1000 * 1000,
PixelPolarity = false,
OutputEnablePolarity = true,
OutputEnableIsFixed = false,
HorizontalFrontPorch = 88,
HorizontalBackPorch = 40,
HorizontalSyncPulseWidth = 48,
HorizontalSyncPolarity = false,
VerticalFrontPorch = 13,
VerticalBackPorch = 32,
VerticalSyncPulseWidth = 3,
VerticalSyncPolarity = false,
```
As for the capacitive touch controller, use this old NETMF driver code as a reference:
```
public class FT5306Controller {
    private InterruptPort touchInterrupt;
    private I2CDevice i2cBus;
    private I2CDevice.I2CTransaction[] transactions;
    private byte[] addressBuffer;
    private byte[] touchDataBuffer;
    private byte[] touchCountBuffer;

    public delegate void TouchEventHandler(FT5306Controller sender, TouchEventArgs e);

    public event TouchEventHandler TouchDown;
    public event TouchEventHandler TouchUp;
    public event TouchEventHandler TouchMove;

    public FT5306Controller(Cpu.Pin interruptPin) {
        this.transactions = new I2CDevice.I2CTransaction[2];
        this.addressBuffer = new byte[1];
        this.touchDataBuffer = new byte[4];
        this.touchCountBuffer = new byte[1];
        this.i2cBus = new I2CDevice(new I2CDevice.Configuration(0x38, 400));
        this.touchInterrupt = new InterruptPort(interruptPin, false, Port.ResistorMode.Disabled, Port.InterruptMode.InterruptEdgeBoth);
        this.touchInterrupt.OnInterrupt += (a, b, c) => this.OnTouchEvent();
    }

    private void OnTouchEvent() {
        var points = this.ReadData(2, this.touchCountBuffer)[0];

        for (var i = 0; i < points; i++) {
            var data = this.ReadData(i * 6 + 3, this.touchDataBuffer);
            var flag = (data[0] & 0xC0) >> 6;
            var x = ((data[0] & 0x0F) << 8) | data[1];
            var y = ((data[2] & 0x0F) << 8) | data[3];

            var handler = flag == 0 ? this.TouchDown : flag == 1 ? this.TouchUp : flag == 2 ? this.TouchMove : null;

            if (handler != null)
                handler(this, new TouchEventArgs { X = x, Y = y });
        }
    }

    private byte[] ReadData(int address, byte[] resultBuffer) {
        this.addressBuffer[0] = (byte)address;

        this.transactions[0] = I2CDevice.CreateWriteTransaction(this.addressBuffer);
        this.transactions[1] = I2CDevice.CreateReadTransaction(resultBuffer);

        this.i2cBus.Execute(this.transactions, 500);

        return resultBuffer;
    }

    public class TouchEventArgs : EventArgs {
        public int X { get; internal set; }
        public int Y { get; internal set; }
    }
}
```

* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/Display%20NHVN%20Module%20Schematic.pdf)

## Display T35
![Display T35](images/modules/display-t35.jpg)

The configurations for the display:
```
Width = 320,
Height = 240,
PixelClockRate = 15 * 1000 * 1000,
PixelPolarity = false,
OutputEnablePolarity = true,
OutputEnableIsFixed = true,
HorizontalFrontPorch = 51,
HorizontalBackPorch = 27,
HorizontalSyncPulseWidth = 41,
HorizontalSyncPolarity = false,
VerticalFrontPorch = 16,
VerticalBackPorch = 8,
VerticalSyncPulseWidth = 10,
VerticalSyncPolarity = false,
```
* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/Display%20T35%20Module%20Schematic.pdf)

## Display T43
![Display T43](images/modules/display-t43.jpg)

The configurations for the display:
```
Width = 480,
Height = 272,
PixelClockRate = 20 * 1000 * 1000,
PixelPolarity = false,
OutputEnablePolarity = true,
OutputEnableIsFixed = false,
HorizontalFrontPorch = 2,
HorizontalBackPorch = 2,
HorizontalSyncPulseWidth = 41,
HorizontalSyncPolarity = false,
VerticalFrontPorch = 2,
VerticalBackPorch = 2,
VerticalSyncPulseWidth = 10,
VerticalSyncPolarity = false,
```
* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/Display%20T43%20Module%20Schematic.pdf)

## Display TE35
![Display TE35](images/modules/display-te35.jpg)

The configurations for the display:
```
Width = 320,
Height = 240,
PixelClockRate = 15 * 1000 * 1000,
PixelPolarity = false,
OutputEnablePolarity = true,
OutputEnableIsFixed = true,
HorizontalFrontPorch = 51,
HorizontalBackPorch = 29,
HorizontalSyncPulseWidth = 41,
HorizontalSyncPolarity = false,
VerticalFrontPorch = 16,
VerticalBackPorch = 3,
VerticalSyncPulseWidth = 10,
VerticalSyncPolarity = false,
```
* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/Display%20TE35%20Module%20Schematic.pdf)

## Distance US3
![Distance US3](images/modules/distance-us3.jpg)

A very common ultrasonic sensor that works by sending a pulse on the trig Pin4 and measuring the response time on echo Pin3.

* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/Distance%20US3%20Module%20Schematic.pdf)

## Ethernet ENC28
![Ethernet ENC28](images/modules/ethernet-enc28.jpg)

* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/Ethernet%20ENC28%20Module%20Schematic.pdf)

## Ethernet J11D
![Ethernet J11D](images/modules/ethernet-j11d.jpg)

* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/Ethernet%20J11D%20Module%20Schematic.pdf)

## Extender
![Extender](images/modules/extender.jpg)


* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/Extender%20Module%20Schematic.pdf)

## FEZtive
![FEZtive](images/modules/feztive.jpg)

* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/FEZtive%20Module%20Schematic.pdf)

## Flash
![Flash](images/modules/flash.jpg)

* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/FLASH%20Module%20Schematic.pdf)

## GPS
![GPS](images/modules/gps.jpg)

* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/GPS%20Module%20Schematic.pdf)

## GasSense
![GasSense](images/modules/gas-sense.jpg)

This module can host several different air sensors, like Alcohol and CO2.

The sensor has an internal heater on pin 4 that needs to be enabled and then it is a simple analog read on pin 3.

* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/GasSense%20Module%20Schematic.pdf)

## Gyro
![Gyro](images/modules/gyro.jpg)

* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/Gyro%20Module%20Schematic.pdf)

## HD44780
![HD44780](images/modules/hd44780.jpg)

See the [Character Display](#character-display) Module
* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/HD44780%20Module%20Schematic.pdf)

## HubAP5
![HubAP5](images/modules/hub-ap5.jpg)

No hub support is currently planned.
* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/Hub%20AP5%20Module%20Schematic.pdf)

## IO60P16
![IO60P16](images/modules/io60p16.jpg)

* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/IO60P16%20Module%20Schematic.pdf)

## IR Receiver
![IR Receiver](images/modules/ir-reciever.jpg)

* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/IRReceiver%20Module%20Schematic.pdf)

## Joystick
![Joystick](images/modules/joystick.jpg)

The Joystick module has two analog inputs for X (pin 4) and Y (pin 5) position. Pressing the knob also works like a button (pin 3).


* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/Joystick%20Module%20Schematic.pdf)

## Keypad KP16
![Keypad KP16](images/modules/keypad-kp16.jpg)

* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/Keypad%20KP16%20Module%20Schematic.pdf)

## LED 7C
![LED 7C](images/modules/led-7c.jpg)

An LED that can be set to one of 7 colors, 8 if you count off!

* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/LED%207C%20Module%20Schematic.pdf)

## LED 7R
![LED 7R](images/modules/led-7r.jpg)

This is a ring of 6 LEDs and a 7th center LED.
Reference the LED 7C module for using pins.

Center LED: pin 9
LEDs going clockwise starting from LEDs D1 to D6 on the board D1, D2, D3, D4, D5, D6 are pins 3 to 8 respectively.
* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/LED%207R%20Module%20Schematic.pdf)

## LED Strip
![LED Strip](images/modules/led-strip.jpg)

A strip of 7 LEDs, connected to pins 3 through 9. Reference the LED 7C module for using pins.
* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/LED%20Strip%20Module%20Schematic.pdf)

## Light Sense
![Light Sense](images/modules/light-sense.jpg)

Simply using analog on pin 3. Use the same code as the potentiometer.
* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/LightSense%20Module%20Schematic.pdf)

## Load
![Load](images/modules/load.jpg)

Each one of the 7 GPIO pins are connected to a transistor to handle a load, like a motor.
* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/Load%20Module%20Schematic.pdf)

## MaxO
![MaxO](images/modules/maxo.jpg)

Shift registers used to take serial SPI data and put on parallel pins, perfect for driving tons of LEDs!
* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/MaxO%20Module%20Schematic.pdf)

## MicroSD Card
![MicroSD Card](images/modules/microsd.jpg)

* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/MicroSD%20Card%20Module%20Schematic.pdf)

## Moisture
![Moisture](images/modules/moisture.jpg)

This is a simple analog input measuring the direct resistance (moisture) on pin 3. An enable pin needs to be activated on pin 6.

* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/Moisture%20Sensor%20Module%20Schematic.pdf)

## Motor Driver
![Motor Driver](images/modules/motordriver.jpg)

The Motor Driver Module uses L298 H-bridge that can drive two motors up to 4A.

* Pin 6: Motor A Direction (GPIO)
* Pin 7: Motor A Speed (PWM)
* Pin 8: Motor B Direction (GPIO)
* Pin 9: Motor B Speed (PWM)

* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/Motor%20Driver%20L298%20Module%20Schematic.pdf)

## Multicolor LED
![Multicolor LED](images/modules/multicolor_led.jpg)

* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/Multicolor%20LED%20Module%20Schematic.pdf)

## Music
![Music](images/modules/music.jpg)

The Music Module uses the popular VS1053 decoder chip that decodes MP3, WMA, OGG, MIDI and WAV files.
* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/Music%20Module%20Schematic.pdf)

## Null Modem
![Null Modem](images/modules/null-modem.jpg)

No driver is needed.

## OBD II
![OBD II](images/modules/obd-ii.jpg)

## OneWire X1
![OneWire X1](images/modules/onewire-x1.jpg)

A breakout with a terminal block for easily connecting OneWire devices, specifically the common temperature probes.

* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/OneWire%20X1%20Module%20Schematic.pdf)

## PIR
![PIR](images/modules/pir.jpg)

Motion detection. Simply pin 3 changes its state when it detects motion.
* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/PIR%20Module%20Schematic.pdf)

## Parallel CNC
![Parallel CNC](images/modules/parallel-cnc.jpg)

* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/Parallel%20CNC%20Module%20Schematic.pdf)

## Potentiometer
![Potentiometer](images/modules/potentiometer.jpg)

The Potentiometer module is simply a variable resistor connected to pin3. Rotating its knob will result in an analog value changing from min to max.
* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/Potentiometer%20Module%20Schematic.pdf)

## Pulse Count
![Pulse Count](images/modules/pulse-count.jpg)

* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/Pulse%20Count%20Module%20Schematic.pdf)


## Pulse InOut
![Pulse InOut](images/modules/pulse-inout.jpg)

* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/Pulse%20In%20Out%20Module%20Schematic.pdf)

## Pulse Oximeter
![Pulse Oximeter](images/modules/pulse-oximeter.jpg)

* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/Pulse%20Oximeter%20Module%20Schematic.pdf)

## RFID Reader
![RFID Reader](images/modules/rfid-reader.jpg)

* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/RFID%20Module%20Schematic.pdf)

## RS232
![RS232](images/modules/rs232.jpg)

Simply a serial port.
* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/RS232%20Module%20Schematic.pdf)

## RS485 
![RS485](images/modules/rs485.jpg)

Simply a serial port.
* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/RS485%20Module%20Schematic.pdf)

## Radio FM1
![Radio FM1](images/modules/radio-fm1.jpg)

* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/Radio%20FM1%20Module%20Schematic.pdf)

## Reflector R3
![Reflector R3](images/modules/reflector-r3.jpg)

* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/Reflector%20R3%20Module%20Schematic.pdf)

## Relay ISOx16
![Relay ISOx16](images/modules/relay-isox16.jpg)

An array of 16 relays. Operate similar to the MaxO module.

* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/Relay%20ISOx16%20Module%20Schematic.pdf)

## Relay X1
![Relay X1](images/modules/relay-x1.jpg)

Simply set pin 3 high to activate the relay.
* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/Relay%20X1%20Module%20Schematic.pdf)

## Rotary H1
![Rotary H1](images/modules/rotary-h1.jpg)

* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/Rotary%20H1%20Module%20Schematic.pdf)

## SD Card
![SD Card](images/modules/sd-card.jpg)

* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/SDCard%20Module%20Schematic.pdf)

## S-Plus
![S-Plus](images/modules/s-plus.jpg)

* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/SPlus%20Module%20Schematic.pdf)

## Serial Camera
![Serial Camera](images/modules/serial-camera.jpg)

## Stepper L6470
![Stepper L6470](images/modules/stepper-l6470.jpg)

* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/Stepper%20L647x%20Module%20Schematic.pdf)

## TempHumidity
![TempHumidity](images/modules/temp-humidity.jpg)

* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/Temp%20Humid%20SI70%20Module%20Schematic.pdf)

## Thermocouple
![Thermocouple](images/modules/thermocouple.jpg)

* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/Thermocouple%20Module%20Schematic.pdf)

## Touch C8
![Touch C8](images/modules/touch-c8.jpg)

* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/Touch%20C8%20Module%20Schematic.pdf)

## Touch L12
![Touch L12](images/modules/touch-l12.jpg)

* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/Touch%20L12%20Module%20Schematic.pdf)

## Tunes
![Tunes](images/modules/tunes.jpg)

The Tunes Module is a tiny speaker that is connected to pin 9. Use PWM to generate sounds

* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/Tunes%20Module%20Schematic.pdf)

## UC Battery 4xAA
![UC Battery 4xAA](images/modules/uc-battery-4xaa.jpg)

No driver is needed.
* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/UC%20Battery%204xAA%20Module%20Schematic.pdf)

## USB Client DP
![USB Client DP](images/modules/usb-client.jpg)

No driver is needed.
* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/USB%20Client%20DP%20Module%20Schematic.pdf)

## USB Client SP
![USB Client SP](images/modules/usb-client-sp.jpg)

No driver is needed.
* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/USB%20Client%20SP%20Module%20Schematic.pdf)

## USB Host
![USB Host](images/modules/usb-host.jpg)

* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/USB%20Host%20Module%20Schematic.pdf)

## USB Serial
![USB Serial](images/modules/usb-serial.jpg)

Simply, a serial port.
* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/Serial%20USB%20Module%20Schematic.pdf)

## USB Serial SP
![USB Serial SP](images/modules/usb-serial-sp.jpg)

Simply, a serial port.
* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/USB%20Serial%20SP%20Module%20Schematic.pdf)

## VideoOut
![VideoOut](images/modules/video-out.jpg)

* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/VideoOut%20Module%20Schematic.pdf)

## WiFi RN171
![WiFi RN171](images/modules/wifi-rn171.jpg)

* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/WiFi%20RN171%20Module%20Schematic.pdf)

## WiFi RS21
![WiFi RS21](images/modules/wifi-rs21.jpg)

* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/WiFi%20RS21%20Module%20Schematic.pdf)

## XBee Adapter
![XBee Adapter](images/modules/xbee-adapter.jpg)

Simply, a serial port. From there a driver like https://xbee.codeplex.com/ will help.
* [Schematic](http://files.ghielectronics.com/downloads/Schematics/Gadgeteer/XBee%20Module%20Schematic.pdf)
