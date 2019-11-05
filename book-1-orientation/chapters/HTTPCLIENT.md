# HttpClient

You've already experienced making http requests from your browser via `fetch`. While building web applications, we often want to make those requests from our server side code. .NET provides us with the `HttpClient` class that allows us to do that.

We'll first need to install an additional package to make this work. Run the following command in your project (NOTE: This is required only if you are in a Console application. If you are in an ASP.NET project, this is not necessary):

```sh
dotnet add package Microsoft.AspNet.WebApi.Client
```


## Why Make Requests on the Server?
In a full stack web application, we know we can make requests to 3rd party APIs from the our client side javascript code. So why would we instead choose to make those calls from our server side code? Some of the benefits of making Http requests server side as opposed to client side are:

- Avoid CORS issues
- Secure sensitive credentials like keys and passwords by not exposing them in your client side code
- Users can already have external data available as soon as your page loads
- Cache data on server to avoid lots of database calls

## Making an Http Request

```csharp
var uri = "https://icanhazdadjoke.com/search?term=cat";
var client = new HttpClient();

// Set request header to accept JSON
client.DefaultRequestHeaders
    .Accept
    .Add(new MediaTypeWithQualityHeaderValue("application/json"));

var response = await client.GetAsync(uri);
```

The Joke API will return a JSON response. When this response comes back, .NET will automatically convert it from JSON to a C# object for us. To prepare for this, we need to create a C# class in the shape of the data we expect. Let's look at the raw JSON response that comes back from the API:

```json
{
    "current_page": 1,
    "limit": 20,
    "next_page": 1,
    "previous_page": 1,
    "results": [
        {
            "id": "haMJRfF6hFd",
            "joke": "How do you fix a broken pizza? With tomato paste."
        },
        {
            "id": "xc21Lmbxcib",
            "joke": "How did the hipster burn the roof of his mouth? He ate the pizza before it was cool."
        },
        {
            "id": "51DAA5Tfaxc",
            "joke": "What did Romans use to cut pizza before the rolling cutter was invented? Lil Caesars"
        },
        {
            "id": "rc2E6EdiNe",
            "joke": "Want to hear my pizza joke? Never mind, it's too cheesy."
        }
    ],
    "search_term": "pizza",
    "status": 200,
    "total_jokes": 4,
    "total_pages": 1
}
```

Given the shape of this data, create a new C# class (or classes) that matches these properties.

```csharp
public class JokeResponse
{
    [JsonPropertyName("current_page")]
    public int CurrentPage { get; set; }

    [JsonPropertyName("limit")]
    public int Limit { get; set; }

    [JsonPropertyName("next_page")]
    public int NextPage { get; set; }

    [JsonPropertyName("previous_page")]
    public int PreviousPage { get; set; }

    [JsonPropertyName("results")]
    public List<JokeResult> Results { get; set; }

    [JsonPropertyName("search_term")]
    public string SearchTerm { get; set; }

    [JsonPropertyName("status")]
    public int Status { get; set; }

    [JsonPropertyName("total_jokes")]
    public int TotalJokes { get; set; }

    [JsonPropertyName("total_pages")]
    public int TotalPages { get; set; }
}

public class JokeResult
{
    public string Id { get; set; }
    public string Joke { get; set; }
}
```

A couple notes about these classes:

- If there is data in the JSON response you don't care about, you do not have to include it in your C# class. For example, if you did not care about the `status` in the previous JSON response, you could leave out the `Status` property in the `JokeResponse` class.

- Not all API's use the same naming conventions. One might use camelCase (i.e. `currentPage`) while another might use snake_case (i.e. `current_page`). By default, the .NET HttpClient is set format responses that use camelCase. If you encounter an API like this one--one that uses a different naming convention--you can handle this by adding a `JsonPropertyName` annotation above your property names. 

```csharp
[JsonPropertyName("total_jokes")]
public int TotalJokes { get; set; }
```

> _Alternatively, you could pass in a `JsonSerializerOptions` object to the `Deserialize` method that is used below (but we will not be doing that in this example)._

If creating classes for API responses seems like a tedious process, Visual studio can handle a lot of this for you by [generating classes for you based off of JSON](https://dailydotnettips.com/did-you-know-you-can-automatically-create-classes-from-json-or-xml-in-visual-studio/). If you're not using visual studio (and maybe using VSCode) there are online tools like [QuickType](https://quicktype.io/) available to help you.

## Handling Responses

Now that we've seen how to make a request, let's looks at how to handle a response back from an API. Here is the full example:

```csharp
class Program
{
    static async Task Main(string[] args)
    {
        var uri = "https://icanhazdadjoke.com/search?term=cat";
        var httpClient = new HttpClient();
        httpClient.DefaultRequestHeaders
            .Accept
            .Add(new MediaTypeWithQualityHeaderValue("application/json"));

        var response = await httpClient.GetAsync(uri);
        if (response.IsSuccessStatusCode)
        {
            var json = await response.Content.ReadAsStreamAsync();
            var jokeData = await JsonSerializer.DeserializeAsync<JokeResponse>(json);

            foreach (var result in jokeData.Results)
            {
                Console.WriteLine(result.Joke);
            }
        }
    }
}
```

## What are `async` and `await` doing?

Unsurprisingly, the `GetAsync` method performs an asynchronous operation (same as when we made `fetch` calls in Javascript). While in Javascript we dealt with Promises, .NET uses something similar called Tasks. It might be helpful to think of a Task as data that's not immediately available, but will be at some point in the future. By using the `await` keyword, we can tell the program to wait for a task to be completed before capturing the returned data and continuing.

The `async` keyword is only needed in the method's signature. It doesn't do anything on its own. All it does is make the `await` keyword available in the method.