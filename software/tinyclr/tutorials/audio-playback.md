# Audio Playback
---

## WAV Files

Simple audio playback is accomplished by reading a PCM WAV file and passing the data to the built-in analog out pin. Even easier, parse the WAV file on a PC and include the PCM samples.

This code plays an 8 bit mono WAV file with a sample rate of 8 kHz. The WAV file must be saved as a BIN file before adding it as a resource. This code does no checking of the WAV file to make sure it is in the correct format.

```cs
var dac = GHIElectronics.TinyCLR.Devices.Dac.DacController.GetDefault();

var analogOut = dac.OpenChannel(GHIElectronics.TinyCLR.Pins.SC20100.DacChannel.PA4);

var wavFile = Properties.Resources.GetBytes(Properties.Resources.BinaryResources.wavFile);

for (int i = 44; i < wavFile.Length; i++) { //First 44 bytes of WAV file are header.
    analogOut.WriteValue(wavFile[i]);

    for (int timer = 0; timer < 58; timer++) ; //Time delay to play output @ 8000 samples/sec.
}

analogOut.WriteValue(0);
```

## MP3 Files

MP3 file decoding can be accomplished by using one of the many MP3 decoders available from VLSI Solution http://www.vlsi.fi/. We provide a drivers for VS1053B, which supports MP3, AAC, Ogg Vorbis, WMA and MIDI. The driver is on the [TinyCLR-Drivers](https://github.com/ghi-electronics/TinyCLR-Drivers) GitHub repository.
