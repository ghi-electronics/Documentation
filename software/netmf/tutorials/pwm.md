# PWM
---

PWM is used to control of the ratio of a pin's high and low state, the "duty cycle." This can be done using software or using built-in PWM pins on the processor. PWM pins have the advantage over Software PWM because the toggling is independent of the CPU. Software PWM is performed using the SignalGenerator class.

PWM objects are constructed with the period and duration of the pulse.  The duration is how long the pin is high or active while the period is the time between one duration and the next. "Duty Cycle" is the ratio of the duration and the period -- as a convenience, a scale can be set. The scale is applied to the numbers assigned to the PWM's properties.

A pin with duty cycle 0.5 will be high half the time and low the other half.

Some common uses of PWM:
* control the intensity of lights and the speed of motors by changing the duty-cycle.
* generate audio tones by keeping the duty-cycle at 50% and changing the frequency.
* positioning of a servo by using a pulse with a specific duration or width.

## .NET Micro Framework PWM Channels
In NETMF, the PWM pins are defined in the "Cpu.PWMChannel" enumeration. As the enumeration has a limited number of members, the number of PWM pins may exceed the members. Casting can be used for those extra PWMs.

```cs
// Using the enumeration
PWM MyServo = new PWM(Cpu.PWMChannel.PWM_3, 2175, 175,
                      PWM.ScaleFactor.Microseconds, false);

// Lots of PWMs on processor, use a cast to access an extra PWM
PWM LED = new PWM((Cpu.PWMChannel)9, 10000, 0.10, false);
 
> [!Tip]
> The examples shown below require the Microsoft.SPOT.Hardware.PWM assembly; 

> [!Warning]
> Some or all PWM pins share the same timers internally. This means the changing frequency on one pin will also effect the others. However, the duty cycle can be different on all pins. Users needing to determine which pins share the same timer have two options. Either use trial and error on all PWM pins or check the processor manual.

## Controlling LEDs Brightness

This example starts the LED at 0% intensity then slowly steps up to full intensity, after which it reverts to 0% and starts over.

```cs
using System.Threading;
using Microsoft.SPOT.Hardware;

public class Program
{
    static PWM MyFader = new PWM(Cpu.PWMChannel.PWM_0, 10000, 0.1, false);

    public static void Main()
    {
        double i = 0.0;
        while (true)
        {
            MyFader.DutyCycle = i;
            /* DutyCycle is not dynamic so make a call to
             * Start() to refresh the object */
            MyFader.Start();

            if ((i += 0.1) >= 1.0)
            {
                i = 0.0;
            }

            Thread.Sleep(10);
        }
    }
}
```

## Musical Tones
Music notes have specific frequencies, for example C is about 261Hz. Plugging these numbers into an array and knowing the length of each tone is all that is needed to play some simple music.

```cs
using System.Threading;
using Microsoft.SPOT.Hardware;

public class Program
{
    const int NOTE_C = 261;
    const int NOTE_D = 294;
    const int NOTE_E = 330;
    const int NOTE_F = 349;
    const int NOTE_G = 392;

    const int WHOLE_DURATION = 1000;
    const int EIGHTH = WHOLE_DURATION / 8;
    const int QUARTER = WHOLE_DURATION / 4;
    const int QUARTERDOT = WHOLE_DURATION / 3;
    const int HALF = WHOLE_DURATION / 2;
    const int WHOLE = WHOLE_DURATION;

    //make sure the two below arrays match in length. each duration element corresponds to
    //one note element.
    static int[] note = { NOTE_E, NOTE_E, NOTE_F, NOTE_G, NOTE_G, NOTE_F, NOTE_E,
                          NOTE_D, NOTE_C, NOTE_C, NOTE_D, NOTE_E, NOTE_E, NOTE_D,
                          NOTE_D, NOTE_E, NOTE_E, NOTE_F, NOTE_G, NOTE_G, NOTE_F,
                          NOTE_E, NOTE_D, NOTE_C, NOTE_C, NOTE_D, NOTE_E, NOTE_D,
                          NOTE_C, NOTE_C};

    static int[] duration = { QUARTER, QUARTER, QUARTER, QUARTER, QUARTER, QUARTER,    QUARTER,
                              QUARTER, QUARTER, QUARTER, QUARTER, QUARTER, QUARTERDOT, EIGHTH,
                              HALF,    QUARTER, QUARTER, QUARTER, QUARTER, QUARTER,    QUARTER,
                              QUARTER, QUARTER, QUARTER, QUARTER, QUARTER, QUARTER,    QUARTERDOT,
                              EIGHTH,  WHOLE};

    public static void Main()
    {
        PWM MyPWM = new PWM(Cpu.PWMChannel.PWM_3, 261, 0.50, false);
        while (true)
        {
            for (int i = 0; i < note.Length; i++)
            {
                MyPWM.Stop();
                MyPWM.Frequency = note[i];
                MyPWM.Start();
                Thread.Sleep(duration[i]);
            }
            Thread.Sleep(100);
        }
    }
}
```

## Servos
For the servo in this example, if the pulse width is about 1.25ms then the servo is at 0 degrees. Increasing the pulse width to 1.50ms will move the servo to 90 degrees (neutral). A wider pulse of 1.75ms will move the servo to 180 degrees.

Servos expect a pulse every 20ms to 30ms.

It is important for the high pulse to be between 1.25ms and 1.75ms so that the servo's position is set properly.

The code below will move the position of the servo to 180 degrees (using a pulse of 1.75ms). It uses a pause time between pulses of 20ms. So the period is 21.75ms and a duration of 1.75ms. Note the use of "scale".

```cs
using System.Threading;
using Microsoft.SPOT.Hardware;

public class Program
{
    public static void Main()
    {
        PWM MyServo = new PWM(Cpu.PWMChannel.PWM_3, 2175, 1750, PWM.ScaleFactor.Microseconds, false);

        while (true)
        {
            // 0 degrees. 20ms period and 1.25ms high pulse
            MyServo.Duration = 1250;
            MyServo.Period = 20000;
            MyServo.Start();
            Thread.Sleep(1000);

            // 90 degrees. 20ms period and 1.50ms high pulse
            MyServo.Duration = 1500;
            MyServo.Period = 20000;
            MyServo.Start();
            Thread.Sleep(1000);

            // 180 degrees. 20ms period and 1.75ms high pulse
            MyServo.Duration = 1750;
            MyServo.Period = 20000;
            MyServo.Start();
            Thread.Sleep(1000);
        }
    }
}
```
