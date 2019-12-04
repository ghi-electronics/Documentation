# Servo Motors
---
A servo motor is a motor that has a small internal circuit allowing you to control it using electrical pulses. Servo motors are available as either continuous or positional servos. While they look identical, a positional servo only turns to a given position and then holds that position until you tell it to move to another position. A continuous servo motor will rotate continuously in one direction until it is told to either stop or reverse direction.

The pulse that controls servos is sent every 20 ms. This pulse will usually have a width between 1 ms and 2 ms which varies depending on the make and model of the motor. The position of a positional servo is based on the width of the pulse, with a 1.5 ms pulse moving to the middle of travel (90 degree position). With a rotational servo, 1.5ms will stop the motor, 1 ms is full speed, and 2 ms is full speed in the opposite direction. 

> [!Tip] 
> As a rule, servos have three wires. Be sure the central wire is connected to 5V. The lighter color wire on one side of the connector is a signal and should be connected to a PWM pin. The third one, which is usually a darker color, is ground.

This example is written for the SC20100 Dev Board. It will turn the positional servo (servo1) to the zero degree position, wait a second, and then turn it to 180 degrees. It will then rotate the continuous servo (servo2) at maximum speed for five seconds, and then reverse direction for five seconds. You must add the servo class (the code below this example) to your project for it to work.

> [!Tip]
> Most servos will have a 1 ms minimum pulse width and a 2 ms maximum pulse width, but check the specs of the motor to be sure.

```csharp
using GHIElectronics.TinyCLR.Pins;
using GHIElectronics.TinyCLR.Devices.Pwm;
using GHIElectronics.TinyCLR.Devices.Servo;
using System.Threading;

class Program {
    private static void Main() {
        ServoMotor servo1 = new ServoMotor(ServoMotor.ServoType.Positional,
            PwmController.FromName(SC20100.PwmChannel.Controller15.Id),
            SC20100.PwmChannel.Controller15.PE6);
        
        servo1.ConfigurePulseParameters(0.5, 2.4);  //Settings for TowerPro SG90 micro servo.

        ServoMotor servo2 = new ServoMotor(ServoMotor.ServoType.Continuous,
            PwmController.FromName(SC20100.PwmChannel.Controller2.Id),
            SC20100.PwmChannel.Controller2.PA3);

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

        Thread.Sleep(-1);
    }
}

```

This is the servo.cs class that provides the methods used in the above code to control the servos:
```csharp
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