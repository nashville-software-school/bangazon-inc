# Mocking
*****
### Testing
* Test one method at a time - it goes in // Action of test.
* Need to come up with // Assert.
* Figuring out how to // Arrange is the hard part (to get it to run).

## MOCKS

Why Moq?  It isolates unit tests which are run in a random order and will modify DB if it is not isolated for the test.

#### Stub methods
When using Moq DB, if method() is called, don't execute full method - just return fake data.

### Read
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