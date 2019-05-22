# Learning SQL with Chinook

## Downloading the Database Files

Click the download button from the [Chinook Database](https://github.com/lerocha/chinook-database/blob/master/ChinookDatabase/DataSources/Chinook_SqlServer.sql) github page.

## Moving the SQL File to Your Workspace

1. Create a directory for your work.
    ```
    mkdir -p ~/workspace/chinook
    ```
2. Move the `Chinook_SqlServer.sql` file that you downloaded to that directory
    ```
    cp Chinook_SqlServer.sql ~/workspace/chinook
    ```

## Setting up the Chinook Database

1. Open Azure Data Studio
1. Connect to your master database
1. Open the `Chinook_SqlServer.sql` file and run it to create the database, the tables, and the data.

## Instructions

1. Create a Github repository for your answers to this exercise. Name your repository `chinook-{your Github username]`.
1. Go ahead and click around a little bit to familarize yourself with the database
1. Draw an ERD of the Chinook database with [dbdiagram.io](http://www.dbdiagram.io). Make sure to label primary keys, foreign keys, and indicate the type of relationship (one to one, one to many, many to many, etc) for each relationship.
1. Once you get a SQL statement working for one of the exercises, copy the SQL statement and paste it into the corresponding file for the exercise (_see below_). If your query doesn't return the expected results, try try again.

For each of the following exercises, provide the appropriate query. Everything from class and the [SQL Documentation](https://www.w3schools.com/sql/sql_intro.asp) is fair game.

1. `non_usa_customers.sql`: Provide a query showing Customers (just their full names, customer ID and country) who are not in the US.
1. `brazil_customers.sql`: Provide a query only showing the Customers from Brazil.
1. `brazil_customers_invoices.sql`: Provide a query showing the Invoices of customers who are from Brazil. The resultant table should show the customer's full name, Invoice ID, Date of the invoice and billing country.
1. `sales_agents.sql`: Provide a query showing only the Employees who are Sales Agents.
1. `unique_invoice_countries.sql`: Provide a query showing a unique/distinct list of billing countries from the Invoice table.
1. `sales_agent_invoices.sql`: Provide a query that shows the invoices associated with each sales agent. The resultant table should include the Sales Agent's full name.
1. `invoice_totals.sql`: Provide a query that shows the Invoice Total, Customer name, Country and Sale Agent name for all invoices and customers.
1. `total_invoices_{year}.sql`: How many Invoices were there in 2009 and 2011?
1. `total_sales_{year}.sql`: What are the respective total sales for each of those years?
1. `invoice_37_line_item_count.sql`: Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for Invoice ID 37.
1. `line_items_per_invoice.sql`: Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for each Invoice. HINT: [GROUP BY](https://docs.microsoft.com/en-us/sql/t-sql/queries/select-group-by-transact-sql?view=sql-server-2017)
1. `line_item_track.sql`: Provide a query that includes the purchased track name with each invoice line item.
1. `line_item_track_artist.sql`: Provide a query that includes the purchased track name AND artist name with each invoice line item.
1. `country_invoices.sql`: Provide a query that shows the # of invoices per country. HINT: [GROUP BY](https://docs.microsoft.com/en-us/sql/t-sql/queries/select-group-by-transact-sql?view=sql-server-2017)
1. `playlists_track_count.sql`: Provide a query that shows the total number of tracks in each playlist. The Playlist name should be include on the resulant table.
1. `tracks_no_id.sql`: Provide a query that shows all the Tracks, but displays no IDs. The result should include the Album name, Media type and Genre.
1. `invoices_line_item_count.sql`: Provide a query that shows all Invoices but includes the # of invoice line items.
1. `sales_agent_total_sales.sql`: Provide a query that shows total sales made by each sales agent.
1. `top_2009_agent.sql`: Which sales agent made the most in sales in 2009?

    > **Hint:** Use the [MAX](https://docs.microsoft.com/en-us/sql/t-sql/functions/max-transact-sql?view=sql-server-2017) function on a [subquery](http://beginner-sql-tutorial.com/sql-subquery.htm).

1. `top_agent.sql`: Which sales agent made the most in sales over all?
1. `sales_agent_customer_count.sql`: Provide a query that shows the count of customers assigned to each sales agent.
1. `sales_per_country.sql`: Provide a query that shows the total sales per country.
1. `top_country.sql`: Which country's customers spent the most?
1. `top_2013_track.sql`: Provide a query that shows the most purchased track of 2013.
1. `top_5_tracks.sql`: Provide a query that shows the top 5 most purchased songs.
1. `top_3_artists.sql`: Provide a query that shows the top 3 best selling artists.
1. `top_media_type.sql`: Provide a query that shows the most purchased Media Type.






