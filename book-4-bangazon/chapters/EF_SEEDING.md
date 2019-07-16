# Seeding the Database

You can seed your database by adding instructions in your `ApplicationDbContext.cs` file with an `OnModelCreating` method. Once you've defined some objects in this method, when you generate a new migration with `Add-Migration DescriptiveLabel`, then instructions will be added to the migration file to insert the data.

When the `Update-Database` instruction is given, then the items will be added to your database.

Here's an example you can reference.

```cs
namespace StudentExercises.Data {
    public class ApplicationDbContext : IdentityDbContext<ApplicationUser> {
        public ApplicationDbContext (DbContextOptions<ApplicationDbContext> options) : base (options) { }

        public DbSet<ApplicationUser> ApplicationUsers { get; set; }
        public DbSet<Cohort> Cohorts { get; set; }
        public DbSet<Student> Students { get; set; }

    protected override void OnModelCreating (ModelBuilder modelBuilder) {
        // Create a new user for Identity Framework
        ApplicationUser user = new ApplicationUser {
            FirstName = "admin",
            LastName = "admin",
            StreetAddress = "123 Infinity Way",
            UserName = "admin@admin.com",
            NormalizedUserName = "ADMIN@ADMIN.COM",
            Email = "admin@admin.com",
            NormalizedEmail = "ADMIN@ADMIN.COM",
            EmailConfirmed = true,
            LockoutEnabled = false,
            SecurityStamp = "7f434309-a4d9-48e9-9ebb-8803db794577",
            Id = "00000000-ffff-ffff-ffff-ffffffffffff"
        };
        var passwordHash = new PasswordHasher<ApplicationUser> ();
        user.PasswordHash = passwordHash.HashPassword (user, "Admin8*");
        modelBuilder.Entity<ApplicationUser> ().HasData (user);

        // Create two cohorts
        modelBuilder.Entity<Cohort> ().HasData (
            new Cohort () {
                CohortId = 1,
                Name = "Day Cohort 10"
            },
            new Cohort () {
                CohortId = 2,
                Name = "Day Cohort 11"
            }
        );

        // Create two students
        modelBuilder.Entity<Student> ().HasData (
            new Student () {
                StudentId = 1,
                FirstName = "Jakob"
                LastName = "Wildman",
                CohortId = 2
            },
            new Student () {
                StudentId = 2,
                FirstName = "Susan"
                LastName = "MacAfee",
                CohortId = 1
            }
        );
    }
}
```
