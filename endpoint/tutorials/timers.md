[IN PROGRESS](error.md) 
# Timers
---
A timer is used to call a method at a specific time. This example will call or invoke the Ticker method after a three second delay, and then it will call Ticker once a second indefinitely.

```cs
static void Ticker(object o) {
    Debug.WriteLine("Hello!");
}

static void Main() {
    Timer timer = new Timer(Ticker, null, 3000, 1000);

    Thread.Sleep(Timeout.Infinite);
}
```

A thread can also be created that loops once a second on its own, without being called by a timer. The difference is that a thread that contains a one second sleep will delay for that one second in addition to the time used by other code in the thread. So, if a thread needs 0.5 second to complete what it is doing, sleeping for one second will cause the thread to execute every 1.5 seconds. This also gets more complex as a thread's code can have different processing time in every loop.

A timer set to invoke a method every second will do so every second regardless of how long the invoked method takes to execute. However, care must be taken, because if a timer calls a method every 100 milliseconds, but the method needs more than 100 milliseconds to execute, you will end up flooding the system. The best practice is for timers to invoke methods that execute in a very short time.
