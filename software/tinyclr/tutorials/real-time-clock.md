# Real Time Clock
---
The Real Time Clock (RTC) is a circuit that runs off a small battery or a super capacitor connected to VBAT. It needs its own crystal and keeps running even when the main system and its clocks are powered off.

In the event the RTC battery was drained or the RTC was never initialized, the RTC will not have a correct value. Use the `rtc.IsValid` method to determine if the time was set correctly.


> [!Tip]
> Needed NuGets: GHIElectronics.TinyCLR.Devices.Rtc, GHIElectronics.TinyCLR.Native

```cs
using GHIElectronics.TinyCLR.Devices.Rtc;
using GHIElectronics.TinyCLR.Native;
using System;
using System.Diagnostics;
using System.Threading;

class Program {
    static void Main() {
        var rtc = RtcController.GetDefault();

        if (rtc.IsValid) {
            Debug.WriteLine("RTC is Valid");
            // RTC is good so let's use it
            SystemTime.SetTime(rtc.Now);
        }
        else {
            Debug.WriteLine("RTC is Invalid");
            // RTC is not valid. Get user input to set it
            // This example will simply set it to January 1st 2020 at 11:11:11
            var MyTime = new DateTime(2020, 1, 1, 11, 11, 11);
            rtc.Now = MyTime;
            SystemTime.SetTime(MyTime);
        }

        while (true) {
            Debug.WriteLine("Current Time    : " + DateTime.Now);
            Debug.WriteLine("Current RTC Time: " + rtc.Now);
            Thread.Sleep(1000);
        }
    }
}
```

The output will show both times and they should match. If the RTC time is invalid when you first run the program, the program will detect the invalid time and will set the RTC.

```
RTC is Valid
Current Time    : 01/01/2019 11:15:35
Current RTC Time: 01/01/2019 11:15:35
Current Time    : 01/01/2019 11:15:36
Current RTC Time: 01/01/2019 11:15:36
```

## Clock Source
When the RTC is initialized, it tries to use an external 32,768Khz crystal. This is usually what is recommended as it provides an accurate time. If crystal is not available, the RTC will fall back and run using an internal RC. The internal RC is not as accurate as an external crystal and temperature will skew the time.

## VBAT

VBAT mode can be set in "charger mode" where it can charge an attached a supercap. Typically, VBAT requires 1.2 to 3.6 volts for correct operation.

> [!Important]
> Make sure the RTC battery charge mode is correctly set. Charging a lithium coin cell may cause damage to the cell and could cause it to leak. Not charging a supercap will result in a discharged supercap and loss of correct time and battery backed ram data when your board is powered down.

```cs
var rtc = GHIElectronics.TinyCLR.Devices.Rtc.RtcController.GetDefault();

//The following line turns off charging. Used for lithium coin cells.
rtc.SetChargeMode(GHIElectronics.TinyCLR.Devices.Rtc.BatteryChargeMode.None);

//The following line charges slowly through a 5 K resistor. Used for supercaps.
rtc.SetChargeMode(GHIElectronics.TinyCLR.Devices.Rtc.BatteryChargeMode.Slow);

//The following line charges quickly through a 1.5 K resistor.
//   This is the mode we use for the supercaps on SITCore Dev boards.
rtc.SetChargeMode(GHIElectronics.TinyCLR.Devices.Rtc.BatteryChargeMode.Fast);
```

---

## System Clock

You can get the current system time using `DateTime.Now`. The system clock starts running at power up, but until you set the clock, the time and date will be incorrect. 

The following command is used to set the time:

```cs
GHIElectronics.TinyCLR.Native.SystemTime.SetTime(DateTime utcTime);
```

To set the system clock to the RTC time, use the following command:

```cs
GHIElectronics.TinyCLR.Native.SystemTime.SetTime(rtc.Now);
```

---

## SNTP

You can use SNTP (Simple Network Time Protocol) to accurately set the time in your application. The following method will return the current date and time after retrieving it from an NTP server. Your device will need an active network connection for this code to work.

```cs
public static DateTime GetNetworkTime(int CorrectLocalTime = 0) {
    const string ntpServer = "pool.ntp.org";
    var ntpData = new byte[48];
    ntpData[0] = 0x1B; //LeapIndicator = 0 (no warning), VersionNum = 3 (IPv4 only),
                        //    Mode = 3 (Client Mode)

    var addresses = System.Net.Dns.GetHostEntry(ntpServer).AddressList;
    var ipEndPoint = new System.Net.IPEndPoint(addresses[0], 123);
    var socket = new System.Net.Sockets.Socket(
        System.Net.Sockets.AddressFamily.InterNetwork,
        System.Net.Sockets.SocketType.Dgram,
        System.Net.Sockets.ProtocolType.Udp);

    socket.Connect(ipEndPoint);

    System.Threading.Thread.Sleep(1); //Added to support TinyCLR OS.

    socket.Send(ntpData);
    socket.Receive(ntpData);
    socket.Close();

    ulong intPart = (ulong)ntpData[40] << 24 | (ulong)ntpData[41] << 16 |
        (ulong)ntpData[42] << 8 | (ulong)ntpData[43];

    ulong fractPart = (ulong)ntpData[44] << 24 | (ulong)ntpData[45] << 16 |
        (ulong)ntpData[46] << 8 | (ulong)ntpData[47];

    var milliseconds = (intPart * 1000) + ((fractPart * 1000) / 0x100000000L);

    var networkDateTime = (new System.DateTime(1900, 1, 1)).
        AddMilliseconds((long)milliseconds);

    return networkDateTime.AddHours(CorrectLocalTime);
}
```

The above method is used as follows, with the argument indicating how many hours to add to convert UTC time to your local time zone:

```cs
DateTime dateTime = GetNetworkTime(-5);
```

---

## Battery Backed Memory

SITCore devices include 4 KBytes of battery backed memory. This memory accepts and returns byte arrays of data. The commands and their overloads for accessing this memory are as follows:

```cs
BackupMemorySize; //Returns 4096, total size in bytes of battery backed memory.

ReadBackupMemory(byte[] destinationData);
ReadBackupMemory(byte[] destinationData, uint sourceOffset);
ReadBackupMemory(byte[] destinationData, uint destinationOffset,
    uint sourceOffset, int count);

public void WriteBackupMemory(byte[] sourceData, uint destinationOffset);
public void WriteBackupMemory(byte[] sourceData);
public void WriteBackupMemory(byte[] sourceData, uint sourceOffset,
    uint destinationOffset, int count);
```

Note that the battery backed memory is not managed at all. There is no allocate, dispose, or garbage collection. The commands used to access battery backed memory only copy the bytes from your array into memory, or from memory into your array. Until you overwrite it or lose RTC battery power, the data will always be in battery backed memory.

Here is a simple example that displays the size of the battery backed memory, and then writes and reads five bytes of data.

> [!Tip]
> Needed NuGet: GHIElectronics.TinyCLR.Devices.Rtc

```cs
var rtc = RtcController.GetDefault();

Debug.WriteLine(rtc.BackupMemorySize.ToString()); //Displays "4096"

var writeData = new byte[] { 1, 2, 3, 4, 5 };

rtc.WriteBackupMemory(writeData);

var readData = new byte[5];

rtc.ReadBackupMemory(readData);

for (int i=0; i < 5; i++) {
    Debug.WriteLine(readData[i].ToString()); //Displays 1, 2, 3, 4, 5
}
```

---

## RTC Calibration

RTC also provides a calibration feature. 

```
rtc.Calibrate(int pulse);
```
```pulse``` is how many ticks to add (positive) or remove (negative) every 32 seconds. Use 0 to disable.

Maximum ```pulse``` is +/-512, meaning RTC frequency can be adjust between -487.1ppm to 488.5ppm.
