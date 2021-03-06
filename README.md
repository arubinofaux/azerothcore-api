## azerothcore-api
[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/arubinofaux/azerothcore-api)

A set of RESTful APIs for [AzerothCore](https://azerothcore.org).

API Swagger demo: [https://azerothcore-api.herokuapp.com/api-docs](https://azerothcore-api.herokuapp.com/api-docs)

username: `admin`  password: `password`

### Requirements

- Ruby
- MySQL
- AzerothCore database

### Installation

```
$ bundle install
```

Copy the configuration file `.env-example` file into `.env` and update it.

```
$ cp .env-example .env
```

Setup local database:
```
$ rake db:setup
```

Run the project:
```
$ foreman start -f Procfile.dev
```

Now you can locally access to the API routes through [http://localhost:5000](http://localhost:5000).

### API Swagger Docs

You can use Swagger to test the endpoints [http://localhost:5000/api-docs](http://localhost:5000/api-docs)
