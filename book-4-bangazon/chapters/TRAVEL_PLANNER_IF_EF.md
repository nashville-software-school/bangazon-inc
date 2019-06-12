# Travel Planning App

You're going to build an app to help travel agents keep track of clients and their clients' trips.

## Business Logic
1. A travel agent can log into the app.
1. A travel agent can create clients. When they log in, they should see a list of only their clients.
1. Clients should have a first name, last name, and phone number.
1. A travel agent can create a trip for a client. The trip should have a start date, end date, and location.
1. When a travel agent clicks on a client's details, they should see all trips assigned to that client.
1. When a travel agent clicks on a "Trips" link in the nav bar, they should see all trips that _any_ of their clients have created.

## Setting up your app
1. Create a new web app with ASP.NET.
1. Under "Authentication", select "Individaul User Accounts"
1. Create your own model for an `ApplicationUser` to override the default Identity user.
1. Your `ApplicationUser` will represent a travel agent and should have a first name and a last name. It should inherit from `IdentityUser`.
1. Follow the steps in [the Identity Framework chapter](./chapters/ASPNET_IDENTITY_INTRO.md) to override your app's default `IdentityUser` with your new `ApplicationUser`.

## Build your database
1. Use the business logic above to build an ERD
1. Build models representing each entity in your ERD. Make sure that all data relationships are represented on your models.
1. Create your database with `Add-Migration` and `Update-Database`
1. Seed your database with at least two clients and at least two trips.

## Scaffold your app
1. Use Entity to scaffold CRUD functionality for clients and trips.
1. In the trips index view, trips should be sorted by date with upcoming dates at the top of the list.

## Viewing Related Data
1. When a travel agent views the client details view, they should see a list of that client's trips.

## Protecting other user's data
1. A travel agent should not be able to edit, delete, or view details of other travel agents' clients or their trips.



## Additional Functionality
1. Trips should be sorted by date
1. Trips that have already happened should not appear on the trip index view by default. Instead, travel agents should see a button that says "view past trips". When they click a button, they should _only_ see trips that have already happened.
1. Travel agents should be able to search trips by location from the trips index view.
1. Travel agents should be able to search clients by first and last name.

## Challenges
1. Travel agents should not be able to delete a client if the client has any trips. Instead, the client and their trips should be marked as `archived`. Archived clients and trips should not show up in their respective index views, but they should still be stored in the database. (Hint: this will involve changing your models and adding a new migration.) If the client doesn't have any trips yet, they can be permanently deleted from the database.
1. Travel agents should be able to view a report of their top five clients (i.e. clients who've taken the most trips)
1. Travel agents should be able to view a report of the top three busiest travel months of the year (i.e. the months when the most trips have started).

## Advanced Challenges
Refactor your database to reflect the following business logic:

1. Your travel agency has restructured. Now, instead of selling individual trips to clients, you also sell group trips. This means that many clients can be on any given trip. Clients can still go on multiple trips.
1. You also want to keep track of the locations visited on each trip. Each trip can have many locations, and any given location might be included in many trips.
1. Travel agents should be able to create, update, and delete locations.
1. When travel agents create a trip, they should be able to select from a multi-select of both locations and clients.
1. When travel agents view a trip, they should see a list of all the locations on that trip as well as all the clients on that trip.
1. Travel agents should now be able to search trips by location from the index view. For example, if they search the for "Hong Kong", trips that include Hong Kong should apepar in the index view.
1. Travel agents should be able to view a report of the agency's top five most visited locations of all time. This should be calculated by the number of clients who have taken trips to those locations.
1. At the top of the Top Five Locations report in the step above, travel agents should see a dropdown. The dropdown should have an option for every year that they've sold trips. When a year is selected, the travel agent should see the top five most popular trip locations for that year.




