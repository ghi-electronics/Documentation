# Analog Inputs
---

Unlike digital input pins which can only read high or low, analog pins can read a range of voltage levels.  Micro-controllers based on 3.3V can read voltages anywhere between zero and 3.3V.  In contrast to digital input pins that are 5V tolerant; the maximum applied voltage for analog input must not exceed 3.3V (for higher voltages a voltage divider or an op-amp circuit can be used).

## Using a Light Sensor to Demonstrate Analog Input
This example uses a light sensor.  Its output voltage varies with light intensity -- the darker the light the higher the voltage output.
The following code requires the Microsoft.SPOT.Hardware assembly. Consult the Developers' Guide or the product manual for specific channels.

```cs
using System.Threading;
using Microsoft.SPOT;
using Microsoft.SPOT.Hardware;


public class Program
{
	public static void Main()
	{
		AnalogInput lightSensor = new AnalogInput((Cpu.AnalogChannel)Cpu.AnalogChannel.ANALOG_7);
		double lightSensorReading = 0;

		while (true)
		{
			lightSensorReading = lightSensor.Read();
			Debug.Print(lightSensorReading.ToString());
			Thread.Sleep(500);
		}
	}
}
```
