# Dirty checking for CI

Utility tool ([`is-dirty`](./is-dirty)) to check whether the changes to the gem/engine have been made
comparing to the master branch.

It automatically builds a dependency tree for all local gems/engines (using `.gemspec` files)
and considers a gem _dirty_ iff there are changes in its code or in any of its dependencies.

**NOTE:** When the current branch is master then everything is considered _dirty_ (to make sure that we run
all tests on master). You can additional _always-dirty_ branches by updating the `ALWAYS_RUN` constant.

## Usage

```sh
.ci/is-dirty my_component || \
  (cd engines/my_component && bundle exec rspec)
```

## Refs

Inspired by this post [https://medium.com/@dan_manges/the-modular-monolith-rails-architecture-fb1023826fc4](https://medium.com/@dan_manges/the-modular-monolith-rails-architecture-fb1023826fc4).
