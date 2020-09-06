# Testing

Say you're working on a brand new application. You pull your first ticket and start implementing the user story. You write some code and think that everything you just wrote should work--but how do you know? You probably run the application, walk through the appropriate steps, observe the app's behavior and see if matches your expectations. This process is considered **manual** testing. If the outcome you observe with your own eyes matches your expectations, you can probably start moving that ticket closer to your "DONE" column and move on to the next, and rinse and repeat. But when you pick up that 2nd ticket and complete it, what assurances do you have that you didn't break the 1st ticket in the process? You might be saying "well, I'll go back and test that the 1st ticket is still working." Imagine though that you're a few months into this application, and you've implemented hundreds of user stories. How can you be sure that your new code is not breaking your old code? The manual testing strategy is not sustainable. We should automate this process. Here's a peek at a simple example of an automated test we might write to confirm that the `Add` method in our Gifter `PostRepository` methods is working as expected:

```csharp
[Fact]
public void PostRepository_Can_Add_New_Post()
{
    // Get all posts and count them
    var repo = new PostRepository(_context);
    var startingPosts = repo.GetAll();
    var startingCount = startingPosts.Count;

    // Add new Post -- THIS IS THE PART WE'RE TESTING
    var newPost = new Post() { Title = "Test Title", ImageUrl = "Test Url", UserProfileId = 1 };
    repo.Add(newPost);

    // Get all posts again and count them
    var resultingPosts = repo.GetAll();
    var resultingCount = resultingPosts.Count;

    // Check that one has been added
    Assert.NotEqual(0, newPost.Id);
    Assert.Equal(startingCount + 1, resultingCount);
}
```

It might seem weird to think about writing code to test our code, but this is an important step in the development process. If we write tests for our code as we go ([or even _before_ we start writing our code](https://www.agilealliance.org/glossary/tdd/#q=~(infinite~false~filters~(postType~(~'page~'post~'aa_book~'aa_event_session~'aa_experience_report~'aa_glossary~'aa_research_paper~'aa_video)~tags~(~'tdd))~searchTerm~'~sort~false~sortDirection~'asc~page~1))), we can have peace of mind knowing that it works _and_ if it ever stops working in the future, we'll know.

## Types of Automated Testing

There are a few common types of automated tests you'll write during the development process

- **Unit Testing** - Testing a single method. The example above, for instance, tests _only_ the `Add` method in the `PostRepository` class

- **Integration Testing** - Testing pieces of our system that are connected to one another. We might, for example, write an integration test that tests one of the routes in our API. To do this, we are interacting with more than just a single unit--we're interacting with a controller, repository, and database.

- **End to End (E2E) Testing** - These tests simulate the actual flow of an end user. In web development, E2E tests may involve automating the process of launching a browser, typing in form values, clicking buttons, etc.

In this chapter we'll look at how to write **unit** tests for the methods in Gifter's `PostRepository`. To do this, we're going to use a testing tool called XUnit

## Setup

The tests we write are not part of our application, so we don't put them in the same project, however they _can_ go in the same Visual Studio solution. Open up the Gifter application in Visual Studio and right click the top item in Solution Explorer marked `Solution 'Gifter'` and select Add > New Project. Search the templates for "xUnit Test Project (.NET Core)" and select the one for C#. Give it the name "Gifter.Tests". This will create a new project for you as well as a file to start writing some tests in that looks like this:

```csharp
using System;
using Xunit;

namespace Gifter.Tests
{
    public class UnitTest1
    {
        [Fact]
        public void Test1()
        {

        }
    }
}
```

Let's update this to write an incredibly simple test... 

```csharp
using System;
using Xunit;

namespace Gifter.Tests
{
    public class UnitTest1
    {
        [Fact]
        public void Two_Numbers_Should_Equal()
        {
            var num1 = 100;
            var num2 = 200;

            Assert.Equal(num1, num2);
        }
    }
}
```

Now let's see how we can execute this test to see the results. In Visual Studio, go to the top menu bar and select Test > Test Explorer. This opens the Test Explorer window where we can see and run all of our tests. Right click the name of the test project and select "Run". This will run our lone test called "Two Numbers Should Equal". The test will fail--but this is a good thing! We always want to start off by writing _failing_ tests. This ensures that we're not getting an false positives by accident. After the test fails, change the code in the test to make it pass and run it again. Your red X is now a green checkmark. Welcome to the joys of software development.

Now let's start setting up some more meaningful tests that will test the behavior of some of our PostRepository methods.


### Entity Framework Core

Our new test project will need access to Entity Framework Core, so we will need to add the EF nuget packages.

Add these Nuget package references to your test project's `*.csproj` file.

```xml
<PackageReference Include="Microsoft.EntityFrameworkCore" Version="3.1.5" />
<PackageReference Include="Microsoft.EntityFrameworkCore.Sqlite" Version="3.1.5" />
<PackageReference Include="Microsoft.EntityFrameworkCore.SqlServer" Version="3.1.5" />
```

### Reference the Project to Test

Our tests will be written to verify that the Gifter app behaves as we expect. This means we'll have to tell our test project about the Gifter project.

Add this project reference to your test project's `*.csproj` file.

```xml
<ItemGroup>
  <ProjectReference Include="..\Gifter\Gifter.csproj" />
</ItemGroup>
```

> **NOTE:** The Gifter app is referred to as the [_System Under Test_](https://en.wikipedia.org/wiki/System_under_test) (SUT).





## Writing Repository Tests

Ponder for a moment the example test earlier in this chapter that tested whether or not our `Add` method actually added something to the database. There is a problem that we have to consider: I want to be able to run that test as many times as I'd like, but I _don't_ want that ugly test data to actually be added to my database every time I run it. 

We can tell Entity Framework to actually use a _different_ database/connection string that's just for our tests. In fact, we're going to use an "in memory" database so that when we run a test, the following things will happen:

1. A brand new database will get created on the fly and live only in memory
2. (Optional) We'll pre-populate the database with some starter data
3. Our tests will run
4. The test database will get destroyed
5. Rinse and repeat

In Visual Studio Solution Explorer right click the Gifter.Test project and select Add > Class and name it `EFTestFixture.cs`. This will be where we set up the in-memory database. Add the following code

```csharp
using Gifter.Data;
using Microsoft.Data.Sqlite;
using Microsoft.EntityFrameworkCore;
using System;
using System.Linq;

namespace Gifter.Tests
{

    public class TestDbContext : ApplicationDbContext
    {
        public TestDbContext(DbContextOptions<ApplicationDbContext> options) : base(options) { }
        protected override void OnModelCreating(ModelBuilder builder)
        {
            builder.Model.GetEntityTypes()
                .Where(e => !e.IsOwned())
                .SelectMany(e => e.GetForeignKeys())
                .ToList()
                .ForEach(relationship => relationship.DeleteBehavior = DeleteBehavior.Restrict);
        }
    }

    public abstract class EFTestFixture : IDisposable
    {
        private const string _connectionString = "DataSource=:memory:";
        private readonly SqliteConnection _connection;

        protected readonly TestDbContext _context;

        protected EFTestFixture()
        {
            _connection = new SqliteConnection(_connectionString);
            _connection.Open();
            var options = new DbContextOptionsBuilder<ApplicationDbContext>()
                    .UseSqlite(_connection)
                    .Options;
            _context = new TestDbContext(options);
            _context.Database.EnsureCreated();

        }

        public void Dispose()
        {
            _connection.Close();
        }

        
    }
}
```

Add another new class to the Gift.Tests project and call it `PostRepositoryTests.cs`. This class will inherit from the `EFTestFixture` class and actually hold our tests, but before we write any of our tests, let's add some sample data to our in-memory database. Add the following code

```csharp
using Gifter.Models;
using Gifter.Repositories;
using System;
using System.Collections.Generic;
using System.Text;
using Xunit;

namespace Gifter.Tests
{
    public class PostRepositoryTests : EFTestFixture
    {
        public PostRepositoryTests()
        {
            AddSampleData();
        }

        // Add sample data
        private void AddSampleData()
        {
            var user1 = new UserProfile()
            {
                Name = "Walter",
                Email = "walter@gmail.com",
                DateCreated = DateTime.Now - TimeSpan.FromDays(365),
                FirebaseUserId = "TEST_FIREBASE_UID_1"
            };

            var user2 = new UserProfile()
            {
                Name = "Donny",
                Email = "donny@gmail.com",
                DateCreated = DateTime.Now - TimeSpan.FromDays(400),
                FirebaseUserId = "TEST_FIREBASE_UID_2"
            };

            var user3 = new UserProfile()
            {
                Name = "The Dude",
                Email = "thedude@gmail.com",
                DateCreated = DateTime.Now - TimeSpan.FromDays(400),
                FirebaseUserId = "TEST_FIREBASE_UID_3"
            };

            _context.Add(user1);
            _context.Add(user2);
            _context.Add(user3);

            var post1 = new Post()
            {
                Caption = "If you will it, Dude, it is no dream",
                Title = "The Dude",
                ImageUrl = "http://foo.gif",
                UserProfile = user1,
                DateCreated = DateTime.Now - TimeSpan.FromDays(10)
            };

            var post2 = new Post()
            {
                Caption = "If you're not into the whole brevity thing",
                Title = "El Duderino",
                ImageUrl = "http://foo.gif",
                UserProfile = user2,
                DateCreated = DateTime.Now - TimeSpan.FromDays(11),
            };

            var post3 = new Post()
            {
                Caption = "It really ties the room together",
                Title = "My Rug",
                ImageUrl = "http://foo.gif",
                UserProfile = user3,
                DateCreated = DateTime.Now - TimeSpan.FromDays(12),
            };

            var comment1 = new Comment()
            {
                Post = post2,
                Message = "This is great",
                UserProfile = user3
            };

            var comment2 = new Comment()
            {
                Post = post2,
                Message = "The post really tied the room together",
                UserProfile = user2
            };

            _context.Add(post1);
            _context.Add(post2);
            _context.Add(post3);
            _context.Add(comment1);
            _context.Add(comment2);
            _context.SaveChanges();
        }
    }
}
```

The code above just adds a few users, posts, and comments in as dummy data. Now we're ready to test one of our methods. Let's test the behavior of our `Search` method. Some things we could/should test are:

- If the search criterion exists anywhere in a post's Title it should be in the result set
- If the search criterion exists anywhere in a post's Caption it should be in the result set
- If the search criterion doesn't match any posts, an empty list should be returned (and not throw an exception)
- If sortDescending is true, then the most recent post should be first in the list
- If sortDescending is false, then the most recent post should be last in the list.

We can turn each of these expectations into automated tests. Update the code to include the following tests:

```csharp
using Gifter.Models;
using Gifter.Repositories;
using System;
using System.Collections.Generic;
using System.Text;
using Xunit;

namespace Gifter.Tests
{
    public class PostRepositoryTests : EFTestFixture
    {
        public PostRepositoryTests()
        {
            AddSampleData();
        }

        [Fact]
        public void Search_Should_Match_A_Posts_Title()
        {
            var repo = new PostRepository(_context);
            var results = repo.Search("Dude", false);

            Assert.Equal(2, results.Count);
            Assert.Equal("El Duderino", results[0].Title);
            Assert.Equal("The Dude", results[1].Title);
        }

        [Fact]
        public void Search_Should_Match_A_Posts_Caption()
        {
            var repo = new PostRepository(_context);
            var results = repo.Search("it is no dream", false);

            Assert.Equal(1, results.Count);
            Assert.Equal("If you will it, Dude, it is no dream", results[0].Caption);
        }

        [Fact]
        public void Search_Should_Return_Empty_List_If_No_Matches()
        {
            var repo = new PostRepository(_context);
            var results = repo.Search("foobarbazcatgrill", false);

            Assert.NotNull(results);
            Assert.Empty(results);
        }

        [Fact]
        public void Search_Can_Return_Most_Recent_First()
        {
            var mostRecentTitle = "The Dude";
            var repo = new PostRepository(_context);
            var results = repo.Search("", true);

            Assert.Equal(3, results.Count);
            Assert.Equal(mostRecentTitle, results[0].Title);
        }

        [Fact]
        public void Search_Can_Return_Most_Recent_Last()
        {
            var mostRecentTitle = "The Dude";
            var repo = new PostRepository(_context);
            var results = repo.Search("", false);

            Assert.Equal(3, results.Count);
            Assert.Equal(mostRecentTitle, results[2].Title);
        }

        // Add sample data
        private void AddSampleData()
        {
            // Omitted for brevity
        }
    }
}

```

## Has this ever happened to you???

In any of your Tabloid sprints, did you ever have a moment where you thought your DELETE for Post was working, but then later you found out if that post had a Comment or Tag on it, it would throw an exception?  

Is that code working in your project right now? Are you sure? How could you prove it?

Let's write a test for the `Delete` method in Gifter to see if it's working

```csharp
[Fact]
public void User_Can_Delete_Post_With_Comment()
{
    var postIdWithComment = 2;
    var repo = new PostRepository(_context);

    // Attempt to delete it
    repo.Delete(postIdWithComment);

    // Now attempt to get it
    var result = repo.GetById(postIdWithComment);

    Assert.Null(result);
}
```

If you run this test, it should alert us that our `Delete` method actually _doesn't_ work. And we didn't even have to create a full API and UI just to be able to test it. Having the test here allows us to now safely refactor our `Delete` method. Here's an updated version of the `Delete` method that _might_ work. We say "might" because we're really not sure, but try replacing the code in your PostRepository with this

> PostRepository.cs
```csharp
public void Delete(int id)
{
    // Remove related comments first
    var relatedComments = _context.Comment.Where(c => c.PostId == id);
    _context.Comment.RemoveRange(relatedComments);

    var post = GetById(id);
    _context.Post.Remove(post);
    _context.SaveChanges();
}
```

Run the test again and see if it passes now.

## Exercise

Add more tests to confirm the following assumptions about the `GetByUserProfileId` method in your PostRepository

- The Posts in the result set should be ordered alphabetically by title
- The Posts in the result set should only belong to the user whose ID was passed in
- If the ID that gets passed in doesn't belong to a user, the method should return an empty list

## Challenge: Test Driven Development

A popular strategy developers choose is Test Driven Development or TDD. Let's say we know exactly what type of method we need, but aren't really sure how to implement it yet. In TDD we would write a test _first_ and then write the code to make it pass. Example: Our Gifter product owner wants a feature where users can see the most recent 1, 2, or 3 posts, so we know we want to make a method that does something like this

> PostRepository.cs
```csharp
public List<Post> GetMostRecent(int numResults)
{
    // TODO: Implement this!
    throw new NotImplementedException();
}
```

Copy this code into your repository but **don't implement it yet**. Instead, add more tests to your test project that confirm the following assumptions

- If numResults is 1, then the result set should only have 1 Post in it
- If numResults is 3, then the result set should have 3 Posts in it
- If numResults is 100 and there are only 3 Posts in the database, the result set should have 3 Posts in it
- If numResults is anything less than 1, the result should be an empty list
- The first Post in the result set should always be the most recent
