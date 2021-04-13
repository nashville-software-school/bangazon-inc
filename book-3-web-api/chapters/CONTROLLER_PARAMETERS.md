# Web API Parameters

---

## Objectives

After completing this lesson and working on related exercises you should be able to:

1. List and describe three different types of parameters.
1. Give two examples of websites that use query string parameters.
1. Discuss a benefit of using query string parameters for a search feature of an application.
1. Write code in an ASP<span>.</span>NET Core Web API that uses query strings to perform a search of a database entity.

---

We've encountered the term _parameter_ a few times throughout the course. We've seen that a parameter is a special variable that is _passed into_ a function or method.

```js
function sum(num1, num2) {
    return num1 + num2;
}
```

`num1` and `num2` are _parameters_ of the `sum` function.

We've also seen _SQL parameters_ as a way to get data into a SQL statement.

```cs
cmd.CommandText = @"
    INSERT INTO Villain ([Name], Power, Weakness)
    VALUES (@name, @power, @weakness)";
cmd.Parameters.AddWithValue("@name", "MovieTalker");
cmd.Parameters.AddWithValue("@power", "irritating an entire audience");
cmd.Parameters.AddWithValue("@weakness", "inability to understand a film");
```

`@name`, `@power` and `@weakness` are SQL parameters.

Clearly the syntax of these two types of parameters is vastly different, but we still call them both _parameters_. Why? Because of they have common purpose. They are both ways of getting data from one part of the code into another part of the code.

## Route Parameters

In addition to the two kinds of parameters mentioned above, we've also seen a third: _Route parameters_.

Recall that route parameters are a feature of MVC and Web API that give us the ability to pass in data on the URL.

```cs
[HttpGet("{id}")]
public IActionResult Get(int id)
{
    var variety = _beanVarietyRepository.Get(id);
    if (variety == null)
    {
        return NotFound();
    }
    return Ok(variety);
}
```

When we make a `GET` request to `https://localhost:5001/api/beanvariety/5`, the value `5` is passed in as the `id` parameter to the `Get(int id)` method. In this case, that `5` represents the id of the bean variety we wish to get from the database.

> **NOTE:** ASP<span>.NET</span> Core turns _route parameters_ into _method parameters_ for us. Isn't that nice of it?

In Web API we specify the route parameter in two places. In the HTTP verb attribute (ex. `[HttpGet("{id}")]`) and in the method parameters (ex. `public IActionResult Get(int id)`)

> **NOTE:** Route parameters are not limited to `id`s and can get significantly more complex if the need arises.

## Query String Parameters

When working with `json-server` you used `_expand` and `_embed` to optionally include related data.

```txt
http://localhost:3000/animal?_embed=employee
```

`_expand` and `_embed` are examples of _query string parameters_.

A _query string_ is the part of a URL after the `?`. It consists of a list of `key=value` pairs separated by `&`.

Consider this URL:

```txt
https://www.reddit.com/search/?q=csharp&sort=top&t=month
```

The query string parameters are `q`, `sort` and `t`. They are used by the Reddit search feature to dictate how the search should be conducted and the search results should be displayed.

* `q` is the search term
* `sort` defines the order in which the search results should be returned. In this example we want "top" results to be first...whatever that means.
* `t` specifies the time limit to search. In this example we only want results from the past month

The Reddit example demonstrates a common use case for query string parameters. They are often used for searching, sorting and configuring how data is returned from a web API.

> **NOTE:** It is important to note that query string parameters can be whatever you, the developer, want them to be. There is nothing special about the query string parameters in the example. They are just what the Reddit developers chose. In the same way, there is nothing special about the _embed or _expand parameters you used with json-server. These are parameter names that the developer of json-server picked out, and are not necessarily relevant keywords outside of json-server

### Query String Example

Let's add the ability to search Posts in Gifter. We'll search by `Title` and allow the results to be sorted by date in either an ascending or descending direction.

We'll start by adding a new method to our `PostRepository`.

```cs
public List<Post> Search(string criterion, bool sortDescending)
{
    using (var conn = Connection)
    {
        conn.Open();
        using (var cmd = conn.CreateCommand())
        {
            var sql =
                @"SELECT p.Id AS PostId, p.Title, p.Caption, p.DateCreated AS PostDateCreated, 
                        p.ImageUrl AS PostImageUrl, p.UserProfileId,

                        up.Name, up.Bio, up.Email, up.DateCreated AS UserProfileDateCreated, 
                        up.ImageUrl AS UserProfileImageUrl
                    FROM Post p 
                        LEFT JOIN UserProfile up ON p.UserProfileId = up.id
                    WHERE p.Title LIKE @Criterion OR p.Caption LIKE @Criterion";

            if (sortDescending)
            {
                sql += " ORDER BY p.DateCreated DESC";
            }
            else
            {
                sql += " ORDER BY p.DateCreated";
            }

            cmd.CommandText = sql;
            DbUtils.AddParameter(cmd, "@Criterion", $"%{criterion}%");
            var reader = cmd.ExecuteReader();

            var posts = new List<Post>();
            while (reader.Read())
            {
                posts.Add(new Post()
                {
                    Id = DbUtils.GetInt(reader, "PostId"),
                    Title = DbUtils.GetString(reader, "Title"),
                    Caption = DbUtils.GetString(reader, "Caption"),
                    DateCreated = DbUtils.GetDateTime(reader, "PostDateCreated"),
                    ImageUrl = DbUtils.GetString(reader, "PostImageUrl"),
                    UserProfileId = DbUtils.GetInt(reader, "UserProfileId"),
                    UserProfile = new UserProfile()
                    {
                        Id = DbUtils.GetInt(reader, "UserProfileId"),
                        Name = DbUtils.GetString(reader, "Name"),
                        Email = DbUtils.GetString(reader, "Email"),
                        DateCreated = DbUtils.GetDateTime(reader, "UserProfileDateCreated"),
                        ImageUrl = DbUtils.GetString(reader, "UserProfileImageUrl"),
                    },
                });
            }

            reader.Close();

            return posts;
        }
    }
}
```

The `Search()` method builds a SQL query that uses the `LIKE` operator to find records matching the search criterion and uses the `sortDesc` parameter to determine the `ORDER BY` direction.

> **NOTE:** The `cmd.CommandText` property is just a string, so we can append to it as we would any other string.

Once we have a repository method, we'll create the new Action in the `PostController`.

```cs 
[HttpGet("search")]
public IActionResult Search(string q, bool sortDesc)
{
    return Ok(_postRepository.Search(q, sortDesc));
}
```

The above method will respond to a request that looks like this:

> https://localhost:5001/api/post/search?q=p&sortDesc=false

Notice the URL's route contains `search` and the URL's query string has values for `q` and `sortDesc` keys. `search` corresponds to the the argument passed to the `[HttpGet("search")]` attribute, and `q` and `sortDesc` correspond to the method's parameters.

## Exercises

1. Update your Gifter API to allow searching of Posts by title as illustrated in this chapter.
1. Add a new endpoint, `/api/post/hottest?since=<SOME_DATE>` that will return posts created on or after the provided date.

> **NOTE:** as always make sure to use Postman to test your API.

## Challenge

1. Take a look at the methods in your `PostRepository`. Pay special attention to the "query" methods - those that `SELECT` data. What do you notice? There's a LOT of redundant code. Your challenge is to create one or more `private` helper methods to reduce the complexity and call those new methods from the query methods.
