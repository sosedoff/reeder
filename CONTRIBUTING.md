# Contributing to Reeder

Steps:

**Update the source code**

```
git checkout master
git pull
```

**Install dependencies**

```
bundle install
```

**Reconfigure DB**

```
dropdb reeder_development
createdb reeder_development
rake db:migrate
```

**Create a new branch**

```
git checkout -b my-fancy-feature
```

**Start application**

```
foreman start
```

**Develop new features**