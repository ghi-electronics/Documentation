# Real Time Clock
---
The Real Time Clock (RTC) is a circuit that runs off a small battery or a super capacitor. It has its own crystal and keeps running even when the system is powered off. Not all hardware has a built in RTC, so check your hardware's documentation for more details.

In the event the RTC battery was drained or the RTC was never initialized, the RTC will not have a correct value. Use the `rtc.IsValid` method to determine if the time was set correctly.

>[!Important]
>There is a command to control charging of the RTC supercap (if used). If your RTC does not keep time when the board is powered down, and you are using a supercap instead of a battery for the RTC (as on our dev boards), add the following code to your program:
>```cs
>var rtc = GHIElectronics.TinyCLR.Devices.Rtc.RtcController.GetDefault();
>rtc.SetChargeMode(GHIElectronics.TinyCLR.Devices.Rtc.BatteryChargeMode.Fast);
```

>[!Note]
>Needed NuGets: GHIElectronics.TinyCLR.Devices.Rtc, GHIElectronics.TinyCLR.Native

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
            // This example will simply set it to January 1st 2019 at 11:11:11
            var MyTime = new DateTime(2019, 1, 1, 11, 11, 11);
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

## Battery Backed Memory

SITCore devices include 4 Kbytes of battery backed memory. Like our [secure storage area](secure-storage-area.md), this memory accepts and returns byte arrays of data. The commands and their overloads for accessing this memory are as follows:

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

>[!Note]
>Needed NuGet: GHIElectronics.TinyCLR.Devices.Rtc

```cs
var rtc = GHIElectronics.TinyCLR.Devices.Rtc.RtcController.GetDefault();

System.Diagnostics.Debug.WriteLine(rtc.BackupMemorySize.ToString()); //Displays "4096"

var writeData = new byte[] { 1, 2, 3, 4, 5 };

rtc.WriteBackupMemory(writeData);

var readData = new byte[5];

rtc.ReadBackupMemory(readData);

for (int i=0; i < 5; i++) {
    System.Diagnostics.Debug.WriteLine(readData[i].ToString()); //Displays 1, 2, 3, 4, 5
}
```