# Endpoint Single Board Computers

---

## Endpoint Domino 

![Single Board Computer](images/endpoint-domino.png)

The Endpoint Domino provides an easy prototyping and evaluating board option, that is low-cost and user friendly. 

#### Features:
* 32bit ARM 650Mhz, 4GB DDR3
* Display FPC connector
* 2x mikroBUS headers
* USB Host
* User LED
* Buzzer
* 40-pin expansion header
* microSD card slot
* USB-C connector 

---

## Pinout

[![Endpoint Domino](images/endpoint-domino-pinout.png)](pdfs/endpoint-domino-pinout.pdf)

---

## Displays

![4.3 Display](images/domino-display.png)

The display FPC connector on EP-Domino uses a common pinout available on many displays. Some of these displays include capacitive touch screens, which are supported as well.

Pin | Function
--|--
1 | Backlight Cathode (-)
2 | Backlight Anode (+)
3 | GND
4 | 3.3V
5-12 | Red Data (top 5 bits only)
13-20 | Green Data (top 6 bits only)
21-28 | Blue Data (top 5 bits only)
29 | GND
30 | Clock (PCLK)
31 | Enable (Connected to 3.3V)
32 | Horizontal Sync (HSYNC)
33 | Vertical Sync (VSYNC)
34 | Data Enable (DE)
35 | Not Connected
36 | GND
37 | Cap Touch Interrupt
38 | Cap Touch Reset
39 | Cap Touch SCL
40 | Cap Touch SDA

Here is a list of displays with capacitive touch we have tested from www.buydisplay.com

Display | Type | Link
--|--|--
ER-TFT043-3 | 4.3" 480x272 | [Link...](https://www.buydisplay.com/tft-4-3-inch-lcd-module-touchscreen-display-for-mp4-gps-480x272)
ER-TFT043A3-3 | 4.3" 480x272 | [Link...](https://www.buydisplay.com/sunlight-readable-4-3-inch-high-brightness-480x272-tft-lcd-display)
ER-TFT043A1-7 | 4.3" 800x480 | [Link...](https://www.buydisplay.com/4-3-800x480-ips-tft-lcd-module-all-viewing-optl-touchscreen-display)
ER-TFT070A2-4 | 7" 800x480 | [Link...](https://www.buydisplay.com/7-tft-lcd-touch-screen-display-module-800x480-for-mp4-gps-tablet-pc)

See the `DisplayController` example in `Libraries->Endpoint API` for details on how to configure the system for the desired display.

---

## Cameras

The Endpoint OS supports cameras through USB and parallel. For added convenience, the top side of the 40 pin header is pinout compatible with the off-the-shelf OV5640 camera board.

![OV5640 Camera](images/domino-camera.png)

---

## mikroBUS

Endpoint Domino has 2x [mikroBUS](https://www.mikroe.com/mikrobus) headers compatible with over 1000 click modules. 

![mikroBUS](images/domino-mikrobus.png)

---

## Wi-Fi

Endpoint Domino Wi-Fi using a the TP-link Wireless N Nano USB adapter. 

![Wifi](images/domino-wifi.png)
