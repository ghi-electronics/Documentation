# DUELink Engine
---

DUELink internal engine is a runtime that interprets and runs DUELink Scripts. These scripts are remotely sent and executed by the connected host. For example, when calling `duelink.Digital.Write(0, true)` in Python, the API will end up sending `DWrite(0,1)` to the engine.

It is possible to record scripts that persist on a DUELink Motherboard. This can be used for two purposes. First, to expand available the functionality and define new commands. This is helpful in real-time applications or to speed things up, where calling this custom method from the host machine will process multiple tasks internally. The second purpose is to allow a DUELink Motherboard to run stand alone to handle small stand alone tasks that does not require high level language such as Python.

## DUELink API Reference


### Analog
| Function | Description
| --- | ---
| AWrite(pin, value)	| Write an analog `value` to 'pin' 
| ARead(pin)			| Reads and returns the analog value of `pin` - 0 to 100

### Digital
| Function | Description
| --- | ---
| DWrite(pin, value) | Write a digital `value` to 'pin'. 0 for low and 1 for high



