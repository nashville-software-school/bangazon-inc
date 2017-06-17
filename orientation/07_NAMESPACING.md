# Namespace for Organizing Code

The `namespace` keyword is used for organizing related classes into a common package. Here's a simple example.

> `Product.cs`

```cs
using System;

namespace Bangazon.Products
{
    public class Product {}
}
```

> `Order.cs`

```cs
using System;

/*
    Providing the additional namespace to the classes makes it easier
    for other developers to understand where the code is coming from
    and how it fits into the mental context of the code base.
*/
using Bangazon.Products.Product;
using Bangazon.Products.ProductType;

namespace Bangazon.Orders
{
    public class Order {}
}
```

> `AccountOverview.cs`

```cs
using System;
using Bangazon.Products.Product;
using Bangazon.Orders.Order;

namespace Bangazon.Account
{
    public class AccountOverview {}
}
```

> **Resource:** [Namespaces (C# Programming Guide)
](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/namespaces/)