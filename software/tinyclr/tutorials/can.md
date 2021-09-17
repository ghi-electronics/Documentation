# CAN
---
Controller Area Network (CAN) bus is a serial communication protocol with built-in error checking and retransmission. It is generally a two wire bus, but other transceivers with one wire or LSFT (Low Speed Fault Tolerant) are used.

The common high-speed two-wire CAN requires termination resistors at the end of the wires, typically 120 ohm.

![CAN linear bus](../images/can-bus.png)

> [!TIP]
> Some CAN devices, including our own development boards, have built in termination resistors.

CAN bit timing is a complex topic that requires considerable knowledge of the CAN protocol. All nodes on a CAN network must use the same baud rate. Sample bit timing settings are provided further down on this page to help you get started.

`SetNominalBitTiming()` and `SetDataBitTiming()` define the CAN bus timing using the arguments listed below. Note that `SetDataBitTiming()` is only used for CAN-FD to specify the faster data rate. `SetNominalBitTiming()` is used both for standard CAN and to define the slower data bit rate for CAN-FD.

> [!TIP]
> The `propagationPhase1` argument combines the propagation and phase1 CAN timing parameters.

| Baud | Propagation+Phase1 | Phase2 | Baudrate Prescaler | Synchronization Jump Width | Use Multi Bit Sampling | Sample Point | Max Osc. Tolerance | Max Cable Length
|---|---|---|---|---|---|---|---|---|
| 33.333K | 13 | 2 | 90 | 1 | False | 87.5% | 0.31% | 2200M
| 83.333K | 13 | 2 | 36 | 1 | False | 87.5% | 0.31% | 850M
| 125K    | 13 | 2 | 24 | 1 | False | 87.5% | 0.31% | 550M
| 250K    | 13 | 2 | 12 | 1 | False | 87.5% | 0.31% | 250M
| 500K    | 13 | 2 | 6  | 1 | False | 87.5% | 0.31% | 100M
| 1M      | 13 | 2 | 3  | 1 | False | 87.5% | 0.31% | 40M

There are many online CAN calculators that can be used to help you with CAN timing, for [example](http://www.bittiming.can-wiki.info/).

![CAN bit segments](images/can-bit-segments.png)

The CAN calculator needs the microcontroller's CAN clock speed. For the SITCore series SC20xxx, this is 48 MHz. For the SC13xxx the speed is 40MHz. These can easily be found with `SourceClock` property.

## Filtering
Filters can be set to automatically accept or ignore messages based on their arbitration ID.

> [!Tip]
>Each CAN channel supports up to 64 standard IDs and 32 Extended IDs

### Range Filter
`AddRangeFilter()` allows you to set a range of arbitration IDs that will be accepted as valid messages. Messages with arbitration IDs outside of this range will be ignored. You can add more than one range filter. In the sample code below, the range filters will accept messages with arbitration IDs ranging from `0x12` to `0x20` and also between `0x500` and `0x1000` inclusive.

### Mask Filter
`AddMaskFilter()` can be used to specify an individual arbitration ID or a range of arbitration IDs that will be accepted regardless of the group filter settings. If the arbitration ID of the message is bitwise anded with the given mask argument, and the result is equal to the compare argument you provide, the message will be accepted.

In the sample code below, CAN messages with arbitration IDs of `0x11`, `0x13`, and `0x5678` will be accepted in addition to the arbitration IDs specified by the group filters.


---
## Sample Code

> [!Tip]
> Needed NuGets: GHIElectronics.TinyCLR.Core, GHIElectronics.TinyCLR.Devices and GHIElectronics.TinyCLR.Pins
 
```cs
using GHIElectronics.TinyCLR.Devices.Can;
using GHIElectronics.TinyCLR.Devices.Gpio;
using GHIElectronics.TinyCLR.Pins;
using System;
using System.Diagnostics;
using System.Threading;

class Program {
    private static void Main() {
        var LdrButton = GpioController.GetDefault().OpenPin(SC20100.GpioPin.PE3);
        LdrButton.SetDriveMode(GpioPinDriveMode.InputPullUp);

        var can = CanController.FromName(SC20100.CanBus.Can1);

        var propagationPhase1 = 13;
        var phase2 = 2;
        var baudratePrescaler = 3;
        var synchronizationJumpWidth = 1;
        var useMultiBitSampling = false;

        can.SetNominalBitTiming(new CanBitTiming(propagationPhase1, phase2, baudratePrescaler,
            synchronizationJumpWidth, useMultiBitSampling));        

        var message = new CanMessage() {
            Data = new byte[] { 0x48, 0x65, 0x6C, 0x6C, 0x6F, 0x2E, 0x20, 0x20 },
            ArbitrationId = 0x11,
            Length = 6,
            RemoteTransmissionRequest = false,
            ExtendedId = false,
            FdCan = false,
            BitRateSwitch = false
        };

        //The following filter will accept arbitration IDs from 0x12 to 0x20 inclusive.
        can.Filter.AddRangeFilter(Filter.IdType.Standard, 0x12, 0x20);

        //The following filter will accept arbitration IDs from 0x500 to 0x1000 inclusive.
        can.Filter.AddRangeFilter(Filter.IdType.Standard, 0x500, 0x1000);

        //The following filter will accept arbitration IDs of 0x11 and 0x13.
        can.Filter.AddMaskFilter(Filter.IdType.Standard, 0x11, 0xFD);

        //The following filter will accept arbitration IDs of 5678 only.
        can.Filter.AddMaskFilter(Filter.IdType.Standard, 0x5678, 0xFFFF);

        can.MessageReceived += Can_MessageReceived;
        can.ErrorReceived += Can_ErrorReceived;
        
        can.Enable();

        while (true) {
            if (LdrButton.Read() == GpioPinValue.Low)
                can.WriteMessage(message);

            Thread.Sleep(100);
        }
    }

    private static void Can_MessageReceived(CanController sender,
        MessageReceivedEventArgs e) {

        sender.ReadMessage(out var message);

        Debug.WriteLine("Arbitration ID: 0x" + message.ArbitrationId.ToString("X8"));
        Debug.WriteLine("Is extended ID: " + message.ExtendedId.ToString());
        Debug.WriteLine("Is remote transmission request: "
            + message.RemoteTransmissionRequest.ToString());

        Debug.WriteLine("Time stamp: " + message.Timestamp.ToString());

        var data = "";
        for (var i = 0; i < message.Length; i++) data += Convert.ToChar(message.Data[i]);

        Debug.WriteLine("Data: " + data);
    }

    private static void Can_ErrorReceived(CanController sender, ErrorReceivedEventArgs e)
        => Debug.WriteLine("Error " + e.ToString());
}
```

---

## CAN-FD
CAN-FD allows for faster data transmission and larger data packet size to increase throughput. At the same time, CAN-FD is compatible with traditional CAN -- CAN-FD and standard CAN nodes can even coexist on the same CAN bus!

CAN-FD can be used by setting the `FdCan` property of your CAN message to `true`. This setting will allow you to send up to 64 bytes of data per CAN message.

To send the data at higher speed you will also need to set two bit timings, one for the normal, slower speed (`SetNominalBitTiming()`), and one for the faster speed (`SetDataBitTiming()`). You will also have to set the `BitRateSwitch` property of the CAN message to `true.`

The following code shows the changes needed to make the above code sample use CAN-FD with speeds of 250 kilobaud and 1 megabaud.

```cs
var propagationPhase1 = 13; //250 kilobaud settings
var phase2 = 2;
var baudratePrescaler = 12;
var synchronizationJumpWidth = 1;
var useMultiBitSampling = false;

//Set the lower CAN speed to 250 kilobaud.
can.SetNominalBitTiming(new CanBitTiming(propagationPhase1, phase2, baudratePrescaler,
    synchronizationJumpWidth, useMultiBitSampling));

baudratePrescaler = 3;  //Change bit timing to 1 megabaud.
        
//Set faster CAN speed to 1 megabaud.
can.SetDataBitTiming(new CanBitTiming(propagationPhase1, phase2, baudratePrescaler,
    synchronizationJumpWidth, useMultiBitSampling));

can.Enable();

var message = new CanMessage() {
    Data = new byte[] { 0x48, 0x65, 0x6C, 0x6C, 0x6F, 0x2E, 0x20, 0x20 },
    ArbitrationId = 0x11,
    Length = 6,
    RemoteTransmissionRequest = false,
    ExtendedId = false,
    FdCan = true,
    BitRateSwitch = true
};

```
