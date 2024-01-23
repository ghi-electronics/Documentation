[IN PROGRESS](error.md) 
# Regular Expression
---
The RegEx class can be used to quickly parse large amounts of text to find specific character patterns; to extract, edit, replace, or delete text substrings; and to add the extracted strings to a collection to generate a report.

The Regex class is defined in the System.Text.Regular Expressions namespace. The RegEx class constructor takes a pattern string as a parameter with other optional parameters.
 
The following code snippet creates a RegEx from a pattern. Here pattern is to match a word starting with char `M`.

```cs
// Create a pattern for a word that starts with letter "M"  
string pattern = @"\b[M]\w+";

// Create a Regex  
Regex rg = new Regex(pattern);

// Long string  
string authors = "Mike, John, Meachel, Mickey, Jenifer";
 
// Get all matches  
MatchCollection matchedAuthors = rg.Matches(authors);

// Print all matched authors  
for (int count = 0; count < matchedAuthors.Count; count++)
    Debug.WriteLine(matchedAuthors[count].Value);
```
