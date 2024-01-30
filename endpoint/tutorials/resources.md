# Resources

---

Resource files can be used to store strings, images, audio files, and other binary or text files that will be used by your application. Endpoint support resources the same of how they work on a PC.


Right-click on your project and `Add-> New Item...` Select `TinyCLR` and click on `Resources File`. Name the file `Resources` to match the code samples in Docs.

![Resources](images/add-resources.jpg)

You can now drag resources right into the file.

![Resources](images/resources.jpg)

In the background, a file is generated to reflect the added resources. Using the resource will look similar to `var resourceData = Resources.GetBytes(Resources.BinaryResources.data);`


> [!Tip]
> If you are copying example code that uses resource files, some changes may be needed to match the resources' names in your project.
