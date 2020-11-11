# Installing Required Software in Windows

> NOTE: Items marked with `*` need to re-installed if you have been using WSL

## Zoom

1. https://zoom.us/

## Web Browsers

1. The main browser we will use is [Google Chrome](https://www.google.com/chrome/browser/desktop/index.html)
1. You might also like to give [Mozilla Firefox](https://www.mozilla.org/en-US/firefox/new/) a try too.

## Postman

1. Install [Postman](https://www.getpostman.com/) for testing APIs.

## Terminal \*

1. Install [Git For Windows](https://gitforwindows.org/). This comes with the `git-bash` bash prompt we will be using throughout the backend.
1. Install [Windows Terminal](https://www.microsoft.com/en-us/p/windows-terminal-preview/9n0dx20hk701?activetab=pivot:overviewtab)
1. Configure Windows Terminal to use git-bash
   1. Open Windows Terminal (You'll find it in the Start menu)
   1. Select the arrow drop-down in the Windows Terminal title bar. It will be next to the `+` button.
   1. Select `Settings`. This will open the `settings.json` file in Visual Studio Code
   1. Add the following object to the `profiles.list` array
      ```json
      {
        "guid": "{00000000-0000-0000-ba54-000000000002}",
        "closeOnExit": true,
        "colorScheme": "Campbell",
        "commandline": "\"%PROGRAMFILES%\\git\\usr\\bin\\bash.exe\" -i -l",
        "cursorColor": "#FFFFFF",
        "cursorShape": "bar",
        "fontFace": "Consolas",
        "historySize": 9001,
        "icon": "ms-appx:///ProfileIcons/{0caa0dad-35be-5f56-a8ff-afceeeaa6101}.png",
        "name": "Bash",
        "padding": "10, 0, 0, 0",
        "snapOnInput": true,
        "startingDirectory": "%USERPROFILE%"
      }
      ```
   1. Find the `defaultProfile` key near the top of the file. Updates it's value to be `"{00000000-0000-0000-ba54-000000000002}"`
   1. Save the `settings.json` file and close Visual Studio Code.

### Creating Your SSH Key For Github \*

Watch a short video for [creating an SSH key in the terminal](https://youtu.be/znRMcNG9_qQ) so that you an work with Github.

### Add SSH Key to Github Account \*

Now watch the video for [adding your SSH key to your Github account](https://youtu.be/8hlmIObpMd4).

## Node \*

1. Install [Node](https://nodejs.org/en/) for working with JavaScript tools
1. Install `serve` and `json-server`
   ```sh
   npm i -g serve json-server
   ```

## .NET Core

1. Visit the [.NET Tutorial](https://dotnet.microsoft.com/learn/dotnet/hello-world-tutorial/intro) site, click on your OS and follow the steps to install .NET Core.
1. In your terminal go to your `workspace` directory and do steps 2 and 3 in the tutorial to verify everything works.

## Visual Studio Code

[Visual Studio Code](https://code.visualstudio.com/download) is Microsoft's cross-platform editor that we'll be using during orientation for writing C# and building .NET applications. Make sure you add the [C# extension](https://code.visualstudio.com/Docs/languages/csharp) immediately after installation completes.

## Gitignore Shortcut

You'll be making a lot of new projects and we want to easily be able to create a gitignore file before pushing to Github. Run the following code from a git bash window

```sh
echo "dnignore() {
    curl -L -s 'https://raw.githubusercontent.com/github/gitignore/master/VisualStudio.gitignore' > .gitignore
}" >> ~/.bashrc
```

You now have access in your terminal to a command called `dnignore` which will add a gitignore file to your project.

## VS Code Settings

If you haven't already set up Visual Studio Code to format your code and autosave your files, now is a good time to set that up. Inside VS Code go to the settings by using the shortcut `ctrl` + `,` and using the search bar find the `Format On Save` setting and make sure it is checked. Next find the setting for `Auto Save` and make sure that it's set to either "onFocusChange" or "onWindowChange" (whatever you prefer)

## Visual Studio IDE

1. [Visual Studio Community Edition](https://visualstudio.microsoft.com/vs/community/). This will be your main code authoring tool for the server-side course.
   > **INFO:** When installing Visual Studio, you will be presented with a variety of workloads. Select the following workloads.
   >
   > - ASP.NET and web development
   > - .NET Core cross-platform development

## SQL Server Express Database

1. [SQL Server Express](https://www.microsoft.com/en-us/sql-server/sql-server-downloads). This is the database tool where all your data will be stored for the server-side course. Click the Download button under the Express option. During the setup, take the basic installation option

## Bookmark the Following Sites

[dbdiagram.io](http://dbdiagram.io) web application for creating ERDs (Entity Relationship Diagrams).

https://docs.asp.net/en/latest/getting-started.html

https://docs.microsoft.com/en-us/dotnet/

#### .NET on YouTube

- **Main page**: https://www.youtube.com/channel/UCvtT19MZW8dq5Wwfu6B0oxw
- **C# 101**: https://www.youtube.com/watch?v=BM4CHBmAPh4&list=PLdo4fOZ0oVxKLQCHpiUWun7vlJJvUiN
- **.NET Core 101**: https://www.youtube.com/watch?v=eIHKZfgddLM&list=PLdo4fOcmZ0oWoazjhXQzBKMrFuArxpW80
