# DUE - Library

---

These library functions are available on all DUE-supported hardware, for user defined funtions, see [langage](language.md) page

---
## Digital

These functions provide access to digital pins.

### Digital Write
- **dwrite(pin, state)**  - Sets a digital output <br>
**pin:** pin number <br> **state:** 1 = high or 0 = low

```basic
for x = 1 to 10
    dwrite(0,1)
    wait(200)
    dwrite(0,0)
    write(200)
next
```

### Digital Read

- **dread(pin, pull)** - Read a digital pin output <br>
**pin:** 0-9, <br> **pull:** Sets the internal pull resistors to -> 0=none, 1=up, 2=down <br>
**Returns:** 1 = high or  0 = low 

```basic
x = dread(2,1)
if x = 0
    print("low")
else
    print("high")
end
```
---
## Analog

### Analog Write

- **awrite(pin, dutyCyle)**  - Sets an analog output <br>
**pin:** pin number
dutyCylcle 0 to 1000
 fized to 50hz

```basic
awrite(1)
```

### Analog Read

- **aread(pin)**  - Read an analog output <br>
**pin:** pin number

```basic
aread(1)
```

---
## Neopixel
fixed on pin 1
- **NeoClear()** - Clears all LEDs (in memory). Needs NeoShow() to see the affect

- **NeoSet(index, red, green, blue)** - Sets a specific LED to a color. Needs NeoShow() to see affect<br>
**index:** The LED index where 0 is first one and supporting up to 256 LEDs<br>
**red, green, blue:** Color levels, 0 to 255 <br>

- **NeoShow(count)** -<br>
 **count:** The count of LEDs to update and show

This example assumes we have 8 LEDs and will set 8 LEDs to red, increasing the color intensity from 0 to 80.  Then it waits one second before it sets teh first LED to bright purple!

```basic
NeoClear()
for x = 0 to 8
    NeoSet(x,x*10,0,0)
next
NeoShow(8)
wait(1000)
NeoSet(0,200,0,200)
NeoShow(8)
```

- **NeoStream(count)** - Streams data directly to LEDs.Needs NeoShow() to see affect<br>
 **count:** The count of LEDs to "stream"

> [!TIP] Data must be in GRB order and must be 3 x count bytes
 
---
## Frequency

fixed to pin 0
- **Frequency(frequency, duration, dutyCycle)** - provides an accurate hardware generated PWM signal <br>
**pin:** pin number <br>
**duration:** 0 to forever <br>
**dutyCycle:** 0 to 1000

```basic
code sample
```

---
## Infrared

IR decoder on pin, fioxed to pin 2

- **IrEnable(enable)** - enables pin for IR signal capture <br>
**enable:** 1 = enable, 0 = disable <br>

- **IrRead()** - reads the value from the IR enabled pin <br>
**Return:** Tracks the past 16 key pressea sand return them. Return -1 if none.

```basic
code sample
```

---

## SPI


- **spibyte(byte)** - sends a byte <br>
**byte:** - value 0 to 255 <br>
**Return:**  Read byte value

```basic
code sample
```

- **spisteam(writeCount, readCount, cs)** - Streams data directly to the SPI device <br>
**writeCount:** xxxxx <br>
**readCount:** xxxxx <br>
**CS:** set to -1 if not needed

```basic
code sample
```

---


## I2C

- **I2cBytes(address, writeCount, readCount)** -  Reads and/or writes up to 4 bytes to/from I2C bus. Data is transfered to and from variables A,B,C,D<br>
**address:** address of the I2C device <br>
**writeCount:** xxxxx <br>
**readCount:** xxxxx <br>

```basic
code sample
```

- **i2cstream(address, writeCount, readCount)** -  <br>
**address:** address of the I2C device <br>
**writeCount:** xxxxx <br>
**readCount:** xxxxx <br>

```basic
code sample
```

>[!Note] On SC13 devices only: The I2C pins are different on BrainPad Pulse vs FEZ boards. PB15 is used to determine how I2C should work. Pay attention to the state of PB15 on power up, Pulse has it pulled up through 10k resistor.

---

## UART

- **uartInit(baudRate)** - Sets the baudrate UART   <br>
**baudRate:** Any commonly used standard baudrates 

- **uartRead()** - Read  <br>
**Return:** Returns a byte from UART

- **uartWrite(data)** - Write  <br>
**data:** Data byte to send on UART

- **uartCount()** - Count  <br>
**Return:** How many bytes have been buffered and ready to be read


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

---

## Distance Sensor
- **distance(pulse, echo)** - uses ultrasonic sonic sensor to read distance.

>[!Tip] most sensors need 5V to work.

---

## System Functions

- **GetTicks()** - read system current ticks in microseconds  

- **Wait()** - holds program from running for milliseconds 

- **Reset(loader)** - Resets the board
**loader:** 0 = system reset,  1 = reset and stay in loader mode

---


## Buttons

- **BtnEnable(pin, enable)** <br>
**pin:** pin number  <br>
**enable:** 1 = enable, 0 = disabled  <br>

- **BtnDown(pin)** <br>
**pin:** pin number  <br>
**Return:** 1 if button was pressed and continues to return 1 until the button is released


>{!Tip} Will always return zero if not enabled


## Device Specific
These functions are added to suppiort  the builty in desplays fopudjn on the nrainpad pul;se, same for teh built in buzer.

## Sound

- **Sounds(frequency, duration, volume)** <br>
**frequency:** sound frequency  <br>
**duration:** in milliseconds. 0 is always on <br>
**volume:** 0 to 100

## LCD

- **LcdClear(color)** 

- **LcdShow()** 

- **LcdLine(color, x1,y1,x2,y2)** 
- **LcdPixel(color, x, y)** 
- **LcdCircle(color, x,y,diameter)** 
- **LcdRect(color, x1, y1, x2, y2)** 
- **LcdText(text, color, x, y)** 
- **LcdTextS(text, color, x, y, scaleWidth, scaleHeight)** 
scale is multiopelr for the pixels in width and height to make the font larger


- **DispStream()** 



