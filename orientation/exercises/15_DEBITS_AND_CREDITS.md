# Banks and Tellers

This exercise is an introduction to writing command line applications that interact with the user, and store their data in a persistent SQLite database. You may want to review the [Command Line User Input](../13_CLI_IO.md) tutorial again before starting on this one.

## Setup

```sh
mkdir -p ~/workspace/csharp/exercises/BankTeller && cd $_
dotnet new console
dotnet add package Microsoft.Data.SQLite --version 2.0.0
dotnet restore
touch bankteller.db
code .
```

## Interface Guidelines

You are going to create a command line application to act as a bank teller. This interface will allow you to create a customer, add money to an account, withdraw money from an account, and show the balance.

```sh
WELCOME TO NASHVILLE SAFE & SOUND BANK
**************************************
1. Create customer account
2. Deposit money
3. Withdraw money
4. Show account balance
5. Exit
```

```sh
Enter the customer name
>
```

```sh
How much would you like to deposit?
>
```

```sh
How much would you like to withdraw?
>
```

```sh
Current Account Balance for Javon Lewis
$ 11,402.36
```

## Starter Code

Clone the [Bank Teller starter code](https://github.com/stevebrownlee/csharp-bankteller-boilerplate) repository and use it to complete this exercise.
