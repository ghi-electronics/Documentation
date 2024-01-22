# Power Management
---
TinyCLR OS supports multiple power-saving modes.

## Idle
The system enters this state whenever it is idle, such as when waiting on events and there are no running threads. This is automatic and they user is not required to take any action.

## Slow Clock Speed

The system can operate at half speed, saving about 40% power consumption. The system can switch speed (with a required soft reset) but it can optionally persist the slow clock.

```cs
var PersistClock = false;
if (Power.GetSystemClock() == SystemClock.High) {
    Power.SetSystemClock(SystemClock.Low, PersistClock);
    Power.Reset();
}
```

Switch back to full speed (only if "PersistClock" was false):

```cs
if (Power.GetSystemClock() == SystemClock.Low) {
    Power.SetSystemClock(SystemClock.High, false);
    Power.Reset();
}
```

When not persisted, calling `Power.Reset()` will retain the set clock speed, but hardware reset (reset pin) or power cycle will revert to the default state.

## Sleep 
In this mode, most of the system features are disabled. A GPIO or RTC interrupt can be used to wake the system and resume operations.

> [!Note]
> Don't forget to configure the interrupt and interrupt handler for the pin that will be used to wake up from Sleep.

> [!Tip]
> Needed NuGets: GHIElectronics.TinyCLR.Core, GHIElectronics.TinyCLR.Devices.Gpio, GHIElectronics.TinyCLR.Native, GHIElectronics.TinyCLR.Pins

```cs
var ldrButton = GpioController.GetDefault().OpenPin(SC20100.GpioPin.PE3);
ldrButton.SetDriveMode(GpioPinDriveMode.InputPullUp);
ldrButton.ValueChanged += ldrButton_ValueChanged;

Debug.WriteLine("System is going to sleep...");
Power.Sleep();
Debug.WriteLine("This will print after system wakeup");

// An event is needed to activate the interrupts internally
private static void ldrButton_ValueChanged(GpioPin sender, GpioPinValueChangedEventArgs e) { }
```

To sleep for a specific time, using RTC:

```cs
Power.Sleep(DateTime.Now.AddSeconds(90)); //Will wake up after 90 seconds.
```
---

## Shutdown
In this mode the system completely shuts down. It can only be awakened by reset, power cycle, RTC, or by toggling the WKUP pin, which will also reset the system. When `Shutdown` is used the system is turned completely off, internal pull-up resistors are also disabled. Adding pull-up or pull-down resistor on WKUP pin is required.

> [!Note]
> Waking from Shutdown mode always resets the system. Your application will start over, it will not resume where it left off.

> [!Tip]
> Needed NuGets: GHIElectronics.TinyCLR.Core, GHIElectronics.TinyCLR.Devices.Gpio, GHIElectronics.TinyCLR.Native, and GHIElectronics.TinyCLR.Pins

The following code shuts down the system to only wake up using WKUP pin.

```cs
Power.Shutdown(true, DateTime.MaxValue); 
```

By default, a rising edge on WKUP pin is needed to wake the system up. The system also allows for using a falling edge instead.

```cs
Power.WakeupEdge = WakeupEdge.Falling;
```

To shutdown for a specific time:
```cs
Power.Shutdown(false, DateTime.Now.AddSeconds(90); //Will wake up after 90 seconds.
                                                   //WKUP pin has no effect.
```

To shutdown for a specific time or when the WKUP pin changes state (whichever comes first):
```cs
Power.Shutdown(true, DateTime.Now.AddSeconds(90); //Will wake up after 90 seconds or
                                                  //when WKUP is pressed.
```

---

## On-board Ethernet
Some modules include an on-board Ethernet PHY. This can be disabled by setting a specific GPIO to **low**. Below are the pin numbers.

| Module      | Pin  |
|-------------|------|
| SCM20260E/D | PG3  |
| SCM20100E   | PD8  |


---

## Software Reset

TinyCLR OS provides two reset modes within your application:

### Reset Application
This command allows to reset your application:

```cs
GHIElectronics.TinyCLR.Native.Power.Reset();
```

### Reset to Bootloader mode

The command below will boot the device in GHI Bootloader mode:
```cs
GHIElectronics.TinyCLR.Native.Power.Reset(false);
```

---

### Reset Source

The cause of the previous reset can be found through `GetResetSource`. This is useful to determine if, for example, a watchdog or was the reason for the reset.

> [!Tip]
> Needed NuGets: GHIElectronics.TinyCLR.Core, GHIElectronics.TinyCLR.Native

```cs
var resetSource = Power.GetResetSource();
```
