# Expert advice API

This repository is a Rails 5.2. application, configured as a pure API. It supports users, user accounts, signups and logins via the users endpoint. Authentication is set up with Doorkeeper. Database is Postgres.

This API is specially designed to work with Ember on the front-end: requests and responses are conformed to JSON:API.
Built with Ruby on Rails framework and PostgreSQL database

## Built With

- Ruby v2.7.2
- Ruby on Rails v6.0.0

## Live Demo

[Expert Advice API](https://marcelomaidden-expert-api.herokuapp.com/api/v1/questions)


## Getting Started

To get a local copy up and running follow these simple example steps.

## Clone the repository

```
   git clone https://github.com/marcelomaidden/expert-advice-backend.git
   cd expert-advice-backend
```

To run the application, use the following commands:

```
bundle install
rake db:create db:migrate db:seed
rails s
```
Open `http://localhost:3000/api/v1/questions` in your browser.

### Run tests

```
    rpsec --format documentation
```

👤 **Marcelo Fernandes**

- GitHub: [@marcelomaidden](https://github.com/marcelomaidden)
- Twitter: [@marcelomaidden](https://twitter.com/marcelomaidden)
- LinkedIn: [Marcelo Fernandes](https://linkedin.com/in/marcelofernandesdearaujo)

## Acknowledments
- NightWatch
- W3schools
- Twitter Boostrap
- Rails
- EmberJS

