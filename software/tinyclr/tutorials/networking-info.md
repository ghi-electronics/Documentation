# Additional Networking Info
---

## A Note About MAC Addresses

SITCore's built in PHY and ENC28 Ethernet networking ship with a default MAC address that is preset by GHI Electronics. This is fine for internal testing, but this is not a unique MAC address suitable for use inside a commercial product.

You will need to set a valid and unique MAC address before shipping your product. If you do not have access to an appropriate MAC address, you can either use an online MAC address generator, which is not ideal, or you can use a MAC address from an old computer or network card that is no longer used.

Not having a unique MAC address can be a problem. If two devices with the same MAC address are present on the same local network subnet, neither device will be able to communicate properly.

The WINC1500 WiFi module supported by SITCore devices ships with a manufacturer assigned unique MAC address. While you can set whatever MAC address you want, it is better to read the manufacturer assigned MAC address and then pass it on to the stack.