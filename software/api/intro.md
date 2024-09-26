# Core Library

---

The core library gives DUE Scripts the necessary API to access hardware. It has other software related libraries as well. These API functions are available from within DUE Scripts and runs host-less. When using a host, a library for that particular language is provided to reflect the DUE Core library. For example, when using Python, the provided Python library includes `dev.Led.Set(200,800,20)` which mirrors the [LED](led.md) API.

| API       | Description          |
| :--- |:---|
| [Analog](analog.md) | Read or Write analog pins |
| [Beep](beep.md) | Beep using any pin |
| [Button](button.md) | Read a button. Similar to Digital read but handles debounce |
| [Digital](digital.md) | Read or write digital pins |
| [Distance](distance.md) | Read ultrasonic distance sensor |
| [Frequency](frequency.md) | Generate frequency on a specific pin. This uses hardware PWM internally|
| [I2C](i2c.md) | Access the I2C bus for transferring data |
| [Infrared](infrared.md) | Read and decode IR remote control signal |
| [LCD](lcd.md) | Draw on LCD (device specific) |
| [LED](led.md) | Control the on-board LED |
| [NeoPixel](neopixel.md) | Control smart color LEDs |
| [Servo](servo.md) | Control servo motors |
| [SPI](spi.md) | Access the SPI data bus |
| [System Functions](systemfunctions.md) | Built-in functions |
| [Temp-Humidity](temp-humidity.md) | Works with DHT sensors |
| [Touch](touch.md) | Allows for capacitive touch sensing |
| [UART](uart.md) | Transfer data on the UART serial port |

