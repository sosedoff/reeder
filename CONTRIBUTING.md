# Contributing to Reeder

Steps:

1. Update the source code:

```
git checkout master
git pull
```

2. Install dependencies

```
bundle install
```

3. Reconfigure DB

```
dropdb reeder_development
createdb reeder_development
rake db:migrate
```

4. Create a new branch

```
git checkout -b my-fancy-feature
```

5. Start application

```
foreman start
```

6. Develop new features