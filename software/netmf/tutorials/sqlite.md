# SQLite Database

## Introduction
According to the SQLite homepage, "SQLite is a software library that implements a self-contained, serverless, zero-configuration, transactional SQL database engine. SQLite is the most widely deployed SQL database engine in the world". GHI provides a driver for SQLite so that you can have access to a SQL database that resides entirely in a simple file on a persistant storage device.

The below code is a simple example where a database file is created in RAM (using SD cards and USB drives is possible as well). A table is created that is filled with some initial rows and then this data is read from the database. This data is then iterated over and printed out. ColumnOriginNames returns the names of each of the columns.

```cs
using System;
using System.Collections;
using Microsoft.SPOT;
using GHI.SQLite;
public class Program
{
    public static void Main()
    {
        // Create a database in memory,
        // file system is possible however!
        Database myDatabase = new GHI.SQLite.Database();
        myDatabase.ExecuteNonQuery("CREATE Table Temperature" +
        " (Room TEXT, Time INTEGER, Value DOUBLE)");
        //add rows to table
        myDatabase.ExecuteNonQuery("INSERT INTO Temperature (Room, Time, Value)" +
        " VALUES ('Kitchen', 010000, 4423)");
        myDatabase.ExecuteNonQuery("INSERT INTO Temperature (Room, Time, Value)" +
        " VALUES ('Living Room', 053000, 9300)");
        myDatabase.ExecuteNonQuery("INSERT INTO Temperature (Room, Time, Value)" +
        " VALUES ('bed room', 060701, 7200)");
        // Process SQL query and save returned records in SQLiteDataTable
        ResultSet result = myDatabase.ExecuteQuery("SELECT * FROM Temperature");
        // Get a copy of columns orign names example
        String[] origin_names = result.ColumnNames;
        // Get a copy of table data example
        ArrayList tabledata = result.Data;
        String fields = "Fields: ";
        for (int i = 0; i < result.RowCount; i++)
        {
            fields += result.ColumnNames[i] + " |";
        }
        Debug.Print(fields);
        object obj;
        String row = "";
        for (int j = 0; j < result.RowCount; j++)
        {
            row = j.ToString() + " ";
            for (int i = 0; i < result.ColumnCount; i++)
            {
                obj = result[j, i];
                if (obj == null)
                    row += "N/A";
                else
                    row += obj.ToString();
                row += " |";
            }
            Debug.Print(row);
        }
        myDatabase.Dispose();
    }
}
```

## The details on SQLite
All details on SQLite are found at the offcial SQLite website http://www.sqlite.org/