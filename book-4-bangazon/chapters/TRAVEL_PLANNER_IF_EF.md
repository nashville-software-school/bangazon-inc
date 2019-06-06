# Travel Planning App

## Setting up your app
1. Create a new web app with ASP.NET.
1. Under "Authentication", select "Individaul User Accounts"
1. Create your own model for an `ApplicationUser` to override the default Identity user.
1. Your `ApplicationUser` should have a first name and a last name and inherit from `IdentityUser`.
1. Change references to `IdentityUser` so that they reference `Applicationuser` instead.

## Business Logic
1. A travel agent can log into the app. (Hint: they'll be your `ApplicationUser`)
1. A travel agent can create clients. When they log in, they should see a list of only their clients.
1. Clients should have a first name, last name, and phone number.
1. A travel agent can create a trip for a client. The trip should have a start date, end date, and location.
1. When a travel agent clicks on a client's details, they should see all trips assigned to that client.
1. When a travel agent clicks on a "Trips" link in the nav bar, they should see all trips that _any_ of their clients have created.

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




