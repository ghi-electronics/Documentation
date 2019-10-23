# Getting Started
---
![Getting Started](images/getting-started-noborder.jpg)

This page explains how to set up the TinyCLR programming environment.  It covers device and computer setup and deployment of a "hello world" program.
> [!Tip]
> If you're an existing user of NETMF and still want to use it in addition to TinyCLR OS, don't worry. TinyCLR is completely independent of NETMF and works side-by-side with no issues.

## TinyCLR Device Setup
To use TinyCLR with a device you must first install the latest versions of the GHI bootloader and TinyCLR firmware on the device.  The bootloader is installed first and provides a way to install the firmware and to execute programs which are uploaded to the device.

The TinyCLR firmware includes the Common Language Runtime (CLR) which converts compiled code into machine instructions and manages program execution.  The TinyCLR firmware is also responsible for interacting with Microsoft Visual Studio to load and debug your application programs.

Instructions for installing the bootloader and firmware are provided on the documentation page for each device.  If you want to use your own device, visit our [porting guide](native/porting.md) for information on how to get started.

## TinyCLR Computer Setup
### Download and Install Visual Studio and the TinyCLR Extension
1. If you don't already have Visual Studio 2017, download and install the free version from here:  [Visual Studio Community 2017](https://www.visualstudio.com/downloads/).
2. Make sure to select the `.NET desktop development` workload when installing Visual Studio.
3. Download and install the newest TinyCLR Visual Studio Project System by going to `Tools` > `Extensions and Updates...`. In the `Extensions and Updates` dialog box select `Online` in the left panel. Type `tinyclr` into the `Search` text box in the upper right of the window to search for and install the `TinyCLR OS Project System`. You'll need to restart Visual Studio to let the extension installer complete the installation.
    ![Install TinyCLR Extension](images/install-tinyclr-extension.gif)

    You can also find the [TinyCLR OS Project System](downloads.md#visual-studio-project-system) on our [Downloads](downloads.md) page if you want to download the file and install it from your hard drive.

### Install the TinyCLR Nuget Packages

1. Connect your device to your PC using a USB cable (make sure your device has the latest firmware installed).
2. Start Visual Studio and create a new `TinyCLR Application` under `C# > TinyCLR`. New to Visual Studio or C#? Take a look at the [getting started guide from Microsoft](https://docs.microsoft.com/en-us/dotnet/csharp/getting-started/with-visual-studio).
3. Right click on your Project in the Solution Explorer panel and select `Manage NuGet Packages`.  If the Solution Explorer window is not visible, open it by selecting `Solution Explorer` in the `View` menu. You can also select `Manage NuGet Packages...` in the `Project` menu of Visual Studio.
![View Show Solution Explorer](images/select-manage-nuget-packages.gif)

4. Make sure the package source is set to "Package source" or "All."
![Set package source](images/package-source.png)

5. In the search box type "tinyclr"
![Search for TinyCLR](images/search-for-tinyclr.png)

6. Selecting the `Browse` tab will show all the TinyCLR NuGet packages. Those installed are noted with a green down arrow in front of the name. 
![Browse NuGet Feed](images/browse-nuget-feed.gif)

7. To install one of the packages click on the down arrow to the right of the package version.
![Add Nuget Package](images/add-nuget-package.gif)

You can also select the package and click on the `Install` button in the center panel.
![Nuget-package-install-button](images/nuget-install-button.gif)

8. Click `OK` to accept the proposed changes.
![Accept changes](images/accept-changes.gif)

9. Accept the licensing agreement to install the package.
![Accept Agreement for NuGet](images/accept-agreement-for-nuget.gif)

And, that's it! You're now ready to start programming using TinyCLR OS.

## Starting a New Project

Let's make a "hello world" program and deploy it on the FEZ Cobra III.

Open Visual Studio and select `File > New > Project`. 

There should be a `TinyCLR` option under `Visual C#`.  Click on `TinyCLR` in the left panel, and `TinyCLR Application` in the center panel.  Name the project and hit the `OK` button to create a new project. 

![New TinyCLR Project](images/new-project.png)

The project will have a single C# file named `Program.cs` whose contents are shown below.

![Program.cs](images/program-cs.png)

C# source files are listed in the `Solution Explorer` window.  If the `Solution Explorer` window is not visible, click on `View > Solution Explorer` to open it.

![Solution Explorer](images/solution-explorer.png)

If you right click on the project name in the Solution Explorer window, a drop down menu will appear.  Select `Manage NuGet Packages...` from the menu.

![View Show Solution Explorer](images/manage-nuget-packages-menu.png) 

Now you should see the installed TinyCLR NuGet library (GHIElectronics.TinyCLR.Core).  This is the only library we will need for our "hello world" program.

![Installed NuGet](images/installed-nuget.png)

Close the `NuGet...` tab or click on the `Program.cs` tab to edit the source code.  Change the contents as shown below.

![Hello World Program](images/hello-world-program.png)

Make sure your device is plugged into the computer's USB port.  Now hit the start button as shown on the above image (or hit the `F5` key).  If you've done everything correctly the program will compile and deploy to your device.  The message "Hello World!" should appear in the output window as shown below.

![Output Window](images/output-window.png)

Congratulations!  You're on your way to becoming a TinyCLR embedded developer!


***

To learn more about TinyCLR embedded programming check out our [**tutorials**](tutorials/intro.md).

You can also visit our main website at [**www.ghielectronics.com**](http://www.ghielectronics.com) and our community forums at [**forums.ghielectronics.com**](https://forums.ghielectronics.com/).