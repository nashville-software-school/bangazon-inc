# Visual Studio

The best way to learn a tool like Visual Studio is to use it. We'll start our exploration by using VS with our Student Exercises console application.

## Loading the Student Exercises Application in Visual Studio

1. The first step is to create a new "solution" to contain our console application project. this will create a *.sln file. In the terminal, go to the folder that contains your Student Exercises application. This is the folder that has the `studentExercises.csproj` file.
1. Create a new solution.
    ```
    dotnet new sln StudentExercises -o .
    ```
1. Add your *.csproj file to the solution.
    ```
    dotnet sln add StudentExercises.csproj
    ```
1. If you are NOT already using Windows...
    1. Push your changes to Github
    1. Switch to your Windows virtual machine
    1. Using git in Windows, pull your project from Github
1. Start Visual Studio.
1. From the `File` menu select `Open -> Project/Solution...`, then use the file explorer to find and select your `StudentExercises.sln` file.

We'll use the StudentExercises solution as we explore some features of Visual Studio.

## Some Important Parts of Visual Studio

1. Solution Explorer
1. Code Editor
1. Standard Toolbar
1. Output Window

### Solution Explorer

The _Solution Explorer_ is used to navigate the components of your application. Just like the file explorer in Visual Studio Code, this includes the files and folders that make up your application, but the Solution Explorer also includes your Nuget and npm dependencies, gives you access to graphical tools for editing your project files, and gives you the ability to drill into `*.cs` files, revealing the classes, methods and properties contained within them.

To open a file for editing, navigate to it within the Solution Explorer and double-click it.

To display the classes, methods and properties of a `*.cs` file, click the "triangle" next to the filename.

### Code Editor

Editing code in Visual Studio is very similar to editing in Visual Studio Code. In Visual Studio you'll find similar syntax highlighting and intellisense. And, most importantly, when you type a key on the keyboard, it appears on the screen!

Open files will appear as tabs across the top of the editor pane.

#### Edit Mode vs Preview Mode

When you single-click on a file in the Solution Explorer, the file is open in _preview mode_. Only one file may be open at a time in preview mode. The currently open filename will be displayed in a tab on the far right side of the tab bar. Preview mode is handy for reading through several code files that you do not wish to edit.

As soon as you attempt to edit a file that's open it preview mode, it will move the file into edit mode.

### Standard Toolbar

Toolbars appear below the Visual Studio menu and above the code editor. Here you'll find standard editor options such as `copy`, `paste`, `undo`, `redo`, `save`, etc... Twoard the middle of the toolbar you'll find a big green "play" button. Clicking this button will run your application.

### Output Window

The _Output Window_ displays the results of various operations performed by Visual Studio. You can think about this window as displaying similar information as the `dotnet` command will print to the terminal. You'll find the results of builds, package installations, debugging information, test results, and many other operations.

This window normally appears at the bottom of Visual Studio. If you do not see it, You can open it by selecting the `Output` item in the `View` menu.