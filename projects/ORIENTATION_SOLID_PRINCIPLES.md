#S.O.L.I.D: The Principles of Object Oriented Design

##Single Responsibility Principle
A class or function should have one and only one reason to change, meaning that a class should have only one job. In the following example 
function to looks up user permissions called GetUserPermissions really does not belong in a class called product. It more likely belongs in a class related to the user. 
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
  to cleanly handle  product having different delivery strategies (in-store pickup, online shippable, and digital downloads). Greate a base class instead.   
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
 
 The base class is called Refund.
 All classes that inherit from the Refund class must implement the "MakeRefund" function and return a string. 
 ```
  public abstract class Refund
   {  
   public abstract string MakeRefund(decimal amount, string transactionId);
   }
 ```
This class called PayPalRefund implements the Refund class. The MakeRefund function returns a string and accepts the same arguments as the refund class. 
 ```
  public class PayPalRefund:Refund
   {
       public string Override MakeRefund(decimal amount, string transactionId)
       {
           string response=PayPalWebService payPalWebService = new PayPalWebService();
              string token = payPalWebService.GetTransactionToken(AccountName, Password);
            string response = payPalWebService.MakeRefund(amount, transactionId, token);
            return response;
       };
   }
   ```
This class called VisaRefund implements the Refund class. The MakeRefund function returns a string and accepts the same arguments as the refund class which is the base class .  
```
   public class VisaRefund:Refund
   {
       public string Override MakeRefund(decimal amount, string transactionId)
       {
            string response=VisaRefundService visaRefundService = new VisaRefundService();
            string token = visaRefundService payPalWebService.GetTransactionToken(AccountName, Password);
            string response = VisaRefundService.MakeRefund(amount, transactionId, token);
            return response;
       };
   }
```
#Interface Segregation Principle

An interface should not force classes that implement it to use methods they do not need. An example would a interface that defines product delivery. It would not make sense to define a function for both physical shipping and digital delivery. It would make more sense to have just a method called DeliverProduct and the implementing classes can at that point implement shipping in the way that is more specific to the product being delivered. As the class below is written both the "ShipProduct" and the "DeliverProductDigitally" must be implemented or the code will not compile.  

```
  interface IProductDelivery
    {
       int CustomerId{get;set;}
       int OrderId{get;set;}
       string ShippingAddress {get;set;}
       string Email{get;set;}
       string ShipProduct();
       string DeliverProductDigitally(int orderid);
    }
```
Something like this more flexible and will not force developers trying to implement your interface to implement methods they don't need. 
```
interface IProductDelivery
    {
    int CustomerId{get;set;}
    int OrderId{get;set;}
    string ShippingAddress {get;set;}
    string Email{get;set;}
    string ShipProduct();
    string DeliverProduct(int orderid);
    }
```
#Dependency Inversion Principle
A. High-level modules should not depend on low-level modules. Both should depend on abstractions.
B. Abstractions should not depend upon details. Details should depend upon abstractions.

The Dependency Inversion Principle (DIP) helps to decouple your code by ensuring that you depend on abstractions rather than concrete implementations. The frequency of the ‘new’ keyword in your code is a rough estimate of the degree of coupling in your object structure. Often times instead of "newing Up and object" you will instead pass in an interface for the object into the constructor. You will be coding against ther interface rather than a concrete implementation. More detail here: https://dotnetcodr.com/2013/08/26/solid-design-principles-in-net-the-dependency-inversion-principle-and-the-dependency-injection-pattern/

```
public class ProductService
{
    private IProductRepository _productRepository;
 
    public ProductService(IProductRepository productRepository)
    {
        _productRepository = productRepository;
    }
 
    public IEnumerable<Product> GetProducts(IProductDiscountStrategy productDiscount)
    {
        IEnumerable<Product> productsFromDataStore = _productRepository.FindAll();
        foreach (Product p in productsFromDataStore)
        {
            p.AdjustPrice(productDiscount);
        }
        return productsFromDataStore;
    }
}
```









   
 

  
  
