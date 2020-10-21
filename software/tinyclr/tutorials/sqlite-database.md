# SQLite Database
---
According to the SQLite homepage, "SQLite is a software library that implements a self-contained, serverless, zero-configuration, transactional SQL database engine. SQLite is the most widely deployed SQL database engine in the world." SQLite lets you set up a database that resides entirely in a single file on a persistent storage device.

The code below is a simple example that creates a database file in RAM (SD cards and USB drives can be used as well). A table is created, a few rows are filled, and then this data is read from the database. This data is then iterated over and printed out. ColumnOriginNames returns the name of each of the columns.

```cs
using System.Collections;
using System.Diagnostics;
using GHIElectronics.TinyCLR.Data.SQLite;

namespace SQLiteSample {
    class Program {
        static void Main() {
            using (var db = new SQLiteDatabase()) {

                Debug.WriteLine("Executing 1...");
                db.ExecuteNonQuery("CREATE Table Test
                    (Var1 TEXT, Var2 INTEGER, Var3 DOUBLE);");

                Debug.WriteLine("Executing 2...");
                db.ExecuteNonQuery("INSERT INTO Test
                    (Var1, Var2, Var3) VALUES ('Hello, World!', 25, 3.14);");

                Debug.WriteLine("Executing 3...");
                db.ExecuteNonQuery("INSERT INTO Test
                    (Var1, Var2, Var3) VALUES ('Goodbye, World!', 15, 6.28);");

                Debug.WriteLine("Executing 4...");
                var result = db.ExecuteQuery
                    ("SELECT Var1, Var2, Var3 FROM Test WHERE Var2 > 10;");

                Debug.WriteLine("Executing 5...");
                Debug.WriteLine(result.ColumnCount.ToString() + " " +
                    result.RowCount.ToString());

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

## More Info
Further details on SQLite can be found at the official SQLite website http://www.sqlite.org/