# XTEA
---

## Introduction
XTEA is a secure encryption algorithm, though not as secure as RSA or others, that uses a 128bit key and requires very little processing power.
 
Make sure you only attempt to encrypt arrays with a size divisible by eight.

## Getting Started
The following example shows the basic encryption and decryption of a string. When you use the parameterless constructor of the Xtea object, a key is generated for you that you can find in the Key property. If you pass a key to the constructor, it will be used instead.

```cs
using GHI.Utilities;
using Microsoft.SPOT;
using System.Text;

public class Program
{
    public static void Main()
    {
        var xtea = new Xtea();

        var encrypted = xtea.Encrypt(Encoding.UTF8.GetBytes("0123456776543210"));
        var decrypted = xtea.Decrypt(encrypted);

        Debug.Print(new string(Encoding.UTF8.GetChars(decrypted))); //should be "0123456776543210"

        var keyStr = "0x";
        for (int i = 0; i < Xtea.KeyLength; i++)
            keyStr += xtea.Key[i].ToString("x2");

        Debug.Print("The key used was " + keyStr);
    }
}
```