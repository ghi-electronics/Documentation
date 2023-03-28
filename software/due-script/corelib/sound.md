## Sounds
This function is device specific and added to support products with built in buzzers like the one found on the BrainPad Pulse.


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


