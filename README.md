# NW Dictionary
A site to read and share NW lingo, for the week 2 code review at Epicodus, July 8, 2016

By Julia Dickey

## Description

This site allows a salon owner to view, add, update and delte stylists and clients.

## Setup/Installation Requirements

* The site can be found [here](https://github.com/JuliaDickey/Ruby-Week-3-Salon) on GitHub
* Clone the github repository to view source files.
* Launch postgres and build the necessary databases with the following commands:
postgres
psql
CREATE DATABASE hair_salon;
\c hair_salon;
CREATE TABLE clients (id serial PRIMARY KEY, name varchar, describe text, stylist_id int);
CREATE TABLE stylists (id serial PRIMARY KEY, name varchar);
CREATE DATABASE hair_salon_test WITH TEMPLATE hair_salon;

## Known Bugs

The backend logic passes all spec tests, but the page will not load on or pass integration tests.

## Support and contact details

For additional questions or comments, email [Julia](mailto:info@gmail.com).

## Technologies Used

Ruby, Sinatra, SQL, HTML, CSS, Bootstrap

Copyright (c) 2016 Julia Dickey
