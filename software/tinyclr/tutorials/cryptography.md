# Cryptography
---
TinyCLR OS supports RSA public key cryptography. Key sizes can be 1024 or 2048 bits and are generated automatically when `RSACryptoServiceProvider()` is instantiated. 

> [!Note]
> `RSACryptoServiceProvider()` implements the IDisposable interface

> [!Tip]
> Needed NuGets: GHIElectronics.TinyCLR.Core and GHIElectronics.TinyCLR.Cryptography

The following sample code encrypts and decrypts a string of text.

```cs
byte[] dataToEncrypt = System.Text.Encoding.UTF8.GetBytes("Data to Encrypt");
byte[] encryptedData;
byte[] decryptedData;

using (GHIElectronics.TinyCLR.Cryptography.RSACryptoServiceProvider RSA = new
    GHIElectronics.TinyCLR.Cryptography.RSACryptoServiceProvider(2048)) {

    //Encrypt data.
    using (GHIElectronics.TinyCLR.Cryptography.RSACryptoServiceProvider encryptRSA = new
        GHIElectronics.TinyCLR.Cryptography.RSACryptoServiceProvider()) {

        encryptRSA.ImportParameters(RSA.ExportParameters(false));
        encryptedData = encryptRSA.Encrypt(dataToEncrypt);
    }

    //Decrypt data.
    using (GHIElectronics.TinyCLR.Cryptography.RSACryptoServiceProvider decryptRSA = new
        GHIElectronics.TinyCLR.Cryptography.RSACryptoServiceProvider()) {

        decryptRSA.ImportParameters(RSA.ExportParameters(true));
        decryptedData = decryptRSA.Decrypt(encryptedData);
    }
}

System.Diagnostics.Debug.WriteLine("Decrypted: " +
    System.Text.Encoding.UTF8.GetString(decryptedData));

```

The above code outputs the following:
```text
Decrypted: Data to Encrypt
```

If no key size is provided as an argument to `RSACryptoServiceProvider()`, a default key size of 1024 bits will be used.

The boolean argument for `RSA.ExportParameters()` determines whether this method returns the private key (true) or public key (false). The public key is used to encrypt messages, while the private key is needed to decrypt messages.
