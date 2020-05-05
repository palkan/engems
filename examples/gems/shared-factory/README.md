# Shared Factory

[FactoryBot](https://github.com/thoughtbot/factory_bot) utilities for apps and engines.

Includes:
- [faker](https://github.com/stympy/faker) (with only English locale loaded)
- `ActiveSupport.on_load(:factory_bot)` hook to configure `factory_bot` prior to loading
definitions
- `factory_bot_rails` (if Rails is defined)

## Usage

Require it instead of `factory_bot` (or `factory_bot_rails`) and use as always:

```ruby
require "shared-factory"
```

### Active Support load hook

The load hook could be used to tell FactoryBot where to look for factory definitions:

```ruby
ActiveSupport.on_load(:factory_bot) do
  FactoryBot.definition_file_paths.unshift File.join(__dir__, "../spec/factories")
end
```

## Why separate gem and not a part of `shared-testing`?

Factories could be used not only in test env, but in development and production
(e.g., for DB seeds and mailers previews).
