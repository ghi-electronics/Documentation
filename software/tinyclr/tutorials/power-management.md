# Power Management
---
TinyCLR OS currently supports the Sleep and Shutdown power saving modes. 
In sleep mode, any GPIO interrupt can be used to wake a board, but in Shutdown mode, only the WKUP pin can wake up the board.

Another way to wakeup the board is, we can set up special time, instead of using GPIO interrupt or WKUP pin.

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
//Pressing the ldrButton button (PE3) wakes up the system.

private static void ldrButton_ValueChanged(GpioPin sender, GpioPinValueChangedEventArgs e) {

}

```

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

## Wakeup by setting special time

In Sleep mode
```
Power.Sleep(DateTime.Now.AddSeconds(90)); // wake the board up after 90 seconds, from now. During sleep mode, any Gpio also wakeup the system.
```

In Shutdown mode:
```
Power.Shutdown(false, DateTime.Now.AddSeconds(90); // wake the board up after 90 seconds, from now. WKUP pin has no effects.
```

Use WKUP pin and time each other:
```
Power.Shutdown(true, DateTime.Now.AddSeconds(90); // wake the board up after 90 seconds, or press WKUP any time to wakeup system.

```


