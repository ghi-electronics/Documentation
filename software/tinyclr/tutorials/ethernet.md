# Ethernet
---
Supporting built-in Ethernet or the use of SPI-based ENC28J60 require TinyCLR to host is own TCP/IP and TLS stacks. This is currently still in development. Another option is to use a C# TCP/IP implementation, such us [mIP](https://archive.codeplex.com/?p=mip). Or use a chip with built in TCP/IP, like [Wiznet W5500](https://www.wiznet.io/product-item/w5500/).