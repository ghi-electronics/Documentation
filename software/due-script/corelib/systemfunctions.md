## System Functions
                       
- **Echo(enable)**  <br>
**enable:** 0 = Enable echo , 1 = Disable echo

- **Version**  - Returns the current firmware version of DUE <br>
The last character returned in Version is board <br> 

  | Board       | Character |
  | :---        |:---       |
  |    Pulse    |     P     |
  |    Edge     |     E     |
  |    Flea     |     F     |
  |    Pico     |     I     |

- **Print(text)**  - Prints the value of the argument to the console on the same line <br>
**text:** String or variable

- **PrintLn(text)**  - Prints the value of the argument to the console then moves to the next line <br>
**text:** String or variable

- **GetTicks()** - read system current ticks in microseconds  <br>

<!---
- **GetSeconds()** - read system current ticks in seconds  <br>
-->

- **GetCh()** - reads character input, in ASCII format. Return **-1** when no character detected  <br>

- **GetNum()** - reads number input, can be used with **IsNAN()** to determine if value is a number  <br>

- **Wait(duration)** - holds program from running <br>
**duration:** duration = milliseconds

- **Reset(loader)** - Resets the board <br>
**loader:** 0 = system reset,  1 = reset and stay in loader mode

- **Rnd(max)** - Generates random number
**max:** maximum value of random number
**Returns:** returns random number between 0 and value of argument **max**

- **Sin(number)** - Returns the sine value of the argument

- **Cos(number)** - Returns the cosine of the argument

- **Tan(number)** - Returns the tangent of the argument

- **Sqrt(number)** - Returns the square root of the argument

- **Trunc(number)** - Returns the trunicated value of the argument
---