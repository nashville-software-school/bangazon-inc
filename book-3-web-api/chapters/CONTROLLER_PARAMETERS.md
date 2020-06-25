# Web API Parameters

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

**TODO**

---

## Exercises

**TODO**
