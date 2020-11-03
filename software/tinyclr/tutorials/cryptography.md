# Cryptography
---
TinyCLR OS supports XTEA symmetric cryptography and RSA public key (asymmetric) cryptography. XTEA has a fixed key size of 128 bits, while RSA key sizes can be 1024 or 2048 bits. RSA keys are generated automatically when `RSACryptoServiceProvider()` is instantiated, but for XTEA a key must be provided.

For those unfamiliar with encryption, symmetric cryptography schemes such as XTEA use a single key which must be shared among all individuals who need to send or receive messages. This single key is used to both encrypt and decrypt messages. This creates a possible security problem as the key must be shared, but only among authorized individuals. 

Asymmetric encryption methods such as RSA use public and private key pairs and are designed to eliminate the problem of securely sharing a key. The public key can be shared openly as it is only used to encrypt messages. Only the private key can decrypt messages, and this key is not shared. Asymmetric encryption is much more computationally intensive.

Check out the Wikipedia [XTEA](https://en.wikipedia.org/wiki/XTEA) and [RSA](https://en.wikipedia.org/wiki/RSA_(cryptosystem)) pages for more information.

## XTEA
XTEA encryption is a symmetrical encryption method that always uses a 128 bit key. Keys of any other size will throw an exception. XTEA encryption also requires the data to you are encrypting to be a multiple of eight bytes in length.

XTEA encryption is not only dependent upon the supplied key, but also the "number of rounds" or iterations the encryption algorithm uses to encode and decode information. TinyCLR OS always uses 32 rounds. So, for example, if you are using a PC to decode data that was encoded using TinyCLR OS, make sure that both the correct key and number of rounds (32) are used on the PC side.

> [!Tip]
> Needed NuGets: GHIElectronics.TinyCLR.Core and GHIElectronics.TinyCLR.Cryptography

The following sample code encrypts and decrypts a string of text.

```cs
//Argument below is the 128 bit key. XTEA always uses a 128 bit key.
var crypto = new Xtea(new uint[] { 0x01234567, 0x89ABCDEF, 0xFEDCBA98, 0x76543210 });

byte[] dataToEncrypt = Encoding.UTF8.GetBytes("Data to encrypt.");
byte[] encryptedData;
byte[] decryptedData;

//Encrypt data. Data must be a multiple of 8 bytes.
encryptedData = crypto.Encrypt(dataToEncrypt, 0, (uint)dataToEncrypt.Length);

//Decrypt data.
decryptedData = crypto.Decrypt(encryptedData, 0, (uint)encryptedData.Length);

Debug.WriteLine("Decrypted: " + Encoding.UTF8.GetString(decryptedData));
```

The above code outputs the following:
```text
Decrypted: Data to encrypt.
```

---

## RSA
RSA public key cryptography has become the most popular asymmetric cryptography scheme on the Internet. While public key cryptography systems solve the problem of secure key sharing that exists in symmetric cryptography, they are much more computationally intensive. As a result, cryptography systems such as RSA are often used only to securely transfer the key for a symmetric cryptography method such as XTEA. Once the key has been sent, the computationally less intensive symmetric cryptography system is then used to encode and decode the bulk of the data.

> [!Note]
> `RSACryptoServiceProvider()` implements the IDisposable interface

> [!Tip]
> Needed NuGets: GHIElectronics.TinyCLR.Core and GHIElectronics.TinyCLR.Cryptography

The following sample code encrypts and decrypts a string of text.

```cs
byte[] dataToEncrypt = Encoding.UTF8.GetBytes("Data to Encrypt");
byte[] encryptedData;
byte[] decryptedData;

using (RSACryptoServiceProvider RSA = new RSACryptoServiceProvider(2048)) {

    //Encrypt data.
    using (RSACryptoServiceProvider encryptRSA = new RSACryptoServiceProvider()) {

        encryptRSA.ImportParameters(RSA.ExportParameters(false));
        encryptedData = encryptRSA.Encrypt(dataToEncrypt);
    }

    //Decrypt data.
    using (RSACryptoServiceProvider decryptRSA = new RSACryptoServiceProvider()) {

        decryptRSA.ImportParameters(RSA.ExportParameters(true));
        decryptedData = decryptRSA.Decrypt(encryptedData);
    }
}

Debug.WriteLine("Decrypted: " + Encoding.UTF8.GetString(decryptedData));

```

The above code outputs the following:
```text
Decrypted: Data to Encrypt
```

If no key size is provided as an argument to `RSACryptoServiceProvider()`, a default key size of 1024 bits will be used.

The boolean argument for `RSA.ExportParameters()` determines whether this method returns the private key (true) or public key (false). The public key is used to encrypt messages, while the private key is needed to decrypt messages.

