# Release Notes
---
## 2.0.0-preview2 on 2019-01-22

### Notes
A preview of the new API and available features.

### Libraries

#### Changes
- First release to private insiders with major changes.

#### Known Issues
- None, still going through final testing.
- Cryptography and hashing are currently only supported through TLS. We are still planning how to securely expose this functionality.

### Firmware

#### Changes
- First release to private insiders with major changes.

#### Known Issues
- Conversion from enum to string (enumObject.ToString()) may fail.
- PulseFeedback DrainDuration does not work when going from low to high.

### TinyCLR Config

#### Changes
- First release to private insiders with major changes.

#### Known Issues
- TinyCLR may not work when connecting over UART. Use Tera Term to update firmware when in UART mode.

## 2.0.0-preview1 on 2019-12-09

### Notes
A preview of the new API and available features.

### Libraries

#### Changes
- Major changes.

#### Known Issues
- Still going through complete testing.

### Firmware

#### Changes
- Major changes.

#### Known Issues
- Internal use only.

### TinyCLR Config

#### Changes
- None.

#### Known Issues
- Random crash.
