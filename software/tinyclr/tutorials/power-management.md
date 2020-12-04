# Power Management
---
TinyCLR OS currently supports the Sleep and Shutdown power saving modes. 
In sleep mode, any GPIO interrupt can be used to wake the board, but in Shutdown mode, only the WKUP pin can wake up the board. You can also program the device to wake up after a specified time.

## Idle
The system enters this state whenever it is idle, such as when waiting on events and there are no running threads. This is automatic and they user is not required to take any action.

## Slow Clock Speed

The system can operate at half speed, saving 40% power consumption with the following commands:

```cs
if (Power.GetSystemClock() == SystemClock.High) {
    Power.SetSystemClock(SystemClock.Low);
    Power.Reset();
}
```

Switch back to full speed:

```cs
if (Power.GetSystemClock() == SystemClock.Low) {
    Power.SetSystemClock(SystemClock.High);
    Power.Reset();
}
```
> [!Note]
> Changing the clock speed requires a software reset in the code. Calling this reset detaches the debugger. 
> If necessary you'll need to redeploy to the device to continue debugging.

## Sleep 
In this mode the system goes to sleep to save power and wakes up and resumes processing when the assigned interrupt is received. Any GPIO interrupt can be used to wake from Sleep. The following example runs on both the SC20100 and SCM20260D Dev boards and uses the LDR button to wake up. 

> [!Note]
> Don't forget to configure the interrupt and interrupt handler for the pin that will be used to wake up from Sleep.

> [!Tip]
> Needed NuGets: GHIElectronics.TinyCLR.Core, GHIElectronics.TinyCLR.Devices.Gpio, GHIElectronics.TinyCLR.Native, GHIElectronics.TinyCLR.Pins

```cs
var ldrButton = GpioController.GetDefault().OpenPin(SC20100.GpioPin.PE3);
ldrButton.SetDriveMode(GpioPinDriveMode.InputPullUp);
ldrButton.ValueChanged += ldrButton_ValueChanged;

//The next line starts Sleep.
Power.Sleep();

//The system is Sleeping.
//Pressing the LDR Button (PE3) wakes up the system.
private static void ldrButton_ValueChanged(GpioPin sender, GpioPinValueChangedEventArgs e) { }

```
To sleep for a specific time:
```cs
Power.Sleep(DateTime.Now.AddSeconds(90)); //Will wake up after 90 seconds.
                                          //A GPIO can also wake up the system.
```
---

## Shutdown
In this mode the system completely shuts down. It can only be awakened by reset, power cycle, or by toggling the WKUP pin.

The following code shuts down the system. The `false` argument configures the system to wake up when the WKUP pin goes from high to low. Make the argument `true` to wake up when WKUP goes high.

> [!Note]
> Waking from Shutdown mode always resets the system. Your application will start over, it will not resume where it left off.

> [!Tip]
> Needed NuGets: GHIElectronics.TinyCLR.Core, GHIElectronics.TinyCLR.Devices.Gpio, GHIElectronics.TinyCLR.Native, and GHIElectronics.TinyCLR.Pins

```cs
//The next line shuts down the system.
Power.Shutdown(true, DateTime.MaxValue); 

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

