# Validation With Annotations

We can get ASP.<span>NET</span> to validate properties for us by adding annotations to them. Annotations are things in square brackets that go above classes, methods, and properties. You've probably noticed ones like `[HttpPost]`. These annotations are meant to augment or "decorate" the thing it goes on top of. In our model class, we can use these to enforce some rules about our properties

```csharp
public class Owner
{
    public int Id { get; set; }

    [EmailAddress]
    [Required]
    public string Email { get; set; }

    [Required(ErrorMessage = "Hmmm... You should really add a Name...")]
    [MaxLength(35)]
    public string Name { get; set; }

    [Phone]
    public string PhoneNumber { get; set; }

    [Required]
    [StringLength(55, MinimumLength = 5)]
    public string Address { get; set; }

    [Required]
    public int NeighborhoodId { get; set; }

    public Neighborhood Neighborhood { get; set; }
}
```

We're using annotations to tell the framework that certain properties are required, have a min/max length, or need to be a valid email address or phone number.

To add client side validation to our application, go into `_Layout.cshtml` and at the bottom where the javascript files are being added, include a reference to the `_ValidationScriptsPartial` like this

```html+razor
<script src="~/lib/jquery/dist/jquery.min.js"></script>
<script src="~/lib/bootstrap/dist/js/bootstrap.bundle.min.js"></script>

@*------THIS IS WHAT WE'RE ADDING----*@
<partial name="_ValidationScriptsPartial" /> 

<script src="~/js/site.js" asp-append-version="true"></script>
@RenderSection("Scripts", required: false)
```

Now go to create an owner and try to put in invalid data in some of the input fields.

## DisplayName Annotations

Have you been finding it annoying that a lot of the input labels in our application aren't very user friendly? They say things like "PhoneNumber" or "NeighborhoodId". We can also use annotations to change the way their labels are displayed when rendered to an html page


```csharp
[Phone]
[DisplayName("Phone Number")]
public string PhoneNumber { get; set; }

[Required]
[DisplayName("Neighborhood")]
public int NeighborhoodId { get; set; }
```

In our view, these annotations will affect the way code like this gets evaluated

```html+razor
<th>
    @Html.DisplayNameFor(model => model.NeighborhoodId)
</th>
```

Annotations can also come in handy when deciding how your DateTime properties should be formatted

```csharp
[DisplayFormat(DataFormatString = "{0:MMM dd, yyyy}")]
public DateTime Birthday { get; set; }
```

## Exercise

Add proper annotations on the `Dog` and `Walker` models so that validation rules are enforced and input labels are user friendly
