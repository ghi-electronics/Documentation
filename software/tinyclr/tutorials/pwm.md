# PWM
---
Pulse Width Modulation (PWM) is a very useful feature found on most microcontrollers. PWM is a method of generating a square wave signal of uniform frequency with variable duty cycle. PWM is often used to generate analog voltages, but has many other uses such as generating digital pulses for driving servo motors or driving infrared LEDs for communication. The ratio of the pulse width to it's period is called the duty cycle. Through software, you can control both the PWM frequency and duty cycle.

> [!Tip]
> We usually use GetDefault() for most peripherals. For example, there is only one GPIO controller on most systems. This is not the case with PWM. Never use the Default controller and always select the proper channel on the corresponding controller.

> [!Tip]
> PWM2.3 is channel 3 on controller 2

## Energy Level
PWM is perfect for dimming an LED or controlling the speed of a motor. When the duty cycle is 50%, half the energy is transferred to the attached load.

This example is written for the SC20260D dev board, but will run unchanged on the SC20100 dev board. The left most LED on the board (PB0) will fade in and out.

```csharp
using GHIElectronics.TinyCLR.Devices.Pwm;
using GHIElectronics.TinyCLR.Pins;
using System.Threading;

class Program {
    private static void Main() {
        var controller = PwmController.FromName(SC20260.PwmChannel.Controller3.Id);
        var led = controller.OpenChannel(SC20260.PwmChannel.Controller3.PB0);
        controller.SetDesiredFrequency(10000);

        double duty = 0.5, speed = 0.01;
        
        led.Start();
        
        while (true) {
            if (duty <= 0 || duty >= 1.0) {
                speed *= -1;    //Reverse direction.
                duty += speed;
            }

            led.SetActiveDutyCyclePercentage(duty);
            duty += speed;

            Thread.Sleep(10);   //Always give the system time to think!
        }
    }
}

   
```

## Musical Tones
Musical notes have specific frequencies; C for example is about 261Hz. Plugging these numbers into an array and knowing the length of each tone is all that is needed to play some simple music. When playing notes by changing the frequency, keep the duty cycle set to 0.5.

```csharp
using System.Threading;
using GHIElectronics.TinyCLR.Devices.Pwm;
using GHIElectronics.TinyCLR.Pins;

class Program {
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

    //Make sure the two below arrays match in length. Each duration element corresponds to
    //  one note element.
    private static int[] note = { NOTE_E, NOTE_E, NOTE_F, NOTE_G, NOTE_G, NOTE_F, NOTE_E,
                          NOTE_D, NOTE_C, NOTE_C, NOTE_D, NOTE_E, NOTE_E, NOTE_D,
                          NOTE_D, NOTE_E, NOTE_E, NOTE_F, NOTE_G, NOTE_G, NOTE_F,
                          NOTE_E, NOTE_D, NOTE_C, NOTE_C, NOTE_D, NOTE_E, NOTE_D,
                          NOTE_C, NOTE_C};

    private static int[] duration = { QUARTER, QUARTER, QUARTER, QUARTER, QUARTER, QUARTER,    QUARTER,
                              QUARTER, QUARTER, QUARTER, QUARTER, QUARTER, QUARTERDOT, EIGHTH,
                              HALF,    QUARTER, QUARTER, QUARTER, QUARTER, QUARTER,    QUARTER,
                              QUARTER, QUARTER, QUARTER, QUARTER, QUARTER, QUARTER,    QUARTERDOT,
                              EIGHTH,  WHOLE};
    private static void Main() {
        var controller = PwmController.FromName(FEZ.PwmChannel.Controller1.Id);
        var toneOut = controller.OpenChannel(FEZ.PwmChannel.Controller1.D0);
        toneOut.SetActiveDutyCyclePercentage(0.5);
        toneOut.Start();
        while (true) {
            for (int i = 0; i < note.Length; i++) {
                controller.SetDesiredFrequency(note[i]);
                Thread.Sleep(duration[i]);
            }
            Thread.Sleep(100);
        }
    }
}

```

## Servo Motors
PWM can also be used to control servo motors. [Click here](servo-motors.md) for more details.
