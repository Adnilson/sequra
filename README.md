# README

## Setup

### This project uses Ruby version `3.3.0` and Rails version `7.1.2`

1. Make sure you have **Ruby**, **Rails**, **PostgreSQL** and **Redis** installed.

2. After the installation run the following commands:

    `bundle install`

    `bin/rails db:seed`

3. To have the disbursements calculated run the rake task:

    `bin/rails disbursements:create`

## Usage

1. Run the server:

    `bin/rails s`

    **Orders** are available on the root endpoint `localhost:3000`

    **Disbursements** are on the `localhost:3000/disbursements` endpoint.

2. Run tests:

    `bin/rails t`

## Decisions

* I decided to try and use repositories for this project even though they are an abstraction on top of AR.

* I did not use the rails convention of the model references (external id foreign keys), this does let use the AR associations and I know that it is useful for many reasons before you call me noob. A risk I am willing to take.
  I'd try Sequel in the future perhaps with Roda or Hanami.

* I created different jobs for weekly and daily disbursements for separation of concerns and also monitoring.

* There is a job for each merchant to create the disbursement as they can be processed in parallel this way.

* If I had more time I would add more tests, create more endpoints, more validations, add authentication, etc.

* I would also find a way to have a similar table to the one you showed on the challenge instructions, but decided to create the disbursements as simple as possible for the sake of time.

* Overall I chose to use the most vanilla Rails and Ruby possible for simplicity. I like to follow one of Jonh Ousterhoust's though: *"It's more important for a module to have a simple interface than a simple implementation"*.

## Table

|     Year     | Number of disbursements | Amount disbursed to merchants |    Amount of order fees       |
|:------------:|:-----------------------:|:-----------------------------:|:-----------------------------:|
|    2022      |           50            |         38.439.162,80€        |         347.314,83€           |
|    2023      |           50            |        187.054.780,85€        |       1.695.599,43€           |
