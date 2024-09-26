# Internal Engine
---

DUELink internal engine is a runtime that interprets and runs DUELink Scripts. These scripts are remotely sent and executed by the connected host. For example, when calling `duelink.Digital.Write(0, true)` in Python, the API will end up sending `DWrite(0,1)` to the engine.

> [!TIP] 
> The documentation of DUELink's internal engine and DUELink scripts are furnished for advanced user looking to expand the system's functionality.

It is possible to record scripts that persist on a DUELink Motherboard. This can be used for two purposes. First, to expand available the functionality and define new commands. This is helpful in real-time applications or to speed things up, where calling this custom method from the host machine will process multiple tasks internally. The second purpose is to allow a DUELink Motherboard to run stand alone to handle small stand alone tasks that does not require high level language such as Python.

## DUELink API Reference


### Analog
| Function | Description
| --- | ---
| ARead(pin) | `pin`: pin number - **Returns**: 0 to 100
| AWrite(pin, dutyCycle) | `pin`: pin number - `dutyCycle`: 0 to 100


### Beep
| Function | Description
| --- | ---
| Beep(pin, frequency, duration) | `pin`: pin number or 'p' - `frequency`: Hz max 10KHz - `duration`: milliseconds

### Button
| Function | Description
| --- | ---
| BtnEnable(pin, enable) |  `pin`: pin number, 'a' or 'b' - `enable`: 1 = enable 0 = disabled
| BtnUp(pin) |  `pin`: pin number, 'a' or 'b' - **Returns**: 1 after first time called. 0 if called again
| BtnDown(pin) |  `pin`: pin number, 'a' or 'b' - **Returns**: 1 if button is pressed

### Cosine
| Function | Description
| --- | ---
| Cos(number) | **Returns**: cosine of its argument

### Digital
| Function | Description
| --- | ---
| DRead(pin, pull) | `pin`: pin number - `pull`: 0 = none, 1 = up, 2 = down - Returns: 1 = high or 0 = low
| DWrite(pin, state) | `pin`: pin number - `state`: 1 = high or 0 = low

### Echo
Echoes back what is received useful when using a terminal program

| Function | Description
| --- | ---
| Echo(state) | `state`: 0 = enable or 1 = disable

### Format
| Function | Description
| --- | ---
| Fmt() | Formats multiple arguments into a single string

### Frequency
| Function | Description
| --- | ---
| Freq(pin, frequency, duration, dutyCycle) | `pin`: pin number - `frequency`: in KHz - `duration`: 0 to forever - `dutyCycle`: 0 to 100

### Get Character
| Function | Description
| --- | ---
| GetCh() | Returns: character input in ASCII format, -1 = no character

### Get Number
| Function | Description
| --- | ---
| GetNum() | Reads number input, can be used with IsNAN()

### Humidity
| Function | Description
| --- | ---
| Humidity(pin, type) | `pin`: pin number - `type`: DHT11 = 11, DHT12 = 12, DHT22 = 22, DHT21 = 21 - **Returns**: Humidity 0 to 100

### I2C
| Function | Description
| --- | ---
| I2cBytes(address, arrayWrite, writeCount, arrayRead, readCount) | `address`: I2C slave address - `arrayWrite`: array to send, `writeCount`: number of bytes to write, `arrayRead`: array to read,`readCount`: Number bytes to read

### Infrared
| Function | Description
| --- | ---
| IrEnable(pin,enable) |  `pin`: on supported pins `enable`: 1 = enable or 0 = disable
| IrRead() | **Returns**: key press value 0 to 24

 ### LCD Drawing
| Function | Description
| --- | ---
| LcdClear(color) | `color`: 0 = black 1= white or any color value
| LcdCircle(color, x, y, radius) | `color`: 0 = black or 1 = white - `x`: x circle center value - `y`: y circle center - `radius`: radius of circle
| LcdConfig(output, address) | `output`: 0 = none, 1 = console, 2 = LCD and console - `address`: I2C address, 0 = default BrainPad Pulse
| LcdFill(color, x, y, width, height)|  `color`: 0 = black or 1 = white - `x`: starting x point - `y`: starting y point - `width`: rectangle width - `height`: rectangle height
| LcdImg(array, x, y, transform) | `array`: image array - `x`: x position - y: `y `position - `transform`: 0 = none, 1 = flip horz, 2 = flip vert, 3 = 90 deg, 4 = 180 deg, 5 = 270 deg
| LcdImgS(array, x, y, transform, scaleWidth, scaleHeight) | same as LcdImg() adds `scaleWidth` and `scaleHeight`
| LcdLine(color, x1, y1, x2, y2) | `color`: 0 = black or 1 = white or any color value- `x1`: starting x point - `y1`: starting y point - `x2`: ending x point - `y2`: ending y point
| LcdPixel(color, x, y) | `color`: 0 = black or 1 = white - x: `x` pixel value - y: `y` pixel value
| LcdRect(color, x, y, width, height) | `color`: 0 = black or 1 = white or any color value- `x`: starting x point - `y`: starting y point - width: rectangle `width` - `height`: rectangle height
| LcdText("text", color, x, y) | `text`: string message in quotes, use Str() to convert variable - `color`: 0 = black or 1 = white - `x`: x position - `y`: y position
| LcdTextT("text", color, x, y) | displays tiny 5px `text`: , use Str() to convert variable - `color`: 0 = black or 1 = white - `x`: x position - `y`: y position
| LcdTextS("text", color, x, y, scaleWidth, scaleHeight) | same as LcdText() adds `scaleWidth` and `scaleHeight`
| LcdShow() | sends the display buffer to the LCD
| LcdClear(color) | `color`: 0 = black 1= white or any color value

 ### Log
 | Function | Description
| --- | ---
| Log() | sends content to the output on the same line
| LogLn() | sends content to the output on a new line

### LED On-board
 | Function | Description
| --- | ---
| LED(high, low, count) | `high`: duration on in milliseconds, `low`: duration off in milliseconds, `count`: number of times to blink

### NeoPixel
| Function | Description
| --- | ---
| NeoClear() | clears all LEDS in memory needs **NeoShow()**
| NeoSet(index, red, green, blue) | `index`: led from 0 to 255, `red`, `green`, `blue`: color levels 0 to 255
| NeoShow(pin, count) | `pin`: pin number - count: number of LEDs to update

### Print
| Function | Description
| --- | ---
| Print("text" or variable) | returns the value of it's argument
| PrintLn("text" or variable) | returns the value of it's argument with line breaks

### Distance Sensor
| Function | Description
| --- | ---
| ReadDistance(trigger, echo) | `trigger`: pin number of trigger - `echo`: pin number of echo, -1 for single pin - **Returns**: distance in centimeters

### Reset
| Function | Description
| --- | ---
| Reset(loader) | `loader`: 0 = system reset, 1 = reset to loader mode

### Random Numbers
| Function | Description
| --- | ---
| Rnd(max) | `max`: maximum value of random number - **Returns**: random number between 0 and max

### Servo Motors
| Function | Description
| --- | ---
| ServoSet(pin, degree) | `pin`: pin number - `degree`: 0 to 180

### Servo Motors
| Function | Description
| --- | ---
| Sin(number) | **Returns** the sine value of its argument

### Sine
| Function | Description
| --- | ---
| Sin(number) | **Returns** the sine value of its argument

### SPI
| Function | Description
| --- | ---
| SpiByte(byte)  | `byte`: 0 to 255 - **Returns**: Read byte value
| SpiCfg(mode, frequency)  | `mode`: 0 to 3 - `frequency`: 200 to 20000 (200KHz to 20MHz)

### Square Root
| Function | Description
| --- | ---
| Sqrt(number) | **Returns** the square root value of it's argument

### String Numbers
| Function | Description
| --- | ---
| Str(number) | **Returns** number as string when need in arguments

### Tangent
| Function | Description
| --- | ---
| Tan(number) | **Returns** the tangent of it's argument

### Temperature
| Function | Description
| --- | ---
| Temp(pin, type) | `pin`: pin number - `type`: DHT11 = 11, DHT12 = 12, DHT22 = 22, DHT21 = 21 - ****Returns**: Temperature in Celsius

### Ticks
| Function | Description
| --- | ---
| TickMs()| Read system ticks in milliseconds
| TickUs()| Read system ticks in microseconds

### Touch 
| Function | Description
| --- | ---
| TouchRead(pin) | `pin`: pin number, 'x' or 'y' - **Returns**: 0 = pin not touched or pin 1 = touched - **Touch Screen Returns**: -1 = not touched or x and y position

### Trunicate
| Function | Description
| --- | ---
| Trunc(number) | **Returns** the truncated value of it's argument

### Version
| Function | Description
| --- | ---
| Version | **Returns** firmware and device versions

### Wait
| Function | Description
| --- | ---
| Wait(duration) | `duration`: in milliseconds

