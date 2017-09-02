# Install Windows 8.1 on OSX

## Prerequisites

1. Install [Oracle VirtualBox](https://www.virtualbox.org/wiki/Downloads). Make sure you click on the OSX Hosts link.
1. Install [Vagrant](https://www.vagrantup.com/)
1. Install [Git Bash](https://git-scm.com/downloads)

## Windows Installation

Nashville Software School has many licenses for Windows 8.1, and the staff will assist you in getting it installed on a virtual machine that will be managed by VirtualBox.

## Installing Development Tools

Once you are logged into Windows, these are the installations that you need to perform.

1. Google Chrome
1. Visual Studio 2017 Community Edition (see installation instructions below)
1. SQL Server 2016 Express Edition

### Visual Studio Configuration

Run the installer for Visual Studio that gets downloaded, and on the first window that appears, make sure the following items are checked.

1. ASP.NET Web Development Tools
1. .NET Core Cross Platform Development

Then click install at the bottom.

## Installing a Comfortable Terminal

Install the [Babun terminal](http://babun.github.io/). This terminal for Windows allows you to continue to use the same commands, aliases, and functions that you've been using on your Mac. It needs to install a lot of files, so the installation takes about 5-10 minutes.

## Launching Visual Studio from your Terminal

Developers are used to being able to control their computer from a bash terminal - including launching their favorite code editor. Here's how you can do the same thing with Visual Studio.

1. Make sure you have Visual Studio Community 2017 installed.
1. In Babun type `cd` to get to your home directory, and then `vim .zshrc` to edit your launch configuration file.
1. Update your path to look in the directory that contains the Visual Studio launcher executable. Paste the following commands at the end of the file.

    ```sh
    # Add the Visual Studio executable to the path
    export PATH=$PATH:/cygdrive/c/Program\ Files\ \(x86\)/Microsoft\ Visual\ Studio/2017/Community/Common7/IDE

    # Alias the will launch Visual Studio with the `studio` command
    # and push the process to the background so that the current
    # bash can continue to be used instead of locked to the VS process
    studio () {
        nohup devenv $1 &>/dev/null &
    }
    ```
1. Save and exit vim.


Now, you can launch Visual Studio with the `studio` command and provide a path to a Solution file.

```
~ $ cd ~/workspace/bangazon/website
~/worksapce/bangazon/website  <master>$ studio ./BangazonWebSite.sln
```
