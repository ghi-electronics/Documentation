# Other Platforms

Endpoint's Visual Studio extension and [config tool](~/endpoint/configuration.md) support other linux SBCs from companies such as Raspberry Pi BeagleBoard. This gives developers an easy way to test out the power of .NEt on hardware they may already own.

Full remote network deploying and debugging are supported. Note that the official .NET libraries may support some of the IoT features on these boards. Consider using Endpoint for access to all libraries.  

This table lists the features available on tested boards:
 
 
Features				| Endpoint	|  Raspberry	| BeagleBone
 --- 					| ---		| ---			| ---
GPIO					|	✓		| ✓				|✓
PWM						|	✓		| ✓				|✓
SPI						|	✓		| ✓				|✓
I2C						|	✓		| ✓				|✓
UART					|	✓		| ✓				|✓
UART					|	✓		| ✓				|✓
CAN						|	✓		| ✗				|✗
ADC						|	✓		| ✗				|✗
Digital Signal			|	✓		| ✗				|✗
RTC						|	✓		| ✗				|✗
USB						|	✓		| ✗				|✗
SD						|	✓		| ✗				|✗
Parallel Display		|	✓		| ✗				|✗
IFU						|	✓		| ✗				|✗
Watchdog				|	✓		| ✗				|✗
Camera					|	✓		| ✗				|✗

 
Also note that our official Endpoint is designed with a tighter image for faster boot. Consider boot time when folowing instrucitons. This is a typical boot time, from power up to a cimplete boot with a blink LED in .NET.

 Device 			| Typical boot time 
 --- 				| ---
 Endpoint Domino 	| 6 seconds
 Raspberry Pi 4 	| 45 seconds
 BeagleBone Black 	| 200 seconds


---
The [Getting Started](~/endpoint/getting-started.md) page applies to other boards; however, some steps may be necessary as shown below.

 ## Raspberry Pi
 
 Raspberry Pi may have SSH disable by default, make sure SSH is enabled for connection. Visit the Raspberry Pi website for details on enableing SSH. 
 
 ## BeagleBone
 
 On BeagleBone, NOPASSWD needs to be enabled for sudo command. To enable NOPASSWD, run the command below from PC's command line:
 
 ```
 ssh debian@beaglebone
 ```
 
 Enter password if needed. Once SSH is connected, run the second command below:
 
 ```
 sudo bash -c 'echo "debian ALL=NOPASSWD: ALL" >> /etc/sudoers'
 ```

 

