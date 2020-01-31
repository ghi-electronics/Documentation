# Multithreading
---
TinyCLR OS is a single process system, only running your application. This is in fact a good security feature! However, TinyCLR OS supports threading similar to full .NET.

```cs
void Blinker()
{
    // LED on
    Thread.Sleep(100);
    // LED off
    Thread.Sleep(100);
}

void main()
{
    var t = new Thread(Blinker);
    t.Start();
    // do secondary task
    Thread.Sleep(Timout.Infinite);
}
```
