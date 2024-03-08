# UART 

---

UART is supported through the standard `SerialPort` class in `System.IO.Ports` but first we need to **Initialize** the serial port. 

```cs
EPM815.SerialPort.Initialize(EPM815.SerialPort.Uart3);
```

After initializing the port, create a buffer to read the data into and configure a new **SerialPort** and **Open** it. 

```cs
static byte[] buffer = new byte[64];

var serial = new SerialPort{
    PortName = EPM815.SerialPort.Uart3,
    BaudRate = 9600,
    DataBits = 8,
    Parity = Parity.None,
    StopBits = StopBits.One,
};

serial.Open();
```

Once configured, the device is ready to write & read the serial data. 

```cs
while(true){
    //Check for data
    if(serial.BytesToRead > 0){
        var data = serial.Read(buffer,0,serial.BytesToRead)
        Console.Writeline(Encoding.UTF8.GetString(buffer,0,data));   
    }
    Thread.Sleep(20);
}
