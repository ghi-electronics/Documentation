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
if x >=0: PrintLn(x):end
Wait(1000)
goto Loop
```
---
