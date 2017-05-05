# ViewBag

* `ViewBag` - for passing data (via variables) from Controller to View.  
  * Connects all way from db to views (full stack)
  * Works like a dictionary, not a class or property.  Uses attribute, which is a  <key, value> pair, with no restrictions on it.
   * e.g. Angular's ng-view; Bootstrap and Foundation each have their own attributes.  Html built on top of XML - made to be extensible.
   * Can embed additional attributes to any tag created.
 * One View Bag is unique for each call to a page.  
 * Can be manipulated inside controller, and/or cshtml.
 * ViewBag is a dynamic object and therefore has no IntelliSense support; errors will not be discovered during compile, only at runtime
 * ViewBag - for passing var's around.
"{}"  could be in code, or in html