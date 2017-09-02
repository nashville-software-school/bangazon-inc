# Mocking

## Testing

* Action - Each test should have the code required to test an action, or feature, of your program.
* Assert - What should be true, or what state should an object be in when code is executed.
* Arrange - Building out the classes and methods needed to make meet the assertion.

## Mocking

Why Moq?  It isolates unit tests which are run in a random order and will modify DB if it is not isolated for the test.

### Stub methods

When using Moq DB, if method() is called, don't execute full method - just return fake data.

### Reference Articles

* http://martinfowler.com/articles/mocksArentStubs.html
* Moq: an enjoyable mocking library for .NET ->
http://www.nuget.org/packages/Moq
* http://www.russellallen.info/post/Unit-Testing-Good-Patterns-3-Know-Your-Moq-Argument-Matchers!.aspx

### Repos for managing Moq 4.x

* https://github.com/Moq/moq4/

### How To

To add Moq to your solution, you want to right click on your test project (in solution explorer) and go to the NuGet package manager...

* Moq/moq4 Quickstart -> https://github.com/Moq/moq4/wiki/Quickstart
* Moq Documentation -> http://www.nudoq.org/#!/Projects/Moq