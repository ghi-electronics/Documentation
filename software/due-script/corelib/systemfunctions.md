## System Functions
- **Cos(number)** - Returns the cosine of the argument        
        
- **Echo(enable)**  <br>
**enable:** 0 = Enable echo , 1 = Disable echo

- **GetCh()** - reads character input, in ASCII format. Return **-1** when no character detected  <br>

- **GetNum()** - reads number input, can be used with **IsNAN()** to determine if value is a number  <br>

- **Print(text)**  - Prints the value of the argument to the console on the same line <br>
**text:** String or variable

- **PrintLn(text)**  - Prints the value of the argument to the console then moves to the next line <br>
**text:** String or variable

- **Reset(loader)** - Resets the board <br>
**loader:** 0 = system reset,  1 = reset and stay in loader mode

- **Rnd(max)** - Generates random number
**max:** maximum value of random number
**Returns:** returns random number between 0 and value of argument **max**

- **Sin(number)** - Returns the sine value of the argument

- **Sqrt(number)** - Returns the square root of the argument

- **Tan(number)** - Returns the tangent of the argument

- **TickMs()** - read system ticks in milliseconds  <br>

- **TickUs()** - read system ticks microseconds  <br>

- **Trunc(number)** - Returns the truncated value of the argument

- **Version**  - Returns the current firmware version of DUE <br>
The last character returned in Version is board <br> 

  | Board       | Character |
  | :---        |:---       |
  |    Pulse    |     P     |
  |    Edge     |     E     |
  |    Flea     |     F     |
  |    Pico     |     I     |

- **Wait(duration)** - holds program from running <br>
**duration:** duration = milliseconds












---