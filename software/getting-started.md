# Getting Started

---

<div style="text-align: center;">

![Host Mode](./images/getting-started.png)

</div>

## Hardware Selection

The first step is to pick from one of the many available [DUE Hardware](../hardware/intro.md) options. Which includes the Maker friendly FEZ (Fast & Easy) boards and the STEM educational BrainPad boards.

If you're just starting out with DUE Link, the BrainPad hardware and its included lessons are recommended.


Follow the hardware instructions to load the latest DUE Link firmware onto your device.

## Start Coding

If using BrainPad, visit its website for full lessons on DUE Link and other hosted languages, like Python and JavaScript.

<div style="text-align: center;">

[![BrainPad Hardware](images/btn-brainpad.png)](../hardware/brainpad.md)

</div>

---

## Blink LED

Assuming you already have hardware and the board is loaded with the latest firmware, We will start by blinking an LED using DUE Script.

Open the [DUE Console](https://console.duelink.com/)

![DUE Console](images/due-console.png)


Reset your hardware, or simply unplug it from the PC and then plug it back in. Now, we can connect to the DUE console. To connect click on the Plug button.

![Connect](images/due-connect.png)

A window will now show the available connections. If you have more than one, select the one that has DUE in it and click **Connect**.

![DUE Console](images/console-connect.png)

Note how the “About” panel shows some important info, and may remind you that you do not have the latest firmware.

![DUE Console About](images/console-about.png)

For our blinky program, we do not need to write any code! Just click on Demos ➤ Blink LED.

![DUE Console Demos](images/console-blinkdemo.png)

We can now Record (red button) 

![DUE Record Button](images/due-record.png)

and then Play (Green Button). The LED will now start blinking on your board.

![DUE Play Button](images/due-play.png)

What you just did was write a program in “Recording Mode”. This program lives on the board (gets recorded) and will always be executed on the device on power up, or after reset. Go ahead and Click Stop (Blue button).

![DUE Stop Button](images/due-stop.png)

Go to the immediate window, where it says “Code to Run Immediately…” and enter:
```
Log(“Hello DUE”)
```
![DUE Console Log](images/console-log.png)

And then click the execute button (Right Arrow). This will now show Hello DUE in the Output panel. This line of code was not recorded onto the device and only got executed. More on recorded vs immediate modes in future lessons.

![DUE Console Log](images/console-log-window.png)

---

## Coding Options

![Coding Options](images/coding-options.png)
The DUE Link ecosystem includes many coding options, starting with DUE Link we have just used. 


<div style="text-align: center;">

[![Coding Options](/images/btn-coding-options.png)](../software/coding-options/coding-options.md)

</div>
