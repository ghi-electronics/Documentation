# Analog Outputs
---

An analog output sets the voltage on its pin anywhere between 0 and the supplied voltage (maximum voltage) which is typically 3.3 volts. The output voltage is only a signal, not meant to drive any loads. An op-amp or similar circuit can be added to drive loads, such as a speaker.

The analog out on a micro has  "precision:" the precision of a particular processor is in its manual or datasheet; consequentially, actual output values on the pin are an approximation. For example, a micro with an 8-bit (256 steps) analog out has a step precision of 3.3V/256.

In NETMF, the voltage to be output is specified as a percentage called the "level." So, on a processor with a maximum output of 3.3V, a level of 0.5 (50%) would output around 1.65V.

NETMF has two properties for the AnalogOutput class:  Scale and Offset.

The final voltage on the output pin will be:  Final voltage = maximum output  * ( (level*Scale) + Offset))

Final voltages are clipped to fit in the range 0V to maximum pin voltage.

**Example**

The processor in this example has a maximum output of 3.3 volts.

The 50% voltage (level == 0.5) by default would generate 1.65V.  Because of Scale, the actual percent will be 10 (0.5 * 0.2), which results in an output voltage of about 0.33V (3.3V * 0.1).

The following code requires the Microsoft.SPOT.Hardware assembly.
    
```cs
using Microsoft.SPOT.Hardware;

public class Program
{
    public static void Main()
    {
        //Setup Analog on the first analog output channel
        AnalogOutput output = new AnalogOutput(
            Cpu.AnalogOutputChannel.ANALOG_OUTPUT_0);
        output.Scale = 0.2;
        output.Write(0.5); //output approx. 0.33V
    }
}
```
