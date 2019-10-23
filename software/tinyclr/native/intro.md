# Native Code on TinyCLR
---
![TinyCLR Logo](../images/tinyclr-logo-noborder.jpg)

TinyCLR has a few different ways you can use native code. You may want to do this for performance reasons or to access advance features on your platform.

The most commonly used option will be [native interops](interops.md) that allow you to call native code from your managed application and interact with managed data from the native side.

TinyCLR also allow access to [native APIs](apis.md) where Interops can access to other services registered with the system like SPI, GPIO, and I2C.
