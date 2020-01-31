# SQLite Database

## Introduction
According to the SQLite homepage, "SQLite is a software library that implements a self-contained, serverless, zero-configuration, transactional SQL database engine. SQLite is the most widely deployed SQL database engine in the world". GHI Electronics provides a driver for SQLite so that you can have access to a SQL database that resides entirely in a simple file on a persistant storage device.

The below code is a simple example where a database file is created in RAM (using SD cards and USB drives is possible as well). A table is created that is filled with some initial rows and then this data is read from the database. This data is then iterated over and printed out. ColumnOriginNames returns the names of each of the columns.

```cs
using System.Collections;
using System.Diagnostics;
using GHIElectronics.TinyCLR.Data.SQLite;

namespace TinyCLRDocTesting
{
    class Program
    {
        static void Main()
        {
            using (var db = new SQLiteDatabase())
            {
                Debug.WriteLine("Executig 1...");
                db.ExecuteNonQuery("CREATE Table Test (Var1 TEXT, Var2 INTEGER, Var3 DOUBLE);");

                Debug.WriteLine("Executig 2...");
                db.ExecuteNonQuery("INSERT INTO Test (Var1, Var2, Var3) VALUES ('Hello, World!', 25, 3.14);");

                Debug.WriteLine("Executig 3...");
                db.ExecuteNonQuery("INSERT INTO Test (Var1, Var2, Var3) VALUES ('Goodbye, World!', 15, 6.28);");

                Debug.WriteLine("Executig 4...");
                var result = db.ExecuteQuery("SELECT Var1, Var2, Var3 FROM Test WHERE Var2 > 10;");

                Debug.WriteLine("Executig 5...");
                Debug.WriteLine(result.ColumnCount.ToString() + " " + result.RowCount.ToString());

                var str = "";

                //foreach (var j in result.ColumnNames)
                //    str += j + " ";

                //Debug.WriteLine(str);

                foreach (ArrayList i in result.Data)
                {
                    str = "";

                    foreach (object j in i)
                        str += j.ToString() + " ";

                    Debug.WriteLine(str);
                }
            }
        }
    }
}


``` 

### The details on SQLite
All details on SQLite are found at the offcial SQLite website http://www.sqlite.org/