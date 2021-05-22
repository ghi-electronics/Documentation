# Time

---

The time module include several helpers. `import time`.

## Sleep

To pause execution for a specific time, use sleep, which takes the sleep time in seconds.

This examples sleeps for two and half a seconds:

```
import time
print("Hello")
time.sleep(2.5)
print("there!")
```

If ms sleep is desired, use sleep_ms instead. Here is a one second delay:

```
import time
print("Hello")
time.sleep_ms(1000)
print("there!")
```
