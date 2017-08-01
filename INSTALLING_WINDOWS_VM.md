# Install Windows 8.1 on OSX

## Prerequisites

1. Install [Oracle VirtualBox](https://www.virtualbox.org/wiki/Downloads). Make sure you click on the OSX Hosts link.
1. Install [Vagrant](https://www.vagrantup.com/)

## Getting the Windows Vagrant Image

Create a directory in your home directory named `VirtualBoxes`. In that directory, type the following commands.


```
vagrant init jaswsinc/windows81 --box-version 1.0
vagrant up
```

This will start the process of downloading the entire Windows 8.1 operating system, as a single file, to your hard drive. Once the download is complete, open VirtualBox, and right click on the item on the left and choose the "Show" option.

You will then see Microsoft Windows starting up.

## Installing Visual Studio

Once you are logged into Windows, open up Internet Explorer, and download Visual Studio 2017 Community Edition. Don't worry, it's free.

Run the installer that gets downloaded, and on the first window that appears, click "Individual Components" at the top of the screen. Make sure the following items are checked.

1. .NET Core runtime
2. ASP.NET Web development tools
3. Nuget package manager
4. SQL Server LocalDB
5. Entity Framework 6

Then click install at the bottom.
