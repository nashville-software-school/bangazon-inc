#C Sharp Tour (Creating and modifying a simple application)

##You will learn the basics of the C# language. For more detail visit https://docs.microsoft.com/en-us/dotnet/articles/csharp/tour-of-csharp/index

Let' start by building a simple application. We will look at the program structure. 
1. Create a new folder called "HelloBangazon"
2. In the integrated terminal, cd to the directory
3. Run the command to create a new command line app: dotnet new
4. Run the command to add needed libraries: dotnet restore
5. Run the command to build the app: dotnet build
6. Run the command to build the app: dotnet run.

##Lets Look at this app. 
It starts with the class called "Program". The function "Main" in the starting point of the app. 

Notice the "using" statement. In this case we are using the "System" namespace. A name space is a way of organizing programs and libraries.
The "System" name space contains many types including console, which is referenced in the program. 


At this point the main method only writes out the phrase "Hello World".

Notice the namespace. In this case it is called "ConsoleApplication", lets rename it "HelloBangazon". 

Lets have our app write out a more interesting message the user. 
Modify the code to look like this:
```
public static void Main(string[] args)
        {
            DateTime purchaseDate=DateTime.Now;
            string lastName="Smith"; 
            var firstName="Bill";
            Console.WriteLine(purchaseDate);
        }
```
Notice that we declared the first and last names differently. Dotnet can use implicity typed variables, which means it infers the datatype by the way it is used.
It would be better to refactor the code to look like this.
```
 public static void Main(string[] args)
        {
            var purchaseDate=DateTime.Now;
            var lastName="Smith"; 
            var firstName="Bill";
            Console.WriteLine(purchaseDate);
        }
```
##Let's build a more informative message
Modify the code to look like this:
```
 public static void Main(string[] args)
        {
            var purchaseDate=DateTime.Now;
            var paymentDueDate=purchaseDate.AddDays(30);
            var lastName="Smith"; 
            var firstName="Bill";
            var message="Hello " + firstName + " " + lastName + ". " + "Your payment is due " + paymentDueDate;
            Console.WriteLine(message);
        }
```
##More Refactoring
Formatting strings can become cumbersome, DotNet has a string builder class that makes it easier and cleaner.
To use the "System.Text" name space. You will also modify the payment due date to be formatted like "1/1/2018'

```
 public static void Main(string[] args)
        {
            var purchaseDate=DateTime.Now;
            var paymentDueDate=purchaseDate.AddDays(30);
            var lastName="Smith"; 
            var firstName="Bill";
            var message= "your payment is due " + paymentDueDate.ToString("d");
            var formalName=firstName + " " + lastName;

            //Build the specific user message
            var sb=new StringBuilder();
            sb.Append("Hello ");
            sb.Append(formalName);
            sb.Append(" " );
            sb.Append(message);

            Console.WriteLine(sb.ToString());
        }

```
##More Refactoring
Our main method is starting to get messy. Lets move the logic we created to display the greetng to it's own function. 
```
 public static void Main(string[] args)
        {
            Console.WriteLine(CustomerGreeting().ToString());
        }
        public static string CustomerGreeting()
        {
            var purchaseDate=DateTime.Now;
            var paymentDueDate=purchaseDate.AddDays(30);
            var lastName="Smith"; 
            var firstName="Bill";
            var message= "your payment is due " + paymentDueDate.ToString("d");
            var formalName=firstName + " " + lastName;

            //Build the specific user message
            var sb=new StringBuilder();
            sb.Append("Hello ");
            sb.Append(formalName);
            sb.Append(" " );
            sb.Append(message);
            return sb.ToString();
        }
```
