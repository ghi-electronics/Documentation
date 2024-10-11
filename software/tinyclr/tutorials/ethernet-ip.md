# EtherNet/IP
---

EtherNet/IP is an industerial communication protocol. It has two modes, an Adaptor, which is typically the PLC. The other mode is Scanner, usually used on the modules controlled by the PLC.


>[!NOTE]
>This is an experimental feature and it is subject to major changes or removal.

## Scanner device

>[!TIP]
>Needed NuGets: GHIElectronics.TinyCLR.EthernetIP.Scanner

### List Identity

The examples assume [NetworkController](networking-core.md) is already enabled.

```cs
var eipClient = new ScannerController();

var devices = eipClient.ListIdentity(networkcontroller, TimeSpan.FromSeconds(5));

if (devices != null)
{
    for (int i = 0; i < devices.Length; i++)
    {

        Debug.WriteLine("Ethernet/IP Device Found:");
        Debug.WriteLine(devices[i].ProductName1);
        Debug.WriteLine("IP-Address: " + Encapsulation.CIPIdentityItem.GetIPAddress(devices[i].SocketAddress.SIN_Address));
        Debug.WriteLine("Port: " + devices[i].SocketAddress.SIN_port);
        Debug.WriteLine("Vendor ID: " + devices[i].VendorID1);
        Debug.WriteLine("Product-code: " + devices[i].ProductCode1);
        Debug.WriteLine("Type-Code: " + devices[i].ItemTypeCode);
        Debug.WriteLine("Serial Number: " + devices[i].SerialNumber1);
    }
}
else
{
    Debug.WriteLine("No device found");
}

```

### Explicit Message

```cs
var classId = 0x04;
var atributeId = 0x03;

var eipClient = new ScannerController();
eipClient.IPAddress = "xx.xx.xx.xx"; // address to send

eipClient.RegisterSession();
var cnt = 0;
// Read and write 10 times
while (cnt++ < 10)
{
	byte[] responses = eipClient.GetAttributeSingle(classId, DEMO_APP_EXPLICT_ASSEMBLY_NUM, atributeId);
	var response_str = string.Empty;
	foreach (byte response in responses)
	{
		response_str += response.ToString() + ", ";

	}
	Debug.WriteLine("AttributeSingle: " + response_str);

	var sendData = new byte[responses.Length];

	for (var i = 0; i < sendData.Length; i++)
	{
		sendData[i] = (byte)(responses[i] + 1);
	}

	eipClient.SetAttributeSingle(classId, DEMO_APP_EXPLICT_ASSEMBLY_NUM, atributeId, sendData);

	Thread.Sleep(1000);
}

eipClient.UnRegisterSession();
```

### Implicit Message

```cs

var eeipClient = new ScannerController();
eeipClient.IPAddress = "xxx.xxx.xxx.xxx"; // Address to send

eeipClient.RegisterSession();   
eeipClient.ForwardOpen();

eeipClient.O_T_InstanceID = DEMO_APP_OUTPUT_ASSEMBLY_NUM;              
eeipClient.O_T_IOData = new byte[O_T_IODataSize];                     
eeipClient.O_T_RealTimeFormat = RealTimeFormat.Header32Bit;
eeipClient.O_T_OwnerRedundant = false;
eeipClient.O_T_Priority = Priority.Scheduled;
eeipClient.O_T_VariableLength = false;
eeipClient.O_T_ConnectionType = ConnectionType.Point_to_Point;
eeipClient.RequestedPacketRate_O_T = 500000;        
    
eeipClient.T_O_InstanceID = DEMO_APP_INPUT_ASSEMBLY_NUM;
eeipClient.T_O_IOData = new byte[T_O_IODataSize];
eeipClient.T_O_RealTimeFormat = RealTimeFormat.ZeroLength;
eeipClient.T_O_OwnerRedundant = false;
eeipClient.T_O_Priority = Priority.Scheduled;
eeipClient.T_O_VariableLength = false;
eeipClient.T_O_ConnectionType = ConnectionType.Point_to_Point;
eeipClient.RequestedPacketRate_T_O = 500000;    

eeipClient.ConfigurationAssemblyInstanceID = DEMO_APP_CONFIG_ASSEMBLY_NUM; 
// If user want to write config, init ConfigurationAssembly_Data array
// Otherwise, keep this config null
//eeipClient.ConfigurationAssembly_Data = new byte[Config_DataSize] { 1, 2, 3, 4, 5, 6, 7, 8 };// write config

var counter = 0;
var t_o_data = -1;

while (counter < 10)
{                    
    // Write O_T
    for (var i = 0; i < eeipClient.O_T_IOData.Length; i++)
    {            
        eeipClient.O_T_IOData[i] = (byte)(counter);   
    }

    // read T_O
    var response_str = string.Empty;
    for (var i = 0; i < eeipClient.T_O_IOData.Length; i++)
    {
        response_str += eeipClient.T_O_IOData[i].ToString() + ", ";
    }

    Debug.WriteLine(response_str);

    Thread.Sleep(1000);

    counter++;
}

eeipClient.ForwardClose();
eeipClient.UnRegisterSession();
```

---

## Adapter device

The example below create a basic adapter device.

>[!TIP]
>Needed NuGets: GHIElectronics.TinyCLR.EthernetIP.Adapter

```cs
public static void DoInitAdapter()
{
    string deviceName = "GHI Adapter";
	uint deviceVendorID = 3;
	ushort deviceType = 12;
	ushort deviceProductCode = 65001;
	uint deviceSerialNumber = 87654321;
	byte deviceMajorRevision = 4;
	byte deviceMinorRevision = 3;
	
	var adapter = new AdapterController(deviceName, deviceVendorID, deviceType, deviceProductCode, deviceSerialNumber, deviceMajorRevision, deviceMinorRevision);

    adapter.EnableHeaderO2T(true); // enable O2T 32bit header
	
	int numberClassAttributes = 0 ;
	uint highestClassAttributeNumber = 7;
	int numberClassServices = 1;
	int numberInstanceAttributes = 2;
	uint highestInstanceAttributeNumber = 4;
	int numberInstanceServices = 2;
	uint numberInstances = 0;
	string name = "assembly";
	ushort revision = 2;

    adapter.CreateAssemblyClass(numberClassAttributes, highestClassAttributeNumber, numberClassServices, numberInstanceAttributes, highestInstanceAttributeNumber,  numberInstanceServices, numberInstances, name, revision);

    MessageRouterInit(adapter);
    IdentityInit(adapter);
    ConnectionManagerInit(adapter);
	

    var g_assembly_t_o = new byte[T_O_IODataSize]; 
    var g_assembly_o_t = new byte[O_T_IODataSize]; 
    var g_assembly_cfg = new byte[Config_DataSize]; 
    var g_assembly_explicit = new byte[ExplicitMessage_DataSize]; 

    var input_asm = new AssemblyObject(DEMO_APP_INPUT_ASSEMBLY_NUM, g_assembly_t_o, (ushort)g_assembly_t_o.Length);
    var output_asm = new AssemblyObject(DEMO_APP_OUTPUT_ASSEMBLY_NUM, g_assembly_o_t, (ushort)g_assembly_o_t.Length);
    var config_asm = new AssemblyObject(DEMO_APP_CONFIG_ASSEMBLY_NUM, g_assembly_cfg, (ushort)g_assembly_cfg.Length);
    var heartbeat_input_asm = new AssemblyObject(DEMO_APP_HEARTBEAT_INPUT_ONLY_ASSEMBLY_NUM, null, 0);
    var heartbeat_output_asm = new AssemblyObject(DEMO_APP_HEARTBEAT_LISTEN_ONLY_ASSEMBLY_NUM, null, 0);
    var explicit_asm = new AssemblyObject(DEMO_APP_EXPLICT_ASSEMBLY_NUM, g_assembly_explicit, (ushort)g_assembly_explicit.Length);

    adapter.AddAssemblyObject(input_asm);
    adapter.AddAssemblyObject(output_asm);
    adapter.AddAssemblyObject(config_asm);
    adapter.AddAssemblyObject(heartbeat_input_asm);
    adapter.AddAssemblyObject(heartbeat_output_asm);
    adapter.AddAssemblyObject(explicit_asm);

    adapter.ConfigureExclusiveOwnerConnectionPoint(0, DEMO_APP_OUTPUT_ASSEMBLY_NUM, DEMO_APP_INPUT_ASSEMBLY_NUM, DEMO_APP_CONFIG_ASSEMBLY_NUM);
    adapter.ConfigureInputOnlyConnectionPoint(0, DEMO_APP_HEARTBEAT_INPUT_ONLY_ASSEMBLY_NUM, DEMO_APP_INPUT_ASSEMBLY_NUM, DEMO_APP_CONFIG_ASSEMBLY_NUM);
    adapter.ConfigureListenOnlyConnectionPoint(0, DEMO_APP_HEARTBEAT_LISTEN_ONLY_ASSEMBLY_NUM, DEMO_APP_INPUT_ASSEMBLY_NUM, DEMO_APP_CONFIG_ASSEMBLY_NUM);


    adapter.RegisterSessionDetected += Adapter_RegisterSessionDetected;
    adapter.UnregisterSessionDetected += Adapter_UnregisterSessionDetected;

    adapter.ForwardOpenDetected += Adapter_ForwardOpenDetected;
    adapter.ForwardCloseDetected += Adapter_ForwardCloseDetected;

    adapter.Enable();
	
	Thread.sleep(-1);
}
```

```cs
// Implement Identity
static void IdentityInit(AdapterController adapter)
{
    // Init Identity with:
    int numberClassAttributes = 0;
    uint highestClassAttributeNumber=7;
    int numberClassServices=2;
    int numberInstanceAttributes= 7;
    uint highestInstanceAttributeNumber = 7;
    int numberInstanceServices = 5;
    uint numberInstances = 1;
    string name = "identity";
    ushort revision = 1;
	
    var identityClass = new CIPClass(AdapterController.ClassId.Identity, numberClassAttributes, highestClassAttributeNumber, numberClassServices, numberInstanceAttributes, highestInstanceAttributeNumber, numberInstanceServices, numberInstances, name, revision);

    adapter.AddCipClass(identityClass);

    var cipInstance = adapter.GetCipInstance(identityClass, 1);

    var vendorId = new byte[] { 12, 0 };
    var deviceType = new byte[] { 34, 0 };
    var productCode = new byte[] { 56, 0 };
    var revision = new byte[] { 78, 87 };
    var status = new byte[] { 90, 0 };
    var serial = new byte[] { 11, 00, 00, 00 };
    var productName = UTF8Encoding.UTF8.GetBytes("GHI custom");

    adapter.InsertAttribute(cipInstance, 1, AdapterController.CIPDataType.kCipUint, AdapterController.CipAttributeEncodeInMessage.EncodeCipUint, AdapterController.CipAttributeDecodeFromMessage.None, vendorId, AdapterController.CIPAttributeFlag.kGetableSingleAndAll);
    adapter.InsertAttribute(cipInstance, 2, AdapterController.CIPDataType.kCipUint, AdapterController.CipAttributeEncodeInMessage.EncodeCipUint, AdapterController.CipAttributeDecodeFromMessage.None, deviceType, AdapterController.CIPAttributeFlag.kGetableSingleAndAll);
    adapter.InsertAttribute(cipInstance, 3, AdapterController.CIPDataType.kCipUint, AdapterController.CipAttributeEncodeInMessage.EncodeCipUint, AdapterController.CipAttributeDecodeFromMessage.None, productCode, AdapterController.CIPAttributeFlag.kGetableSingleAndAll);
    adapter.InsertAttribute(cipInstance, 4, AdapterController.CIPDataType.kCipUsintUsint, AdapterController.CipAttributeEncodeInMessage.EncodeCipUint, AdapterController.CipAttributeDecodeFromMessage.None, revision, AdapterController.CIPAttributeFlag.kGetableSingleAndAll);
    adapter.InsertAttribute(cipInstance, 5, AdapterController.CIPDataType.kCipUint, AdapterController.CipAttributeEncodeInMessage.EncodeCipUint, AdapterController.CipAttributeDecodeFromMessage.None, status, AdapterController.CIPAttributeFlag.kGetableSingleAndAll);
    adapter.InsertAttribute(cipInstance, 6, AdapterController.CIPDataType.kCipUdint, AdapterController.CipAttributeEncodeInMessage.EncodeCipUdint, AdapterController.CipAttributeDecodeFromMessage.None, serial, AdapterController.CIPAttributeFlag.kGetableSingleAndAll);
    adapter.InsertAttribute(cipInstance, 7, AdapterController.CIPDataType.kCipShortString, AdapterController.CipAttributeEncodeInMessage.EncodeCipShortString, AdapterController.CipAttributeDecodeFromMessage.None, productName, AdapterController.CIPAttributeFlag.kGetableSingleAndAll);

    adapter.InsertService(identityClass, AdapterController.CIPServiceCode.kGetAttributeSingle, AdapterController.CipServiceFunctionCode.kGetAttributeSingle, "GetAttributeSingle");
    adapter.InsertService(identityClass, AdapterController.CIPServiceCode.kGetAttributeAll, AdapterController.CipServiceFunctionCode.kGetAttributeAll, "GetAttributeAll");
    adapter.InsertService(identityClass, AdapterController.CIPServiceCode.kReset, AdapterController.CipServiceFunctionCode.kReset, "Reset");
    adapter.InsertService(identityClass, AdapterController.CIPServiceCode.kGetAttributeList, AdapterController.CipServiceFunctionCode.kGetAttributeList, "GetAttributeList");
    adapter.InsertService(identityClass, AdapterController.CIPServiceCode.kSetAttributeList, AdapterController.CipServiceFunctionCode.kSetAttributeList, "SetAttributeList");
}
```

```cs
// Implement MessageRouter
static void MessageRouterInit(AdapterController adapter)
{
    // Init message router with:
    int numberClassAttributes = 7;
    uint highestClassAttributeNumber=7;
    int numberClassServices=2;
    int numberInstanceAttributes= 0;
    uint highestInstanceAttributeNumber = 0;
    int numberInstanceServices = 1;
    uint numberInstances = 1;
    string name = "message router";
    ushort revision = 1;
		
    var messageRouterClass = new CIPClass(AdapterController.ClassId.MessageRouter, numberClassAttributes, highestClassAttributeNumber, numberClassServices, numberInstanceAttributes, highestInstanceAttributeNumber, numberInstanceServices, numberInstances, name, revision);
    adapter.AddCipClass(messageRouterClass);
    adapter.InsertService(messageRouterClass, AdapterController.CIPServiceCode.kGetAttributeSingle, AdapterController.CipServiceFunctionCode.kGetAttributeSingle, "GetAttributeSingle");
}
```

```cs
// Implement ConnectionManager
static void ConnectionManagerInit(AdapterController adapter)
{
    int numberClassAttributes = 0;
    uint highestClassAttributeNumber=7;
    int numberClassServices=2;
    int numberInstanceAttributes= 0;
    uint highestInstanceAttributeNumber = 14;
    int numberInstanceServices = 8;
    uint numberInstances = 1;
    string name = "connection manager";
    ushort revision = 1;
	
    var connectionManagerClass = new CIPClass(AdapterController.ClassId.ConnectionManager, numberClassAttributes, highestClassAttributeNumber, numberClassServices, numberInstanceAttributes, highestInstanceAttributeNumber, numberInstanceServices, numberInstances, name, revision);

    adapter.AddCipClass(connectionManagerClass);
    var cipInstance = adapter.GetCipInstance(connectionManagerClass, 1);

    adapter.InsertService(connectionManagerClass, AdapterController.CIPServiceCode.kGetAttributeSingle, AdapterController.CipServiceFunctionCode.kGetAttributeSingle, "GetAttributeSingle");
    adapter.InsertService(connectionManagerClass, AdapterController.CIPServiceCode.kGetAttributeAll, AdapterController.CipServiceFunctionCode.kGetAttributeAll, "GetAttributeAll");

    adapter.InsertService(connectionManagerClass, AdapterController.CIPServiceCode.kForwardOpen, AdapterController.CipServiceFunctionCode.kForwardOpen, "ForwardOpen");
    adapter.InsertService(connectionManagerClass, AdapterController.CIPServiceCode.kLargeForwardOpen, AdapterController.CipServiceFunctionCode.kLargeForwardOpen, "LargeForwardOpen");
    adapter.InsertService(connectionManagerClass, AdapterController.CIPServiceCode.kForwardClose, AdapterController.CipServiceFunctionCode.kForwardClose, "ForwardClose");

    adapter.InsertService(connectionManagerClass, AdapterController.CIPServiceCode.kGetConnectionOwner, AdapterController.CipServiceFunctionCode.kGetConnectionOwner, "GetConnectionOwner");
    adapter.InsertService(connectionManagerClass, AdapterController.CIPServiceCode.kGetConnectionData, AdapterController.CipServiceFunctionCode.kGetConnectionData, "GetConnectionData");
    adapter.InsertService(connectionManagerClass, AdapterController.CIPServiceCode.kSearchConnectionData, AdapterController.CipServiceFunctionCode.kSearchConnectionData, "SearchConnectionData");
}
```

These variables below are shared between Scanner and Addapter device so Scanner know where messages send to / read from

```cs
public const byte DEMO_APP_INPUT_ASSEMBLY_NUM = 100;
public const byte DEMO_APP_OUTPUT_ASSEMBLY_NUM = 150;
public const byte DEMO_APP_CONFIG_ASSEMBLY_NUM = 151;
public const byte DEMO_APP_HEARTBEAT_INPUT_ONLY_ASSEMBLY_NUM = 152;
public const byte DEMO_APP_HEARTBEAT_LISTEN_ONLY_ASSEMBLY_NUM = 153;
public const byte DEMO_APP_EXPLICT_ASSEMBLY_NUM = 154;

public const ushort O_T_IODataSize = 8;
public const ushort T_O_IODataSize = 8;
public const ushort Config_DataSize = 8;
public const ushort ExplicitMessage_DataSize = 8;
```

### Event Handler

```cs

adapter.RegisterSessionDetected += Adapter_RegisterSessionDetected;
adapter.UnregisterSessionDetected += Adapter_UnregisterSessionDetected;
adapter.ForwardOpenDetected += Adapter_ForwardOpenDetected;
adapter.ForwardCloseDetected += Adapter_ForwardCloseDetected;

adapter.ReceivedExplictTcpData += Adapter_EventReceivedExplictTcpDataHandler;
adapter.ReceivedExplictUdpData += Adapter_EventReceivedExplictUdpDataHandler;
adapter.NotifyClass += Adapter_EventNotifyClassHandler;
adapter.AfterAssemblyDataReceived += Adapter_EventAssemblyConnectedDataReceivedHandler;
adapter.BeforeAssemblyDataSend += Adapter_BeforeAssemblyDataSend;

```

```cs
private static void Adapter_ForwardCloseDetected(AdapterController adapter, System.Net.IPAddress ipAdrress)
{

    Debug.WriteLine("ForwardClosed from IP: " + ipAdrress.ToString());
}

private static void Adapter_ForwardOpenDetected(AdapterController adapter, System.Net.IPAddress ipAdrress, bool large)
{
    Debug.WriteLine("ForwardOpen from IP: " + ipAdrress.ToString() + ", Large: " + large.ToString());
}

private static void Adapter_UnregisterSessionDetected(AdapterController adapter, System.Net.IPAddress ipAdrress)
{
    Debug.WriteLine("UnregisterSession from IP: " + ipAdrress.ToString());
}

private static void Adapter_RegisterSessionDetected(AdapterController adapter, System.Net.IPAddress ipAdrress)
{
    Debug.WriteLine("RegisterSession from IP: " + ipAdrress.ToString());
}

private static void Adapter_BeforeAssemblyDataSend(AdapterController adapter, ushort instanceNumbber)
{
    Debug.WriteLine("Before => instanceNumbber = " + instanceNumbber);
}
private static void Adapter_EventAssemblyConnectedDataReceivedHandler(AdapterController adapter, ushort instanceNumbber)
{
    Debug.WriteLine("After => instanceNumbber = " + instanceNumbber);

}

private static void Adapter_EventNotifyClassHandler(AdapterController adapter, uint classCode, ushort instanceNumbber, ushort attributeNumber, IPAddress ipAdrress)
{
    Debug.WriteLine("NotifyClass :  classCode = " + classCode);
    Debug.WriteLine("               instanceNumbber = " + instanceNumbber);
    Debug.WriteLine("               attributeNumber = " + attributeNumber);
    Debug.WriteLine("               ipAdrress = " + ipAdrress.ToString());
}

private static void Adapter_EventReceivedExplictUdpDataHandler(AdapterController adapter, ushort commandCode, IPAddress ipAdrress, bool unicast)
{
    Debug.WriteLine("udp:   commandCode = " + commandCode);
    Debug.WriteLine("       address = " + ipAdrress.ToString());
    Debug.WriteLine("       unicast = " + unicast);
}

private static void Adapter_EventReceivedExplictTcpDataHandler(AdapterController adapter, ushort commandCode, IPAddress address)
{
    Debug.WriteLine("tcp: commandCode = " + commandCode);
    Debug.WriteLine("     address = " + address.ToString());
}
```