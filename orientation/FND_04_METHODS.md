# Accessibility

## Public Methods

Public method are available for use by external code that creates an instance of the class.

```cs
class PaymentType
{
    private string _cardNumber;
    private string _cvv;
    private string _cardHolderName;

    public string ToString ()
    {
        return $"{cardNumber} {_cvv} {_cardHolderName}", )
    }
}
```

## Private Methods

Private methods are used by the class for perform calculations or change its internal state, and should be hidden from external code.

```cs
class PaymentType
{
    private string _cardNumber;
    private string _cvv;
    private string _cardHolderName;

    /*
        Provide a public interface to external code to perform a high
        level process, but how the actual implementation of that
        process is hidden to external code.

        - Information hiding
        - Encapsulation
    */
    public string ProcessPayment (decimal amount)
    {
        ConnectToProvider();

        if (VerifyDetails(cardNumber, CVV) && ConfirmPayment(amount))
        {
            CreateEscrowEntry(amount);
        }
    }

    private void ConnectToProvider()
    {
        ...
    }

    private bool ConfirmPayment()
    {
        ...
    }

    private void CreateEscrowEntry()
    {
        ...
    }

    private bool VerifyDetails()
    {
        ...
    }
}
```

# Return Value vs. No Return Value

If a method returns a value, you must explicitly tell the compiler the return value's type (`string`, `int`, `decimal`, `double`, etc.). If the method has no return value, then you must tell the compiler that with `void`.

```cs
// This method performs a calculation and returns the calculated value
public decimal FinalPrice (double unitPrice, 
                           double stateTaxRate, 
                           double shippingCharge)
{
    double basePrice = unitPrice + shippingCharge;
    return basePrice + (basePrice * stateTaxRate);
}

// This method sets the value of a field, and has no return value
public void SetContainerSize (int width, int height, int depth)
{
    _shippingContainerVolume = width * height * depth;
}
```

# Static vs. Instance

Instance methods require that a new instance exists in order to use the method.

## Instance Methods

```cs
public class Box
{
    public void Open () {
        ...
    }

    public void Close () {
        ...
    }
}

// New object based on Box class created
Box cardboardBox = new Box();

// Open and Close methods can be used
cardboardBox.Open();
cardboardBox.Close();
```

## Static Methods

If a a series of logic needs to be performed, but an object instance isn't required, then the method should be defined as `static`.

```cs
public class Utilities
{
    public static int AddTwoNumbers (int first, int second)
    {
        return first + second;
    }
}
````

