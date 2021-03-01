# Installing Required Software in Windows

> **NOTE:** If you used Windows in the front-end course, you have most of this installed and configured already, but there are a few new tools to install so please carefully read through this document.

## Zoom

https://zoom.us/

## Slack

https://slack.com/

## Web Browsers

1. The main browser we will use is [Google Chrome](https://www.google.com/chrome/browser/desktop/index.html)
1. You might also like to give [Mozilla Firefox](https://www.mozilla.org/en-US/firefox/new/) a try too.

## Visual Studio Code

[Visual Studio Code](https://code.visualstudio.com/download) is Microsoft's cross-platform editor that we'll be using during orientation for writing C# and building .NET applications. Make sure you add the [C# extension](https://code.visualstudio.com/Docs/languages/csharp) immediately after installation completes.

> **NOTE:** On the second window, Select Additional Tasks, you will be prompted with checkbox options. Select all options under 'Other'. 

## VS Code Settings

If you haven't already set up Visual Studio Code to format your code and autosave your files, now is a good time to set that up. Inside VS Code go to the settings by using the shortcut `ctrl` + `,` and using the search bar find the `Format On Save` setting and make sure it is checked. Next find the setting for `Auto Save` and make sure that it's set to either "onFocusChange" or "onWindowChange" (whatever you prefer)

## Postman

1. Install [Postman](https://www.postman.com/downloads/) for testing APIs.

## Terminal

1. Install [Git For Windows](https://gitforwindows.org/). This comes with the `git-bash` bash prompt we will be using throughout the backend.
1. Install [Windows Terminal](https://www.microsoft.com/en-us/p/windows-terminal/9n0dx20hk701?activetab=pivot:overviewtab)
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

   1. Find the `defaultProfile` key near the top of the file. Updates its value to be `"{00000000-0000-0000-ba54-000000000002}"`
   1. Save the `settings.json` file and close Visual Studio Code.
1. Open your terminal and create a workspace directory `mkdir ~/workspace`

### Creating Your SSH Key For Github

Watch a short video for [creating an SSH key in the terminal](https://youtu.be/znRMcNG9_qQ) so that you can work with Github.

### Add SSH Key to Github Account

Now watch the video for [adding your SSH key to your Github account](https://youtu.be/8hlmIObpMd4).

### Configuring Git

First we'll configure git to use `main` as the default branch instead of `master`.

```sh
git config --global init.defaultBranch main
```

Next, in order for Git to know who made a commit, we have to set the username and email properties in the git config. 

In the terminal, paste the following and add your email:

```sh
git config --global user.email "you@example.com"
```

In the terminal, paste the following and add your name:

```sh
git config --global user.name "Your Name"
```

Finally, we will tell git which _merge strategy_ to use when we do a `git pull`.

```sh
git config --global pull.rebase false
```

## Node

1. Install [Node](https://nodejs.org/en/) for working with JavaScript tools

> **NOTE:** You will be prompted with a checkbox in the window 'Tools for Native Modules' that asks, 'Automatically install the necessary tools. Note that this will also install Chocolatey. The script will pop-up in a new window after the installation completes'. You must leave this checkbox *unchecked*, which is the default setting.
>
> After installing node, you should close and reopen your terminal window before continuing.

2. Install `serve` and `json-server`

```sh
npm i -g serve json-server
```

## .NET

1. Install .NET from https://dotnet.microsoft.com/download
   * Click the `Download .NET SDK x64` button under the large `.NET` header on the left side. This will download the _.NET 5 Software Development Kit_
1. Open a terminal and run `dotnet --version`. You should see a version greater than or equal to `5.0.103`

## Gitignore Shortcut

You'll be making a lot of new projects and we want to easily be able to create a gitignore file before pushing to Github. Run the following code from a git bash window

```sh
echo "dnignore() {
    curl -L -s 'https://raw.githubusercontent.com/github/gitignore/master/VisualStudio.gitignore' > .gitignore
}" >> ~/.bashrc
```

You now have access in your terminal to a command called `dnignore` which will add a gitignore file to your project.

## Always Open a Terminal Window in Last Directory
If you would like your terminal window to always open in the last directory you were in, then you can run the following code in your terminal.

```sh
echo $'\n \n
# always remember last directory
cd() {
  builtin cd "$@"
  pwd > ~/.last_dir
}
if [ -f ~/.last_dir ]; then
  cd "`cat ~/.last_dir`"
fi' >> ~/.bashrc
```

## Visual Studio IDE

 [Visual Studio Community Edition](https://visualstudio.microsoft.com/vs/community/). This will be your main code authoring tool for the server-side course.
   > **INFO:** When installing Visual Studio, you will be presented with a variety of workloads. Select the following workloads.
   >
   > - ASP.NET and web development
   > - .NET Core cross-platform development

## SQL Server Express Database

[SQL Server Express](https://www.microsoft.com/en-us/sql-server/sql-server-downloads). This is the database tool where all your data will be stored for the server-side course. Click the Download button under the Express option. During the setup, take the basic installation option


## Installation Check
Now that you have finished the installation process, please double check that you have not missed something.

### Installation Check: Start Menu
Check that you have the following programs by pressing your Windows key (Windows keyboard) or Command key (Apple keyboard) to open the Start menu, and begin typing in the name of the following progams to see that they are installed:

```ssh
Zoom
Slack
Postman
Google Chrome
Visual Studio
Visual Studio Code
Windows Terminal
Mozilla Firefox (if you installed it)
SQL Server 2019 Configuration Manager
```

### Installation Check: Terminal Commands
Finally, run the following commands in Windows Terminal to check that the following are installed or set correctly. Example outputs are listed under each command:

```ssh
$ git --version
git version 2.28.0.windows.1
```

```ssh
$ node -v
v12.16.3
```

```ssh
$ serve -v
11.3.2
```

```ssh
$ json-server -v
0.16.3
```

```ssh
$ dotnet --version
5.0.103
```

```ssh
$ ls -al ~/.ssh
drwxr-xr-x 1 mecar 197609    0 May 22  2020 ./  
drwxr-xr-x 1 mecar 197609    0 Feb 26 13:41 ../  
-rw-r--r-- 1 mecar 197609 3434 May 20  2020 id_rsa  
-rw-r--r-- 1 mecar 197609  751 May 20  2020 id_rsa.pub  
-rw-r--r-- 1 mecar 197609  751 May 20  2020 id_rsa.pub  
-rw-r--r-- 1 mecar 197609 2375 Jun  1  2020 known_hosts  
```

```ssh
$ git config --list
user.email=youremail@example.com  
user.name=yourGitHubUsername  
pull.rebase=false  
init.defaultbranch=main  
```
> **Note:** There are many settings listed. You only need to check `user.email`, `user.name`, `pull.rebase`, & `init.defaultBranch`.

```ssh
$ type dnignore
dnignore is a function  
dnignore ()  
{  
   curl -L -s "https://<span></span>raw.githu<span></span>busercontent.<span></span>com/dotnet/core/master/.gitignore" > .gitignore  
}
```

```ssh
$ type cd
cd is a function  
cd ()  
{  
   builtin cd "$@";  
   pwd > ~/.last_dir  
}
```
> **Note:** Only if you chose to run the command to always open a terminal window in the last directory.

## Bookmark the Following Sites

[dbdiagram.io](http://dbdiagram.io) web application for creating ERDs (Entity Relationship Diagrams).

https://docs.asp.net/en/latest/getting-started.html

https://docs.microsoft.com/en-us/dotnet/

### .NET on YouTube

- **Main page**: https://www.youtube.com/channel/UCvtT19MZW8dq5Wwfu6B0oxw
- **C# 101**: https://www.youtube.com/watch?v=BM4CHBmAPh4&list=PLdo4fOZ0oVxKLQCHpiUWun7vlJJvUiN
- **.NET 101**: https://www.youtube.com/watch?v=eIHKZfgddLM&list=PLdo4fOcmZ0oWoazjhXQzBKMrFuArxpW80