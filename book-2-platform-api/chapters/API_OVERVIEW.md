# ASP.NET Web API

In the client side course, you learned how to create a JSON based API using `json-server`. You also, likely, consumed a third-party API for your client side capstone project. Organizations provide APIs so that software developers can build interesting products based on their data.

With ASP.NET, you can use the Web API project type to actually build business logic into your API. `json-server` was severely limited in that it could only create, update, and read JavaScript objects in arrays in your JSON file. In the upcoming sprint, you can perform multiple actions in response to a request from a client.

For example, if someone wants to buy a product from Bangazon, the software can submit a POST request to the `Order` resource. However, in the Bangazon ERD, products are attached to order via the `OrderProduct` table. In the logic that handles the POST request, you can perform the following logical steps.

1. Is there enough inventory left for the product?
1. If not, reject the request with an error message.
1. If there is, check if the customer already has an order in the system that hasn't been paid for.
1. If so, insert data into the `OrderProduct`
1. If not, create a new order in the database and then insert data into the `OrderProduct` table.

That's some complex logic that your API will handle instead of forcing the client software developer make all those checks. Which is what you would have had to do before with a React client and a simple JSON API using `json-server`.

## Resources

1. [Create a Web API with ASP.NET Core and Visual Studio](https://docs.microsoft.com/en-us/aspnet/core/tutorials/first-web-api?view=aspnetcore-2.1) - This tutorial uses Entity Framework, not Dapper, but still is a good tutorial to see how everything works.
