# SQLite Database
---
According to the SQLite homepage, "SQLite is a software library that implements a self-contained, serverless, zero-configuration, transactional SQL database engine. SQLite is the most widely deployed SQL database engine in the world." SQLite lets you set up a database that resides entirely in a single file on a persistent storage device.

> [!TIP]
> Needed NuGets: GHIElectronics.TinyCLR.Data.SQLite



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
                db.ExecuteNonQuery(
                    "CREATE Table Test Var1 TEXT, Var2 INTEGER, Var3 DOUBLE);");

                Debug.WriteLine("Executing 2...");
                db.ExecuteNonQuery("INSERT INTO Test(Var1, Var2, Var3) VALUES ('Hello, World!', 25, 3.14);");

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

                foreach (ArrayList i in result.Data){
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

## Omitted commands & features

In order to reduce the memory requirements, some commands and features of SQLite have been omitted. Below is a table of those omitted features.
For more information regarding these omissions see the [SQLite Website.](https://www.sqlite.org/compile.html) 

|Omitted Command or Feature                  |                                                               |             
|----------------------------|---------------------------------------------------------------|
| **ALTER TABLE**            | Executing the statement causes a parse error                  | 
| **ANALYZE**                | Command omitted from the build                                | 
| **ATTACH**                 | ATTACH and DETACH commands are omitted                        | 
| **REINDEX**                | Executing the statement causes a parse error                  | 
| **AUTOMATIC INDEX**        | Feature omitted from the build                                |
| **AUTHORIZATION**          | Authorization callback feature omitted                        |
| **AUTOINCREMENT**          | Feature omitted from the build                                |
| **AUTOVACCUM**             | Feature omitted from the build                                |
| **BETWEEN OPTIMIZATION**   | Disables WHERE clause terms that use BETWEEN operator                   |
| **BLOB LITERAL**           | Not possible to specify a blob in an SQL statement using X'ABCD' syntax |
| **COMPOUND SELECT**        | SELECT that use UNION, UNION ALL, INTERSECT or EXCEPT will cause a parse error. |
| **INSERT**                 | Cannot insert more than a single row using an INSERT INTO...VALUES statement  |
| **CTE**                    | Common Table Expressions omitted from the build  |
| **DATETIME FUNCS**         | SQL functions julianday(), date(), time(), datetime() and strftime() are not available  |
| **DEPRECATED**             | Omitted support for interfaces marked deprecated by SQLite  |
| **EXPLAIN**                | Executing the statement causes a parse error                                |
| **FLAG PRAGMAS**           | PRAGMA commands that query and set boolean properties omitted |
| **FOREIGN KEY**            | Foreign key constraint syntax is not recognized      |
| **HEX INTEGER**            | Support for Hexadecimal integer literals omitted      |
| **INCRBLOB**               | Support for incremental BLOB I/O omitted      |
| **INTEGRITY CHECK**        | Support for integrity check pragma omitted      |
| **LIKE OPTIMIZATION**      | Feature to help resolve LIKE and GLOB operators in a WHERE clause omitted     |
| **LOAD EXTENSION**         | Extension loading mechanism omitted    |
| **LOCALTIME**              | "localtime" modifier from the date and time functions omitted    |
| **LOOKASIDE**              | Lookaside memory allocator omitted   |
| **OR OPTIMIZATION**        | Index together with terms of a WHERE clause connected by the OR operator, disabled.   |
| **PAGER PRAGMAS**          | Pragmas related to the pager subsystem omitted from the build   |
| **PRAGMA**                 | P ragma command has been omitted                                 |
| **PROGRESS CALLBACK**      | "progress" callbacks capability during long-running SQL statements omitted.       |
| **QUICKBALANCE**           | Omitted an alternative, faster B-Tree balancing routine.      |
| **SCHEMA PRAGMAS**         | Pragmas for querying the database schema from the build omitted      |
| **SCHEMA VERSION PRAGMAS** | Pragmas for querying & modifying the database schema and user versions omitted     |
| **SHARED CACHE**           | Support for shared-cache mode has been omitted     |
| **SUBQUERY**               | Support for sub-selects and the IN() operator are omitted.     |
| **TCL VARIABLE**           | "$" syntax used to automatically bind SQL variables to TCL variables is omitted.     |
| **TEMPDB**                 | Support for TEMP or TEMPORARY tables omitted     |
| **TRACE**                  | Sqlite3_profile() and sqlite3_trace() interfaces and their associated logic omitted     |
| **TRIGGER**                | TRIGGER objects omitted. CREATE TRIGGER or DROP TRIGGER commands are unavailable     |
| **TRUNCATE OPTIMIZATION**  | Removing this feature only affects the speed of operation     |
| **UTF16**                  | Support for UTF16 text encoding has been omitted.     |
| **VIRTUALTABLE**           | Virtual Table mechanism in SQLite omitted.     |
| **XFER OPT**               | Removed optimization that help INSERT INTO...SELECT...run faster     |
| **WAL**                    | Write-ahead log capability omitted.      |


## More Info
Further details on SQLite can be found at the official SQLite website http://www.sqlite.org/
