# Validating Input and Customizing the Display Using C# Attributes

---

## Objectives

After completing this lesson and working on related exercises you should be able to:

1. Define the term "validation" as it's commonly used in web applications.
1. Describe two scenarios when we use C# attributes in an MVC application.
1. Write the code to ensure a particular model property is required.
1. Write the code to ensure a particular model property is within a given minimum and maximum length.
1. Write the code to ensure a particular model property is a valid email address.
1. Write the code to customize label for a particular model property.
1. Write the code to alter the display of a `DateTime` property to only show the date portion.

---

## Validation

Validation is the process of confirming a user has entered properly formatted data. For example, imagine we create a form that requires the user input an email address. Such a form might have two types of validation. The first to confirm that the user has not left the field blank and the second to confirm that the user has entered some text that "looks like" an email address.

Writing validation code can be tedious and error prone, so, fortunately, ASP<span>.</span>NET Core gives us a set of special C# attributes we can use to get validation for "free".

## Validation Attributes

Attributes are the things in square brackets that go above classes, methods, and properties. You've probably noticed ones like `[HttpPost]`. These attributes are meant to augment or "decorate" the thing it goes on top of. In our model class, we can use these to enforce some rules about our properties

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

We're using attributes to tell the ASP<span>.</span>NET Core framework that certain properties are required, have a min/max length, or need to be a valid email address or phone number.

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

## DisplayName Attributes

Have you been finding it annoying that a lot of the input labels in our application aren't very user friendly? They say things like "PhoneNumber" or "NeighborhoodId". We can also use attributes to change the way their labels are displayed when rendered to an html page


```csharp
[Phone]
[DisplayName("Phone Number")]
public string PhoneNumber { get; set; }

[Required]
[DisplayName("Neighborhood")]
public int NeighborhoodId { get; set; }
```

In our view, these attributes will affect the way code like this gets evaluated

```html+razor
<th>
    @Html.DisplayNameFor(model => model.NeighborhoodId)
</th>
```

Attributes can also come in handy when deciding how your DateTime properties should be formatted

```csharp
[DisplayFormat(DataFormatString = "{0:MMM dd, yyyy}")]
public DateTime Birthday { get; set; }
```

## Exercise

Add proper attributes on the `Dog` and `Walker` models so that validation rules are enforced and input labels are user friendly
