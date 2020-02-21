# Collections
---
Similar data can often be handled more efficiently when stored and manipulated as a collection. You can use the System.Array class or the classes in the System.Collections namespace to add, remove, and modify either individual elements or a range of elements in a collection.

For more info go to https://docs.microsoft.com/en-us/dotnet/standard/collections/index.

TinyCLR OS collections support ArrayLists, Hashtables, Queues, and Stacks.

## ArrayLists

The following code sample creates an ArrayList, adds a couple of records, and then iterates through the ArrayList items and displays each record.

```cs
class Program {
    private struct rmaRecord {
        public System.DateTime date;
        public string modelNumber;
        public string fault;
    }
    private static void Main() {
        var rmaList = new System.Collections.ArrayList();
        var record = new rmaRecord();

        record.date = new System.DateTime(2020, 2, 21);
        record.modelNumber = "XY23";
        record.fault = "No power";

        rmaList.Add(record);

        record.date = new System.DateTime(2020, 2, 20);
        record.modelNumber = "XY42";
        record.fault = "Blown fuse";

        rmaList.Add(record);

        PrintValues(rmaList);
    }

    private static void PrintValues(System.Collections.ArrayList list) {
        System.Diagnostics.Debug.WriteLine("Count: " + list.Count);
        System.Diagnostics.Debug.WriteLine("Capacity: " + list.Capacity);
        System.Diagnostics.Debug.WriteLine(" ");
        System.Diagnostics.Debug.WriteLine("Values:");

        foreach (rmaRecord record in list) {
            System.Diagnostics.Debug.WriteLine("    Date: " + record.date.Year + "/" + record.date.Month + "/" + record.date.Day);
            System.Diagnostics.Debug.WriteLine("    Model#: " + record.modelNumber);
            System.Diagnostics.Debug.WriteLine("    Fault: " + record.fault);
            System.Diagnostics.Debug.WriteLine("----------");
        }
    }
}
```
The above code outputs the following:

```
Count: 2
Capacity: 4
 
Values:
    Date: 2020/2/21
    Model#: XY23
    Fault: No power
----------
    Date: 2020/2/20
    Model#: XY42
    Fault: Blown fuse
----------
```

## Hashtables

The following code sample creates a hash table, adds elements to the hash table, and then reads back the value for each key.

```cs
//Create a hash table.
System.Collections.Hashtable processorPin = new System.Collections.Hashtable();

//Add some elements to the hash table. There can be no duplicate keys, but duplicate
//    values are allowed.

//                Key   Value
processorPin.Add("LDR", "PE3");
processorPin.Add("APP", "PB7");
processorPin.Add("MOD", "PD7");
processorPin.Add("WKUP", "PA0");
processorPin.Add("BTN1", "PE3");
processorPin.Add("BTN2", "PB7");
processorPin.Add("BTN3", "PD7");

//When you use foreach to enumerate hash table elements, the elements are retrieved
//    as DictionaryEntry objects.

foreach (System.Collections.DictionaryEntry de in processorPin) {
    System.Diagnostics.Debug.WriteLine("Key = " + de.Key + "    Value = " + de.Value);
}
```

The above code outputs the following:
```
Key = MOD    Value = PD7
Key = LDR    Value = PE3
Key = BTN1    Value = PE3
Key = BTN2    Value = PB7
Key = BTN3    Value = PD7
Key = WKUP    Value = PA0
Key = APP    Value = PB7
```