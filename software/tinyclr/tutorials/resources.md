# Resources
---
Resource files can be used to store strings, images, audio files, and other binary or text files that will be used by your application.

Right-click on your project and `Add->New Item...`. From here select `Resource File`.

You can now drag resources right into the file.

![Resources](images/resources.jpg)

In the background, a file is generated to reflect the added resources. Using the resource will look similar to `var resourceData = Resource.GetBytes(Resource.BinaryResources.data);`


> [!Tip]
> If you are copying example code that uses resource files, some changes may be needed to match the resources' names in your project.

## Partial loading
Large resources can be partially loaded in RAM as needed.

```cs
var resourceId = (short)Resources.BinaryResources.YourResourceId;
var data = (byte[])(Resources.ResourceManager.GetObject(resourceId, offset, readSize));
```

