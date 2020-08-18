# Installing Required Software in Windows

## Zoom

1. https://zoom.us/

## Web Browsers

1. The main browser we will use is [Google Chrome]( https://www.google.com/chrome/browser/desktop/index.html)
1. You might also like to give [Mozilla Firefox](https://www.mozilla.org/en-US/firefox/new/) a try too.

## Postman

1. Install [Postman](https://www.getpostman.com/) for testing APIs.

## Terminal

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
          "acrylicOpacity": 0.75,
          "closeOnExit": true,
          "colorScheme": "Campbell",
          "commandline": "\"%PROGRAMFILES%\\git\\usr\\bin\\bash.exe\" -i -l",
          "cursorColor": "#FFFFFF",
          "cursorShape": "bar",
          "fontFace": "Consolas",
          "historySize": 9001,
          "icon": "ms-appx:///ProfileIcons/{0caa0dad-35be-5f56-a8ff-afceeeaa6101}.png",
          "name": "Bash",
          "padding": "0, 0, 0, 0",
          "snapOnInput": true,
          "startingDirectory": "%USERPROFILE%",
          "useAcrylic": true
        },
        ```
    1. Find the `defaultProfile` key near the top of the file. Updates it's value to be `"{00000000-0000-0000-ba54-000000000002}"`
    1. Save teh `settings.json` file and close Visual Studio Code.

## Configure Git

Once Git is done being installed, watch the video on how to [set up global Git configuration](https://youtu.be/66EB9oxGMzQ) so that you can successfully back up your code to Github in a few days... once we show you how to do it.

### Handling Permission Issues After Setup

Sometimes, a student has permission issues after installing and configuring Git. To ensure that this doesn't happen to you, watch the [Owning Your Git Config Directory](https://youtu.be/exva3J_jojc) video and follow the steps.


### Create SSH key

SSH is a technology that allows you to create a very secure connection between your computer, and a computer located somewhere else in the world. It's an acronym for Secure SHell. When you create an SSH key on your computer, it actually creates two files

1. A public key file that you share with other people and computers. It is usually named `id_rsa.pub`.
1. A private key file that you never, ever, ever, ever, ever share with anyone. It is usually named `id_rsa`.

### Creating Your SSH Key

Watch a short video for [creating an SSH key in the terminal](https://youtu.be/znRMcNG9_qQ) so that you an work with Github.

### Add SSH Key to Github Account

Now watch the video for [adding your SSH key to your Github account](https://youtu.be/8hlmIObpMd4).

## Node

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

## Install a C# Linter

C# FixFormat is a vscode extension that will--as its name implies--automatically format your C# code. To set it up:

1. Install [C# FixFormat](https://marketplace.visualstudio.com/items?itemName=Leopotam.csharpfixformat)
1. In VSCode go to File > Preferences > Settings
1. In the search bar, look for the setting `Format On Save` and make sure it is checked
1. In the same search bar, look for the setting `Auto Save` and make sure it's *NOT* set to `afterDelay`
1. Configure C# FixFormat
    1. Inside Visual Studio code type `ctrl+.` to open the vscode settings.
    1. Click the `Open Settings (JSON)` button near the upper-right corner of the window.
    1. Add the following to `settings.json` file:

    ```json
    "[csharp]": {
        "editor.defaultFormatter": "Leopotam.csharpfixformat"
    },
    "csharpfixformat.style.braces.onSameLine": false,
    "csharpfixformat.style.spaces.beforeIndexerBracket": false,
    "csharpfixformat.style.spaces.beforeParenthesis": false
    ```

## Visual Studio IDE

1. [Visual Studio Community Edition](https://visualstudio.microsoft.com/vs/community/). This will be your main code authoring tool for the server-side course.
    > **INFO:** When installing Visual Studio, you will be presented with a variety of workloads. Select the following workloads.
    > * ASP.NET and web development
    > * .NET Core cross-platform development

## SQL Server Express Database

1. [SQL Server Express](https://www.microsoft.com/en-us/sql-server/sql-server-editions-express). This is the database tool where all your data will be stored for the server-side course.

## Bookmark the Following Sites

[dbdiagram.io](http://dbdiagram.io) web application for creating ERDs (Entity Relationship Diagrams).

https://docs.asp.net/en/latest/getting-started.html

https://docs.microsoft.com/en-us/dotnet/

#### .NET on YouTube

* **Main page**: https://www.youtube.com/channel/UCvtT19MZW8dq5Wwfu6B0oxw
* **C# 101**: https://www.youtube.com/watch?v=BM4CHBmAPh4&list=PLdo4fOZ0oVxKLQCHpiUWun7vlJJvUiN
* **.NET Core 101**: https://www.youtube.com/watch?v=eIHKZfgddLM&list=PLdo4fOcmZ0oWoazjhXQzBKMrFuArxpW80
