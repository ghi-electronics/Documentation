# Timers
---

## Introduction
NETMF includes 2 timer classes, Timer and ExtendedTimes. Timer class is the same one included in full framework where ExtendedTimer is specific to NETMF with extra functionality.

## A timer example
This example creates a timer that will run after five seconds and then it will keep firing every second.

Note: the time parameters expect times in milliseconds.

```cs
using System.Threading;
using Microsoft.SPOT;

public class Program
{
    class OurClass
    {
        public int x;
    }

    static void RunMe(object o)
    {
        OurClass cls = (OurClass)o;
        Debug.Print("From timer!");
        Debug.Print("Value: " + cls.x.ToString());
    }

    public static void Main()
    {
        OurClass cls = new OurClass();
        cls.x = 5;

        Timer MyTimer =
           new Timer(new TimerCallback(RunMe), cls, 5000, 1000);
        Debug.Print(
               "The timer will fire in 5 seconds and then fire priodically every 1 second");
        Thread.Sleep(Timeout.Infinite);
    }
}
```
