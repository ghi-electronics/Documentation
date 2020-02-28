# Collections
---
Similar data can often be handled more efficiently when stored and manipulated as a collection. You can use the System.Array class or the classes in the System.Collections namespace to add, remove, and modify either individual elements or a range of elements in a collection.

For more info go to https://docs.microsoft.com/en-us/dotnet/standard/collections/index.

TinyCLR OS collections support ArrayLists, Hashtables, Stacks, and Queues.

## ArrayLists

ArrayLists have a significant advantage over arrays in that ArrayLists are automatically resized as needed, whereas arrays are limited to a fixed number of elements. The following code sample creates an ArrayList, adds a couple of records, and then iterates through the ArrayList items and displays each record.

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
            System.Diagnostics.Debug.WriteLine("    Date: " + record.date.Year +
                "/" + record.date.Month + "/" + record.date.Day);

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

In the above sample, `rmaList.Clear()` will remove all elements from `rmaList`, `rmaList.RemoveAt(1)` will remove only the second element in the list, and `rmaList.Remove(record)` will remove the first element that is equal to `record`.


## Hashtables
Hash tables are used to store information in a way that associates each data element, or value, with a key that can be used to look up that value. Hash tables make it easy to quickly retrieve information that would otherwise be difficult to organize in an efficient manner.

For example, imagine trying to look up a phone number from a given name. You could make a two dimension array of names and phone numbers and then iterate through the array looking for the correct name, but this would be slow with a large array. Hash tables solve this problem by using a hash function to convert a key, in this case a name, into an array index that points directly to the data element you are looking for. This allows you to quickly retrieve the data directly instead of searching for it. 

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

## Stacks

Stacks are first in, last out (or last in, first out) collections of objects. The `Push` method is used to add items to a stack, and the `Pop` method is used to remove items from a stack. There is also a `Peek` method that returns the item at the top of the stack without removing it from the stack.

```cs
private static void Main() {
    var sitCoreDevices = new System.Collections.Stack();
    sitCoreDevices.Push("SC20100S");
    sitCoreDevices.Push("SC20260B");
    sitCoreDevices.Push("SCM20260D");
    sitCoreDevices.Push("SCM20260E");
    sitCoreDevices.Push("SCM20260N");
        
    PrintValues(sitCoreDevices);

    System.Diagnostics.Debug.WriteLine("Popped: " + sitCoreDevices.Pop().ToString());
    System.Diagnostics.Debug.WriteLine(" ");

    PrintValues(sitCoreDevices);
}

public static void PrintValues(System.Collections.Stack myQueue) {
    System.Diagnostics.Debug.WriteLine("Count: " + myQueue.Count);
    System.Diagnostics.Debug.WriteLine("Items in queue:");

    foreach (System.Object obj in myQueue)
        System.Diagnostics.Debug.WriteLine("    " + obj);

    System.Diagnostics.Debug.WriteLine(" ");
}
```

The above code outputs the following:
```
The thread '<No Name>' (0x2) has exited with code 0 (0x0).
Count: 5
Items in queue:
    SCM20260N
    SCM20260E
    SCM20260D
    SC20260B
    SC20100S
 
Popped: SCM20260N
 
Count: 4
Items in queue:
    SCM20260E
    SCM20260D
    SC20260B
    SC20100S
```

## Queues

Queues are first in, first out collections of objects. To add items to a queue, the `enqueue` method is used. To remove items, the `dequeue` method is used.

```cs
private static void Main() {
    var sitCoreDevices = new System.Collections.Queue();
    sitCoreDevices.Enqueue("SC20100S");
    sitCoreDevices.Enqueue("SC20260B");
    sitCoreDevices.Enqueue("SCM20260D");
    sitCoreDevices.Enqueue("SCM20260E");
    sitCoreDevices.Enqueue("SCM20260N");
        
    PrintValues(sitCoreDevices);

    System.Diagnostics.Debug.WriteLine("Dequeued: " +
        sitCoreDevices.Dequeue().ToString());

    System.Diagnostics.Debug.WriteLine(" ");

    PrintValues(sitCoreDevices);
}

public static void PrintValues(System.Collections.Queue myQueue) {
    System.Diagnostics.Debug.WriteLine("Count: " + myQueue.Count);
    System.Diagnostics.Debug.WriteLine("Items in queue:");

    foreach (System.Object obj in myQueue)
        System.Diagnostics.Debug.WriteLine("    " + obj);

    System.Diagnostics.Debug.WriteLine(" ");
}
```

The above code outputs the following:
```
Count: 5
Items in queue:
    SC20100S
    SC20260B
    SCM20260D
    SCM20260N
    SCM20260E
 
Dequeued: SC20100S
 
Count: 4
Items in queue:
    SC20260B
    SCM20260D
    SCM20260N
    SCM20260E
```
