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