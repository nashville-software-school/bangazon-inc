
# Seeding your Database 

## First involves a migration
Another way is to set an initializer for your database context that brings in database for you.

### If you’ve done a migration:
* If you go to your configuration.cs file you can make a Seed method that takes the EventContext. Within the method, you can say something like:
```
  protected override void Seed (WaitForIt.EventContext.context) {
    context.Events.AddorUpdate<Model.Event>
    (n => n.Name,    // if there is an object of the same thing, do not add another one
     new Model.Event { Name = “Jurnell’s Birthday”, Date = “10/05/2015”}
    )}
```
* This way works if you have done a migration already and you want to use configuration.cs within that folder in order to seed data.
* Jurnell COMMITTED this example above to the WaitForIt project.
* You also need to set `AutomaticMigationEnabled = true`, so that every time it builds it will seed the database.

### What if you haven’t done any migrations? Here’s another strategy.

* You can create a **connection string** so that you have two databases, one for your production run and one for your test run:

 `public EventContext(): base(NameofDatabase){ }`

* If you have a column (say, from a migration) and it's not part of the constructor, what happens?
  * If you want to add info to that column, you will have to change your constructor properties accordingly.
    * If you change the constructor without changing the database properly (such as doing a migration to add a column, or delete/building another database), then it will error out.
  * If you have a column, but it is not used in the constructor, what happens is dependent on the property of that column.
    * For example, if it’s okay for that column to be null, then it will not produce any errors since it’s not required to have data in it.
    * However, if the column is required to be NOT NULL, then it will error out.