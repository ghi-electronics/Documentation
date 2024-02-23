# Databases

---

## SQLite Database

According to the SQLite homepage, "SQLite is a software library that implements a self-contained, server-less, zero-configuration, transactional SQL database engine. SQLite is the most widely deployed SQL database engine in the world." SQLite lets you set up a database that resides entirely in a single file on a persistent storage device.

> [!TIP]
> Needed NuGet: Microsoft.Data.Sqlite

The code below is a simple example that creates an SQLite database file.

```cs
using Microsoft.Data.Sqlite;

var id = 1;
var dataFile = "sqltest.db";

//Create a new database file
using (var connection = new SqliteConnection($"Data Source={dataFile}")){

    connection.Open();
    var command = connection.CreateCommand();

    //Create a new table
    command.CommandText = "CREATE TABLE IF NOT EXISTS user (id INTEGER PRIMARY KEY, name TEXT)";
    command.ExecuteNonQuery();

    //Insert a new row
    command.CommandText = "INSERT INTO user (name) VALUES ('World 1')";
    command.ExecuteNonQuery();

    //query the database
    command.CommandText =    @"SELECT name FROM user WHERE id = $id";
    command.Parameters.AddWithValue("$id", id);

    //print the result
    using (var reader = command.ExecuteReader()){
        while (reader.Read()){
            var name = reader.GetString(0);
            Console.WriteLine($"Hello, {name}!");
        }
    }
}

//delete the data file when done
FileInfo dbFile = new FileInfo(dataFile);
try{
    if (dbFile.Exists){
        dbFile.Delete();
    }
}
catch(Exception ex){
    Console.WriteLine("Unable to delete the data file"+ex.Message);
}
``` 

### More Info
Further details on SQLite can be found at the official SQLite website http://www.sqlite.org/

---

## LiteDB Database
Often applications need a way to store unstructured or semi-structured data. Using a NonSQL database could be a solution.

> [!TIP]
> Needed NuGet: LiteDB

The code below is a simple example that creates an LiteDB database file. LiteDB offers several features that makes it useful for an embedded device.

```cs
using LiteDB;

var dataFile = "SensorData.db";

// Open database (or create if doesn't exist)
using (var db = new LiteDatabase(dataFile)){

    // Get a collection (or create, if doesn't exist)
    var col = db.GetCollection<Sensor>("sensors");

    // Create a new sensor instance
    var sensor = new Sensor {
        Name = "MEMS12",
        ConfigValues = new string[] { "0x00", "0xAA" },
        IsActive = true
    };

    // Insert new sensor document (Id will be auto-incremented)
    col.Insert(sensor);

    // Update a document inside a collection
    sensor.Name = "MEMS13";

    col.Update(sensor);

    // Index document using document Name property
    col.EnsureIndex(x => x.Name);

    // Use LINQ to query documents (filter, sort, transform)
    var results = col.Query()
        .Where(x => x.Name.StartsWith("M"))
        .OrderBy(x => x.Name)
        .Select(x => new { x.Name, NameUpper = x.Name.ToUpper() })
        .Limit(10)
        .ToList();

    foreach(var memsSensor in results){
        Console.WriteLine(memsSensor.Name);
    }
    
    // Create an index on the ConfigValues property
    col.EnsureIndex(x => x.ConfigValues);

    // Query by config value
    var r = col.FindOne(x => x.ConfigValues.Contains("0xAA"));

    Console.WriteLine(r.Name);
}

//delete the data file when done
FileInfo dbFile = new FileInfo(dataFile);
try{
    if (dbFile.Exists){
        dbFile.Delete();
    }
}
catch(Exception ex){
    Console.WriteLine("Unable to delete the data file"+ex.Message);
}

//Define Sensor class
public class Sensor{
    public int Id { get; set; }
    public required string Name { get; set; }
    public required string[] ConfigValues { get; set; }
    public bool IsActive { get; set; }
}
```


### More Info
Further details on SQLite can be found at the official SQLite website http://www.litedb.org/