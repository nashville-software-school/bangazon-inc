# Deploying to Azure

Deploying to Microsoft Azure Cloud is a straightforward process.

## Sign Up

First you sign for a free tier account on [azure.microsoft.com](https://azure.microsoft.com/en-us/) by click the _**Start Free**_ link on the main page. You will be asked for your credit card info, but you get $200 credit which should last long enough for your job search.

## Creating a SQL Server

Next, you will deploy your database from SQL Server Management Studio (SSMS).

[You may need to update SSMS first](https://docs.microsoft.com/en-us/sql/ssms/download-sql-server-management-studio-ssms?view=sql-server-2017).

Go to [portal.azure.com](https://portal.azure.com) and once you are signed in, click on _**SQL Databases**_ on the left. Click the _Add_ button at the top and complete all of the steps for creating a new SQL Server. This can just be a sample database-- it doesn't have to be named the same thing as your capstone. You're basically just using this databse to create a new instance of a SQL Server.

> **Reference:** [Quickstart: Create an Azure SQL database in the Azure portal](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-get-started-portal)

## Connect SSMS to Azure

Follow the steps in the [Quickstart: Azure SQL Database: Use SQL Server Management Studio to connect and query data](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-connect-query-ssms) tutorial to connect to your new SQL Server.

## Deploy your Database

1. Open SSMS
1. Navigate to your database
1. Right click and select _Tasks > Deploy Database to Microsoft Azure_
1. Follow the steps in the tool that appears.
  - In the first window that pops up, select "App Service" from the menu bar on the left.
  - Select "Create New"
  - In the next view, the resource group that you created when you created your sample database should show up. Select it from the dropdown.

## Connect your Application to your Azure Database

1. Go back to your Azure portal and refresh to see your new database
1. Select your new database
1. Select the _Connection Strings_ item from the sub-menu
1. Copy the connection string and paste it into your `appsettings.json` file in your project.
1. Replace `{your_username}` with the username you created for the database. 
1. Replace `{your_password}` with the password you created for the database.
1. In both previous steps, don't forget to take out the curly braces!

## Testing your Azure Database

Start your application and make sure it connects correctly to your SQL Server database on Azure.

## Deploy your Application

1. In Visual Studio, right click your project and select _Publish_ from the menu.
1. Follow the steps in the deployment tool that appears.
1. When complete, you can click on the `Site URL` it created for you.

That's it. Your application is now deployed.
