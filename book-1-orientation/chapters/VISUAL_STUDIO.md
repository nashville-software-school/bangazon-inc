# Visual Studio

Get started with Visual Studio Tutorial
https://tutorials.visualstudio.com/vs-get-started/intro

> **NOTE:** This tutorial covers VS 2017, but it is largely relevant to VS 2019. The main difference is the UI for creating a new project.


## Some important parts of Visual Studio

1. Solution Explorer
1. Code Editor
1. Output Window

### Solution Explorer

#### What is a Solution?

In Visual Studio a C# Project must be contained within a _Solution_. A _solution_ is a logical container for one or more _projects_. Just as a project is defined by a `*.csproj` file, a solution is defined by a `*.sln` file. Normally a solution will be in a folder with projects in subfolders beneath the solution. It is common practice for a solution to have the same name as the "main" project within it.

Here is an example folder structure of a solution and projects.

```
MyApplication/
  |- MyApplication.sln
  |- MyApplication/
       |- MyApplication.csproj
       |- Program.cs
  |- AnotherProject/
       |- AnotherProject.csproj
       |- SomeClass.cs
```

#### The Solution Explorer

The _Solution Explorer_ is used to navigate the components of your application. Similar to the file explorer in Visual Studio Code, the Solution Explorer displays the files and folders that make up your application, but the Solution Explorer also displays Nuget and npm dependencies, gives you access to graphical tools for editing your project files, and gives you the ability to drill into `*.cs` files, revealing the classes, methods and properties contained within them.

To open a file for editing, navigate to it within the Solution Explorer and double-click it.

To display the classes, methods and properties of a `*.cs` file, click the "triangle" next to the filename.

### Code Editor

Editing code in Visual Studio is very similar to editing in Visual Studio Code. In Visual Studio you'll find similar syntax highlighting and intellisense. And, most importantly, when you type a key on the keyboard, it appears on the screen!

Open files will appear as tabs across the top of the editor pane.

#### Edit Mode vs Preview Mode

When you single-click on a file in the Solution Explorer, the file is open in _preview mode_. Only one file may be open at a time in preview mode. The currently open filename will be displayed in a tab on the far right side of the tab bar. Preview mode is handy for reading through several code files that you do not wish to edit.

As soon as you attempt to edit a file that's open it preview mode, it will move the file into edit mode.

### Output Window

The _Output Window_ displays the results of various operations performed by Visual Studio. You can think about this window as displaying similar information as the `dotnet` command will print to the terminal. You'll find the results of builds, package installations, debugging information, test results, and many other operations.

This window normally appears at the bottom of Visual Studio. If you do not see it, You can open it by selecting the `Output` item in the `View` menu.
