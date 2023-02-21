# DUE - Library

---

These library functions are available on all DUE-supported hardware, for user defined functions, see [language](language.md) page

---

## System Functions
                       
- **Echo(enable)**  <br>
**enable:** 0 = Enable echo , 1 = Disable echo

- **Version**  - Returns the current firmware version of DUE <br>

- **Print(text)**  - Prints the value of the argument to the console on the same line <br>
**text:** String or variable

- **PrintLn(text)**  - Prints the value of the argument to the console then moves to the next line <br>
**text:** String or variable

- **GetTicks()** - read system current ticks in microseconds  <br>

- **Wait(duration)** - holds program from running <br>
**duration:** duration = milliseconds

- **Reset(loader)** - Resets the board <br>
**loader:** 0 = system reset,  1 = reset and stay in loader mode

---


## Digital

These functions provide access to digital pins.

##### Digital Write
- **DWrite(pin, state)**  - Sets a pins digital output <br>
**pin:** pin number <br> **state:** 1 = high or 0 = low

```basic
for x = 1 to 10
    DWrite(0,1)
    Wait(200)
    DWrite(0,0)
    Wait(200)
next
```

##### Digital Read

- **DRead(pin, pull)** - Read a digital pin output <br>
**pin:** 0-9 <br> 
**pull:** Sets the internal pull resistors to -> 0=none, 1=up, 2=down <br>
**Returns:** 1 = high or  0 = low 

```basic
x = DRead(2,1)
if x = 0
    Print("low")
else
    Print("high")
end
```
---
## Analog

These functions provide access to analog pins. 

##### Analog Write

- **AWrite(pin, dutyCycle)**  - Writes to pin using PWM <br>
**pin:** pin number<br>
**dutyCycle:** 0 to 1000

> [!NOTE] Frequency is fixed to 50hz.

```basic
@loop
for i=0 to 1000 step 100:AWrite(0,i):Wait(100):next
for i=1000 to 0 step -100:AWrite(0,i):Wait(100):next
goto loop

```

##### Analog Read

- **ARead(pin)**  - Read an analog output <br>
**pin:** pin number <br>
**Returns:** The analog value of the pin

```basic
@loop
for i=0 to 100:x=ARead(0):println(x):wait(100):next
goto loop
```

---
## Neopixel

Neopixel is fixed to pin number 1 

- **NeoClear()** - Clears all LEDs (in memory). Needs NeoShow() to see the affect

- **NeoSet(index, red, green, blue)** - Sets a specific LED to a color. Needs NeoShow() to see affect<br>
**index:** The LED index where 0 is first one and supporting up to 256 LEDs<br>
**red, green, blue:** Color levels, 0 to 255 <br>

- **NeoShow(count)** -<br>
 **count:** The count of LEDs to update and show

This example assumes we have 8 LEDs and will set 8 LEDs to red, increasing the color intensity from 0 to 80.  Then it waits one second before it sets the first LED to bright purple!

```basic
NeoClear()
for x = 0 to 8
    NeoSet(x,x*10,0,0)
next
NeoShow(8)
Wait(1000)
NeoSet(0,200,0,200)
NeoShow(8)
```

- **NeoStream(count)** - Streams data directly to LEDs.Needs NeoShow() to see affect<br>
 **count:** The count of LEDs to "stream"

> [!TIP] Data must be in GRB order and must be 3 x count bytes
 
---
## Frequency

Frequency is fixed to pin 0
- **Frequency(frequency, duration, dutyCycle)** - provides an accurate hardware generated PWM signal <br>
**pin:** pin number <br>
**duration:** 0 to forever <br>
**dutyCycle:** 0 to 1000

```basic
code sample
```

---
## Infrared

IR decoder is fixed to pin 2

- **IrEnable(enable)** - enables pin for IR signal capture <br>
**enable:** 1 = enable, 0 = disable <br>

- **IrRead()** - reads the value from the IR enabled pin <br>
**Return:** Tracks the past 16 key presses and returns them. -1 if none.

```basic
code sample
```

---

## SPI


- **SpiByte(byte)** - sends a byte <br>
**byte:** - value 0 to 255 <br>
**Return:**  Read byte value

```basic
code sample
```

- **SpiSteam(writeCount, readCount, cs)** - Streams data directly to the SPI device <br>
**writeCount:** <br>
**readCount:** <br>
**cs:** set to -1 if not needed

```basic
code sample
```

---


## I2C

- **I2cBytes(address, writeCount, readCount)** -  Reads and/or writes up to 4 bytes to/from I2C bus. Data is transfered to and from variables A, B, C, D<br>
**address:** address of the I2C device <br>
**writeCount:** <br>
**readCount:** <br>

```basic
code sample
```

- **I2cStream(address, writeCount, readCount)** -  <br>
**address:** address of the I2C device <br>
**writeCount:** xxxxx <br>
**readCount:** xxxxx <br>

```basic
code sample
```

> [!NOTE] On SC13 devices only: The I2C pins are different on BrainPad Pulse vs FEZ boards. PB15 is used to determine how I2C should work. Pay attention to the state of PB15 on power up, Pulse has it pulled up through 10k resistor.

---

## UART

- **UartInit(baudRate)** - Sets the baudrate UART   <br>
**baudRate:** Any commonly used standard baudrate 

- **UartRead()** - Read  <br>
**Returns:** A byte from UART

- **UartWrite(data)** - Write  <br>
**data:** Data byte to send on UART

- **UartCount()** - Count  <br>
**Returns:** How many bytes have been buffered and ready to be read


```basic
code sample
```

---

## Touch

- **TouchRead(pin)** - Initializes the pin for touch   <br>
**pin:** pin number

```basic
code sample
```

---

## Servo Motor

- **ServoSet(pin, degree)** - Initializes the pin for    <br>
**pin:** pin number  <br>
**degree:**  0 to 180

> [!TIP] most servo motors need 5V to work.

```basic
code sample
```

---

## Distance Sensor
- **Distance(pulse, echo)** - uses ultrasonic sonic sensor to read distance.

> [!TIP] most sensors need 5V to work.

```basic
code sample
```

---


## Buttons

- **BtnEnable(pin, enable)** <br>
**pin:** pin number  <br>
**enable:** 1 = enable, 0 = disabled  <br>

- **BtnDown(pin)** <br>
**pin:** pin number  <br>
**Returns:** 1 if button was pressed and continues to return 1 until the button is released


> [!TIP] Will always return zero if not enabled

```basic
code sample
```

---


## Device Specific
These functions are added to support the built in display & buzzer found on the Brainpad Pulse

## Sounds

- **Sound(frequency, duration, volume)** <br>
**frequency:** sound frequency in Hz <br>
**duration:** in milliseconds. 0 is always on <br>
**volume:** 0 to 100

```basic
Sound(256,1000,50) # Plays middle C note for 1 second at 50% volume
```

---

## LCD


- **LcdShow()** Sends the display buffer to the LCD. 

- **LcdClear(color)**  Clears the entire screen to black or white<br>
**color:** 0 = black, 1 = white

```basic
LcdClear(0)
LcdShow()
```

##### Draw Line

- **LcdLine(color, x1,y1,x2,y2)** <br>
**color:** 0 = black, 1 = white <br>
**x1:** Starting x point <br>
**y1:** Starting y point <br>
**x1:** Ending x point <br>
**y1:** Ending y point 

```basic
LcdClear(0)
LcdLine(1,0,0,128,64)
LcdShow()
```

##### Set Pixel

- **LcdPixel(color, x, y)** <br>
**color:** 0 = black, 1 = white <br>
**x:** x pixel value<br>
**y:** y pixel value

```basic
LcdClear(0)
LcdPixel(1,64,32)
LcdShow()
```

##### Draw Circle

- **LcdCircle(color, x,y,radius)** <br>
**color:** 0 = black, 1 = white <br>
**x:** x position of circle's center <br>
**y:** y position of circle's center <br>
**radius:** radius of the circle

```basic
LcdClear(0)
LcdCircle(1,64,32,31)
LcdShow()
```

##### Draw Rectangle

- **LcdRect(color, x1, y1, x2, y2)** <br>
**color:** 0 = black, 1 = white <br>
**x1:** Starting x point <br>
**y1:** Starting y point <br>
**x1:** Ending x point <br>
**y1:** Ending y point 

```basic
LcdClear(0)
LcdRect(1,10,10,118,54)
LcdShow()
```

##### Draw Text

- **LcdText(text, color, x, y)** <br>
**text:** Takes either a variable or "string"<br>
**color:** 0 = black, 1 = white <br>
**x:** x position <br>
**y:** y position

```basic
LcdClear(0)
LcdText("Hello World",1,10,10)
LcdShow()
```
##### Draw Scaled Text

- **LcdTextS("text", color, x, y, scaleWidth, scaleHeight)** <br>
**text:** String message <br>
**color:** 0 = black, 1 = white <br>
**x:** x position <br>
**y:** x position <br>
**scaleWidth:** Width scale multiplier <br>
**scaleHeight:** Width scale multiplier 

```basic
LcdClear(0)
LcdText("Hello",1,0,0,2,2)
LcdShow()
```

> [!TIP]Scale is multiplier for the pixel in width and height to make the font larger

##### LCD Stream

Stream is used to send chunks of data to the device. 

- **LcdStream()** 



