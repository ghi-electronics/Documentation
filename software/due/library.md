# Due - Library

---

These library functions are available on all Due-supported hardware, for user defined functions, see [language](language.md) page

> [!TIP]
> Code samples are using upper and lower case to make things look clearer. Due is not case sensitive and Print("Due") is exactly the same as print("Due")

## Streams

Some functionality require speed when sending/retrieving data to/from a device. For example, when sending the entire LCD display.

A stream command initiates the request, in this case **LcdStream()**. Once this command is received and accepted by the device, it will respond with the **&** symbol. Now, the PC can send the entire data, exactly to the required byte count. This required count, to follow the stream command, is documented with each stream command individual. 

---

## System Functions
                       
- **Echo(enable)**  <br>
**enable:** 0 = Enable echo , 1 = Disable echo

- **Version**  - Returns the current firmware version of Due <br>

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

**Digital Write**
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

> [!NOTE] 
> Frequency is fixed to 50hz.

```basic
@loop
for i=0 to 1000 step 100
    AWrite(0,i)
    Wait(100)
next
for i=1000 to 0 step -100
    AWrite(0,i) 
    Wait(100)
next
goto loop

```

##### Analog Read

- **ARead(pin)**  - Read an analog output <br>
**pin:** pin number <br>
**Returns:** The analog value of the pin

```basic
@loop
for i=0 to 100
    x=ARead(0)
    PrintLn(x)  
    Wait(100)
next
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
 **count:** The count of LEDs to "stream"<br>
 **Stream size:** It is "count" multiplied by 3, due to the fact that each LED needs 3 bytes for colors, ordered in GRB format.
 
---
## Frequency

Frequency is fixed to pin 0
- **Freq(frequency, duration, dutyCycle)** - provides an accurate hardware generated PWM signal <br>
**frequency:** frequency <br>
**duration:** 0 to forever <br>
**dutyCycle:** 0 to 1000

> [!NOTE] 
> Freq() is a non-blocking function, calling Freq() a second time before the duration of the first call is over will end the function despite the duration of first calls argument.

```basic
@Loop
for x=1 to 1000
    Freq(x,500,500)
    Wait(200)
next
for x=1000 to 1 step -1
    Freq(x,500,500)
    Wait(200)
next
goto Loop
```

---
## Infrared

IR decoder is fixed to pin 2

- **IrEnable(enable)** - enables pin for IR signal capture <br>
**enable:** 1 = enable, 0 = disable <br>

- **IrRead()** - reads the value from the IR enabled pin <br>
**Return:** Tracks the past 16 key presses and returns them. -1 if none.


|Button              |Return Value|
|:----------------|:----------|
|power            |0               |
|up               |1               |
|lightbulb        |2               |
|left arrow       |4               |
|sound            |5               |
|right arrow      |6               |
|backward         |8               |
|down             |9               |
|forward          |2               |
|+                |12              |
|0                |13              |
|-                |14              |
|1                |16              |
|2                |17              |
|3                |18              |
|4                |19              |
|5                |20              |
|6                |21              |
|7                |22              |
|8                |23              |
|9                |24              |




```basic
IrEnable(1)
@Loop
x=IrRead()
if x >=0: Println(x):end
Wait(1000)
goto Loop
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
**writeCount:** The number of bytes to write<br>
**readCount:** The number of bytes to read<br>
**cs:** set to -1 if not needed<br>
**Stream size:** The stream starts with PC sending "writeCount" of bytes and then the PC must read the "readCount". If either count is zero then that step can be skipped.




```basic
code sample
```
- **Spi4Bpp(count)** - Streams and converts data from 4BPP to 16BPP<br>
**count:** The count of bytes to be written.<br>
**Stream size:** The "count".

This special function converts 4BPP incoming data to 16BPP on-the-fly. This is added to speed up the use of SPI color displays, namely ones using ST7735 found on the very common 1.8" SPI color displays. This allows for faster updates, since each byte sent is 2 pixels.

- **Palette(index, colorValue)** - Sets the desired color for a palette.<br>
**index:** Index number of color<br>
**colorValue:** A standard HEX value of the RGB color.

This function goes hand-in-hand with **Spi4Bpp()** function to set the colors that are to be used. 

Default colors:

|Index|Color Value|Color|
|:-   |:-------|:----------|
|0    |0x000000|Black      |
|1    |0xFFFFFF|White      |
|2    |0xFF0000|Red        |
|3    |0x32CD32|Lime       |
|4    |0x0000FF|Blue       |
|5    |0xFFFF00|Yellow     |
|6    |0x00FFFF|Cyan       |
|7    |0xFF00FF|Magenta    |
|8    |0xC0C0C0|Silver     |
|9    |0x808080|Gray       |
|10   |0x800000|Maroon     |
|11   |0xBAB86C|Olive      |
|12   |0x00FF00|Green      |
|13   |0xA020F0|Purple     |
|14   |0x008080|Teal       |
|15   |0x000080|Navy       | 


---


## I2C

- **I2cBytes(address, writeCount, readCount)** -  Reads and/or writes up to 4 bytes to/from I2C bus. Data is transfered to and from variables A, B, C, D<br>
**writeCount:** The number of bytes to write<br>
**readCount:** The number of bytes to write

```basic
code sample
```

- **I2cStream(address, writeCount, readCount)** -  <br>
**address:** address of the I2C device <br>
**writeCount:** <br>
**readCount:** <br>
**Stream size:** The stream starts with PC sending "writeCount" of bytes and then the PC must read the "readCount". If either count is zero then that step can be skipped.

```basic
code sample
```

> [!NOTE] 
> On SC13 devices only: The I2C pins are different on BrainPad Pulse vs FEZ boards. PB15 is used to determine how I2C should work. Pay attention to the state of PB15 on power up, Pulse has it pulled up through 10k resistor.

---

## UART

- **UartInit(baudRate)** - Sets the baud rate UART   <br>
**baudRate:** Any commonly used standard baud rate 

- **UartRead()** - Read UART data  <br>
**Returns:** A byte read from UART

- **UartWrite(data)** - Write UART data <br>
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
@Loop
a=TouchRead(0):b=TouchRead(1):c=TouchRead(2)
if a>0:Println("pin 0"):end 
if b>0:Println("pin 1"):end
if c>0:Println("pin 2"):end 
wait(100)
goto Loop
```

---

## Servo Motor

- **ServoSet(pin, degree)** - Sets servo motor connected to pin to a specific position<br>
**pin:** pin number  <br>
**degree:**  0 to 180

> [!TIP] 
> Many servo motors need 5V to work.

```basic
@Loop
ServoSet(0,0)
Wait(1000)
ServoSet(0,180)
Wait(1000)
goto Loop
```

---

## Distance Sensor
- **ReadDistance(trigger, echo)** - uses ultrasonic sonic sensor to read distance.<br>
**trigger:** The pin number that is connected to trigger (pulse) signal<br>
**echo:**  The pin number that is connected to echo signal<br>
**Returns:**  Distance in centimeters

> [!TIP]
> most sensors need 5V to work.

```basic
@Loop
x = Distance(0,1) 
if x>0 
    PrintLn(x)
end
Wait(100)
goto Loop
```

---


## Buttons

- **BtnEnable(pin, enable)** - sets up a button to be used <br>
**pin:** pin number, 'a', or 'b' <br>
**enable:** 1 = enable, 0 = disabled  <br>

- **BtnDown(pin)** Returns a value when button is pressed<br>
**pin:** pin number, 'a', or 'b' <br>
**Returns:** 1 if button was pressed and continues to return 1 until the button is released

> [!NOTE] 
> **'a'** is ASCII a or 97, **'b'** is ASCII b or 98

> [!TIP] 
> Will always return zero if not enabled

```basic
BtnEnable('a',1)
@Loop
x=BtnDown('a')
if x=1
    Println("Button A")
end
goto Loop
```

---


## Device Specific
These functions are added to support the built in display & buzzer found on the BrainPad Pulse

## Sounds

- **Sound(frequency, duration, volume)** <br>
**frequency:** sound frequency in Hz <br>
**duration:** in milliseconds. 0 is always on <br>
**volume:** 0 to 100

>[!NOTE] 
> Sound() uses Freq() which is a non-blocking function. Calling Sound() could end the duration of the previous Sound() despite the set duration inside the argument. See Freq() section for more details. 

```basic
Sound(256,1000,50) 
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

**Draw Line**

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

**Set Pixel**

- **LcdPixel(color, x, y)** <br>
**color:** 0 = black, 1 = white <br>
**x:** x pixel value<br>
**y:** y pixel value

```basic
LcdClear(0)
LcdPixel(1,64,32)
LcdShow()
```

**Draw Circle**

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

**Draw Rectangle**

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


**Draw Scaled Text**

- **LcdTextS("text", color, x, y, scaleWidth, scaleHeight)** <br>
**text:** String message in double quotes. Using variables is not supported<br>
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

> [!TIP]
> Scale is multiplier for the pixel in width and height to make the font larger

**Draw Text**

- **LcdText("text", color, x, y)** <br>
Works exactly the same as **LcdText()** minus scaling.

```basic
LcdClear(0)
LcdText("Hello World",1,10,10)
LcdShow()
```

**LCD Stream**

Stream is used to send the entire LCD update. 

- **LcdStream()**<br>
 **Stream Size:** The size screen size divided by 8, 128x64/8=1K.
The data is organized as 8bit columns going left to right and then wrapping around to the next row.

Example code to set a pixel at 10x10

```cs
int x=10;
int y=10;

buffer[(y >> 3) * 128 + x] |= (byte)(1 << (y & 7));
```



