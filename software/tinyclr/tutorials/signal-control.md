# Signal Control
---
![HC-SR04 ultrasonic sensor](images/signal-control.jpg)

## DigitalSignal

The DigitalSignal is used to handle digital signals! Unlike the other features on this page, DigitalSignal is accurate because it is hardware-backed and runs in a non-blocking manner.

Being hardware backed, this feature only runs on specific pins. Those pins can be found under the pins library, under `SC20260.Timer.DigitalSignal.Controller?.xxx.

> [!TIP]
> Timers are also used with other features, such as PWM. Once a `Timer` is reserved for DigitalSignal, it is no longer available for other features.

There are two uses for DigitalSignal, reading a signal (capture) and sending a signal (generate). The capture feature also support capturing a stream of durations (signal analyzer) or a pulse counter.

### Generate
Using the `Generate` function allows the user to create a very accurate signal generator.  

```cs
Generate(uint[]data, uint offset, uint count)
```

`data` is the length of each pulse in ticks. By default, each tick is 100ns. 


There is a limitation to the `data` being used: The `data` array length is limited to 64K elements. Also, adding individual elements together in the array can also not exceed 0xFFFFFFFF in total.
 
![Default Timing](images/write1.jpg)
  
```cs
Generate(uint[]data, uint offset, uint count, unit multiplier)
```

Allowable multiplier values range from 25 to 250,000 (250us). There are also 2 rules to the allowed values: 1,000,000,000 % multiplier must result in zero and  240,000,000 % (1,000,000,000 / multiplier) must also be zero.

The signal generator always start with a signal at low level. It then toggles the signal every x time. The time is fetched from the array given, one by one. Note that by sending an even count of pulses, teh signal will terminate with a high-level as shown below.

![Signal Example](images/write2.jpg)

Starting a second write will cause the signal to first go low, which may not be desired, as it causes an extra pulse on the next `Generate`. This pulse has a variable with. Making sure that the data `Length` is always an odd number will assure that the signal will terminate at a low-level.

![Signal Example](images/write3.jpg) 


> [!TIP] 
> Software-generated `SignalGenerator` below gives more flexibility but runs in system blocking mode. While `SignalGenerator` is all Hardware-driven making it very accurate, non-blocking and it does not use processor time.

Calling `Generate` will return immediately (non-blocking) allowing the system to do other tasks while the signal is being generated in the background. When the signal is generated completely, an event is fired. To aid in signal handling, the event provides the final resting level of the signal.

```cs
OnGenerateFinished => OnGenerateFinished;

dsig.OnGenerateFinished += (a, b) => {
    if (b == GpioPinValue.High)
        Debug.WriteLine("Write done, end state high");
    else
        Debug.WriteLine("Write done, end state low");
   };
```

### Capture
The Capture feature returns an array of timestamps of individual durations. The returned values are in nanoseconds.

> [!TIP]
> Digital Signal is limited to the timer max value, which comes to be about 17.89 seconds. The `waitForEdge` helps by only starting the timer when there is an active pulse.

```cs
var digitalSignalPin = GpioController.GetDefault().OpenPin(SC20260.Timer.Capture.Controller5.PB3);

var digitalSignal = new DigitalSignal(digitalSignalPin);
bool waitForEdge = false;// Start capturing as soon as Capture is called

// Subscribe event when done capturing
digitalSignal.OnCaptureFinished += Digital_OnCaptureFinished;
                      
// start capture 100 samples, timeout is 15seconds
digitalSignal.Capture(100, GpioPinEdge.RisingEdge | GpioPinEdge.FallingEdge, waitForEdge, TimeSpan.FromSeconds(15));

// Wait for finish capture
// do other work
Thread.Sleep(Timeout.Infinite); 

// The event
private static void Digital_OnCaptureFinished(DigitalSignal sender, uint[] buffer, uint count, GpioPinValue pinValue) {
    if (count == 0) {
        Debug.WriteLine("no data was captured!");
        return;
    }
    for (int i = 0; i < count; i++) {
        Debug.WriteLine("Sample [" + i +"]: "+ buffer[i]+" ns");
    }
}
```
> [!NOTE]
> The first captured pulse will likely have an inaccurate (shorter) value due to system prep-time.

### ReadPulse
ReadPulse can be used to measure frequency and other analyses that require measuring time duration for specific pulse count.

```cs
var digitalSignalPin = GpioController.GetDefault().OpenPin(SC20260.Timer.Capture.Controller5.PB3);
var digitalSignal = new DigitalSignal(digitalSignalPin);
bool waitForEdge = true;// wait for first pulse before starting the measurement

// Subscribe event when done reading
digitalSignal.OnReadPulseFinished += Digital_OnReadPulseFinished;           

// Start reading 1000 pulses
digitalSignal.ReadPulse(1000, GpioPinEdge.RisingEdge, waitForEdge);

// do other work...
Thread.Sleep(Timeout.Infinite);

// the event
private static void Digital_OnReadPulseFinished(DigitalSignal sender, TimeSpan duration, uint count, GpioPinValue pinValue) {
    var ticks = duration.Ticks;
    var microsecond = ((double)duration.Ticks) / 10;
    var millisecond = ((double)duration.Ticks) / 10000;
    var freq = (count / microsecond) * 1000000;

    Debug.WriteLine("GpioPinValue = " + ((pinValue == GpioPinValue.High) ? "High" : "Low"));
    Debug.WriteLine("PulseCount = " + count);
    Debug.WriteLine("Duration ticks = " + ticks);
    Debug.WriteLine("Duration microsecond = " + microsecond);
    Debug.WriteLine("Duration millisecond = " + millisecond);
    Debug.WriteLine("freq = " + freq / 1000.0 + " KHz");
}
```

---
### Abort
An event is fired when any `DigitalSignal` operation is completed. In some cases, it may be desired to terminate the operation early, using `Abort`. When aborted, an event is still triggered, which will contain whatever data/pulses was collected from the trigger to the time `Abort` was called.

```cs
var digitalSignalPin = GpioController.GetDefault().OpenPin(SC20260.Timer.Capture.Controller5.PB3);
var digitalSignal = new DigitalSignal(digitalSignalPin);
var waitForEdge = false;

digitalSignal.OnReadPulseFinished += Digital_OnReadPulseFinished

while (true) {
    if (digitalSignal.CanReadPulse) {
        digitalSignal.ReadPulse(1000, GpioPinEdge.RisingEdge, waitForEdge);                  
        Thread.Sleep(1000);                    
        digitalSignal.Abort();
        Debug.WriteLine("Aborted");
    }
}
      
private static void Digital_OnReadPulseFinished(DigitalSignal sender, TimeSpan duration, uint count, GpioPinValue pinValue) {
    if (count > 0) {
        var microsecond = ((double)duration.Ticks) / 10;
        var freq = (count / microsecond) * 1000000;
        Debug.WriteLine("freq = " + freq / 1000.0 + " KHz");
    }
    else {
        Debug.WriteLine("No clock found.");
    }
}
```

> [!TIP] 
> In the sample code above you can use PWM to provide the pulse needed to verify the code. Keep in mind that both PWM and `DigitalSignal` share resources, so a different Timer controller must be used.

---

## Pulse Feedback

The PulseFeedback class can be used in three different modes. These modes are used to measure Echo Duration, Duration Until Echo, and Drain Duration.

### Echo Duration

![Echo duration timing](images/echo-duration.gif)

Echo Duration sends a trigger pulse of a given state over the provided pin. It then waits for an echo on the other specified pin and measures the length of that echo pulse. The trigger and echo pins cannot be the same pin.

The following code will read the distance in centimeters from an HC-SR04 ultrasonic distance sensor. This sensor has a trigger pin that is pulsed high to start distance measurement. It has a separate echo pin that the sensor holds high until it receives an echo. Therefore, the time the echo pin is high represents the time it takes for the sound to hit the target and reflect back to the sensor.

To test this code, I plugged the sensor directly into the SCM20260D Dev board and ran a couple short wires for power. It was convenient having 5V on the header. I was surprised how well this inexpensive sensor worked.

![HC-SR04 on dev board](images/ultrasonic-on-header.jpg)

> [!Note]
> The HC-SR04 ultrasonic distance sensor requires a 5 volt power supply. While the module accepts 3.3 volt logic on the Trig and Echo pins, it will not work with a 3.3 volt supply for power.


```cs
var gpio = GpioController.GetDefault();
var distanceTriggerPin = gpio.OpenPin(SC20260.GpioPin.PA15);

var distanceEchoPin = gpio.OpenPin(SC20260.GpioPin.PJ14);

pulseFeedback = new PulseFeedback(distanceTriggerPin,
    distanceEchoPin,
    PulseFeedbackMode.EchoDuration) {
    DisableInterrupts = false,
    Timeout = System.TimeSpan.FromSeconds(1),
    PulseLength = System.TimeSpan.FromTicks(100),
    EchoValue = GpioPinValue.High,
    PulseValue = GpioPinValue.High,
};

while (true) {
    var time = pulseFeedback.Trigger();
    var microseconds = time.TotalMilliseconds * 1000.0;
    var distance = microseconds * 0.036 / 2.0;

    Debug.WriteLine(distance.ToString());
    Thread.Sleep(Timeout.Infinite);
}
```

### Duration Until Echo

![Duration until echo timing](images/duration-until-echo.gif)

Duration Until Echo is very similar to Echo Duration, although instead of sending a pulse and measuring the length of the resulting echo, it measures how long it takes until that echo is received. Pulse and echo cannot use the same pins.

The following code reads the distance in centimeters from a Polaroid 6500 Ranging Module. This module is similar to the HC-SR04 distance sensor, however the time it takes for the sensor to pulse the ECHO pin after your device pulses the INIT must be measured.


>[!TIP]
>Needed Nuget: GHIElectronics.TinyCLR.Devices.Signals`

```cs
var gpio = GpioController.GetDefault();
var distanceTriggerPin = gpio.OpenPin(SC20260.GpioPin.PA15);

var distanceEchoPin = gpio.OpenPin(SC20260.GpioPin.PJ14);

var pulseFeedback = new PulseFeedback(distanceTriggerPin, 
    distanceEchoPin, 
    PulseFeedbackMode.DurationUntilEcho) {

    DisableInterrupts = false,
    Timeout = System.TimeSpan.FromSeconds(1),
    PulseLength = System.TimeSpan.FromTicks(100),
    EchoValue = GHIElectronics.TinyCLR.Devices.Gpio.GpioPinValue.High,
    PulseValue = GHIElectronics.TinyCLR.Devices.Gpio.GpioPinValue.High,
};

while (true) {
    var time = pulseFeedback.Trigger();
    var microseconds = time.TotalMilliseconds * 1000.0;
    var distance = microseconds * 0.036 / 2.0;

    Debug.WriteLine(distance.ToString());
    Thread.Sleep(1000);
}
```

### Drain Duration

![Drain duration timing](images/drain-duration.gif)

In this DrainDuration mode is used to implement capacitive touch. When calling Trigger, the pulse line will be held in the specified state for the specified time and then set to an input. It then measures the time for the pin to change its state.

Only the pulse line is used in this mode. Echo pin is ignored.

The image below shows a sample circuit. Note that this mode can only be used with a single pin.

![Capacitive touch schematic](images/capacitive-touch-schematic.gif)

The following example illustrates the reading of a capacitive touch sensor. It sends a pulse of 10us to charge a capacitor and then measures the length of time it takes the capacitor to discharge on the same pin. It prints out the total discharge duration in milliseconds. It repeats every second.

```cs
var gpio = GpioController.GetDefault();
var capacitiveSensePin = gpio.OpenPin(SC20260.GpioPin.PJ14);

var pulseFeedback = new PulseFeedback(capacitiveSensePin, 
    PulseFeedbackMode.DrainDuration) {

    DisableInterrupts = false,
    Timeout = System.TimeSpan.FromSeconds(1),
    PulseLength = System.TimeSpan.FromTicks(100),
    PulseValue = GHIElectronics.TinyCLR.Devices.Gpio.GpioPinValue.High,
};

while (true) {
    Debug.WriteLine(pulseFeedback.Trigger().TotalMilliseconds.ToString());
    Thread.Sleep(1000);
}
```

---

## Signal Capture

The SignalCapture class monitors a pin and records any changes (high-low or low-high transitions) of the pin to an array. It is a digital waveform recorder. Each array element is the number of microseconds between each signal change.

When calling Read, it blocks other code from executing until it either fills the input buffer or it has captured the number of transitions specified by the count argument. If your signal is shorter than that, the call will never return. Make sure to request only what you plan to capture.

The following sample code captures the signal generated by pressing LDR button on the SC20100S Dev board. It will attempt to capture 100 transitions, waiting no more than 10 seconds. It will also enable the pull-up resistor on the pin. It will return the initial state of the pin when it started capturing and how many transitions it captured. Note that the signal capture may record button bounces, resulting in a number of transitions in rapid succession.

```cs
var gpio = GpioController.GetDefault();
var capturePin = gpio.OpenPin(SC20100.GpioPin.PE3);

var capture = new SignalCapture(capturePin);
var buffer = new TimeSpan[100];

capture.DisableInterrupts = false;
capture.Timeout = TimeSpan.FromSeconds(10);
capture.DriveMode = GpioPinDriveMode.InputPullUp;

while (true) {
    var count = capture.Read(out var init, buffer);
    Thread.Sleep(100);
}
```
---

## Signal Generator

SignalGenerator is a digital waveform generator. SignalGenerator works by comparing an internal counter to an array of time values, one by one. When the value of the argument matches the counter, the output pin is changed. The time values are in microseconds.

SignalGenerator can also be used to generate PWM. Unlike the PWM class, SignalGenerator can be used to generate PWM on any available output pin. It does use processor time -- the higher the frequency the more processor time it uses.

At this time, SignalGenerator only operates in blocking mode. While SignalGenerator is running, it will not yield any processor time to other code.

The following sample code will blink the user LED on the SC20100S Dev board four times (for one second each time) every five seconds.

```cs
var gpio = GpioController.GetDefault();
var signalPin = gpio.OpenPin(SC20260.GpioPin.PE11);
var signalGen = new SignalGenerator(signalPin);

var buffer = new[] {
    TimeSpan.FromSeconds(1),
    TimeSpan.FromSeconds(1),
    TimeSpan.FromSeconds(1),
    TimeSpan.FromSeconds(1),
    TimeSpan.FromSeconds(1),
    TimeSpan.FromSeconds(1),
    TimeSpan.FromSeconds(1),
    TimeSpan.FromSeconds(1),
};

signalGen.DisableInterrupts = false;
signalGen.IdleValue = GpioPinValue.Low;

while (true) {
    signalGen.Write(buffer);
    Thread.Sleep(5000);
}
```
