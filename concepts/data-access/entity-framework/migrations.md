# Migrations

### What is a Migration and how do you update or recall a database structure change?
* Migration has two types: schema and data.
* Migration just means changing the structure of the database.
  * For example, in a data migration you want to add a whole column such as adding hashtags, how are you going to backwards add these hashtags to all your past data items? You could delete it and start again, but migration is a better way to do it when you don’t want your millions of data deleted.
  * It’s a way to change the structure without having to delete and recreate the tables.

* To **add migration**, go to NuGet Manager Console and Type `Enable-Migrations`.
  * You don’t want to autogenerate the migration most of the time, so you can do it manually. For example, for hashes, you can put in your console `Add-Migration AddHashField`.
    * This does some scaffolding in which it readies your database and creates a class `AddHashField: DbMigration` with two methods `Up` and `Down`.

  * In the **up** method (meaning the database from here on out), you can add:

      `public override void Up() AddColumn(“dbo.Events”,      “Hash”, c => c.String());`

    * put the **dbo** (database object) before the Events (the name of the table we’re interested in)
    * then add the field we want which is “hash”, and the lambda that says for any column c, you want it to have type string.

  * The **down** migration:

    `public override void Down() DropColumn(“dboEvents.EventContext”, “Hash”);`

  * Both methods are overrides since each overrides the program’s migration’s idea of up and down.
    * This is because it requires the interface `dbMigration` and which means .NET has to require the methods in dbMigration, their default implementation of up and down.

* Now in the console, you can do `Update-Database -Verbose`.
  * This is to do an up migration
  * You don’t have to use verbose, but it gives you more info as it’s running.

If we want to `Update-Database -TargetMigration $InitialDatabase` let’s you undo all the migration.

If you want to go directly down `Update-Database -TargetMigration SpecificMigrationName` will take you to a specific migration to do down migration.

#### What if you want to delete a field in your database?
 * In general, people don’t delete fields or columns in their database because that means deleting data.
   * It’s easier and safer, to add the column you want and then just take out the old code that is referring to the old fields you no longer want to use.
   * Thus, it’s still in the database but there is no way to access those particular fields anymore since your code doesn’t have those references.

#### What is the difference between the up and down methods in migration?
https://stackoverflow.com/questions/9769515/c-sharp-code-first-migration-up-down
* Up method upgrades your database from its current state (represented by your previous migration) to the state expected by your current code migration.
* Down method does the reverse operation - it removes all changes from the current migration and reverts database to state expected by the previous migration.
* It is same like install / uninstall the migration.
* Only one of these methods is executed when you call update-database. To use Down method you must explicitly specify target migration for your upgrade. If the target migration is the old one, the migration API will automatically use Down method and downgrade your database.


### Migrations Setup
https://gist.github.com/jcockhren/4d58d603920c39f29f45
[Migrations_Setup.md]
  1. From the menu, Go to `Tools -> NuGet Package Manager -> Package Manager Console`
  2. Follow Steps in commits to ready project for migrations [ https://github.com/NashvilleSoftwareSchool/jitter-juniper/compare/625cb9f9a339e243fb1d3c3a1f03d3d301cb9c60...103d40c?diff=split&name=103d40c ] and then:

    `PM> Enable-Migrations -ContextTypeName ProjectName.Models.ProjectNameContext`

      where "ProjectName" is your project's name.  
      N.B.  This step only ever needs to be done once (do not need to redo for scorched earth below)
  3. In order to Create an initial migration :
	`PM> Add-Migration InitialCreate`
  4. To apply that migration:
	`PM> Update-Database`

### Initial Migration
https://gist.github.com/jcockhren/243d76d925d51abcb3df [instructions.md]
  1. `PM> Update-Database -TargetMigration $InitialDatabase` (Deletes all tables in database, but keeps Database file)
  2. If you have a file with the name `InitialCreate1` delete it. If it's not there, no worries.
  3. `PM> Add-Migration InitialCreate` (re-create `InitialCreate` migration file with your new model's changes)
  4. `PM> Update-Database` (apply the newly created migration)

### Adding a Migration
  0. Make any necessary changes to your model
  1. `PM> Add-Migration NameForNewMigration` ('NameForNewMigration' should reflect your new model's changes)
  2. `PM> Update-Database` (apply the newly created migration)
      * Update database will run the seed data if it doesn’t initialize in the beginning.


### To Completely Re-Create Database File
This "scorched earth" approach may be necessary when all else fails, since Visual Studio has some glitches wrt migrations.

https://gist.github.com/jcockhren/d92140ce675e0b62fa4f  [database_file_recreate.md]
  1. In Server Explorer, under your `Data Connections`, delete both connections (`DefaultConnection` and `ProjectName.mdf`)
  2. Go to your project and right-Click on `App_Data`, then select `Open in File Explorer`.  
  3. Delete the Database FILES in the directory from #1, and copy the full path at the top of the `File Explorer` onto your clipboard.
  4. In Server Explorer right click on `Data Connections` and select `Add Connection`.  In the open field for `Database File Name`, paste the path from your clipboard and append the name of your project at the end of that path.  Click `OK`.
  5. In Package Manager Console, run
  `PM> Update-Database`

### ?? Not sure where this stuff fits, if it belongs at all:
Beware:  .NET system is 'finicky'!!
[Config.cs: 'AutomaticMigrationsEnabled = false' for this very reason! ]
=> Check if table created (should be able to see new table inside InitialCreate.cs).  If table is not there, then need to create table:
  1. To recreate scaffolding, delete InitialCreations  (revert DB to no tables)
`PM> Add-Migration InitialCreate` => `InitialCreate` file, with `Designer` and `resx` elements
  2. Change database:  To recreate DB with entirely new tables, and run Seed method:
`PM> Update-Database -TargetMigration $InitialDatabase -Force`




************
### Additional Resources
* Microsoft Data Developer Website on Code-First Migrations
 * https://msdn.microsoft.com/en-us/data/jj591621.aspx#generating
* Wikipedia
 * https://en.wikipedia.org/wiki/Schema_migration