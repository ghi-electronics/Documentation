# Downloads

---
![Download](images/downloads.png)

This page includes downloads for the Endpoint line of products.

Software status legend:

Status | Meaning
--- | ---
Production (RTW) | Ready to be used commercially (ready to wear).
Update | An update to a production release, still RTW.
Release Candidate (RC) | Could become a production release if proven solid.
Preview | Preview of the next release, not quite ready for production use.


### Endpoint OS Image

The Endpoint OS image can be downloaded and run from a microSD card or flashed to eMMC if the Endpoint hardware supports it. 

File | Date | Status | MD5
--- | --- | --- |
[v0.1.8.0 (Beta)](https://ghistorage.blob.core.windows.net/downloads/Endpoint/Firmware/endpoint_image_B0180.7.31.24.img) | 2024-8-21 | Preview | E3DA15BCAF8C51BD67C0B2B15DBB8F01
[v0.1.7.0 (Beta)](https://ghistorage.blob.core.windows.net/downloads/Endpoint/Firmware/endpoint_image_B0170.5.14.24.img) | 2024-5-14 | Preview | 8D5BF770027FA1C9FA5E7AFFBF603732

Endpoint OS image is large and that take time to update. For quick update/re-install firmware or dotnet, user can select update firmware or dotnet from Endpoint Config tool, and using the files below:

#### Firmware

File | Date | Status | MD5
--- | --- | --- |
[v0.1.8.0 (Beta)](https://ghistorage.blob.core.windows.net/downloads/Endpoint/Firmware/rootfs.ghi) | 2024-8-21 | Preview | 5C8ED398E4D9EF9A781AEBA4D0859868

#### Dotnet

File | Date | Status | MD5
--- | --- | --- |
[v8.0.100 (Beta)](https://ghistorage.blob.core.windows.net/downloads/Endpoint/Firmware/dotnet.ghi) | 2024-02-02 | Preview | E163B3E8EAF8A162D7871776684C1332

### Endpoint Config 

Endpoint Config is a tool used to update and configure your Endpoint device.

File | Date | Status | MD5
--- | --- | --- | 
[v0.1.8.0 (Beta)](https://ghistorage.blob.core.windows.net/downloads/Endpoint/Config/Endpoint_Config_Setup_v0.1.8.msi) | 2024-8-21 | Preview | D65F23D7570F6A39E6494B879824FCF1
[v0.1.7.0 (Beta)](https://ghistorage.blob.core.windows.net/downloads/Endpoint/Config/Endpoint_Config_Setup_v0.1.7.msi) | 2024-5-14 | Preview | 5C8728F4B669851854E16C09F4F1BA92
[v0.1.6.0 (Beta)](https://ghistorage.blob.core.windows.net/downloads/Endpoint/Config/Endpoint_Config_Setup_v0.1.6.msi) | 2024-4-22 | Preview | D0DDC758C3411378B9C7C29ACE13DFA8
[v0.1.3.0 (Beta)](https://ghistorage.blob.core.windows.net/downloads/Endpoint/Config/Endpoint_Config_Setup_v0.1.3.msi) | 2024-8-3 | Preview | 779763643D55D5F91C064C9DA9052D41
[v0.1.2.0 (Beta)](https://ghistorage.blob.core.windows.net/downloads/Endpoint/Config/Endpoint_Config_Setup_v0.1.2.msi) | 2024-21-02 | Preview | A372D2E3C5A5752D4CEBF819ED85086D
[v0.1.0.0 (Beta)](https://ghistorage.blob.core.windows.net/downloads/Endpoint/Config/Endpoint_Config_Setup_v0.1.0.0.msi) | 2024-02-02 | Preview | 8440E6358F46199B656F5F61CBF9B62B

## Endpoint Libraries

Endpoint Libraries are designed to fill in any gaps the .NET API is missing for hardware. It is preferred to access these libraries through NuGet.org by using the IDE's default package source.

> [!Note]
> Make sure to check the `Include prerelease` box in Visual Studio's NuGet package manager if you're not using the production release.

File | Date | Status | MD5
--- | --- | --- | 
[v0.1.7.0 (Beta)](https://ghistorage.blob.core.windows.net/downloads/Endpoint/Libraries/GHIElectronics.Endpoint.Libraries_v0.1.7.0.zip) | 2024-5-14 | Preview | 663E01082E712EDE235CC299C07C7465
[v0.1.6.0 (Beta)](https://ghistorage.blob.core.windows.net/downloads/Endpoint/Libraries/GHIElectronics.Endpoint.Libraries_v0.1.6.0.zip) | 2024-4-22 | Preview | B022A7CEFAAF5B16077F0800DFC98461
[v0.1.4.0 (Beta)](https://ghistorage.blob.core.windows.net/downloads/Endpoint/Libraries/GHIElectronics.Endpoint.Libraries_v0.1.4.0.zip) | 2024-4-5 | Preview | F9145F97F1F6E6723830617F3E45D690
[v0.1.3.0 (Beta)](https://ghistorage.blob.core.windows.net/downloads/Endpoint/Libraries/endpoint_libraries_v0.1.3.0.zip) | 2024-8-3 | Preview | E59F145C850D748C61ACB4CEF2179961
[v0.1.2.0 (Beta)](https://ghistorage.blob.core.windows.net/downloads/Endpoint/Libraries/endpoint_libraries_v0.1.2.0.zip) | 2024-21-02 | Preview | 5B2077ABB3AC31B024179FD2B0654F0D
[v0.1.0.0 (Beta)](https://ghistorage.blob.core.windows.net/downloads/Endpoint/Libraries/endpoint_libraries_v0.1.0.0.zip) | 2024-02-02 | Preview | 708833FEFCE57C51F9CE01DA47EF0541



## Visual Studio & VS Code extension files

The extension is what gets loaded on Visual Studio/VS Code to allow it to communicate with an Endpoint device. It also includes project templates.

#### Visual Studio 2022

The Endpoint Debugger for Visual Studio can be installed from within in Visual Studio. It can also be downloaded at the [Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=ghielectronics.Endpoint-VS-Debugger)

#### VS Code

The Endpoint Debugger for VS Code can be installed from within in VS Code. It can also be downloaded at the [VS Code Marketplace](https://marketplace.visualstudio.com/items?itemName=ghielectronics.endpointvscnet)
The Endpoint Debugger for Python can be installed from within in VS Code. It can also be downloaded at the [VS Code Marketplace](https://marketplace.visualstudio.com/items?itemName=ghielectronics.endpointvscpy)



