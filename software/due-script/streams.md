# Streams

---

DUE Link APIs are built to be ASCII human-friendly. This works great when using DUE Script. However, there are instances where speed or raw binary data is required. For example, when updating a display using I2C. This is where streams come in handy. Provided libraries, such as Python, use streams internally whenever possible.

A stream command initiates the request, such as `LcdStream()`. Once this command is received and accepted by the device, the `&` symbol will be returned indicating readiness. The host can now send the entire data, exactly to the required byte count. See the individual stream command for details on what data count and structure to be sent.

## Streams in DUE Script

Streams are not used when coding DUE Script directly. They are utilized by the provided libraries, when used in hosted mode.