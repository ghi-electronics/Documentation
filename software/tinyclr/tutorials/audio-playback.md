# Audio Playback
---

## WAV Files
---
Simple audio playback is accomplished by reading a PCM WAV file and passing the data onto the built-in analog out pin. Even easier, parse the WAV file on a PC and include the PCM samples.

This code plays an audio file

```
// code
```

## MP3 Files
MP3 file decoding can be accomplished through one of the name MP3 decoders available from VLSI Solution http://www.vlsi.fi/. We provide a drivers for VS1053B, which supports MP3, AAC, Ogg Vorbis, WMA and MIDI. The driver is on the [TinyCLR-Drivers](https://github.com/ghi-electronics/TinyCLR-Drivers) GitHub repository.
