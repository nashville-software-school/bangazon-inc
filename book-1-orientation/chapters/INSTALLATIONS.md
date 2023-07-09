# Installing Required Software in Windows

---

## Objectives

After completing this chapter you should be able to:

1. Informally describe what it means to install software
1. Install and configure the tools mentioned in this chapter on a new Windows computer

---

## .NET

1. Install .NET 6 from [here](https://dotnet.microsoft.com/en-us/download/dotnet/thank-you/sdk-6.0.411-windows-x64-installer)
   * Run the program once it is downloaded
1. Open a terminal and run `dotnet --version`. You should see a version equal to `6.0.411`

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
   > **INFO:** When installing Visual Studio, you will be presented with a variety of workloads. Select the following workload:
   >
   > - ASP.NET and web development




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

> **NOTE:** The version numbers you see may be higher than those listed below. It's completely fine to have a higher version of any of these tools, but if you have a lower version, please ask an instructor to take a look.

```sh
$ git --version
git version 2.28.0.windows.1
```

```sh
$ node -v
v12.16.3
```

```sh
$ serve -v
11.3.2
```

```sh
$ json-server -v
0.16.3
```

```sh
$ dotnet --version
6.0.411
```

```sh
$ ls -al ~/.ssh
drwxr-xr-x 1 mecar 197609    0 May 22  2020 ./  
drwxr-xr-x 1 mecar 197609    0 Feb 26 13:41 ../  
-rw-r--r-- 1 mecar 197609 3434 May 20  2020 id_rsa  
-rw-r--r-- 1 mecar 197609  751 May 20  2020 id_rsa.pub  
-rw-r--r-- 1 mecar 197609  751 May 20  2020 id_rsa.pub  
-rw-r--r-- 1 mecar 197609 2375 Jun  1  2020 known_hosts  
```

```sh
$ git config --list
user.email=youremail@example.com  
user.name=Your Name 
pull.rebase=false  
init.defaultbranch=main  
```

> **Note:** There are many settings listed. You only need to check `user.email`, `user.name`, `pull.rebase`, & `init.defaultBranch`.
```sh
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

* **Main page**: https://www.youtube.com/channel/UCvtT19MZW8dq5Wwfu6B0oxw
* **C# 101**: https://www.youtube.com/watch?v=BM4CHBmAPh4&list=PLdo4fOZ0oVxKLQCHpiUWun7vlJJvUiN
* **.NET 101**: https://www.youtube.com/watch?v=eIHKZfgddLM&list=PLdo4fOcmZ0oWoazjhXQzBKMrFuArxpW80
