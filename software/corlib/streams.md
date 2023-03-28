## Streams

Some functionality require speed when sending/retrieving data to/from a device. For example, when sending the entire LCD display.

A stream command initiates the request, in this case **LcdStream()**. Once this command is received and accepted by the device, it will respond with the **&** symbol. Now, the PC can send the entire data, exactly to the required byte count. This required count, to follow the stream command, is documented with each stream command individual. 

---