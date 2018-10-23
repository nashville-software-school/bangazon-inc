# Static in C#

In C# all your code must be inside a `class`. Normally a class acts as a blueprint for creating objects within your program. However, there are times when you don't need to create a new object in order get your work done. Sometimes you just need a function or a property without the "context" of an object.

This is where the `static` classes come in.

Consider the following.

```csharp
public static class MathUtils {
    public static double PI {
        get {
            return 3.14159;
        }
    }

    public static int Pow(int num, int exponent) {
        int result = 1;
       for(int i=0; i<exponent; i++) {
            result = result * num;
        }
        return result;
    }
}
```