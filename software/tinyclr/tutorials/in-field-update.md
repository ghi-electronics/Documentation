# In-Field Update
---
This feature allows the system to do a secure and encrypted In-Field software updates, IFU for short. The updates can be done from buffers or from file system.

## Buffer Updater
Systems with external memory can use the buffer updater, which loads the new update from anywhere (files, network or a bus) into a buffer. When the entire system updated is in memory, the IFU will then checks the buffer for authenticity and only then it will decrypts the data and flash it internally.

This is the recommended update mode; however, this will only work on systems with external memories.

> Warning
> No power interruption can happen when the system class “Update”. This only takes about 2 seconds. A power interruption will fail the update and then manual update becomes necessary.

```
```

## File Updater

The file updater reads files from a memory storage, SD or USB and then handles the updated directly without the need for external memories. This update will of course still work on systems with or without external mamory.

```
```

## Firmware and Application matching
It is important to keep the right versions when doing firmware update. It is best to always update both, application and firmware, simultaneously if this is an option.
