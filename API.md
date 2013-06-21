# API Reference

- Base endpoint: http://reeder.io/api
- Output format: JSON

## Errors

API errors structure:

```json
{
  "error": "Error message goes here",
  "status": "HTTP response status code"
}
```

## Signup

To create a new user account, send request:

```
POST /api/users
```

Required parameters:

- `[user][email]` - Email address
- `[user][name]` - User name
- `[user][password]` - Password

Successful response will include new user attributes:

```json
{
  "id": 1,
  "name": "Dan Sosedoff",
  "email": "dan.sosedoff@gmail.com",
  "api_token": "3c5d7f1f1482498027d070cd14038a91",
  "created_at": "2013-06-20T19:37:53-05:00"
}
```

In case if user validation failed, you might get error:

```json
{
  "error": "Email has already been taken",
  "status": 422
}
```

You must use returned `api_token` for all requests that require authentication.

## Authentication

To authenticate an existing user, send request:

```
POST /api/authenticate
```

Required parameters:

- `email` - Registered email address
- `password` - User password

Successful response will include user attributes:

```json
{
  "id": 1,
  "name": "Dan Sosedoff",
  "email": "dan.sosedoff@gmail.com",
  "api_token": "3c5d7f1f1482498027d070cd14038a91",
  "created_at": "2013-06-20T19:37:53-05:00"
}
```

If provided email and/or password is not correct, you will get error:

```json
{
  "error": "Invalid email or password",
  "status": 400
}
```

You must use returned `api_token` for all requests that require authentication.

## Feeds

Get collection of feeds:

```
GET /api/feeds 
```

Get a single feed:

```
GET /api/feeds/:id
```

Get feed posts:

```
GET /api/feeds/:id/posts
```

Create a new feed:

```
POST /api/feeds
```

Import a feed from url:

```
POST /api/feeds/import
```

Import feed from OPML:

```
POST /api/feeds/import/opml
```

Delete feed:

```
DELETE /api/feeds/:id
```

## Posts

Get all recent posts:

```
GET /api/posts
```

Get a single post:

```
GET /api/posts/:id
```

Mark post as read:

```
POST /api/posts/:id/read
```

Mark post a bookmarked:

```
POST /api/posts/:id/bookmark
```

## Reference

**User**

- `id` - User ID (Integer)
- `name` - Name (String)
- `email` - Email address (String)
- `api_token` - API authentication token (String)
- `created_at` - Signup timestamp (DateTime)
- `updated_at` - Last update timestamp (DateTime)

**Feed**

- `id` - Feed ID (Integer)
- `title` - Name / title (String)
- `description` - Optional description (String)
- `url` - RSS/Atom url (String)
- `site_url` - Optional website url (String)
- `last_modified_at` - Last update timestamp (DateTime)
- `status` - Feed status (String)
- `posts_count` - Number of posts (Integer)
- `unread_posts_count` - Number of unread posts (Integer)
- `created_at` - Creation timestamp (DateTime)
- `updated_at` - Update timestamp (DateTime)

Available values for `status` attribute:

- `ok` - Feed is functioning fine
- `error` - Feed sync error, or url does not exist

**Post**

- `id` - Post ID (Integer)
- `feed_id` - Feed ID (Integer)
- `title` - Post title (String)
- `author` - Author name (String)
- `url` - Post direct url (String)
- `content` - Original post content (String)
- `published_at` - Publication timestamp (DateTime)
- `read_at` - Read timestamp (DateTime)
- `bookmarked` - Bookmark flag (Boolean)
- `feed` - Container with `Feed` instance (Feed)