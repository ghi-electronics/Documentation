# Excel

---
![Excel](../images/excel-logo.png)

DUE Link allows supports many systems, and Microsoft Excel is one the supported options! Yes, you can access devices right from spreadsheets! Combine that with VB macros and you have unlimited options.


## Setup

The access to the device is done though [Excel Data Streamer plug-in](https://microsoft.github.io/DataStreamerDevPortal/).

Enabling the streamer is simple as it is already built in:

1. Go to File > Options
2. In the Excel Options dialog click Add-ins
3. At the bottom of the dialog in the Manage: drop-down select COM Add-ins and click Go
4. Check the box for Microsoft Data Streamer for Excel

You should now see the Data Streamer tab in the Excel ribbon.

Connect the correct COM port and you will be presented with 4 new tabs (Data In, Data Out, Settings, and Manifest).

## Blinky!

Our first program will blink the on-board LED 20 times, where it comes on for 200ms and then it is off for 800ms.

Go to `Settings` and change the `Data Channels` to 1

Go to the `Data Out` tab and enter the following text right under `CH1` column `Led(200, 800, 20)`

The LED should be blinking now.

The support for Excel is still in progress. Check back this page for more excitement!
