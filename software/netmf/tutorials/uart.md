# UART
---

UART transfers data between two pins TXD (transmit) and RXD (receive). Normally, the pins are on different processors. Data is sent from TXD, in a sequence, at a predefined speed. The receiver checks data on RXD.

Usually systems want to send and recieve as well, so there will be a TXD and RXD on one end with another set on the other end. The connection in between is rossed so TXD on one end goes to RXD on the other end and vice versa.

## UART Technical Details

The " baud rate"  is number of bits are transmitted per second; standard baud rates are 9600, 119200, 115200 and others.

Direct connection between TXD/RXD pins use their high/low voltages for bits ("TTL level," 0V to 3.3V).

NETMF supports serial ports (UART) in the same way as the full .NET framework. Serial ports on PC's and on NETMF are called "COM ports."  Their names start with COM1 and go up (there is no COM0). Processors usually start with UART0 not UART1 (so, COM1 is UART0... etc.)

## Software UART
Through GHI's SignalGenerator, a system can simulate a UART data. This is beneficial as any GPIO pin can be used to send the UART data. A good example is a serial character display. These typically do not require speed and not updated frequently. If all UARTs are being used, any GPIO can be used to simulate a UART transmission.

## RS232

Processor pins can be set at 0 for low or at the power level for high, 3.3V for example. This means connecting outputs on a micro to inputs on another is safe. These levels are called TTL. In our case here a TTL UART levels.

To overcome distances, the very old standard RS232 defined the low state to be +12V. Sounds like it is backwards but this is how it is! This port is found on many systems and found on many PCs. It has been disappearing from PCs lately but this can be easily added using a USB to serial cable.

We can't connect the RS232 levels to TTL levels directly. This is easily solved by adding a small circuitry that converts the RS232 levels to TTL, like the MAX232 chip.
In other words, do not connect a PC's serial port to a micro directly. Use a level converter in between.

## Example using UART
The following program sends a counter value 10 times per second. The data is sent at 115200 baud so make sure that the receiving end is setup the same way. This program sends the data on COM1 of your NETMF device. This COM number has nothing to do with COM number on your PC. For example, you may have a USB serial port on your PC that maps to COM8 and so you need to open COM8 on your PC, not COM1. The NETMF program will still use COM1 because it uses UART0 (COM1).

The data sent can be shown on a terminal program, like teraterm. Note how we ended the string with "\r\n". The "\r" is code to tell the terminal to "return" back to the beginning of the line and "\n" is to add "new" line. When data is received on UART, it is automatically queued a side so you wouldn't lose any data.
 
> [!Tip]
> Using serial ports require the Microsoft.SPOT.Hardware.SerialPort. If your program uses the enums Parity or StopBits, the Microsoft.SPOT.Hardware assembly is needed.

```cs
using System.IO.Ports;
using System.Text;
using System.Threading;

public class Program
{
    public static void Main()
    {
        SerialPort UART = new SerialPort("COM1", 115200);
        int counter = 0;
        UART.Open();
        while (true)
        {
            // create a string
            string counter_string = "Count: " + counter.ToString() +
                                    "\r\n";
            // convert the string to bytes
            byte[] buffer = Encoding.UTF8.GetBytes(counter_string);
            // send the bytes on the serial port
            UART.Write(buffer, 0, buffer.Length);
            // increment the counter;
            counter++;
            //wait...
            Thread.Sleep(100);
        }
    }
}
```

## Receiving Data
This example will wait until a byte is received on the port and then print it telling you what was sent from the other end.

```cs
using System.Threading;
using System.IO.Ports;
using System.Text;

public class Program
{
    public static void Main()
    {
        SerialPort UART = new SerialPort("COM1", 115200);
        int read_count = 0;
        byte[] rx_byte = new byte[1];

        UART.Open();
        while (true)
        {
            // read one byte
            read_count = UART.Read(rx_byte, 0, 1);
            if (read_count > 0)// do we have data?
            {
                // create a string
                string counter_string =
                        "You typed: " + rx_byte[0].ToString() + "\r\n";
                // convert the string to bytes
                byte[] buffer = Encoding.UTF8.GetBytes(counter_string);
                // send the bytes on the serial port
                UART.Write(buffer, 0, buffer.Length);
                //wait...
                Thread.Sleep(10);
            }
        }
    }
}
```

## Sending and Receiving
This example is a loop-back. Connect a wire from TX to RX on your board and it will send data and make sure it is receiving it correctly.

```cs
using System.IO.Ports;
using System.Text;
using System.Threading;
using Microsoft.SPOT;

public class Program
{
    public static void Main()
    {
        SerialPort UART = new SerialPort("COM1", 115200);
        int read_count = 0;
        byte[] tx_data;
        byte[] rx_data = new byte[10];
        tx_data = Encoding.UTF8.GetBytes("FEZ");
        UART.ReadTimeout = 0;
        UART.Open();

        while (true)
        {
            // flush all data
            UART.Flush();
            // send some data
            UART.Write(tx_data, 0, tx_data.Length);
            // wait to make sure data is transmitted
            Thread.Sleep(100);
            // read the data
            read_count = UART.Read(rx_data, 0, rx_data.Length);
            if (read_count != 3)
            {
                // we sent 3 so we should have 3 back
                Debug.Print("Wrong size: " + read_count.ToString());
            }
            else
            {
                // the count is correct so check the values
                // I am doing this the easy way so the code is more clear
                if (tx_data[0] == rx_data[0])
                {
                    if (tx_data[1] == rx_data[1])
                    {
                        if (tx_data[2] == rx_data[2])
                        {
                            Debug.Print("Perfect data!");
                        }
                    }
                }
            }
            Thread.Sleep(100);
        }
    }
}
```

> [!Tip]
> For .NET Gadgeteer examples, see the Device to PC communications document.