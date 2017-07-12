# Calculator Unit Tests

In this exercise, you're going to create a program that tests the functionality of a Calculator class.

## Setup

```
mkdir -p ~/workspace/csharp/exercises/calculator/Calculator && cd $_
dotnet new console
dotnet restore
mkdir ../Calculator.Tests && cd $_
dotnet new xunit
dotnet add reference ../Calculator/Calculator.csproj 
dotnet restore
cd .. && code .
```

##### Starter code for test class

```cs
using System;
using Xunit;

namespace Calculator.Tests
{
    public class CalculatorShould
    {
        private Calculator _calculator;

        public CalculatorShould()
        {
            _calculator = new Calculator();
        }

        [Fact]
        public void AddTwoIntegers()
        {
            // Given this input to the method
            int sum = _calculator.Add(54, 29);

            // We are asserting that the output should be this
            Assert.Equal(sum, 83);
        }
    }
}
```
