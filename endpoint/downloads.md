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

File | Date | Status 
--- | --- | --- |
[v0.0.1.0.0 (Beta)](https://ghistorage.blob.core.windows.net/downloads/Endpoint/Firmware/sdcard.img) | 2024-01-24 | Preview 


### Endpoint Config 

Endpoint Config is a tool used to update and configure your Endpoint device.

File | Date | Status 
--- | --- | --- | 
[v0.1.0.0 (Beta)](https://ghistorage.blob.core.windows.net/downloads/Endpoint/Config/Endpoint_Config_Setup_v0.1.0.0.msi) | 2024-01-24 | Preview 

## Endpoint Libraries

Endpoint Libraries are designed to fill in any gaps the .NET API is missing for hardware. It is preferred to access these libraries through NuGet.org by using the IDE's default package source.

> [!Note]
> Make sure to check the `Include prerelease` box in Visual Studio's NuGet package manager if you're not using the production release.

The libraries are available on [Github](https://github.com/ghi-electronics/Endpoint-Libraries).


## Visual Studio & VS Code extension files

The extension is what gets loaded on Visual Studio/VS Code to allow it to communicate with an Endpoint device. It also includes project templates.

#### Visual Studio 2022

The Endpoint Debugger for Visual Studio can be installed from within in Visual Studio. It can also be downloaded at the [Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=ghielectronics.Endpoint-VS-Debugger)

#### VS Code

The Endpoint Debugger for VS Code can be installed from within in VS Code. It can also be downloaded at the [VS Code Marketplace](https://marketplace.visualstudio.com/vscode)



