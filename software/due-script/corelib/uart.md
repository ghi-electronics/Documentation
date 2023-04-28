## UART

- **UartInit(baudRate)** - Sets the baud rate UART   <br>
**baudRate:** Any commonly used standard baud rate 

- **UartRead()** - Read UART data  <br>
**Returns:** A byte read from UART

- **UartWrite(data)** - Write UART data <br>
**data:** Data byte to send on UART

- **UartCount()** - Count  <br>
**Returns:** How many bytes have been buffered and ready to be read

---