# Bluetooth
---

Endpoint supports two kinds of bluetooth devices through USB, they are:

- Broadcom: BCM4335,BCM4350, BCM4356, BCM4371, BCM20702, BCM20703, BCM43142 
- Realtek: RTL87xx

Endpoint uses BlueZ stack to control bluetooth. There is an example for using BlueZ in .NET, can be found here: https://github.com/SuessLabs/Linux.Bluetooth

> [!Note]
> Hardware driver needs to be loaded, initialized, and paired before using BlueZ library.<BR>
> Pair is requested from Endpoint only.

## Example

Below is an example how to initialize and pair between Endpoint and another device with provided MAC_ADDRESS

```cs

const string MAC_ADDRESS = "80:07:94:46:57:B6"; // The mac address needed for ep to connect to.

private static void Main()
{

    Bluetooth.Initialize();

    Console.WriteLine($"Mac Address : {Bluetooth.GetDeviceMacAddress()}");
    Console.WriteLine($"Name : {Bluetooth.GetDeviceName()}");
    Console.WriteLine($"Manufacturer : {Bluetooth.GetDeviceManufacturer()}");

    Bluetooth.Power(false);
    Thread.Sleep(1000);
    Bluetooth.Power(true);

    Bluetooth.OnScanEvent += Console.WriteLine;

    var knownDevices = Bluetooth.DevicePaired();

    if (knownDevices != null)
    {
        foreach (var device in knownDevices)
        {
            Console.WriteLine("Known:" + device);
        }
    }

    Bluetooth.Unpair(MAC_ADDRESS); // unpair and scan to pair again

    if (Bluetooth.Scan(new TimeSpan(0, 0, 200), MAC_ADDRESS))
    {

        if (Bluetooth.Pair(MAC_ADDRESS))
        {
            Console.WriteLine("Pair sucessfully"); 
        }
        else
        {
            Console.WriteLine("Pair failed");
        }

    }

    Thread.Sleep(-1);
}
```



