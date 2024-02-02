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
[v0.0.1.0.0 (Beta)](https://ghistorage.blob.core.windows.net/downloads/Endpoint/Firmware/endpoint_image_5.13.0Feb12024.img) | 2024-02-02 | Preview | 1539CB1D959376BF2588EE416E62C625

Endpoint OS image is large and that take time to update. For quick update/re-install firmware or dotnet, user can select update firmware or dotnet from Endpoint Config tool, and using the files below:

#### Firmware

File | Date | Status | MD5
--- | --- | --- |
[v0.0.1.0.0 (Beta)](https://ghistorage.blob.core.windows.net/downloads/Endpoint/Firmware/rootfs.ghi) | 2024-02-02 | Preview | C4AA6D761FA8AA7A24B1406A9A9A5523

#### Dotnet

File | Date | Status | MD5
--- | --- | --- |
[v0.0.1.0.0 (Beta)](https://ghistorage.blob.core.windows.net/downloads/Endpoint/Firmware/dotnet.ghi) | 2024-02-02 | Preview | E163B3E8EAF8A162D7871776684C1332

### Endpoint Config 

Endpoint Config is a tool used to update and configure your Endpoint device.

File | Date | Status | MD5
--- | --- | --- | 
[v0.1.0.0 (Beta)](https://ghistorage.blob.core.windows.net/downloads/Endpoint/Config/Endpoint_Config_Setup_v0.1.0.0.msi) | 2024-02-02 | Preview | 8440E6358F46199B656F5F61CBF9B62B

## Endpoint Libraries

Endpoint Libraries are designed to fill in any gaps the .NET API is missing for hardware. It is preferred to access these libraries through NuGet.org by using the IDE's default package source.

> [!Note]
> Make sure to check the `Include prerelease` box in Visual Studio's NuGet package manager if you're not using the production release.

File | Date | Status | MD5
--- | --- | --- | 
[v0.1.0.0 (Beta)](https://ghistorage.blob.core.windows.net/downloads/Endpoint/Libraries/endpoint_libraries_v0.1.0.0.zip) | 2024-02-02 | Preview | 708833FEFCE57C51F9CE01DA47EF0541



## Visual Studio & VS Code extension files

The extension is what gets loaded on Visual Studio/VS Code to allow it to communicate with an Endpoint device. It also includes project templates.

#### Visual Studio 2022

The Endpoint Debugger for Visual Studio can be installed from within in Visual Studio. It can also be downloaded at the [Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=ghielectronics.Endpoint-VS-Debugger)

#### VS Code

The Endpoint Debugger for VS Code can be installed from within in VS Code. It can also be downloaded at the [VS Code Marketplace](https://marketplace.visualstudio.com/items?itemName=ghielectronics.endpointvscnet)



