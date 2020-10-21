# Audio Playback
---

## WAV Files

Simple audio playback is accomplished by reading a PCM WAV file and passing the data to the built-in analog out pin. Even easier, parse the WAV file on a PC and include the PCM samples.

This code plays an 8 bit mono WAV file with a sample rate of 8 kHz. The WAV file must be saved as a BIN file before adding it as a resource. The audio is output to pin PA4 on the SC20100S Dev Board.

> [!Tip]
> Needed NuGets: GHIElectronics.TinyCLR.Core, GHIElectronics.TinyCLR.Devices.Dac, GHIElectronics.TinyCLR.Devices.Gpio, GHIElectronics.TinyCLR.Devices.Spi, GHIElectronics.TinyCLR.Drawing, GHIElectronics.TinyCLR.Drivers.Media, GHIElectronics.TinyCLR.IO, GHIElectronics.TinyCLR.Native, GHIElectronics.TinyCLR.Pins.


```cs
var dac = DacController.GetDefault();
var analogOut = dac.OpenChannel(SC20100.DacChannel.PA4);

var byteFile = Properties.Resources.GetBytes
    (Properties.Resources.BinaryResources.yourWavFileResource);

var wavFile = new Wav(byteFile);
var dataIndex = wavFile.GetDataIndex();
var size = wavFile.GetDataSize();
var sampleRate = wavFile.GetSampleRate();

if (sampleRate == 8000) {
    for (int i = dataIndex; i < size; i++) {
        analogOut.WriteValue(byteFile[i]);

        for (int timer = 0; timer < 58; timer++) {}
    }
}
else {
    Debug.WriteLine("Sorry, file does not have an 8 kHz sample rate.");
}
```

## MP3 Files

MP3 file decoding can be accomplished by using one of the many MP3 decoders available from VLSI Solution http://www.vlsi.fi/. We provide a drivers for VS1053B, which supports MP3, AAC, Ogg Vorbis, WMA and MIDI. The driver is on the [TinyCLR-Drivers](https://github.com/ghi-electronics/TinyCLR-Drivers) GitHub repository.
