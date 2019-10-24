# HttpClient

You've already experienced making http requests from your browser via `fetch`. While building web applications, we often want to make those requests from our server side code. .NET provides us with the `HttpClient` class that allows us to do that. 


## Why Make Requests on the Server?
In a full stack web application, we know we can make requests to 3rd party APIs from the our client side javascript code. So why would we instead make those calls from our server side code? Some of the benefits of making Http requests server side as opposed to client side are:

- Avoid CORS issues
- Secure sensitive credentials like keys and passwords by not exposing them in your client side code
- Users can already have external data available as soon as your page loads

## Making an Http Request

Making a request is fairly simple:

```csharp
var client = new HttpClient();
var uri = "http://api.github.com/users/adamsheaffer/";
var response = await client.GetAsync(uri);
```

The Github API will return a JSON response. When this response comes back, .NET will automatically convert it from JSON to a C# object for us. To prepare for this, we need to create a C# class in the shape of the data we expect. Let's look at the raw JSON response that comes back from Github:

```json
[
    {
        "id": "10552217170",
        "type": "PushEvent",
        "actor": {
            "id": 9039241,
            "login": "AdamSheaffer",
            "display_login": "AdamSheaffer",
            "gravatar_id": "",
            "url": "https://api.github.com/users/AdamSheaffer",
        },
        "repo": {
            "id": 212260122,
            "name": "nss-day-cohort-32/HeistPartDeux",
            "url": "https://api.github.com/repos/nss-day-cohort-32/HeistPartDeux"
        },
        "payload": {
            "push_id": 4107356582,
            "size": 1,
            "distinct_size": 1,
            "ref": "refs/heads/master",
            "head": "a4ef37d73c3f055d7268debd59cee962b6983b49",
            "before": "13230d7489fe108c15c8230c55dd0cc6b45a7d5a",
            "commits": [
                {
                    "sha": "a4ef37d73c3f055d7268debd59cee962b6983b49",
                    "author": {
                        "email": "adam.sheaffer@nashvillesoftwareschool.com",
                        "name": "Adam"
                    },
                    "message": "fix spelling. prepopulate rolodex",
                    "distinct": true,
                    "url": "https://api.github.com/repos/nss-day-cohort-32/HeistPartDeux/commits/a4ef37d73c3f055d7268debd59cee962b6983b49"
                }
            ]
        },
        "public": true,
        "created_at": "2019-10-03T14:46:27Z",
        "org": {
            "id": 49160972,
            "login": "nss-day-cohort-32",
            "gravatar_id": "",
            "url": "https://api.github.com/orgs/nss-day-cohort-32"
        }
    },
    {
        "id": "10539452209",
        "type": "CreateEvent",
        "actor": {
            "id": 9039241,
            "login": "AdamSheaffer",
            "display_login": "AdamSheaffer",
            "gravatar_id": "",
            "url": "https://api.github.com/users/AdamSheaffer"
        },
        "repo": {
            "id": 212260122,
            "name": "nss-day-cohort-32/HeistPartDeux",
            "url": "https://api.github.com/repos/nss-day-cohort-32/HeistPartDeux"
        },
        "payload": {
            "ref": "master",
            "ref_type": "branch",
            "master_branch": "master",
            "description": null,
            "pusher_type": "user"
        },
        "public": true,
        "created_at": "2019-10-02T05:11:49Z",
        "org": {
            "id": 49160972,
            "login": "nss-day-cohort-32",
            "gravatar_id": "",
            "url": "https://api.github.com/orgs/nss-day-cohort-32"
        }
    }
]
```

Given the shape of this data, create a new C# class (or classes) that matches these properties. You can also ignore any properties that you don't care about:

```csharp
public class GithubEvent
{
    public string Id { get; set; }
    public Actor Actor { get; set; }
    public bool Public { get; set; }

    [JsonProperty("created_at")]
    public DateTime CreatedAt { get; set; }
    public Actor Org { get; set; }
}

public class Actor
{
    public long Id { get; set; }
    public string Login { get; set; }
    public string DisplayLogin { get; set; }
    public string GravatarId { get; set; }
    public Uri Url { get; set; }
    public Uri AvatarUrl { get; set; }
}
```