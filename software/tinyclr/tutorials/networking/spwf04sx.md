# SPWF04Sx WiFi Module
---
First introduced over twenty years ago, WiFi has become the most popular wireless networking technology. The SPWF04Sx family of modules from STMicroelectronics have an easy-to-use AT command based socket API that allow applications to quickly connect to the Internet. They also support Transport Layer Security, which is vital in an IoT environment.

Take a look at the [FEZ WiFi sample](https://github.com/ghi-electronics/TinyCLR-Samples/) for a working example to get going quickly.

The [TinyCLR Driver repo](https://github.com/ghi-electronics/TinyCLR-Drivers) includes the complete source code.

## Hardware

### Firmware Updating

To update the firmware, please see this [page](../../../../hardware/components/spwf04sa.md).

## Software

### Constructors

#### SPWF04SxInterface()

`SPWF04SxInterface(SpiDevice spi, GpioPin irq, GpioPin reset)`. Used to create a new instance of the WiFi driver. Takes the SPI device and the IRQ and RESET GPIO pins as arguments. Has no return value. You must also set the mode pin but the constructor does not yet do this for you. Be sure to see the [sample](https://github.com/ghi-electronics/TinyCLR-Samples/blob/master/FEZ/FEZWiFi/Program.cs) for the correct setup or your device will not work.

### Methods

#### ClearTlsServerRootCertificate()

`ClearTlsServerRootCertificate()`. Erases the currently loaded root certificates from the WiFi module's flash memory. Takes no arguments and has no return value.

#### CloseSocket()

`CloseSocket(int id)`. Closes the socket specified by the id parameter. The socket id is assigned by the `OpenSocket()` method when the socket is created. Has no return value.

#### DisableRadio()

`DisableRadio()`. Disables the WiFi radio. Takes no arguments and has no return value.

#### Dispose()

`Dispose()`. Disposes of the WiFi instance. Takes no arguments and has no return value.

#### EnableRadio()

`EnableRadio()`. Enables the WiFi radio. Takes no arguments and has no return value.

#### GetConnectionSettings()

`GetConnectionSettings(SpiChipSelectType chipSelectType, int chipSelectLine)`. Returns the SPI connection settings used to open an SPI port for communication with the WiFi module. The first parameter taken by this function specifies the type of chip select used -- only `SpiChipSelectType.Gpio` is supported at this time. The second parameter specifies the GPIO pin that controls the WiFi module's chip select pin.

#### JoinNetwork()

`JoinNetwork(string ssid, string password)`. Attempts to join the WiFi network specified by the ssid and password values. Has no return value.

#### ListSocket()

`ListSocket()`. Returns a string that lists all open socket clients in the format `AT-S.List::<id>:<connected>:<kind>:<len>:<IP>:<port>`. Takes no arguments.

#### OpenSocket()

`OpenSocket(string host, int port, SPWF04SxConnectionType connectionType, SPWF04SxConnectionSecurityType connectionSecurity, string commonName)`. Opens a socket client. Arguments are a string host name, an integer port number, an SPWF04SxConnectionType connection type, and a connection security type of `none` or `Tls`. Returns an integer ID number for the socket.

#### QuerySocket()

`QuerySocket(int socket)`. Queries a socket client for pending data. Returns an integer number of bytes that are waiting on the socket. Takes the socket id as its only argument. The socket id is returned by the `OpenSocket()` method when the socket is created.

#### ReadHttpResponse()

`ReadHttpResponse(byte[] buffer, int offset, int count)`. Reads the response to the currently active HTTP command. Arguments are a byte array buffer to store the incoming data, an integer offset into the array, and an integer count of the size in bytes of available buffer. Returns an integer value of the number of bytes read.

#### ReadSocket()

`ReadSocket(int socket, byte[] buffer, int offset, int count)`. Reads data from a socket client. Arguments are an integer socket ID, an input buffer byte array, an integer offset into the array, and an integer count of how many bytes can be read into the buffer array. The socket id is returned by the `OpenSocket()` method when the socket is created. Returns an integer number of bytes received.

#### ResetConfiguration()

`ResetConfiguration()`. Restores the factory configuration variables to the flash of the WiFi module. It is necessary to perform a hardware or software reset of the WiFi module after a factory restore. Takes no arguments and has no return value.

#### SendHttpGet()

`SendHttpGet(string host, string path, int port, SPWF04SxConnectionSecurityType connectionSecurity)`. Sends a single http get request to the given host and path to retrieve information from a server. Arguments are a string host name, a string host path, an integer port number, and a connection security type of `none` or `Tls`. Returns an integer HTTP server status code.

#### SendHttpPost()

`SendHttpPost(string host, string path, int port, SPWF04SxConnectionSecurityType connectionSecurity)`. Sends an HTTP post request to a remote host. Arguments are a string host name, a string host path, an integer port number, and a connection security type of `none` or `Tls`. Returns an integer HTTP server status code.

#### SetTlsServerRootCertificate()

`SetTlsServerRootCertificate(byte[] certificate)`. Loads a TLS certificate into the flash memory of the WiFi module. Accepts a byte array containing the certificate as its only argument. Returns a string containing the Subject Key Identifier (SKI) of the certificate. The certificate must be loaded into your application as part of a resources file, be DER encoded, and have the extension .cer.

You can use your web browser to obtain a website's root certificate. In Chrome, click on the lock icon to the left of the web address. Then click on `Certificate` and select the `Details` tab. In `Details` click on the `Copy to File...` button. The `Certificate Export Wizard` will appear. Export the certificate as `DER encoded binary X.509 (.CER)`.

In Micorosoft Edge click on the lock icon to the left of the web address and then select `View certificate.` Click on the `Export to file` button and save the file with a .cer extension.

#### TurnOff()

`TurnOff()`. Turns off the WiFi module. Takes no arguments and has no return value.

#### TurnOn()

`TurnOn()`. Turns on the WiFi module. Takes no arguments and has no return value.

#### WriteSocket()

`WriteSocket(int socket, byte[] data)`. Writes data to a socket client. Arguments are an integer ID number for the socket and a byte array of data. The socket id is returned by the `OpenSocket()` method when the socket is created.

`WriteSocket(int socket, byte[] data, int offset, int count)`. Same as above but also takes integer arguments for the offset into the data array and a count for the number bytes to send.

### Events

#### IndicationReceived

Fires an event when a WiFi indication (WIND) message is received.

#### ErrorReceived

Fires an event when a WiFi error message is received.

### Properties

#### ForceSocketsTls

Boolean property that can be used to ensure a socket is opened as a secure TLS socket. For example, executing `wifi.ForceSocketsTls = true;` before `OpenSocket()` will cause the socket to be opened as a TLS Socket.

#### ForceSocketsTlsCommonName

String property used to specify the common name as found in the websites certificate. The common name is listed in the `Subject Alternative Name` field of the certificate.

#### State

Read only property of type `SPWF04SxWiFiState` that reflects the current state of the WiFi module. For example:

`if (wifi.State == SPWF04SxWiFiState.HardwareFailure) Debug.WriteLine("Hardware Failure");`

The possible states are: `HardwarePowerUp`, `HardwareFailure`, `RadioTerminatedByUser`, `RadioIdle`, `ScanInProgress`, `ScanComplete`, `JoinInProgress`, `Joined`, `AccessPointStarted`, `HandshakeComplete`, and `ReadyToTransmit`.
