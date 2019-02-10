# Windows Installations and Configuration

## SQL Server Express

This is the relationship database management system that will store your tables and data.

## SQL Server Management Studio

This tool allows you to interact with SQL Server Express. You can review tables and columns, and create files for authoring your SQL.

## Visual Studio Community Edition

This will be your coding and debugging environment. No more using Visual Studio Code. When you are prompted for which packages to install, choose the following two.

1. ASP.NET Web Development
1. .NET cross platform development

## Github SSH Key (for those using virtual machine)

Since the virtual machine you created is a separate operating system, your SSH key that you've been using so far on the host operating system - whether OSX or Linux - is not accessible any longer.

1. In the Windows virtual machine, create a new SSH key
1. In your Github profile settings, create a new SSH key entry and paste in the contents of your public key (e.g. `id_rsa.pub`) that you created in Windows.

## Postman

[Postman](https://www.getpostman.com/apps) will allow you to generate requests to an API without having to write code.
