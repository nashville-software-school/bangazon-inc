# Automated Testing

Say you're working on a brand new application. You pull your first ticket and start implementing the user story. You write some code and think that everything you just wrote should work--but how do you know? You probably run the application, walk through the appropriate steps, observe the app's behavior and see if matches your expectations. This process is considered **manual** testing. If the outcome you observe with your own eyes matches your expectations, you can probably start moving that ticket closer to your "DONE" column and move on to the next, and rinse and repeat. But when you pick up that 2nd ticket and complete it, what assurances do you have that you didn't break the 1st ticket in the process? You might be saying "well, I'll go back and test that the 1st ticket is still working." Imagine though that you're a few months into this application, and you've implemented hundreds of user stories. How can you be sure that your new code is not breaking your old code? The manual testing strategy is not sustainable. We should automate this process. 

## Our First Test

In order to demonstrate a test, we must first have some code that needs to be tested.

Here's a utility class that has a single method, `MakeExciting`, that makes a string more exciting.

> StringUtils.cs

```cs
public class StringUtils
{
    public static string MakeExciting(string source)
    {
        return $"{source.ToUpper()}!!!";
    }
}
```

And here's a test we can use to verify that the `MakeExciting` method works correctly.

> StringUtilsTests.cs

```cs
using Xunit;

namespace Tests
{
    public class StringUtilsTests
    {
        [Fact]
        public void MakeExciting_Method_Makes_A_String_Exciting()
        {
            // Arrange - Create any variables, objects or resources needed to run the test
            var testString = "There's a spider on me";

            // Act - Run the code you want to test (a.k.a "System Under Test")
            var result = StringUtils.MakeExciting(testString);

            // Assert - Verify that the code from the "Act" step did what we expected
            Assert.Equal("THERE'S A SPIDER ON ME!!!", result);
        }
    }
}
```

It might seem weird to think about writing code to test our code, but this is an important step in the development process. If we write tests for our code as we go ([or even _before_ we start writing our code](https://www.agilealliance.org/glossary/tdd/#q=~(infinite~false~filters~(videoType~(~'page~'video~'aa_book~'aa_event_session~'aa_experience_report~'aa_glossary~'aa_research_paper~'aa_video)~tags~(~'tdd))~searchTerm~'~sort~false~sortDirection~'asc~page~1))), we can have peace of mind knowing that it works _and_ if it ever stops working in the future, we'll know.

## Types of Automated Testing

There are a few common types of automated tests you'll write during the development process

- **Unit Testing** - Testing a single method. The example above, for instance, tests _only_ the `MakeExciting` method.

- **Integration Testing** - Testing pieces of our system that are connected to one another. We might, for example, write an integration test that tests one of the routes in our API. To do this, we are interacting with more than just a single unit--we're interacting with a controller, repository, and database.

- **End to End (E2E) Testing** - These tests simulate the actual flow of an end user. In web development, E2E tests may involve automating the process of launching a browser, typing in form values, clicking buttons, etc.

In this chapter we'll look at how to write **unit** tests for the methods in Streamish's `VideoController`. To do this, we're going to use a testing tool called XUnit

## Setup

The tests we write are not part of our application, so we don't put them in the same project, however they _can_ go in the same Visual Studio solution. Open up the Streamish application in Visual Studio and right click the top item in Solution Explorer marked `Solution 'Streamish'` and select Add > New Project. Search the templates for "xUnit Test Project (using .NET 5)" and select the one for C#. Give it the name "Streamish.Tests". This will create a new project for you as well as a file to start writing some tests in that looks like this:

```csharp
using System;
using Xunit;

namespace Streamish.Tests
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

namespace Streamish.Tests
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

Now let's start setting up some more meaningful tests that will test the behavior of some of our VideoRepository methods.

### Reference the Project to Test

Our tests will be written to verify that the Streamish app behaves as we expect. This means we'll have to tell our test project about the Streamish project.

Add this project reference to your test project's `*.csproj` file.

```xml
<ItemGroup>
  <ProjectReference Include="..\Streamish\Streamish.csproj" />
</ItemGroup>
```

> **NOTE:** The Streamish app is referred to as the [_System Under Test_](https://en.wikipedia.org/wiki/System_under_test) (SUT).

## Writing Controller Tests

As we know ASP<span>.</span>NET controllers are special classes that handle HTTP requests. However when it comes to unit testing a controller, we don't have to worry about what makes controllers "special". Instead we rely on the fact that they are really _just C# classes_.

Here's a snippet of the Streamish `VideoController` class

```cs
[ApiController]
public class VideoController : ControllerBase
{
    private readonly IVideoRepository _videoRepository;
    public VideoController(IVideoRepository videoRepository)
    {
        _videoRepository = videoRepository;
    }

    [HttpGet]
    public IActionResult Get()
    {
        return Ok(_videoRepository.GetAll());
    }

// ...
```

Let's focus on the `Get()` method. What does it do? It returns an object - some kind of `IActionResult` - that contains a list of all the videos in our database.

What do you think we'd need to do in order to test the `Get()` method? Well, to see if the `Get()` method does what we think it should do, we could _run it and see if it does what we think it should do_.

How do we do that?

1. Create an instance of the `VideoController`.
1. Call the `Get()` method.
1. Check the object returned by the `Get()` method to see if it contains the list of videos.

### Unit Testing the VideoController

#### Creating an Instance of the `VideoController`

The process outlined above sounds simple enough until we look a little closer. The first step is to create instance of the `VideoController` class, but an examination of the `VideoController` constructor shows us that we need to pass in instance of `IVideoRepository` when we instantiate a `VideoController`.

#### "Mocking" the IVideoRepository

Let's revisit the definition of a _uint test_. A unit test is a test that verifies a single method works properly.

But how can we test a single controller method given that each controller method calls into the repository and the repository sends SQL commands to the database. If you think about it you'll see that's a LOT more than one method.

We solve this problem by creating a _mock_ repository. This is a fake version of repository that we will use for tests. Instead of connecting to SQL Server, this mock repository will mimic the behavior using a simple list of videos.

In your test project create a folder called 'Mocks` and add the following class.

> Mocks/InMemoryVideoRepository.cs

```cs
using System;
using System.Collections.Generic;
using System.Linq;
using Streamish.Models;
using Streamish.Repositories;

namespace Streamish.Tests.Mocks
{
    class InMemoryVideoRepository : IVideoRepository
    {
        private readonly List<Video> _data;

        public List<Video> InternalData
        {
            get
            {
                return _data;
            }
        }

        public InMemoryVideoRepository(List<Video> startingData)
        {
            _data = startingData;
        }

        public void Add(Video video)
        {
            var lastVideo = _data.Last();
            video.Id = lastVideo.Id + 1;
            _data.Add(video);
        }

        public void Delete(int id)
        {
            var videoToDelete = _data.FirstOrDefault(p => p.Id == id);
            if (videoToDelete == null)
            {
                return;
            }

            _data.Remove(videoToDelete);
        }

        public List<Video> GetAll()
        {
            return _data;
        }

        public Video GetById(int id)
        {
            return _data.FirstOrDefault(p => p.Id == id);
        }

        public void Update(Video video)
        {
            var currentVideo = _data.FirstOrDefault(p => p.Id == video.Id);
            if (currentVideo == null)
            {
                return;
            }

            currentVideo.Description = video.Description;
            currentVideo.Title = video.Title;
            currentVideo.DateCreated = video.DateCreated;
            currentVideo.Url = video.Url;
            currentVideo.UserProfileId = video.UserProfileId;
        }

        public List<Video> Search(string criterion, bool sortDescending)
        {
            throw new NotImplementedException();
        }

        public List<Video> GetAllWithComments()
        {
            throw new NotImplementedException();
        }

        public Video GetVideoByIdWithComments(int id)
        {
            throw new NotImplementedException();
        }
    }
}
```

Take a spin through the code. What do you see?

The first thing to note is that the `InMemoryVideoRepository` implements the `IVideoRepository` interface. This means it has the same methods as the "real" `VideoRepository` class in our Streamish application.

Have you been wondering why we have to go to all the trouble of creating both an interface and a class for each repository? Well this is the reason. Be creating the `IVideoRepository` interface and using that interface within the `VideoController` class, our code is flexible enough to allow us to use a mock repository in unit tests.

Another important thing ot notice is how we use the `_data` list. Instead of a SQL Server database, our mock repository stores data inside this list. Since the list is resides within our C# program, we say we're storing the data _in memory_.

#### The `VideoControllerTests` Test Class

Rename the `UnitTes1.cs` file to `VideoControllerTests.cs` and copy the following code into it.

> `VideoControllerTests.cs`

```cs
using Streamish.Controllers;
using Streamish.Models;
using Streamish.Tests.Mocks;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using Xunit;

namespace Streamish.Tests
{
    public class VideoControllerTests
    {
        [Fact]
        public void Get_Returns_All_Videos()
        {
            // Arrange 
            var videoCount = 20;
            var videos = CreateTestVideos(videoCount);

            var repo = new InMemoryVideoRepository(videos);
            var controller = new VideoController(repo);

            // Act 
            var result = controller.Get();

            // Assert
            var okResult = Assert.IsType<OkObjectResult>(result);
            var actualVideos = Assert.IsType<List<Video>>(okResult.Value);

            Assert.Equal(videoCount, actualVideos.Count);
            Assert.Equal(videos, actualVideos);
        }

        [Fact]
        public void Get_By_Id_Returns_NotFound_When_Given_Unknown_id()
        {
            // Arrange 
            var videos = new List<Video>(); // no videos

            var repo = new InMemoryVideoRepository(videos);
            var controller = new VideoController(repo);

            // Act
            var result = controller.Get(1);

            // Assert
            Assert.IsType<NotFoundResult>(result);
        }

        [Fact]
        public void Get_By_Id_Returns_Video_With_Given_Id()
        {
            // Arrange
            var testVideoId = 99;
            var videos = CreateTestVideos(5);
            videos[0].Id = testVideoId; // Make sure we know the Id of one of the videos

            var repo = new InMemoryVideoRepository(videos);
            var controller = new VideoController(repo);

            // Act
            var result = controller.Get(testVideoId);

            // Assert
            var okResult = Assert.IsType<OkObjectResult>(result);
            var actualVideo = Assert.IsType<Video>(okResult.Value);

            Assert.Equal(testVideoId, actualVideo.Id);
        }

        [Fact]
        public void Post_Method_Adds_A_New_Video()
        {
            // Arrange 
            var videoCount = 20;
            var videos = CreateTestVideos(videoCount);

            var repo = new InMemoryVideoRepository(videos);
            var controller = new VideoController(repo);

            // Act
            var newVideo = new Video()
            {
                Description = "Description",
                Title = "Title",
                Url = "http://video.url/",
                DateCreated = DateTime.Today,
                UserProfileId = 999,
                UserProfile = CreateTestUserProfile(999),
            };

            controller.Post(newVideo);

            // Assert
            Assert.Equal(videoCount + 1, repo.InternalData.Count);
        }

        [Fact]
        public void Put_Method_Returns_BadRequest_When_Ids_Do_Not_Match()
        {
            // Arrange
            var testVideoId = 99;
            var videos = CreateTestVideos(5);
            videos[0].Id = testVideoId; // Make sure we know the Id of one of the videos

            var repo = new InMemoryVideoRepository(videos);
            var controller = new VideoController(repo);

            var videoToUpdate = new Video()
            {
                Id = testVideoId,
                Description = "Updated!",
                Title = "Updated!",
                UserProfileId = 99,
                DateCreated = DateTime.Today,
                Url = "http://some.url",
            };
            var someOtherVideoId = testVideoId + 1; // make sure they aren't the same

            // Act
            var result = controller.Put(someOtherVideoId, videoToUpdate);

            // Assert
            Assert.IsType<BadRequestResult>(result);
        }

        [Fact]
        public void Put_Method_Updates_A_Video()
        {
            // Arrange
            var testVideoId = 99;
            var videos = CreateTestVideos(5);
            videos[0].Id = testVideoId; // Make sure we know the Id of one of the videos

            var repo = new InMemoryVideoRepository(videos);
            var controller = new VideoController(repo);

            var videoToUpdate = new Video()
            {
                Id = testVideoId,
                Description = "Updated!",
                Title = "Updated!",
                UserProfileId = 99,
                DateCreated = DateTime.Today,
                Url = "http://some.url",
            };

            // Act
            controller.Put(testVideoId, videoToUpdate);

            // Assert
            var videoFromDb = repo.InternalData.FirstOrDefault(p => p.Id == testVideoId);
            Assert.NotNull(videoFromDb);

            Assert.Equal(videoToUpdate.Description, videoFromDb.Description);
            Assert.Equal(videoToUpdate.Title, videoFromDb.Title);
            Assert.Equal(videoToUpdate.UserProfileId, videoFromDb.UserProfileId);
            Assert.Equal(videoToUpdate.DateCreated, videoFromDb.DateCreated);
            Assert.Equal(videoToUpdate.Url, videoFromDb.Url);
        }

        [Fact]
        public void Delete_Method_Removes_A_Video()
        {
            // Arrange
            var testVideoId = 99;
            var videos = CreateTestVideos(5);
            videos[0].Id = testVideoId; // Make sure we know the Id of one of the videos

            var repo = new InMemoryVideoRepository(videos);
            var controller = new VideoController(repo);

            // Act
            controller.Delete(testVideoId);

            // Assert
            var videoFromDb = repo.InternalData.FirstOrDefault(p => p.Id == testVideoId);
            Assert.Null(videoFromDb);
        }

        private List<Video> CreateTestVideos(int count)
        {
            var videos = new List<Video>();
            for (var i = 1; i <= count; i++)
            {
                videos.Add(new Video()
                {
                    Id = i,
                    Description = $"Description {i}",
                    Title = $"Title {i}",
                    Url = $"http://video.url/{i}",
                    DateCreated = DateTime.Today.AddDays(-i),
                    UserProfileId = i,
                    UserProfile = CreateTestUserProfile(i),
                });
            }
            return videos;
        }

        private UserProfile CreateTestUserProfile(int id)
        {
            return new UserProfile()
            {
                Id = id,
                Name = $"User {id}",
                Email = $"user{id}@example.com",
                Bio = $"Bio {id}",
                DateCreated = DateTime.Today.AddDays(-id),
                Url = $"http://user.url/{id}",
            };
        }
    }
}
```

Take a look at the code. Focus on the `Get_Returns_All_Videos()` method for now.

```cs
[Fact]
public void Get_Returns_All_Videos()
{
    // Arrange
    var videoCount = 20;
    var videos = CreateTestVideos(videoCount);

    var repo = new InMemoryVideoRepository(videos);
    var controller = new VideoController(repo);

    // Act
    var result = controller.Get();

    // Assert
    var okResult = Assert.IsType<OkObjectResult>(result);
    var actualVideos = Assert.IsType<List<Video>>(okResult.Value);

    Assert.Equal(videoCount, actualVideos.Count);
    Assert.Equal(videos, actualVideos);
}
```

The `Get_Returns_All_Videos()` method is a single test. Tests are public methods marked with the `[Fact]` attribute. The `[Fact]` attribute is provided by the xUnit testing library.

It's also very common to write out very long names for tests. The name should describe what the test is doing.

> **NOTE:** This is the _ONLY TIME_ we use underscores in method names in C#...and some people would argue we shouldn't use them even in tests.

#### Arrange, Act, Assert

Unit tests often follow the "Arrange, Act, Assert" pattern. The `Get_Returns_All_Videos` test is no exception. Notice the comments above each section of the test that call out the pattern.

##### Arrange

In the _arrange_ section we create any objects that are needed for the test. In our example we create some test Videos, a mock repository and an instance of the `VideoController` class.

> **NOTE:** It's important to understand what's happening in the arrange section of the `Get_Get_Returns_All_Videos` test. Pay particular attention to our use of the `InMemoryVideoRepository` as a mock repository.

##### Act

In the _act_ section we execute the method that is being testing. In our example we call the `VideoController.Get()` method.

##### Assert

In the _assert_ section we verify that the method we're testing did what we expected it to do. We usually use the `Assert` utility class (provided by xUnit) to help.

In the example we verify the result of `Get()` method is an instance of the `OkObjectResult` class - this is the type returned by the `Ok()` method - and then we verify that it contains the expected list of videos.

### Run the Tests

Use the Visual Studio Test Explorer to run all the tests in the `VideoControllerTests` class, then take some time to explore each test.

## Exercises

1. Create tests for all the basic CRUD functionality in the `UserProfileController`. You should create _at least one_ test for each of these controller methods.

    * `Get()`
    * `Get(int id)`
    * `Post(UserProfile userProfile)`
    * `Put(int id, UserProfile userProfile)`
    * `Delete(int id)`

    > **NOTE:** You'll need to create a mock repository as part of this exercise.
 
1. Create a test for the `VideoController.Search()` method.
