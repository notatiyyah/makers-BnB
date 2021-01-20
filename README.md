# Makers BnB

This is a web application based on ruby and sinatra, using a psql database, with capybara for testing.
This app allows users to list spaces available to hire for the night, and allows other users to hire them.

Users will be able to log in using:
* Username
* Email
* Phone Number

Each space will be able to be personalised with info such as:
* Name
* Description
* Price
* Availability
  * Booking a space will make it unavailable

Users can request to hire, which the owner can accept or deny.
Once bookings have been confirmed, users will receive text notifications.

## User Stories

```
As a user
So that I can host or rent places
I would like to be able to sign up with my details: username, email and phone number

As a user,
So that i can track my bookings/ rentings
I would like to sign in and sign out

As a host 
So that i can rent out my properties
I would like to be able to list a new place


As a host,
So that people can know about the property I have listed,
I would like to be able to provide descriptions of the spaces

As a host,
So that my property is not double booked,
I would like to provide available properties and available dates of listings that are not already booked


As a user,
So that i can rent a property,
I would like to see the available dates a property has

As a user,
So that i can rent a property,
I would like to be able to submit my booking to the host
```

## Models

### Databases
![Database Models](/public/images/database_models.png)

### Classes
![Class Models](/public/images/class_models.png)

## Wireframes

# Instructions

## Installation

```
git clone https://github.com/notatiyyah/makers-BnB.git
bundle install
psql
```
### Setting Up Main Database
```
CREATE DATABASE makers_bnb;
\c makers_bnb
** Now run the commands saved in 01_Create_Tables.sql (db/migrations)
```
### Setting Up Testing Database
```
CREATE DATABASE makers_bnb_testing;
\c makers_bnb_testing
** Now run the commands saved in 01_Create_Tables.sql (db/migrations)
** Now run the commands saved in 02_create_test_bases.sql
** Now run the commands saved in 03_add_test_data.sql
```
## To Run

```
rackup
```

# Acknowledgements
* [README template](https://github.com/othneildrew/Best-README-Template)
