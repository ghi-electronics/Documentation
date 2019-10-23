# Timers
---

A timer is used to call a method at a specific time. This example will call (invoke) Ticker initially after 3 seconds and then it will repeat once a second indefinitely.

```cs
static void Ticker(object o) {
    Debug.WriteLine("Hello!");
}
static void Main() {

    Timer timer = new Timer(Ticker, null, 3000, 1000);

    Thread.Sleep(Timeout.Infinite);
}
```

A thread can also be created that loops once a second. The difference is that a thread with a 1 second sleep will always sleep for one second after whatever time was needed by the thread. So if a thread needed 0.5 second to complete what it is doing, sleeping for one second will cause the thread to execute every 1.5 seconds. This also gets more complex as a thread can be interrupted by the system. There is no guaranteed time on threads.

A timer set to invoke a method every second will do so every second regardless of how long that method needs to complete its task. However, care must be taken as if a timer calls a method every 10 milliseconds but then the method needs more than 10 milliseconds to execute you will end up flooding the system. The best practice is for timers to invoke methods that execute in a short time.
