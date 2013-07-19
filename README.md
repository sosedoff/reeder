# Reeder

Experimental app to read RSS subscriptions

## Requirements

- Ruby 2.0
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

To start server locally (http://localhost:5000/) type:

```
foreman start
```

This will start web server, feed worker and periodic update worker.

## API Documentation

Check `API.md` file for API documentation and reference.

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

## TODO

- OPML import with web interface
- Responsive / mobile layout
- Better feed processing based on update frequency

## License

The MIT License (MIT)

Copyright (c) 2013 Dan Sosedoff <dan.sosedoff@gmail.com>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
