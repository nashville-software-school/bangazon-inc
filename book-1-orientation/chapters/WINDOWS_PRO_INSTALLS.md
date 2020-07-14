# Things to Install for Development on Windows

1. Chrome
1. [Git for Windows](https://gitforwindows.org/) - Accept all defaults during installation.
1. Once the installation is complete, open Git Bash and enter in the following command.
    ```sh
    git config --global core.longpaths true
    ```
1. [Create an SSH key](https://help.github.com/en/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent#platform-windows) on your Windows VM, and add it to your Github profile.
1. [Postman](https://www.getpostman.com/) for testing APIs.
1. [SQL Server Express](https://www.microsoft.com/en-us/sql-server/sql-server-editions-express). This is the database tool where all your data will be stored for the server-side course.
1. [Visual Studio Code](https://code.visualstudio.com/) for when you need to open files that have nothing to do with your code. The full Visual Studio IDE can be overkill for editing simple text files.
1. [Visual Studio Community Edition](https://visualstudio.microsoft.com/vs/community/). This will be your main code authoring tool for the server-side course.
    > **INFO:** When installing Visual Studio, you will be presented with a variety of workloads. Select the following workloads.
    > * ASP.NET and web development
    > * .NET Core cross-platform development
