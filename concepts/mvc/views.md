### Views
* `ActionResult`s of a controller match the `View` with the same name.
  * View - named same as controller prefix (built into .NET by convention).
* `.cshtml` - filetype specific to Microsoft's MVC framework
  * Supports use of embedded C# inside html-syntax files using Razor syntax.
  * .cshtml files can be shared by multiple views, e.g.
   * `_Layout.cshtml` - layout template = html markup for navbar, header, footer to be reflected in all webpages
   * `_Partials`
     * "Partial" = view not rendered by Controller, but called by other views
   * `index.cshtml` - view template = 'content' only, for index page

* `ActionLink` methods - method calls used to create anchor tags (`<href>`).
 * E.g.
@Html.ActionLink("Home", "Index", "Home"), where:
   *	first "Home" is visible on the page
   *	"Index" is the name of method to be called
   *	second "Home" is prefix of controller
  * "Helper methods" - facilities to help develop Views.
    *  https://msdn.microsoft.com/en-us/library/system.web.mvc.html.linkextensions.actionlink%28v=vs.118%29.aspx