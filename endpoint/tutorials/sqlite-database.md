# SQLite Database
---
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

## More Info
Further details on SQLite can be found at the official SQLite website http://www.sqlite.org/
