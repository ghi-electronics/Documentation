# Power Management
---
TinyCLR OS currently supports Hibernate and Shutdown.

## Hibernate 
In this mode the system goes into sleep low power mode and only wakes up and resumes when the WKUP pin is toggled.

```
// sleep and wakeup using APP pin

```

## Shutdown
In this mode, the system completely shuts down. It can only be woken up by reset, power cycle, or by toggling the WKUP pin. Note that the system will always reset when it wakes up from this mode.

```
// Showdown

```
