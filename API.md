# API Reference

- Enpoint: http://localhost:3000/api
- Output format: JSON

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