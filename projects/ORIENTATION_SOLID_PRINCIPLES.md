#S.O.L.I.D: The Principles of Object Oriented Design

##Single Responsibility Principle
A class or function should have one and only one reason to change, meaning that a class should have only one job. In the following example 
function to look up user permissions called GetUserPermissions really does not belong in a class called product. It more likely belongs in a class related to the user. 
```
public class Products
   {
       public void AddProduct(string name, string description, decimal price)
       {
           var product =new Product
           {
               Name=name,
               Description=description,
               Price=price
           };

       }
       
       public void RemoveProduct(int productid)
       {
           //remove a product from inventory
       }
       
      public void DiscountProductPrice(int productid, decimal percent)
       {
           //get the discounted price
       }
       
       public int GetUserPermissions(int userid)
       {
                //find out what permission level a user has
                 return 4;
       }

  }
```

  
##Open Closed Principle
  
 Software entities (classes, modules, functions, etc.) should be open for extension, but closed for modification. In the following code sample.
  Products may not always be shipped or even a weight so it might make more sense to inherit from an abstract product class that contains only the
  commonalities between products for example (price, description, name..) . The sub class can calculate shipping if it is a physical product but a digital product
  may have a download method in it's class. The following code needs refactored it would be a ["code smell"](https://en.wikipedia.org/wiki/Code_smell). This code would need refactoring to be able 
  to cleanly handle product types (in-store pickup, online shippable, and digital downloads). Greate a base class instead. 
  
  ```
   public class Products
   {
       public void AddProduct(string name, string description, decimal price, decimal weight)
       {
           var product =new Product
           {
               Name=name,
               Description=description,
               Price=price,
               Weight=weight
           };

       }

       public void RemoveProduct(int productid)
       {
           //remove a product from inventory
       }
      public void DiscountProductPrice(int productid, decimal percent)
       {
           //get the discounted price
       }
       public decimal CalculateShipping(decimal weight )
       {
                //get shipping cost
                 return 4.3m;
       }

  }
```

#Liskov Substitution Principle
 You should be able to use any derived class in place of a parent class and have it behave in the same manner without modification. 
 It ensures that a derived class does not affect the behaviour of the parent class, i.e. that a derived class must be substitutable for its base class. In the sample below we have an abstract class called "Refund". Refunds will vary
 depending on payment type. The derived classes must implement the method "MakeRefund". In all cases "MakeRefund" will return a string "success" or "fail".
 
 Base Class called Refund
 All classes that inherit from the Refund class must implement the "MakeRefund" function and return a string. 
 ```
  public abstract class Refund
   {  
   public abstract string MakeRefund(decimal amount, string transactionId);
   }
 ```
 

  
  
