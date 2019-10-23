# Files
---
The file system features in NETMF are very similar to full .NET. There are no limits on file counts or sizes other than the limits of the FAT file system itself. NETMF supports FAT16 and FAT32.  

With a few minor changes, NETMF file system access can be tested from within the Microsoft NETMF emulator. Changes include removing any of the GHI library dependencies.

Unlike full .NET, NETMF does require mounting of media. NETMF also handles media names differently than full .NET. Media name differences are easily handled by accessing the root directory name at runtime and then using that name. Consequently, most online examples of how to use .NET to access files on PCs can be used with NETMF. In NETMF, other than differences for specific physical characteristics, usage of SD/MMC cards and USB memory devices are identical to .NET.

This document splits it's examples into two sets. One for SD/MMC Card file system access and the other for USB Mass Storage. The core file operations (open, read, write, etc.) are identical between the two.

> [!Warning]
> The file system does a lot of data buffering internally to speed up file access time and to increase the life of flash media. When you write data to a file, it is often saved somewhere in internal buffers rather than being written immediately to the media. To make sure the data is stored on the media, you need to flush the data.

> Flushing (or closing) a file is the only way to guarantee that the data you are trying to write is on the actual media. In addition to the file data  there is other  information, such as directory information, that may not be written to the media when the file is flushed. For example, if you delete a file and remove the card from the system, the file is probably not actually erased because the directory structure was not flushed.

> Under current versions of .NET Micro Framework, there can be a variable time delay before the buffers are actually written to the media when using the FileStream's Flush method. This delay can reportedly be as long as a minute (see: https://netmf.codeplex.com/workitem/2149). To guarantee that the file buffers and the meta-data are written to the media you need to flush the volume:
>
> * `VolumeInfo.GetVolumes()[0].FlushAll()` -or-
> * `Microsoft.SPOT.IO.VolumeInfo("\SD").FlushAll()`.
>
> Ideally, you would unmount the media before it is removed from the system. This may not be always possible -- FlushAll will guarantee your data is saved

> [!Tip]
> The SD/MMC Card  examples shown below require the GHI.Hardware, Microsoft.SPOT.IO, and System.IO assemblies.

Some Microsoft documentation class descriptions, such as for Directory, place the library code in the mscorlib assembly; however, it is found in the System.IO assembly.

## SD Card: Show Files in Root Directory

This example assumes the card is already inserted; it lists all files available in the root directory.

> [!Note]
> Some SD card sockets/interfaces have an internal switch that closes when a card is inserted or ejected. Utilizing the switch is shown in the "[**SD Card: Media Detection**](#sd-card-media-detection)" example further down on this page.

```cs
using System.IO;
using Microsoft.SPOT;
using Microsoft.SPOT.Hardware;
using Microsoft.SPOT.IO;

using GHI.IO;
using GHI.IO.Storage;

class Program {
    public static void Main() {
        // ...
        // assume SD card is inserted
        // Create a new storage device
        // NETMF only allows one SD card
        // to be supported at a time.

        SDCard sd_card = new SDCard();

        // this is a non-blocking call 
        // it fires the RemovableMedia.Insert event after 
        // the mount is finished. 
        sd_card.Mount();

        // for some cases, a simple sleep might suffice
        // This example just waits on the event before proceeding
        // (After first time firing of the event, you may want
        // to disable the handler or re-assign it
        bool fs_ready = false;
        RemovableMedia.Insert += (a, b) => {
            fs_ready = true;
        };

        while (! fs_ready) {
            System.Threading.Thread.Sleep(50);
        }

        // Assume one storage device is available, access it through 
        // NETMF and display the available files and folders:
        Debug.Print("Getting files and folders:");
        if (VolumeInfo.GetVolumes()[0].IsFormatted) {
            string rootDirectory = VolumeInfo.GetVolumes()[0].RootDirectory;
            string[] files = Directory.GetFiles(rootDirectory);
            string[] folders = Directory.GetDirectories(rootDirectory);

            Debug.Print("Files available on " + rootDirectory + ":");
            for (int i = 0; i < files.Length; i++)
                Debug.Print(files[i]);

            Debug.Print("Folders available on " + rootDirectory + ":");
            for (int i = 0; i < folders.Length; i++)
                Debug.Print(folders[i]);
        }
        else {
            Debug.Print("Storage is not formatted. " +
                "Format on PC with FAT32/FAT16 first!");
        }
        // Unmount when done
        sd_card.Unmount();
    }
}
```

## SD Card: Writing Files

There is more than one way to open files. I will only cover FileStream objects. This example will open a file and write a string to it. Since FileStream will only take byte arrays, we need to convert our string to a byte array.
```
using System.Threading;
using System.Text;
using Microsoft.SPOT;
using System.IO;
using Microsoft.SPOT.IO;
using GHI.IO.Storage;

public class Program {
    static void Main() {
        // if necessary, check that SD is present here...

        SDCard sd_card = new SDCard();
 
        sd_card.Mount();
        bool fs_ready = false;
        RemovableMedia.Insert += (a, b) => {
            fs_ready = true;
        };

        while (! fs_ready ) {
            System.Threading.Thread.Sleep(1);
        }

        // Assume only one storage device is available
        // and that the media is formatted
        string rootDirectory = VolumeInfo.GetVolumes()[0].RootDirectory;
        FileStream FileHandle = new FileStream(rootDirectory +
                                      @"\hello.txt", FileMode.Create);
        byte[] data =
           Encoding.UTF8.GetBytes("This string will go in the file!");
        FileHandle.Write(data, 0, data.Length);
        FileHandle.Close();

        sd_card.Unmount();
    }
}
```

## SD Card: Reading a File

Take the SD Card used in the last example, put it in a PC and you will see the file.
For this example, we use the same SD Card written to by the last example. The file is opened and read to verify its contents.
```
using System.Threading;
using System.Text;
using Microsoft.SPOT;
using System.IO;
using Microsoft.SPOT.IO;
using GHI.IO.Storage;

public class Program {
    static void Main() {
        // ... If desired, check if SD is inserted

        // SD Card is inserted
        // Create a new storage device
        SDCard sd_card = new SDCard();

        // Mount the file system
        sd_card.Mount();
        bool fs_ready = false;
        RemovableMedia.Insert += (a, b) => {
            fs_ready = true;
        };

        while (!fs_ready) {
            System.Threading.Thread.Sleep(1);
        }

        // Assume one storage device is available, 
        // access it through NETMF
        string rootDirectory = VolumeInfo.GetVolumes()[0].RootDirectory;
        FileStream FileHandle = new FileStream(rootDirectory +
                 @"\hello.txt", FileMode.Open, FileAccess.Read);
        byte[] data = new byte[100];
        int read_count = FileHandle.Read(data, 0, data.Length);
        FileHandle.Close();
        Debug.Print("The size of data read is: " +
                    read_count.ToString());
        Debug.Print("Data from file:");
        Debug.Print(new string(Encoding.UTF8.GetChars(data), 0, read_count));

        sd_card.Unmount();
    }
}
```

##SD Card: Media Detection

The previous examples assumed that the card was already inserted and mostly ignored whether that media was formatted (contained a file system). The following example shows an application without such assumptions; additionally, it demonstrates the Format method.

Together, `InsertEventHandler`, `EjectEventHandler`, and `IsSDCardPresent` are used to respond to physical card activities, which in turn are used to control mounting (`Mount`, `Unmount`) of the card. Once the card is mounted, the file-system can be used.

```
using System;
using System.IO;
using System.Threading;
using Microsoft.SPOT;
using Microsoft.SPOT.IO;

using GHI.IO.Storage;

public class Program
{
    // evt is used to avoid the possibility that accesses to the 
    // mounted file system do not occur until mount()
    // is fully done.
    private static AutoResetEvent evt = new AutoResetEvent(false);
  
  	//Make sure to set the pin to your sd card detect pin.
  	private static InputPort sdCardDetect = new InputPort(Cpu.Pin.GPIO_NONE, false, Port.ResistorMode.Disabled);
  
    public static void Main() {
        RemovableMedia.Insert += new InsertEventHandler(RemovableMedia_Insert);
        RemovableMedia.Eject += new EjectEventHandler(RemovableMedia_Eject);

        // Start auto mounting thread
        new Thread(SDMountThread).Start();
        evt.WaitOne(); // yield here until mounting and initializing is finished

        // Your program goes here
        // ...
    }

    // This event is fired by unmount; not neccesarily by physical ejection of media
    static void RemovableMedia_Eject(object sender, MediaEventArgs e) {
        Debug.Print("SD card unmounted, eject event fired");
        // as desired signal other thread(s) in application
        // that unmount occurred
    }

    static void RemovableMedia_Insert(object sender, MediaEventArgs e) {
        Debug.Print("Insert event fired; SD card mount is finished.");

        // insert code here for anything the program wants to do immediately
        // after mounting occurs...

        if (e.Volume.IsFormatted) {
            Debug.Print("Available folders:");
            string[] strs = Directory.GetDirectories(e.Volume.RootDirectory);
            for (int i = 0; i < strs.Length; i++)
                Debug.Print(strs[i]);

            Debug.Print("Available files:");
            strs = Directory.GetFiles(e.Volume.RootDirectory);
            for (int i = 0; i < strs.Length; i++)
                Debug.Print(strs[i]);
        }
        else {
            Debug.Print("SD card is not formatted. Formatting...");

            // VolumeInfo is the class that contains volume information for a specific
            //      media.
            // .GetVolumes()[0] aquires the first volume on the device. Change the 
            //      index for different volumes.
            // .Format("FAT", 0); Selects the "FAT" file system as the format type.
            VolumeInfo.GetVolumes()[0].Format("FAT", 0);
        }
        evt.Set(); // proceed with other processing
    }

    public static void SDMountThread() {
        SDCard SD = null;
        const int POLL_TIME = 500; // check every 500 millisecond

        bool sdExists;
        while (true) {
            try {       // If SD card was removed while mounting, it may throw exceptions.
                sdExists = sdCardDetect.Read();

                // make sure it is fully inserted and stable
                if (sdExists) {
                    Thread.Sleep(50);
                    sdExists = sdCardDetect.Read();
                }

                if (sdExists && SD == null) {
                    SD = new SDCard();
                    SD.Mount();
                }
                else if (!sdExists && SD != null) {
                    SD.Unmount();
                    SD.Dispose();
                    SD = null;
                }
            }
            catch {
                if (SD != null) {
                    SD.Dispose();
                    SD = null;
                }
            }

            Thread.Sleep(POLL_TIME);
        }
    }
}
```

## USB Mass Storage Devices
USB mass storage devices, such as memory sticks and card readers are supported by GHI's NETMF devices.
If you compare the following example with those above for SD Cards, you will see how easy it is to program for one, the other, or both with virtually identical code.

```
using System;
using System.Threading;
using System.IO;
using Microsoft.SPOT;
using System.Text;
using Microsoft.SPOT.IO;
using GHI.Usb;
using GHI.Usb.Host;
using GHI.IO.Storage;

public class Program {
    // evt is used to avoid the possibility that accesses to the 
    // mounted file system do not occur until mount()
    // is fully done.
    private static AutoResetEvent evt = new AutoResetEvent(false);
    private static MassStorage usb_storage;
    private static string rootDirectory;
    public static void Main() {

        RemovableMedia.Insert += new InsertEventHandler(RemovableMedia_Insert);
        RemovableMedia.Eject += new EjectEventHandler(RemovableMedia_Eject);

        // Unlike SD Card detection, the USB Host Controller sends an
        // event when a Mass Storage device is plugged-in.
        Controller.MassStorageConnected += (sender, massStorage) => {
            usb_storage = massStorage;
            usb_storage.Mount();  // fires the insert event when finished
        };
        Controller.Start();
      
        evt.WaitOne(); // yield here until mounting and initializing is finished

        byte[] data;
        // write
        using (var FileHandle = new FileStream(rootDirectory +
                                      @"\hello.txt", FileMode.Create)) {
            data =
            Encoding.UTF8.GetBytes("This string will go in the file!");
            FileHandle.Write(data, 0, data.Length);
        }

        // read
        int read_count;
        using (var FileHandle = new FileStream(rootDirectory +
                @"\hello.txt", FileMode.Open, FileAccess.Read)) {
            data = new byte[100];
            read_count = FileHandle.Read(data, 0, data.Length);
        }

        Debug.Print("The size of data we read is: " +
            read_count.ToString());
        Debug.Print("Data from file:");
        Debug.Print(new string(Encoding.UTF8.GetChars(data), 0,
            read_count));

        usb_storage.Unmount();
    }

    // This event is fired by unmount
    static void RemovableMedia_Eject(object sender, MediaEventArgs e) {
        Debug.Print("USB unmounted, eject event fired");
    }

    static void RemovableMedia_Insert(object sender, MediaEventArgs e) {
        Debug.Print("Insert event fired; USB Storage mount is finished.");
        if (e.Volume.IsFormatted) {
            rootDirectory = e.Volume.RootDirectory;

            Debug.Print("Available folders:");
            string[] strs = Directory.GetDirectories(e.Volume.RootDirectory);
            for (int i = 0; i < strs.Length; i++)
                Debug.Print(strs[i]);

            Debug.Print("Available files:");
            strs = Directory.GetFiles(e.Volume.RootDirectory);
            for (int i = 0; i < strs.Length; i++)
                Debug.Print(strs[i]);
        }
        else {
            Debug.Print("Media is not formatted. Formatting...");
            e.Volume.Format("FAT", 0);
            rootDirectory = e.Volume.RootDirectory;
        }
        evt.Set(); // proceed with other processing
    }
}
```
> [!Warning]
> Media formatted as FAT12 will not work. This shouldn't be an issue since FAT12 is no longer in use.
