# PWM
---
Pulse Width Modulation (PWM) is a very useful feature found on most microcontrollers. PWM is a method of generating a square wave signal of uniform frequency with variable duty cycle. PWM is often used to generate analog voltages, but has many other uses such as generating digital pulses for driving servo motors or driving infrared LEDs for communication. The ratio of the pulse width to it's period is called the duty cycle. Through software, you can control both the PWM frequency and duty cycle.

> [!Tip]
> We usually use GetDefault() for most peripherals. For example, there is only one GPIO controller on most systems. This is not the case with PWM. Never use the Default controller and always select the proper channel on the corresponding controller.

> [!Tip]
> PWM2.3 is channel 3 on controller 2.

## Energy Level
PWM is perfect for dimming an LED or controlling the speed of a motor. When the duty cycle is 50%, half the energy is transferred to the attached load.

```cs
var controller = PwmController.FromName(SC20260.Timer.Pwm.Controller3.Id);
var led = controller.OpenChannel(SC20260.Timer.Pwm.Controller3.PB0);
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
```
---

## Musical Tones
Musical notes have specific frequencies; C for example is about 261Hz. Plugging these numbers into an array and knowing the length of each tone is all that is needed to play some simple music. When playing notes by changing the frequency, keep the duty cycle set to 0.5.

The following example is written for the SC20100S Dev Board.

```cs
using GHIElectronics.TinyCLR.Devices.Pwm;
using GHIElectronics.TinyCLR.Pins;
using System.Threading;

class Program {
    const int NOTE_C = 261;
    const int NOTE_D = 294;
    const int NOTE_E = 330;
    const int NOTE_F = 349;
    const int NOTE_G = 392;

    const int WHOLE_DURATION = 24;
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

    private static int[] duration = { QUARTER, QUARTER, QUARTER, QUARTER, QUARTER, QUARTER,
                              QUARTER, QUARTER, QUARTER, QUARTER, QUARTER, QUARTER,
                              QUARTERDOT, EIGHTH, HALF, QUARTER, QUARTER, QUARTER, QUARTER,
                              QUARTER, QUARTER, QUARTER, QUARTER, QUARTER, QUARTER,
                              QUARTER, QUARTER, QUARTERDOT, EIGHTH, WHOLE};

    private static void Main() {
        var controller = PwmController.FromName(SC20100.Timer.Pwm.Controller14.Id);
        var toneOut = controller.OpenChannel(SC20100.Timer.Pwm.Controller14.PA7);
        toneOut.SetActiveDutyCyclePercentage(0.5);

        while (true) {
            toneOut.Start();

            for (int i = 0; i < note.Length; i++) {
                controller.SetDesiredFrequency(note[i]);
                Thread.Sleep(duration[i]);
            }

            toneOut.Stop();

            Thread.Sleep(1000);
        }
    }
}
```

---

## Servo Motors
A servo motor is a motor that has a small internal circuit allowing you to control it using electrical pulses. Servo motors are available as either continuous or positional servos. While they look identical, a positional servo only turns to a given position and then holds that position until you tell it to move to another position. A continuous servo motor will rotate continuously in one direction until it is told to either stop or reverse direction.

The pulse that controls servos is sent every 20 ms. This pulse will usually have a width between 1 ms and 2 ms which varies depending on the make and model of the motor. The position of a positional servo is based on the width of the pulse, with a 1.5 ms pulse moving to the middle of travel (90-degree position). With a rotational servo, 1.5ms will stop the motor, 1 ms is full speed, and 2 ms is full speed in the opposite direction. 

> [!Tip] 
> As a rule, servos have three wires. Be sure the central wire is connected to 5V. The lighter color wire on one side of the connector is a signal and should be connected to a PWM pin. The third one, which is usually a darker color, is ground.

This example is written for the SC20100S Dev Board. It will turn the positional servo (servo1) to the zero-degree position, wait a second, and then turn it to 180 degrees. It will then rotate the continuous servo (servo2) at maximum speed for five seconds, and then reverse direction for five seconds. You must add the servo class (the code below this example) to your project for it to work.

> [!Tip]
> Most servos will have a 1 ms minimum pulse width and a 2 ms maximum pulse width, but check the specs of the motor to be sure.

```cs
using GHIElectronics.TinyCLR.Pins;
using GHIElectronics.TinyCLR.Devices.Pwm;
using GHIElectronics.TinyCLR.Devices.Servo;
using System.Threading;

class Program {
    private static void Main() {
        ServoMotor servo1 = new ServoMotor(ServoMotor.ServoType.Positional,
            PwmController.FromName(SC20100.Timer.Pwm.Controller15.Id),
            SC20100.Timer.Pwm.Controller15.PE6);
        
        servo1.ConfigurePulseParameters(0.5, 2.4);  //Settings for TowerPro SG90 micro servo.

        ServoMotor servo2 = new ServoMotor(ServoMotor.ServoType.Continuous,
            PwmController.FromName(SC20100.Timer.Pwm.Controller2.Id),
            SC20100.Timer.Pwm.Controller2.PA3);

        servo1.Set(0);
        Thread.Sleep(1000);
        servo1.Set(180);
        Thread.Sleep(1000);
        servo1.Stop();

        servo2.Set(100);
        Thread.Sleep(5000);
        servo2.Set(-100);
        Thread.Sleep(5000);
        servo2.Stop();

        Thread.Sleep(Timeout.Infinite);
    }
}
```

This is the servo.cs class that provides the methods used in the above code to control the servos:

```cs
using GHIElectronics.TinyCLR.Devices.Pwm;
using System;

namespace GHIElectronics.TinyCLR.Devices.Servo {
    public class ServoMotor {
        private PwmChannel servo;
        private ServoType type;

        private double minPulseLength;
        private double maxPulseLength;
        public double position { get; set; }

        public enum ServoType {
            Positional,
            Continuous
        }

        public ServoMotor(ServoType type, PwmController controller, int PwmPin) {
            this.servo = controller.OpenChannel(PwmPin);
            this.ConfigurePulseParameters(1.0, 2.0);
            controller.SetDesiredFrequency(50);

            this.type = type;
            this.position = 0;
        }

        public void ConfigurePulseParameters(double minimumPulseWidth,
            double maximumPulseWidth) {

            if (minimumPulseWidth > 1.5 || minimumPulseWidth < 0.1)
                throw new ArgumentOutOfRangeException("Must be between 0.1 and 1.5 ms");

            if (maximumPulseWidth > 3 || maximumPulseWidth < 1.6)
                throw new ArgumentOutOfRangeException("Must be between 1.6 and 3 ms");

            this.minPulseLength = minimumPulseWidth;
            this.maxPulseLength = maximumPulseWidth;
        }

        public void Set(double value) {
            if (this.type == ServoType.Positional) {
                this.PositionalSetPosition(value);
                this.position = value;
            }
            else {
                this.ContinousSetSpeed(value);
            }
        }

        private void PositionalSetPosition(double angle) {
            if (angle < 0 || angle > 180)
                throw new ArgumentOutOfRangeException("degrees",
                    "degrees must be between 0 and 180.");

            var duty = ((angle / 180.0 * (this.maxPulseLength - this.minPulseLength))
                + this.minPulseLength) / 20;

            this.servo.SetActiveDutyCyclePercentage(duty);
            this.servo.Start();
        }

        private void ContinousSetSpeed(double speed) {
            if (speed < -100 || speed > 100)
                throw new ArgumentOutOfRangeException("speed",
                    "speed must be between -100 and 100.");

            PositionalSetPosition(speed / 100 * 90 + 90);
        }

        public void Stop() => this.servo.Stop();
    }
}
```