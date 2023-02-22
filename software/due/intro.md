# DUE Scripting Language
---

![Downloads](images/due.png) 

It can be accessed from any modern OS and any language/system that have access to serial ports.


See the [downloads](downloads.md) page for currently supported languages.

## Why DUE?
DUE stands for Dynamic, Universal, and Extensible. A user-friendly scripting language that allows for internal real-time processing. 

## Dynamic
 There are 2 modes to code or command a DUE device, *Immediate* or *Record* modes. In *Immediate* mode, commands are executed immediately. In *Record* mode, commands are stored in flash and executed with the **run** command. Learn more about modes on the [language](language.md) page.


## Universal

DUE doesn't care if you use Python or C#, because the DUE commands are sent over serial port. It can also be scripted using a terminal editor with simple BASIC like commands included in the API.

## Extensibility

DUE devices when used with other languages extend the language.
Call any DUE recorded function from any external source using serial commands. 

## On-line editor

You can program any DUE device using a simple terminal editor like TerraTerm. This is nimble for quick testing but can be cumbersome with large programs. An on-line editor will soon be released to make coding and debugging programs very easy. 

## Streams
Send data in chunks directly to the device. This is useful when working with screens or other device which require batches of data. 