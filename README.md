# Reeder

Experimental app to read RSS subscriptions

## Requirements

- Ruby 1.9.3
- PostgreSQL
- Redis

## Install

Clone repository and install dependencies:

```
git clone git@github.com:sosedoff/reeder.git
cd reeder
bundle install
```

Create development database:

```
createdb -U postgres reeder_development
```

Migrate database:

```
rake db:migrate
```

## Usage

To start server locally (http://localhost:3000/) type:

```
foreman start
```

## Testing

Prepare database:

```
createdb -U postgres reeder_test
rake db:migrate RACK_ENV=test
```

To execute test suite:

```
bundle exec rake test
```