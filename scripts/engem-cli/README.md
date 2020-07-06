# `bin/engem`

[Engem CLI](./engem) is a utility tool which helps you to manege engines and gems from the app's root directory.

Put in in your `bin/` folder and use like this:

```sh
# show available commands
bin/engem --help

# run a specific test
bin/engem core_by rspec spec/models/core_by/city.rb:5

# run Rails console
bin/engem core_by console

# runs `bundle install`, `rubocop` and `rspec` by default
bin/engem core_by build

# you can omit running rspec/rubocop by providing `--skip-rspec`/`--skip-rubocop` option:
bin/engem shared-rubocop build --skip-rspec

# generate a migration
bin/engem core_by rails g migration <name>

# engem automatically detects gems and engines (i.e. libs ubder engines/ and gems/ directories)
# you don't have to specify whether it's a gem or engine
bin/engem shared-testing build

# you can run command for all engines/gems at once by using "all" name
bin/engem all build

# or just for engines
bin/engem all-engines build

# or just for gems
bin/engem all-gems build

# the execution halts as soon as the command fails for one of the engines/gems;
# to disable this fail-fast behaviour use `--ignore-failures` switch
bin/engem all build --ignore-failures
```
