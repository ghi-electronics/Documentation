# Streams

---

DUE Link APIs are built to be ASCII human-friendly. This works great from the [DUE Console](../console.md) for example. However, there are instances where speed is required. For example, when updating a display. Also, there are instances where raw binary data is desired instead of ASCII. For example, when sending data over a data bus. This is where streams come in handy.

A stream command initiates the request, for example `LcdStream()`. Once this command is received and accepted by the device, the `&` symbol will be returned. Now, the host can send the entire data, exactly to the required byte count. This required count and format, to follow the stream command, is documented with each stream command individual. 

## Streams in DUE Script

Streams are not used when coding DUE Script directly. They are part of the provided libraries used in hosted mode.